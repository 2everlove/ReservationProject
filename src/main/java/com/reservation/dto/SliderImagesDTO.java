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
public class SliderImagesDTO {
	
	private int no;
	private String filename;
	private String sortNo;
	private String Activity;
	
	private Date createdAt, updatedAt;
    private String deleteFlg;
}
