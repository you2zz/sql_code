CREATE TABLE IF NOT EXISTS Genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Artist (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Album (
    album_id SERIAL PRIMARY KEY,
    album_title VARCHAR(250) NOT NULL,
    year_of_release INTEGER NOT NULL CHECK (year_of_release > 1900)
);

CREATE TABLE IF NOT EXISTS Track (
    track_id SERIAL PRIMARY KEY,
    track_name VARCHAR(250) NOT NULL,
    track_duration INTEGER NOT NULL CHECK (track_duration > 0),
    album_id INTEGER REFERENCES Album (album_id)
);

CREATE TABLE IF NOT EXISTS Collections (
    collections_id SERIAL PRIMARY KEY,
    collections_title VARCHAR(250) NOT NULL UNIQUE,
    year_of_release INTEGER NOT NULL CHECK (year_of_release > 1900)
);

CREATE TABLE IF NOT EXISTS genre_artist (
    artist_id INTEGER NOT NULL REFERENCES Artist (artist_id),
    genre_id INTEGER NOT NULL REFERENCES Genre (genre_id),
    CONSTRAINT genre_artist_pk PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS artist_album (
    artist_id INTEGER NOT NULL REFERENCES Artist (artist_id),
    album_id INTEGER NOT NULL REFERENCES Album (album_id),
    CONSTRAINT artist_album_pk PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS track_collections (
    track_id INTEGER NOT NULL REFERENCES Track (track_id),
    collections_id INTEGER NOT NULL REFERENCES Collections (collections_id),
    CONSTRAINT track_collections_pk PRIMARY KEY (track_id, collections_id)
);