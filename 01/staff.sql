CREATE TABLE IF NOT EXISTS Staff (
    employee_id SERIAL PRIMARY KEY,
    employe_name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Department (
    department_id SERIAL PRIMARY key,
    department_name VARCHAR(60) NOT NULL CONSTRAINT must_be_different_department_name UNIQUE
);

CREATE TABLE IF NOT EXISTS Management (
    boss_id SERIAL PRIMARY KEY,
    post_name VARCHAR(60) NOT NULL CONSTRAINT must_be_different_post_name UNIQUE,
    subordinate_department INTEGER NOT NULL REFERENCES Department (department_id),
    employee_id INTEGER REFERENCES Staff (employee_id)
);

ALTER TABLE Staff ADD COLUMN department_id INTEGER NOT NULL REFERENCES Department (department_id);
ALTER TABLE Staff ADD COLUMN boss_id INTEGER REFERENCES Management (boss_id);
ALTER TABLE Department ADD COLUMN head_of_department INTEGER REFERENCES Management (boss_id);