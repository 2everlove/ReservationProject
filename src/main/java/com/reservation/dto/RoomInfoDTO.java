package com.reservation.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class RoomInfoDTO {
	private Long no;
	private String roomNum;
	private String roomTitle;
	private int max;
	private Long adultCost;
	private Long childCost;
	private String explanation;
	private String images;
	private String colorCd;
	private int buildCd;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
}
