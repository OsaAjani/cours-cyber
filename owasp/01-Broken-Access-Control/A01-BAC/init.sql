CREATE DATABASE IF NOT EXISTS owasp_bac;

-- Création de la table users
CREATE TABLE IF NOT EXISTS users (
    id TEXT PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    fullName TEXT NOT NULL,
    email TEXT NOT NULL,
    theme TEXT DEFAULT 'light',
    newsletter INTEGER DEFAULT 0
);

-- Insertion des utilisateurs de démonstration
INSERT INTO users (id, username, password, fullName, email, theme, newsletter) VALUES
('123', 'alice', 'password', 'Alice Dupont', 'alice@example.local', 'light', 1),
('124', 'bob', 'password', 'Bob Martin', 'bob@example.local', 'dark', 0),
('125', 'charlie', 'iunzeidnkjnfoinefozneofinzopefn', 'Charlie Moreau', 'charlie@example.local', 'light', 0),
('126', 'dave', 'password', 'Dave Bernard', 'dave@example.local', 'dark', 1),
('127', 'eve', 'password', 'Eve Laurent', 'eve@example.local', 'light', 1);
