-- Создать индекс к какой-либо из таблиц вашей БД
-- Здесь представлен индекс для полнотекстового поиска
CREATE INDEX idx_films_name ON public.films USING GIN (to_tsvector('english', name));

EXPLAIN SELECT *
        FROM public.films
        WHERE to_tsvector('english', name) @@ to_tsquery('english', 'search_query');

-- Возвращает следующий результат:

-- Bitmap Heap Scan on films  (cost=12.00..16.26 rows=1 width=1874)
-- "  Recheck Cond: (to_tsvector('english'::regconfig, (name)::text) @@ '''search'' <-> ''queri'''::tsquery)"
--   ->  Bitmap Index Scan on idx_films_name  (cost=0.00..12.00 rows=1 width=0)
-- "        Index Cond: (to_tsvector('english'::regconfig, (name)::text) @@ '''search'' <-> ''queri'''::tsquery)"
-- Он говорит нам о том, что индекс полнотекстового поиска используется успешно

-- Реализовать индекс на часть таблицы или индекс
-- на поле с функцией
CREATE INDEX idx_people_full_name ON public.people USING GIN(to_tsvector('english', full_name));

-- поле full_name - формируется из  (name || ' ' || surname) STORED,

-- Создать индекс на несколько полей
CREATE INDEX idx_films_duration_ration ON public.films (duration, rating);
