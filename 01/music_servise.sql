CREATE TABLE IF NOT EXISTS Genre (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Artist (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Album (
    album_id SERIAL PRIMARY KEY,
    album_title VARCHAR(250) NOT NULL,
    year_of_release interval YEAR NOT NULL
);

CREATE TABLE IF NOT EXISTS Track (
    track_id SERIAL PRIMARY KEY,
    track_name VARCHAR(250) NOT NULL,
    track_duration INTEGER NOT NULL,
    album_id INTEGER REFERENCES Album (album_id)
);

CREATE TABLE IF NOT EXISTS Collections (
    collections_id SERIAL PRIMARY KEY,
    collections_title VARCHAR(250) NOT NULL,
    year_of_release date  NOT NULL
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

INSERT INTO genre (genre_name)
VALUES ('Heavy metal');

INSERT INTO artist (artist_name)
VALUES ('Accept');

INSERT INTO genre_artist (artist_id, genre_id)
VALUES (1, 1);

INSERT INTO album (album_title, year_of_release)
VALUES ('Hungry Years', 1986);

INSERT INTO artist_album (artist_id, album_id)
VALUES (1, 1);



SELECT * FROM genre_artist;