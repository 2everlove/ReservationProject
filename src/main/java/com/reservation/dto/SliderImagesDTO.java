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
public class SliderImagesDTO {
	
	private Long no;
	private String filename;
	private String sortNo;
	private String Activity;
	
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
}
