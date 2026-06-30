package com.example.uiproject.Model;
import lombok.*;
import java.time.Instant;
@Getter @Setter
public class InfluxRowdataDTO {
    private String assyinfo;
    private String blockinfo;
    private String cableinfo;
    private String feedid;
    private Instant time;
    private String gapinfo;
    private String errorstatus;
    private String rowdataid;
}
