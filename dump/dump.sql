CREATE TABLE film_genres
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

CREATE TABLE film_types
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

CREATE TABLE roles
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

CREATE TABLE countries
(
    id  SERIAL PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

CREATE TABLE films
(
    id  SERIAL PRIMARY KEY,
    name          VARCHAR(128)   NOT NULL,
    release_date   DATE           NOT NULL,
    film_type_id  BIGINT         NOT NULL,
    film_genre_id BIGINT         NOT NULL,
    country_id    BIGINT         NOT NULL,
    description   VARCHAR(255)   NULL,
    duration      INT         NOT NULL,
    rating        DECIMAL(10, 2) NOT NULL,
    image_url      VARCHAR(255)   NULL,

    FOREIGN KEY (film_type_id) REFERENCES film_types (id) ON UPDATE CASCADE,
    FOREIGN KEY (film_genre_id) REFERENCES film_genres (id) ON UPDATE CASCADE,
    FOREIGN KEY (country_id) REFERENCES countries (id) ON UPDATE CASCADE
);

CREATE TABLE people
(
    id  SERIAL PRIMARY KEY,
    name          VARCHAR(64)  NOT NULL,
    surname       VARCHAR(64)  NOT NULL,
    full_name     VARCHAR(255) GENERATED ALWAYS AS (name || ' ' || surname) STORED,
    date_of_birth DATE         NOT NULL,
    description   VARCHAR(255) NULL,
    image_url      VARCHAR(255) NULL
);

CREATE TABLE people_film_roles
(
    role_id   BIGINT NOT NULL,
    people_id BIGINT NOT NULL,
    film_id   BIGINT NOT NULL,

    FOREIGN KEY (role_id) REFERENCES roles (id) ON UPDATE CASCADE,
    FOREIGN KEY (people_id) REFERENCES people (id) ON UPDATE CASCADE,
    FOREIGN KEY (film_id) REFERENCES films (id) ON UPDATE CASCADE,
    UNIQUE (role_id, people_id, film_id)
);

CREATE INDEX idx_name ON films (name);
CREATE INDEX idx_rating ON films (rating);
CREATE INDEX idx_film_type_id ON films (film_type_id);
CREATE INDEX idx_film_genre_id ON films (film_genre_id);
CREATE INDEX idx_country_id ON films (country_id);

CREATE INDEX idx_full_name on people (full_name);
