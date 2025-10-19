#!/bin/bash
# install.sh - Installation script for SecureBank CTF

set -e

echo "🏦 SecureBank CTF - Installation Script"
echo "======================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are available"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Check if sqlite3 command is available
if command -v sqlite3 &> /dev/null; then
    echo "✅ sqlite3 command found"
    
    # Initialize database
    echo "🗄️  Initializing database..."
    sqlite3 securebank.db < init.sql
    echo "✅ Database initialized successfully"
else
    echo "⚠️  sqlite3 command not found. Database will be initialized programmatically."
    echo "   You can install sqlite3 with:"
    echo "   - Ubuntu/Debian: sudo apt install sqlite3"
    echo "   - macOS: brew install sqlite"
    echo "   - Windows: Download from https://sqlite.org/download.html"
fi

echo ""
echo "🎉 Installation completed!"
echo ""
echo "To start the application:"
echo "  npm start"
echo ""
echo "Then open your browser to:"
echo "  http://localhost:3000"
echo ""
echo "Demo accounts:"
echo "  - alice / password"
