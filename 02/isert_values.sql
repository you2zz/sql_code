-- добавляем жанры

INSERT INTO genre (genre_name) VALUES
    ('Рок'),
    ('Металл'),
    ('Джазз'),
    ('R&B');
  
-- добавляем исполнителей

INSERT INTO artist (artist_name) VALUES
    ('Metallica'),
    ('Iron Maiden'),
    ('Би-2'),
    ('Nirvana'),
    ('Frank Sinatra'),
    ('Ray Charles');

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
    ('Have a Smile with Me', 2019); -- Ray Charles

-- добавляем треки

INSERT INTO track (track_name, track_duration, album_id) VALUES
    ('That Was Just Your Life', 468, 1),
    ('The Judas Kiss', 480, 1),
    ('my own', 231, 1),
    ('Hardwired', 189, 2),
    ('Atlas, Rise!', 281, 2),
    ('own my', 214,2),
    ('Shadows Follow', 365, 3),
    ('Chasing Light', 401, 3),
    ('my', 235, 3),
    ('El Dorado', 265, 4),
    ('Coming Home', 378, 4),
    ('oh my god', 201, 4),
    ('Starblind', 382, 5),
    ('When the Wild Wind Blows', 259, 5),
    ('myself', 196, 5),
    ('Mother of Mercy', 352, 6),
    ('Satellite 15… The Final Frontier', 201, 6),
    ('by myself', 300, 6),
    ('Мой лётчик', 351, 7),
    ('Чёрное солнце', 294, 7),
    ('bemy self', 203, 7),
    ('Детство', 651, 8),
    ('Мой талисман', 482, 8),
    ('myself by', 245, 8),
    ('Алиса', 298, 9),
    ('by myself by', 187, 9),
    ('Blew', 186, 10),
    ('About a Girl', 196, 10),
    ('beemy', 198, 10),
    ('It is my life', 175, 11),
    ('Swap Meet', 203, 11),
    ('premyne', 301, 11),
    ('Negative Creep', 348, 12),
    ('Scoff', 311, 12),
    ('My Kind Of Broadway', 401, 13),
    ('My Way', 297, 13),
    ('She Shot Me Down', 249, 14),
    ('Close To You', 201, 14),
    ('Look To Your Heart', 189, 15),
    ('Funny', 176, 15),
    ('You Know', 240, 16),
    ('X-Ray Blues', 189, 16),
    ('Let The Good Times Roll', 148, 17),
    ('The Right Time', 216, 17),
    ('If I Give You My Love', 198, 18),
    ('Sitting On The Top Of The World', 217, 18);

-- добавляем сборники   

INSERT INTO collections (collections_title, year_of_release) VALUES
    ('The best of jazz and R&B', 2018),
    ('The best of metall', 2019),
    ('Нeavy wave', 2016),
    ('Oh this blues', 2020),
    ('Rock is alive', 2017);

-- связываем жанры и исполнителей

INSERT INTO genre_artist (artist_id, genre_id) VALUES
    (1, 2),
    (1, 1),
    (2, 1),
    (2, 2),
    (3, 1),
    (4, 1),
    (4, 2),
    (5, 3),
    (6, 3),
    (6, 4);

-- связываем альбомы и исполнителей

INSERT INTO artist_album (artist_id, album_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5),
    (2, 6),
    (3, 7),
    (3, 8),
    (3, 9),
    (4, 10),
    (4, 11),
    (4, 12),
    (5, 13),
    (5, 14),
    (5, 15),
    (6, 16),
    (6, 17),
    (6, 18);

-- связываем сборники и треки

INSERT INTO track_collections (collections_id, track_id) VALUES
    (1, 30),
    (1, 31),
    (1, 32),
    (1, 33),
    (1, 34),
    (2, 1),
    (2, 2),
    (2, 3),
    (2, 7),
    (2, 8),
    (3, 9),
    (3, 7),
    (3, 11),
    (3, 1),
    (3, 3),
    (4, 35),
    (4, 34),
    (4, 27),
    (4, 25),
    (4, 30),
    (5, 13),
    (5, 16),
    (5, 20),
    (5, 17),
    (5, 18),
    (5, 21);