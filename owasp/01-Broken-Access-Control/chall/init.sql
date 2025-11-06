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
    (3, 'Carol', 'carol', '$2y$10$UusDKHA0P/3xMJjUoLTMze47kq2MF75w8zQgFNbhKHcGchFH1yqBi', 'FR8510096000704865227838C12', 760.55),
    (4,  'Emma',    'emma',    '$2b$10$aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'FR2210098000604865123456B98', 340.20),
    (5,  'Frank',   'frank',   '$2b$10$bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 'FR5512579000102148999999C77', 820.00),
    (6,  'Grace',   'grace',   '$2b$10$cccccccccccccccccccccccccccccccccccccc', 'FR8412456000502198765432D43', 22000.50),
    (7,  'Hannah',  'hannah',  '$2b$10$dddddddddddddddddddddddddddddddddddddd', 'FR5414508000502853476543E21', 430.00),
    (8,  'Ian',     'ian',     '$2b$10$eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee', 'FR6512739000502148389336F99', 1999.99),
    (9,  'Julia',   'julia',   '$2b$10$ffffffffffffffffffffffffffffffffffffff', 'FR4312097000301865432123G56', 870.45),
    (10, 'Kevin',   'kevin',   '$2b$10$11111111111111111111111111111111111111', 'FR2712001000202853000000H88', 130.75),
    (11, 'Laura',   'laura',   '$2b$10$22222222222222222222222222222222222222', 'FR9115006000702123456677I11', 5500.00),
    (12, 'Mike',    'mike',    '$2b$10$33333333333333333333333333333333333333', 'FR6610096000704865227838J24', 75.10),
    (13, 'Nina',    'nina',    '$2b$10$44444444444444444444444444444444444444', 'FR5015006000702198765123K30', 1600.00),
    (14, 'Oscar',   'oscar',   '$2b$10$55555555555555555555555555555555555555', 'FR8012345000901234567890L55', 45.00),

    (16, 'Paula',   'paula',   '$2b$10$66666666666666666666666666666666666666', 'FR6111111000203334445556M12', 980.20),
    (17, 'Quentin', 'quentin', '$2b$10$77777777777777777777777777777777777777', 'FR4412233000405566677889N34', 120.60),
    (18, 'Rita',    'rita',    '$2b$10$88888888888888888888888888888888888888', 'FR9912345000601234567890O78', 2300.00),
    (19, 'Steve',   'steve',   '$2b$10$99999999999999999999999999999999999999', 'FR1411223000809876543210P90', 15.75),
    (20, 'Tina',    'tina',    '$2b$10$aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbb', 'FR5512098000102223334445Q21', 502.40),
    (21, 'Uma',     'uma',     '$2b$10$bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcc', 'FR6610987000203334445556R32', 760.00),
    (22, 'Viktor',  'viktor',  '$2b$10$ccccccccccccccccccccccccccccccccccccccd', 'FR7712345000304445556667S43', 999.99),
    (23, 'Wendy',   'wendy',   '$2b$10$dddddddddddddddddddddddddddddddddddddde', 'FR8812345000405556667778T54', 1340.00),
    (24, 'Xavier',  'xavier',  '$2b$10$eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeef', 'FR9912345000506667778889U65', 57.25),
    (25, 'Yara',    'yara',    '$2b$10$fffffffffffffffffffffffffffffffffffff00', 'FR1012345000607778889990V76', 300.00),

    (26, 'Zoe',     'zoe',     '$2b$10$12121212121212121212121212121212121212', 'FR1212345000708889990001W87', 75.00),
    (27, 'Adam',    'adam',    '$2b$10$13131313131313131313131313131313131313', 'FR1312345000809990001112X98', 420.50),
    (28, 'Bella',   'bella',   '$2b$10$14141414141414141414141414141414141414', 'FR1412345000900001112223Y09', 1500.00),
    (29, 'Cesar',   'cesar',   '$2b$10$15151515151515151515151515151515151515', 'FR1512345000101112223334Z11', 880.80),
    (30, 'Diana',   'diana',   '$2b$10$16161616161616161616161616161616161616', 'FR1612345000202223334445A22', 60.60),
    (31, 'Ethan',   'ethan',   '$2b$10$17171717171717171717171717171717171717', 'FR1712345000303334445556B33', 210.10),
    (32, 'Fiona',   'fiona',   '$2b$10$18181818181818181818181818181818181818', 'FR1812345000404445556667C44', 1450.00),
    (33, 'Gabe',    'gabe',    '$2b$10$19191919191919191919191919191919191919', 'FR1912345000505556667778D55', 77.77),
    (34, 'Helena',  'helena',  '$2b$10$1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a', 'FR2012345000606667778889E66', 9999.99),
    (35, 'Ivo',     'ivo',     '$2b$10$2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b', 'FR2112345000707778889990F77', 5.00),

    (36, 'Jo',      'jo',      '$2b$10$2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c2c', 'FR2212345000808889990001G88', 2020.02),
    (37, 'Kara',    'kara',    '$2b$10$2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d', 'FR2312345000909990001112H99', 620.00),
    (38, 'Liam',    'liam',    '$2b$10$2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e2e', 'FR2412345000100001112223I12', 333.33),
    (39, 'Maya',    'maya',    '$2b$10$2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f', 'FR2512345000201112223334J23', 410.40),
    (40, 'Noah',    'noah',    '$2b$10$3030303030303030303030303030303030303030', 'FR2612345000302223334445K34', 987.65),
    (41, 'Olga',    'olga',    '$2b$10$3131313131313131313131313131313131313131', 'FR2712345000403334445556L45', 12.34),
    (42, 'Bernard', 'bernard', '$2y$10$UusDKHA0P/3xMJjUoLTMze47kq2MF75w8zQgFNbhKHcGchFH1yqBi', 'FR6512739000502148389336H54', 999999999999999.00);

-- Insert demo transactions
INSERT OR IGNORE INTO transactions (id, user_id, amount, description, date) VALUES
    (1, 1, -40.0, 'Coffee Shop', '2025-10-16'),
    (2, 1, -120.0, 'Rent', '2025-10-03'),
    (3, 5, 500000000.0, 'Salary', '2025-10-10'),
    (4, 5, -1.0, 'Taxes', '2025-10-08'),
    (5, 3, 800.0, 'Freelance Payment', '2025-10-12');
