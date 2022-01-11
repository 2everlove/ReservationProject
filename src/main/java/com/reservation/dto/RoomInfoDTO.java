package com.reservation.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class RoomInfoDTO {
	private int no;
	private String roomNum;
	private String roomTitle;
	private int max;
	private int adultCost;
	private int childCost;
	private String explnation;
	private String images;
	private String colorCd;
	private int buildCd;
	
	private Date createdAt, updatedAt;
    private String deleteFlg;
}
