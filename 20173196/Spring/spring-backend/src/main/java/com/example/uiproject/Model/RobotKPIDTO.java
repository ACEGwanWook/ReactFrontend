package com.example.uiproject.Model;
import lombok.*;
@Getter @Setter
public class RobotKPIDTO {
    private String robot;
    private int robotcount;
    private int operate;
    private int wait;
    private int error;
    private int operationrate;
    private int controlrate;
    private int productivity;
    private int accuracy;
}
