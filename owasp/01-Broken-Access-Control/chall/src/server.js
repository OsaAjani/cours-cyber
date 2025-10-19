const path = require('path');
const express = require('express');
const session = require('express-session');
const bcrypt = require('bcrypt');
const sqlite3 = require('sqlite3')
const { open } = require('sqlite')

const app = express();

// ---- Express setup ----
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// ---- Database ----
let db;
(async () => {
    // open the database
    db = await open({
        filename: path.join(__dirname, 'securebank.db'),
        driver: sqlite3.Database
    })
})()

// ---- Sessions ----
app.use(
    session({
        secret: 'dev-secret-change-me',
        resave: false,
        saveUninitialized: false,
        cookie: { maxAge: 1000 * 60 * 60 } // 1 hour
    })
);

// Flash helper (simple)
app.use((req, res, next) => {
    res.locals.flash = req.session.flash || null;
    delete req.session.flash;
    res.locals.user = req.session.user || null;
    next();
});

// Middleware to require login
function requireAuth(req, res, next) {
    if (!req.session.user) {
        req.session.flash = { type: 'danger', message: 'Please log in first.' };
        return res.redirect('/');
    }
    next();
}

// ---- Routes ----

app.get('/', (req, res) => {
    res.render('login', { title: 'Login - SecureBank' });
});

app.post('/login', async (req, res) => {
    const { username, password } = req.body;
    const user = await db.get(`SELECT * FROM users WHERE username = ?`, username);
    if (!user || !bcrypt.compareSync(password, user.password)) {
        req.session.flash = { type: 'danger', message: 'Invalid credentials!' };
        return res.redirect('/');
    }
    req.session.user = { id: user.id, name: user.name, username: user.username };
    res.redirect('/dashboard');
});

app.get('/logout', (req, res) => {
    req.session.destroy(() => res.redirect('/'));
});

app.get('/dashboard', requireAuth, async (req, res) => {
    const me = await db.get(`SELECT * FROM users WHERE id = ?`, req.session.user.id);
    
    res.render('dashboard', {
        title: 'Dashboard - SecureBank',
        me,
        rib: false,
        resultTx: []
    });
});

app.post('/account-info', requireAuth, async (req, res) => {
    const { user_id, action } = req.body;

    let me = await db.get(`SELECT * FROM users WHERE id = ?`, user_id);
    if (!me) {
        me = await db.get(`SELECT * FROM users WHERE id = ?`, req.session.user.id);
        req.session.flash = { type: 'danger', message: 'User not found.' };
        return res.render('dashboard', { title: 'Dashboard - SecureBank', me, rib: false, resultTx: [] });
    }

    let resultTx = [];
    if (action === 'view_transactions') {
        resultTx = await db.all(`SELECT * FROM transactions WHERE user_id = ? ORDER BY date DESC, id DESC`, me.id);
    }

    let rib = false;
    // Compute BIC from IBAN (simple example, replace with actual logic if needed)
    if (action === 'view_rib') {
        rib = {
            name: me.name,
            iban: me.account_number,
            bic: (me.account_number.length < 8 ? 'UNKNOWNBIC' : `NSSB${me.account_number.slice(4, 8)}`),
            bankname: "NSSBank"
        }
    }

    res.render('dashboard', {
        title: 'Dashboard - SecureBank', 
        me, 
        rib,
        resultTx,
    });
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`SecureBank running on http://localhost:${port}`);
    console.log(`Make sure to run './install.sh' first to initialize the database`);
});
