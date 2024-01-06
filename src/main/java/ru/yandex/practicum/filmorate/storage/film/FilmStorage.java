package ru.yandex.practicum.filmorate.storage.film;

import ru.yandex.practicum.filmorate.model.Film;

import java.util.List;

public interface FilmStorage {
    Film updateFilm(Film film);

    Film createFilm(Film film);

    List<Film> getFilms();

    Film getFilmById(int id);

    Film addLike(int filmId, int userId);

    Film deleteLike(int filmId, int userId);

    void deleteFilm(int id);

    List<Film> getListOfTopFilms(int count);
}
