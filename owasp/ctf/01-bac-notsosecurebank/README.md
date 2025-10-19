# SecureBank CTF - IDOR Vulnerability Demo

Une application bancaire intentionnellement vulnérable pour apprendre les vulnérabilités IDOR (Insecure Direct Object References).

## 🚀 Installation

### Installation automatique
```bash
./install.sh
```

### Installation manuelle
```bash
# 1. Installer les dépendances
npm install

# 2. Initialiser la base de données
npm run install-db
# ou directement avec sqlite3 :
sqlite3 securebank.db < init.sql

# 3. Démarrer l'application
npm start
```

## 📊 Scripts disponibles

- `npm start` - Démarre l'application
- `npm run install-db` - Initialise la base de données  
- `npm run reset-db` - Supprime et recrée la base de données
- `npm run setup` - Exécute le script d'installation complet

## 🎯 Objectif du CTF

Exploiter une vulnérabilité IDOR pour accéder aux informations du compte de Bernard et trouver son numéro de compte (clé CTF).

## 👥 Comptes de démonstration

- **Alice** : `alice` / `password1`
- **Bernard** : `bernard` / `password2` (cible)
- **Carol** : `carol` / `password3`
```

Open http://localhost:3000 and log in with:

- alice / password1
- bernard / password2
- carol / password3

The dashboard form contains a **hidden user_id field**. Editing it before submitting `/account-info` will demonstrate the IDOR.

A secure alternative endpoint `/account-info-secure` shows the proper authorization check.

## Tech
- Express
- EJS
- Async SQLite (`sqlite` + `sqlite3`)
- express-session
