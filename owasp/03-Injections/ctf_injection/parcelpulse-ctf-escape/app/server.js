const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const md5 = require('md5');
const e = require('express');

const app = express();
const PORT = 3001;

// Setup Flag 2
fs.writeFileSync('flag2.txt', 'FLAG{sh3ll_inj3cti0n_m4st3r_filtering_is_futile}');

// Middleware
app.set('view engine', 'ejs');
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'super-secret-ctf-key',
    resave: false,
    saveUninitialized: true
}));

// Database Setup
const db = new sqlite3.Database(':memory:');

db.serialize(() => {
    // Create Users Table
    db.run(`CREATE TABLE support80923 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mail TEXT,
        mdp TEXT
    )`);

    // Create Shipments Table
    db.run(`CREATE TABLE shipments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tracking_number TEXT,
        status TEXT,
        destination TEXT,
        updated_at TEXT
    )`);

    // Insert Dummy Data
    pwd = md5('mustang123');
    pwd2 = md5('porsche69');
    db.run(`INSERT INTO support80923 (mail, mdp) VALUES ('admin@parcelpulse.com', '${pwd}')`);
    db.run(`INSERT INTO support80923 (mail, mdp) VALUES ('support@parcelpulse.com', '${pwd2}')`);

    db.run(`INSERT INTO shipments (tracking_number, status, destination, updated_at) VALUES ('PP-10029', 'In Transit', 'Berlin Warehouse', '2023-10-25 14:00')`);
    db.run(`INSERT INTO shipments (tracking_number, status, destination, updated_at) VALUES ('PP-88372', 'Delivered', 'Paris HQ', '2023-10-24 09:30')`);
    db.run(`INSERT INTO shipments (tracking_number, status, destination, updated_at) VALUES ('PP-44912', 'Processing', 'London Hub', '2023-10-26 08:15')`);
});

// Auth Middleware
const requireAuth = (req, res, next) => {
    if (req.session.user) next();
    else res.redirect('/support/login');
};

// Routes
app.get('/', (req, res) => {
    res.render('index');
});

// VULNERABILITY 1: SQL Injection
app.get('/track', (req, res) => res.render('track', { results: null, error: null }));
app.post('/track', (req, res) => {
    const tracking_number = req.body.tracking_number;
    
    // Intentionally vulnerable SQL query (String concatenation)
    // Selects 4 columns. Attacker can UNION SELECT 4 columns from users table.
    const query = `SELECT tracking_number, status, destination, updated_at FROM shipments WHERE tracking_number = '${tracking_number}'`;
        console.log(query);


    db.all(query, [], (err, rows) => {
        if (err) {
            res.render('track', { results: null, error: 'Database error occurred : ' + err.message });
        } else {
            res.render('track', { results: rows, error: null });
        }
    });
});

app.get('/support/login', (req, res) => {
    res.render('login', { error: null });
});

app.post('/support/login', (req, res) => {
    const { email, password } = req.body;
    db.get(`SELECT * FROM support80923 WHERE mail = ? AND mdp = ?`, [email, md5(password)], (err, row) => {
        if (row) {
            req.session.user = row;
            res.redirect('/support/dashboard');
        } else {
            res.render('login', { error: 'Invalid credentials' });
        }
    });
});

app.get('/support/dashboard', requireAuth, (req, res) => {
    res.render('dashboard', { user: req.session.user });
});

app.get('/support/monitoring', requireAuth, (req, res) => {
    res.render('monitoring', { output: null });
});

// VULNERABILITY 2: Command Injection
app.post('/support/monitoring', requireAuth, (req, res) => {
    const hostname = req.body.hostname;

    // Protect hostname by removing ; & | and other command chaining characters
    if (/[\;&|]/.test(hostname)) {
        return res.render('monitoring', { output: 'Dangerous characters detected' });
    }
    
    // Intentionally vulnerable to command injection
    const command = `ping -c 2 ${hostname}`;
    
    exec(command, (error, stdout, stderr) => {
        res.render('monitoring', { output: stdout || stderr || error.message });
    });
});

app.listen(PORT, () => {
    console.log(`ParcelPulse CTF running at http://localhost:${PORT}`);
});
