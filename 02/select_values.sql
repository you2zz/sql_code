-- название и продолжительность самого длительного трека
SELECT track_name, track_duration FROM track
WHERE track_duration = (SELECT MAX(track_duration) from track);

-- название треков, продолжительность которых не менн 3,5 минут
SELECT track_name FROM track
WHERE track_duration >= 60 * 3.5;

-- названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT collections_title FROM collections
WHERE year_of_release BETWEEN 2018 AND 2020;

-- исполнители, чье имя состоит из одного слова
SELECT artist_name FROM artist
WHERE artist_name NOT IN 
(SELECT artist_name FROM artist
WHERE artist_name like '% %');

-- исполнители, чье имя состоит из олного слова var.2
SELECT artist_name FROM artist
WHERE (LENGTH(artist_name) - LENGTH(REPLACE(artist_name, ' ', ''))) = 0;

/* название треков, которые содержат "мой" или "my" */
SELECT track_name FROM track
WHERE track_name ILIKE '% my'
or track_name ILIKE 'my %'
or track_name ILIKE '% my %'
or track_name ILIKE 'my'
or track_name ilike '% мой'
or track_name ILIKE 'мой %'
or track_name ILIKE '% мой %'
or track_name ILIKE 'мой';

/* название треков, которые содержат "мой" или "my" */
SELECT track_name FROM track
WHERE string_to_array(LOWER(track_name), ' ') && array ['my', 'мой'];

/* название треков, которые содержат "мой" или "my" */
SELECT track_name FROM track
where regexp_like(track_name, '\ymy[[:>:]]', 'i')
or regexp_like(track_name, '\yмой[[:>:]]', 'i');

/* название треков, которые содержат "мой" или "my" */
SELECT track_name FROM track
where track_name ~* '\ymy[[:>:]]'
or track_name ~* '\yмой[[:>:]]';

-- количество исполнителей в каждом жанре
SELECT g.genre_name, COUNT(artist_id) FROM genre_artist ga
JOIN genre g ON g.genre_id = ga.genre_id 
GROUP BY g.genre_name, g.genre_id
ORDER BY g.genre_id;

-- количество треков, вошедших в альбомы 2019-2020 годов
SELECT COUNT(track_id) FROM track t 
JOIN album a ON t.album_id = a.album_id 
WHERE a.year_of_release BETWEEN 2019 AND 2020;

-- средняя продолжительность треков по каждому альбому
SELECT a.album_title, AVG(track_duration) FROM track t
JOIN album a ON a.album_id = t.album_id
GROUP BY a.album_title;

-- все исполнители, которые не выпустили альбомы в 2020 году
SELECT artist_name FROM artist
WHERE artist_name NOT IN
(SELECT a.artist_name FROM artist a 
JOIN artist_album aa ON a.artist_id = aa.artist_id 
JOIN album a2 ON aa.album_id = a2.album_id 
WHERE a2.year_of_release IN (2020));

-- названия сборников, в которых присутствует исполнитель Metallica
SELECT collections_title FROM collections c 
JOIN track_collections tc ON c.collections_id = tc.collections_id 
JOIN track t ON tc.track_id = t.track_id 
JOIN album a ON t.album_id = a.album_id 
JOIN artist_album aa ON a.album_id = aa.album_id 
JOIN artist a2 ON aa.artist_id = a2.artist_id 
WHERE a2.artist_name = 'Metallica'
GROUP BY collections_title;

-- названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT album_title FROM album a 
JOIN artist_album aa ON a.album_id = aa.album_id 
JOIN artist a2 ON a2.artist_id = aa.artist_id 
JOIN genre_artist ga ON a2.artist_id = ga.artist_id 
GROUP BY album_title
HAVING COUNT(genre_id) > 1;

-- наименования треков, которые не входят в сборники
SELECT track_name FROM track
WHERE track_name  NOT IN
(SELECT track_name FROM track t 
JOIN track_collections tc ON t.track_id = tc.track_id 
GROUP BY track_name);

-- исполнитель,написавший самый короткий по продолжительности трек
SELECT artist_name FROM artist a 
JOIN artist_album aa ON a.artist_id = aa.artist_id 
JOIN album a2 ON a2.album_id = aa.album_id 
JOIN track t ON a2.album_id = t.album_id 
where track_duration = (SELECT min(track_duration)  FROM track t);

-- названия альбомов, содержащих наименьшее количество треков
SELECT album_title FROM album a 
JOIN track t ON a.album_id = t.album_id  
GROUP BY album_title
HAVING 
COUNT(*) = (SELECT MIN(c) FROM (SELECT COUNT(*) AS c FROM track GROUP BY album_id) AS q);