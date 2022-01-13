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
public class NoticeDTO {
	
	private Long no;
	private String title;
	private String contents;
	private int buildCd;
	
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
}
