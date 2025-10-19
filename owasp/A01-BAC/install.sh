#!/bin/bash

# Script d'installation pour l'application de démonstration BAC
# Ce script installe les dépendances et initialise la base de données

echo "======================================"
echo "Installation de l'application BAC Demo"
echo "======================================"
echo ""

# Vérifier si Node.js est installé
if ! command -v node &> /dev/null
then
    echo "❌ Node.js n'est pas installé."
    echo "Veuillez installer Node.js depuis https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"

# Vérifier si npm est installé
if ! command -v npm &> /dev/null
then
    echo "❌ npm n'est pas installé."
    echo "Veuillez installer npm."
    exit 1
fi

echo "✅ npm version: $(npm --version)"
echo ""

# Installer les dépendances
echo "📦 Installation des dépendances npm..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Erreur lors de l'installation des dépendances"
    exit 1
fi

echo "✅ Dépendances installées avec succès"
echo ""

# Supprimer l'ancienne base de données si elle existe
if [ -f "database.db" ]; then
    echo "🗑️  Suppression de l'ancienne base de données..."
    rm database.db
fi

echo ""
echo "======================================"
echo "✅ Installation terminée avec succès!"
echo "======================================"
echo ""
echo "Pour démarrer l'application:"
echo "  npm start          - Démarrage normal"
echo "  npm run dev        - Démarrage en mode développement (avec nodemon)"
echo ""
echo "L'application sera accessible sur http://localhost:3000"
echo ""
echo "Comptes de démonstration:"
echo "  - alice / password (id: 123)"
echo "  - bob / password (id: 124)"
echo "  - charlie / password (id: 125)"
echo "  - dave / password (id: 126)"
echo "  - eve / password (id: 127)"
echo ""
