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
public class NoticeDTO {
	
	private int no;
	private String title;
	private String contents;
	private int buildCd;
	
	private Date createdAt, updatedAt;
    private String deleteFlg;
}
