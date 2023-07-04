CREATE TABLE IF NOT EXISTS clients (
    client_id  SERIAL PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    e_mail  VARCHAR(60) NOT NULL UNIQUE
    CHECK (e_mail ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$')
);

CREATE TABLE IF NOT EXISTS phones(
    phone_id SERIAL PRIMARY KEY,
    client_id INTEGER REFERENCES clients (client_id) ON DELETE CASCADE,
    phone_number TEXT NOT NULL UNIQUE
    CHECK (phone_number ~ '^\d{10}$')
);

-- заполнение таблицы
INSERT INTO clients (first_name, last_name, e_mail) VALUES
    ('Юрий', 'Власов', 'yrivla@gmail.com'),
    ('Юрий', 'Квасов', 'yriлмфa@gmail.com');

INSERT INTO phones (client_id, phone_number) VALUES
    (1, '79826123876'),
    (1, '79826123877'),
    (2, '79126108098'),
    (2, '79126123581');

DELETE FROM phones
WHERE phone_id = 7;


-- вариант приналичии телефонеа
with rows as (
INSERT INTO clients (first_name, last_name, e_mail) VALUES ('Вахтангий', 'Власов', 'vxrivla@gmail.com') RETURNING client_id 
)
INSERT INTO phones (client_id, phone_number) 
SELECT client_id, '912612354'
FROM rows;