package com.example.uiproject;

import com.example.uiproject.Model.ScheduleEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface ScheduleEventRepository extends JpaRepository<ScheduleEvent, Long> {

    @Query("""
        select e from ScheduleEvent e
        where (coalesce(e.end, e.start) >= :from) and (e.start <= :to)
    """)
    List<ScheduleEvent> findOverlap(@Param("from") LocalDateTime from,
                                    @Param("to")   LocalDateTime to);

    List<ScheduleEvent> findByEndGreaterThanEqualAndStartLessThanEqual(
            LocalDateTime start,
            LocalDateTime end
    );
}
