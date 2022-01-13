package com.reservation.dto;

import java.time.LocalDateTime;

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
	
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
}
