-- ============================================================
--  GameVerse Academy — Script SQL pour la table CLIENTS
--  À exécuter dans PostgreSQL (pgAdmin ou psql)
--  Base de données : gameverseacademy
-- ============================================================

-- 1. Créer la table clients
CREATE TABLE IF NOT EXISTS clients (
    id               SERIAL PRIMARY KEY,
    nom              VARCHAR(100) NOT NULL,
    prenom           VARCHAR(100) NOT NULL,
    email            VARCHAR(200) NOT NULL UNIQUE,
    telephone        VARCHAR(30),
    pays             VARCHAR(80),
    abonnement       VARCHAR(20) NOT NULL DEFAULT 'FREE'
                        CHECK (abonnement IN ('FREE','SILVER','GOLD','PLATINUM')),
    mods_achetes     INTEGER NOT NULL DEFAULT 0,
    solde            NUMERIC(10,2) NOT NULL DEFAULT 0.00,
    date_inscription TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    actif            BOOLEAN NOT NULL DEFAULT TRUE
);

-- 2. Insérer des données de test
INSERT INTO clients (nom, prenom, email, telephone, pays, abonnement, mods_achetes, solde, actif)
VALUES
  ('El Amrani',   'Youssef',   'youssef.elamrani@email.ma',  '+212 661 234 567', 'Maroc',    'GOLD',     12, 350.00, true),
  ('Benali',      'Fatima',    'fatima.benali@mail.com',     '+212 662 345 678', 'Maroc',    'PLATINUM', 27, 120.50, true),
  ('Dupont',      'Pierre',    'pierre.dupont@gmail.com',    '+33 6 12 34 56 78','France',   'SILVER',    5,  80.00, true),
  ('Martin',      'Sophie',    'sophie.martin@yahoo.fr',     '+33 6 98 76 54 32','France',   'FREE',      1,  15.00, true),
  ('Khoury',      'Karim',     'karim.khoury@hotmail.com',   '+213 555 123 456', 'Algérie',  'GOLD',      9, 200.00, true),
  ('Trabelsi',    'Nadia',     'nadia.trabelsi@email.tn',    '+216 20 123 456',  'Tunisie',  'SILVER',    3,  60.00, false),
  ('Hassan',      'Mohamed',   'hassan.mo@gameverseacad.ma', '+212 700 111 222', 'Maroc',    'FREE',      0,   0.00, true),
  ('Lecomte',     'Emma',      'emma.lecomte@outlook.be',    '+32 470 123 456',  'Belgique', 'PLATINUM', 31, 500.00, true);

-- 3. Vérification
SELECT id, nom, prenom, email, abonnement, actif FROM clients ORDER BY id;

-- ============================================================
-- Table MODS (si pas encore créée — rappel pour référence)
-- ============================================================
-- CREATE TABLE IF NOT EXISTS mods (
--     id           SERIAL PRIMARY KEY,
--     title        VARCHAR(200) NOT NULL,
--     category     VARCHAR(100),
--     author       VARCHAR(150),
--     description  TEXT,
--     downloads    INTEGER DEFAULT 0,
--     created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     developer    VARCHAR(200),
--     publisher    VARCHAR(200),
--     platform     VARCHAR(100),
--     release_date VARCHAR(50),
--     metacritic   INTEGER DEFAULT 0
-- );
