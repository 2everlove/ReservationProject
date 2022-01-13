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
public class ConsultationDTO {
	
	private Long no;
	private Long grno;
	private Long grgrod;
	private int depth;
	private String title;
	private String contents;
	private String name;
	private String passwd;
	private String lockFlg;
	
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
}
