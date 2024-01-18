DROP TABLE IF EXISTS
users, film, rating_mpa, genre, film_genre, likes, friends, film_directors, directors, reviews, feed, review_rates CASCADE;

CREATE TABLE IF NOT EXISTS users
(
    user_id  integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email    varchar(100) NOT NULL,
    login    varchar(100) NOT NULL,
    name     varchar(100) NOT NULL,
    birthday date         NOT NULL
);

CREATE TABLE IF NOT EXISTS rating_mpa
(
    id   integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS directors
(
    director_id integer     GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name        varchar(200)     NOT NULL
);

CREATE TABLE IF NOT EXISTS film
(
    film_id      integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name         varchar(200) NOT NULL,
    description  varchar(200) NOT NULL,
    release_date date         NOT NULL,
    duration     REAL DEFAULT 1,
    rating_id    integer      NOT NULL
);

CREATE TABLE IF NOT EXISTS film_directors
(
    film_directors_id   integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    film_id             integer REFERENCES film (film_id)           ON DELETE CASCADE ON UPDATE CASCADE,
    director_id         integer REFERENCES directors (director_id)  ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS genre
(
    genre_id integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name     varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS film_genre
(
    genre_id integer NOT NULL,
    film_id  integer NOT NULL,
    CONSTRAINT fk_film
        FOREIGN KEY (film_id)
            REFERENCES film (film_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_genre
        FOREIGN KEY (genre_id)
            REFERENCES genre (genre_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS likes
(
    user_id integer NOT NULL,
    film_id integer NOT NULL,
    CONSTRAINT fk_film_likes
        FOREIGN KEY (film_id)
            REFERENCES film (film_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_user_likes
        FOREIGN KEY (user_id)
            REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS friends
(
    user_id   integer NOT NULL,
    friend_id integer NOT NULL,
    status    boolean,
    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
            REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_user_friend
        FOREIGN KEY (friend_id)
            REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews
(
    review_id       integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    content         varchar(200) NOT NULL,
    is_positive     boolean      NOT NULL,
    user_id         integer      REFERENCES users (user_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    film_id         integer      REFERENCES film (film_id)   ON DELETE CASCADE ON UPDATE CASCADE,
    useful          integer      DEFAULT 0
);

CREATE TABLE IF NOT EXISTS review_rates
(
    review_id       integer REFERENCES reviews (review_id)  ON DELETE CASCADE ON UPDATE CASCADE,
    user_id         integer REFERENCES users (user_id)      ON DELETE CASCADE ON UPDATE CASCADE,
    is_like         boolean,

    PRIMARY KEY (review_id, user_id)
);

CREATE TABLE IF NOT EXISTS event_type
(
    type_id        integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    type_name      varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS type_operation
(
    operation_id        integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operation_name      varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS feed
(
    event_id           integer GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    timestamp_event    timestamp default current_timestamp,
    user_id            integer REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    event_type_id      integer REFERENCES event_type (type_id) ON DELETE CASCADE ON UPDATE CASCADE,
    type_operation_id  integer REFERENCES type_operation (operation_id) ON DELETE CASCADE ON UPDATE CASCADE,
    entity_id          integer NOT NULL
);

ALTER TABLE film
    ADD FOREIGN KEY (rating_id) REFERENCES rating_mpa (id);
ALTER TABLE film_genre
    ADD CONSTRAINT key_film_genre PRIMARY KEY (genre_id, film_id);
ALTER TABLE friends
    ADD CONSTRAINT key_friends PRIMARY KEY (user_id, friend_id);