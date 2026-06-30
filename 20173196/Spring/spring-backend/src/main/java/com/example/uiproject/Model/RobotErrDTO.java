package com.example.uiproject.Model;
import lombok.*;
@Getter @Setter
public class RobotErrDTO {
    private String RobotNum;
    private String ErrorNum;
    private String ErrorReason;
    private String ErrorDetail;
    private String ErrorDate;
    private String ReceiveNum;
    private String ReceiveDate;
    private String ReceivePart;
    private String ReceiveCost;
    private String ReceiveDetail;
    private String File;
}
