package ru.yandex.practicum.filmorate.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class Feed {

    @NotNull
    long timestamp;

    @NotNull
    Integer userId;

    @NotBlank
    @NotNull
    String eventType;

    @NotBlank
    @NotNull
    String operation;

    @NotNull
    Integer eventId;

    @NotNull
    Integer entityId;
}