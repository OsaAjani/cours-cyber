-- init.sql
-- Database initialization script for SecureBank CTF

PRAGMA foreign_keys = ON;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    account_number TEXT NOT NULL,
    balance REAL NOT NULL
);

-- Create transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    description TEXT NOT NULL,
    date TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Insert demo users
INSERT OR IGNORE INTO users (id, name, username, password, account_number, balance) VALUES
    (1, 'Alice', 'alice', '$2b$10$.3FyaoKyXEKeGiC51FVBqeovk3KMQ1O18gxcsb0qiBPy.Jnj9DBzS', 'FR1414508000502853468675D61', 5400.40),
    (5, 'Bernard', 'bernard', '$2y$10$UusDKHA0P/3xMJjUoLTMze47kq2MF75w8zQgFNbhKHcGchFH1yqBi', 'FR6512739000502148389336H54', 999999999999999.00),
    (3, 'Carol', 'carol', '$2y$10$UusDKHA0P/3xMJjUoLTMze47kq2MF75w8zQgFNbhKHcGchFH1yqBi', 'FR8510096000704865227838C12', 760.55);

-- Insert demo transactions
INSERT OR IGNORE INTO transactions (id, user_id, amount, description, date) VALUES
    (1, 1, -40.0, 'Coffee Shop', '2025-10-16'),
    (2, 1, -120.0, 'Rent', '2025-10-03'),
    (3, 5, 500000000.0, 'Salary', '2025-10-10'),
    (4, 5, -1.0, 'Taxes', '2025-10-08'),
    (5, 3, 800.0, 'Freelance Payment', '2025-10-12');
