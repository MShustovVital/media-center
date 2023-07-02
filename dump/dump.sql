CREATE SCHEMA private;
CREATE ROLE super_admin;
CREATE ROLE operator;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA private TO super_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO super_admin;
GRANT USAGE ON SCHEMA public TO operator;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO operator;

CREATE TABLE public.film_genres
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
) TABLESPACE pg_global;

CREATE TABLE public.film_types
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
) TABLESPACE pg_global;

CREATE TABLE public.roles
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
) TABLESPACE pg_global;

CREATE TABLE public.countries
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
) TABLESPACE pg_global;

CREATE TABLE public.films
(
    id  SERIAL PRIMARY KEY,
    name          VARCHAR(128)   NOT NULL,
    release_date   DATE           NOT NULL,
    film_type_id  BIGINT         NOT NULL,
    film_genre_id BIGINT         NOT NULL,
    country_id    BIGINT         NOT NULL,
    description   VARCHAR(255)   NULL,
    duration      INT         NOT NULL CHECK (duration > 0),
    rating        DECIMAL(10, 2) NOT NULL CHECK (rating between 0 AND 10),
    image_url      VARCHAR(255)   NULL,

    FOREIGN KEY (film_type_id) REFERENCES film_types (id) ON UPDATE CASCADE,
    FOREIGN KEY (film_genre_id) REFERENCES film_genres (id) ON UPDATE CASCADE,
    FOREIGN KEY (country_id) REFERENCES countries (id) ON UPDATE CASCADE
) TABLESPACE data;

CREATE TABLE public.people
(
    id  SERIAL PRIMARY KEY,
    name          VARCHAR(64)  NOT NULL,
    surname       VARCHAR(64)  NOT NULL,
    full_name     VARCHAR(255) GENERATED ALWAYS AS (name || ' ' || surname) STORED,
    date_of_birth DATE         NOT NULL,
    description   VARCHAR(255) NULL,
    image_url      VARCHAR(255) NULL
) TABLESPACE pg_global;

CREATE TABLE public.people_film_roles
(
    role_id   BIGINT NOT NULL,
    people_id BIGINT NOT NULL,
    film_id   BIGINT NOT NULL,

    FOREIGN KEY (role_id) REFERENCES roles (id) ON UPDATE CASCADE,
    FOREIGN KEY (people_id) REFERENCES people (id) ON UPDATE CASCADE,
    FOREIGN KEY (film_id) REFERENCES films (id) ON UPDATE CASCADE,
    UNIQUE (role_id, people_id, film_id)
) TABLESPACE pg_global;

CREATE INDEX idx_films_name ON public.films (name) TABLESPACE pg_default;
CREATE INDEX idx_films_rating ON public.films (rating) TABLESPACE pg_default;
CREATE INDEX idx_films_film_type_id ON public.films (film_type_id) TABLESPACE pg_default;
CREATE INDEX idx_films_film_genre_id ON public.films (film_genre_id) TABLESPACE pg_default;
CREATE INDEX idx_films_country_id ON public.films (country_id) TABLESPACE pg_default;
CREATE INDEX idx_people_full_name ON public.people (full_name) TABLESPACE pg_default;
