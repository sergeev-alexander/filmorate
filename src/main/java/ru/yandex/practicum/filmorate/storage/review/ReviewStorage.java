package ru.yandex.practicum.filmorate.storage.review;

import ru.yandex.practicum.filmorate.model.Review;

import java.util.List;

public interface ReviewStorage {

    Review getReviewById(Integer reviewId);

    List<Review> getAllReviewsForAllFilms(Integer count);

    List<Review> getAllReviewsForOneFilm(Integer filmId, Integer count);

    Review postReview(Review review);

    Review putReview(Review review);

    void incrementLikeToReview(Integer reviewId, Integer userId);

    void decrementLikeToReview(Integer reviewId, Integer userId);

    void deleteReviewById(Integer reviewId);
}
