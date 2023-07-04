CREATE TABLE IF NOT EXISTS clients (
    client_id  SERIAL PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    e_mail  VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS phones(
    phone_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients (client_id) ON DELETE CASCADE,
    phone_number TEXT NOT NULL UNIQUE
    CHECK (phone_number ~ '^\d{9}$')
);

-- заполнение таблицы
INSERT INTO clients (first_name, last_name, e_mail) VALUES
    ('Юрий', 'Власов', 'yrivla@gmail.com'),
    ('Юрий', 'Квасов', 'yriлмфa@gmail.com');

INSERT INTO phones (client_id, phone_number) VALUES
    (1, 9826123876),
    (1, '9826123877'),
    (2, '9126108098'),
    (2, '912612358');

DELETE FROM phones
WHERE phone_id = 7;