package com.example.uiproject.Model;
import java.time.LocalDateTime;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "schedule_event")
@Getter @Setter
public class ScheduleEvent {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    @Column(name = "start_dt")
    private LocalDateTime start;
    @Column(name = "end_dt")
    private LocalDateTime end;
    @Column(name = "all_day")
    private boolean allDay;
    private String category;
    private String color;
    private String memo;
    public enum EventType { HUMAN, ROBOT }
    @Enumerated(EnumType.STRING)
    @Column(name = "ev_type", length = 10, nullable = false)
    private EventType type = EventType.HUMAN;
}
