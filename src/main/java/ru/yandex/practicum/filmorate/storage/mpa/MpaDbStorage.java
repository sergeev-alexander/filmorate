package ru.yandex.practicum.filmorate.storage.mpa;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import ru.yandex.practicum.filmorate.exeptions.NotFoundException;
import ru.yandex.practicum.filmorate.model.Mpa;
import ru.yandex.practicum.filmorate.storage.mapper.MpaMapper;

import java.util.List;

@Slf4j
@Repository
@RequiredArgsConstructor
public class MpaDbStorage implements MpaStorage {
    private final JdbcTemplate jdbcTemplate;
    private final MpaMapper mapper;

    @Override
    public List<Mpa> findAll() {
        String sqlQuery = "SELECT * FROM mpa_ratings";
        log.info("Отправлены все рейтинги");
        return jdbcTemplate.query(sqlQuery, mapper);
    }

    @Override
    public Mpa getById(int id) {
        String sqlQuery = "SELECT * FROM mpa_ratings WHERE mpa_id = ?";
        SqlRowSet mpaRows = jdbcTemplate.queryForRowSet(sqlQuery, id);

        if (!mpaRows.next()) {
            log.warn("Рейтинг {} не найден.", id);
            throw new NotFoundException("Рейтинг не найден");
        }

        return jdbcTemplate.queryForObject(sqlQuery, mapper, id);
    }
}
