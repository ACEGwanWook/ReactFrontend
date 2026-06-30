package com.example.uiproject;

import com.example.uiproject.Model.InfluxRowdataDTO;
import com.influxdb.client.InfluxDBClient;
import com.influxdb.query.FluxRecord;
import com.influxdb.query.FluxTable;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class InfluxService {

    private final InfluxDBClient client;

    public List<InfluxRowdataDTO> query(String bucket) {
        String flux = """
                from(bucket: "row_data")
                    |> range(start: 2025-12-10T00:00:00Z)
                    |> filter(fn: (r) => r._measurement == "row_data_tbl")
                    |> pivot(rowKey: ["_time"], columnKey: ["_field"], valueColumn: "_value")
                    |> group(columns: [])
                    |> sort(columns: ["_time"], desc: false)
                """.formatted(bucket);

        List<FluxTable> tables = client.getQueryApi().query(flux);
        List<InfluxRowdataDTO> out = new ArrayList<>();
        for (FluxTable t : tables) {
            for (FluxRecord r : t.getRecords()) {
                InfluxRowdataDTO dto = new InfluxRowdataDTO();
                dto.setAssyinfo((String) r.getValueByKey("AssyInfo"));
                dto.setBlockinfo((String) r.getValueByKey("BlockInfo"));
                dto.setCableinfo((String) r.getValueByKey("CableInfo"));
                dto.setFeedid((String) r.getValueByKey("FeedID"));
                dto.setTime((Instant) r.getValueByKey("_time"));
                dto.setGapinfo((String) r.getValueByKey("GapInfo2F"));
                dto.setErrorstatus((String) r.getValueByKey("ErrorStatus"));
                dto.setRowdataid((String) r.getValueByKey("RowDataID"));
                out.add(dto);
            }
        }
        return out;
    }
}
