const express = require("express");
const session = require("express-session");
const bodyParser = require("body-parser");
const path = require("path");
const sqlite = require("sqlite");
const sqlite3 = require("sqlite3");
const fs = require("fs");

const app = express();

// Initialisation de la base de données SQLite
let db;

async function initDatabase() {
    try {
        // Ouvrir la base de données avec support des Promises
        db = await sqlite.open({
            filename: "./database.db",
            driver: sqlite3.Database
        });
        
        console.log("Connecté à la base de données SQLite");
    
    } catch (err) {
        console.error("Erreur lors de l'initialisation de la base de données:", err.message);
    }
}

// Initialiser la base de données au démarrage
initDatabase();

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));
app.use(bodyParser.urlencoded({ extended: false }));

// Utilisez une store de session réelle en prod — ici MemoryStore pour demo uniquement.
app.use(
    session({
        secret: "demo-secret-change-me",
        resave: false,
        saveUninitialized: false,
        cookie: { maxAge: 60 * 60 * 1000 }
    })
);


// --- middleware de vérification de connection ---
function requireLogin(req, res, next) {
    if (!req.session.userId) return res.status(401).send("Veuillez vous connecter");
    next();
}

// --- Fonctions helper pour la base de données ---
async function findUserByUsername(username) {
    const row = await db.get("SELECT * FROM users WHERE username = ?", [username]);
    if (row) {
        row.prefs = { theme: row.theme, newsletter: row.newsletter === 1 };
    }
    return row;
}

async function findUserById(id) {
    const row = await db.get("SELECT * FROM users WHERE id = ?", [id]);
    if (row) {
        row.prefs = { theme: row.theme, newsletter: row.newsletter === 1 };
    }
    return row;
}

async function updateUser(id, fullName, email) {
    return await db.run("UPDATE users SET fullName = ?, email = ? WHERE id = ?", [fullName, email, id]);
}

// --- Routes publiques ---
app.get("/", (req, res) => {
    res.redirect("/login");
});

app.get("/login", (req, res) => {
    res.render("login", { error: null });
});

app.post("/login", async (req, res) => {
    try {
        const { username, password } = req.body;
        const user = await findUserByUsername(username);
        if (user && user.password === password) {
            req.session.userId = user.id;
            return res.redirect(`/user/profile/${user.id}`);
        }
        res.status(401).render("login", { error: "Identifiants invalides" });
    } catch (err) {
        console.error(err);
        res.status(500).render("login", { error: "Erreur serveur" });
    }
});

app.get("/logout", (req, res) => {
    req.session.destroy(() => res.redirect("/login"));
});

app.get("/user/profile/:id", requireLogin, async (req, res) => {
    try {
        const targetId = req.session.userId; // Sécurité toujours utiliser l'id de session
        const targetUser = await findUserById(targetId);
        
        if (!targetUser) return res.status(404).send("Profil introuvable");
        
        res.render("profile", {
            meId: req.session.userId,
            profile: targetUser,
            vulnerable: true
        });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur");
    }
});

// --- Démarrage ---
const PORT = 3001;
app.listen(PORT, () => console.log(`Demo app démarrée sur http://localhost:${PORT}`));

