package com.example.uiproject.Model;
import lombok.*;
@Getter @Setter
public class WeldingDTO {
    private int      id;
    private String   work_date;
    private String   operation_time;
    private String   arc_time;
    private double   arc_rate;
    private double   weld_length;
    private String   vessel_no;
    private String   block;
    private String   assy;
    private String   worker;
    private String   worktime;
    private String   operation_time_rec;
    private int      record_id;
    private int      summary_id;
    private String   time_start;
    private String   time_end;
    private String   arc_time_rec;
    private double   weld_length_rec;
    private double   set_current;
    private double   out_current;
    private double   set_voltage;
    private double   out_voltage;
    private String   cell_shape;
    private String   section;
    private int      leg_length;
    private int      total_pass;
    private Integer  current_pass;
}
