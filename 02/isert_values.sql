-- добавляем жанры

INSERT INTO genre (genre_name) VALUES
    ('Рок'),
    ('Металл'),
    ('Джазз'),
    ('Блюз');   

-- добавляем исполнителей

INSERT INTO artist (artist_name) VALUES
    ('Metallica'),
    ('Iron Maiden'),
    ('Би-2'),
    ('Nirvana'),
    ('Frank Sinatra'),
    ('Ray Charles'),
    ('B.B. King'),
    ('Eric Clapton');
    

-- добавляем альбомы

INSERT INTO album (album_title, year_of_release) VALUES
    ('Death Magnetic', 2017), -- металлика
    ('Hardwired... to Self-Destruct', 2018), -- металлика
    ('72 Seasons', 2020), -- металлика
    ('The Final Frontier', 2010), -- iron maiden
    ('The Book of Souls', 2015), -- iron maiden
    ('Senjutsu', 2019), -- iron maiden
    ('Горизонт событий', 2017), -- Би-2
    ('Нечетный воин', 2019), -- Би-2
    ('Аллилуйя', 2022), -- Би-2
    ('Bleach', 2017), -- Nirvana
    ('Nevermind', 2018), -- Nirvana
    ('In Utero', 2020), -- Nirvana
    ('Close To You', 2017), -- Frank Sinatra
    ('No One Cares', 2018), -- Frank Sinatra
    ('All The Way', 2019), -- Frank Sinatra
    ('Basin Street Blues', 2010), -- Ray Charles
    ('Soul Meeting', 2018), -- Ray Charles
    ('Have a Smile with Me', 2019), -- Ray Charles
    ('Take It Home', 2016), -- B.B. King
    ('Love Me Tender', 2018), -- B.B. King
    ('Guess Who', 2020), -- B.B. King
    ('Happy Xmas', 2018), -- Eric Clapton
    ('I Still Do', 2019), -- Eric Clapton
    ('Old Sock', 2020);  -- Eric Clapton

-- добавляем треки

INSERT INTO track (track_name, track_duration, album_id) VALUES
    ('That Was Just Your Life', 468, 1),
    ('The Judas Kiss', 480, 1),
    ('Hardwired', 189, 2),
    ('Atlas, Rise!', 281, 2),
    ('Shadows Follow', 365, 3),
    ('Chasing Light', 401, 3),
    ('El Dorado', 265, 4),
    ('Coming Home', 378, 4),
    ('Starblind', 382, 5),
    ('When the Wild Wind Blows', 259, 5),
    ('Mother of Mercy', 352, 6),
    ('Satellite 15… The Final Frontier', 201, 6),