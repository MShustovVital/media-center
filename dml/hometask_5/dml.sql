--1 - хочу найти все фильмы, которые начинаются с 'terminator'
select name, release_date from public.films where name like 'terminator%';

--2 Разница между запросами в том, что первый запрос с иннер джоином выведет только те фильмы, страны которых присутствуют в таблице countries. А второй запрос выведет все фильмы, а для тех, где не будет найдено название страны подставится null
select f.name, c.name from films f inner join countries c on f.country_id = c.id;
select f.name, c.name from films f left join countries c on f.country_id = c.id;

--3
INSERT INTO country (name) VALUES ('Belarus') RETURNING name;

--4
UPDATE films
SET rating = 8.5
FROM film_genres
WHERE films.film_genre_id = film_genres.id
  AND film_genres.name = 'Drama';

--5
DELETE
FROM public.films
    USING public.film_genres
WHERE public.films.film_genre_id = public.film_genres.id
  AND public.film_genres.name = 'Movie';

-- * При помощи утилиты COPY можно экспортировать данные. В данном примере мы экспортируем данные из таблицы films в csv файл, у которого разделитель ','
COPY public.films TO '/folder/films.csv' DELIMITER ',' CSV HEADER;

