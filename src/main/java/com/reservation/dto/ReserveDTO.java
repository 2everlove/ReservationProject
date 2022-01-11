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
public class ReserveDTO {

	private int no;
	private String name;
	private String phone;
	private String adult;
	private String child;
	private String startDate;
	private String endDate;
	private String options;
	private String paymentFlg;
	private int totalCost;
	private String cancelFlg;
	private String bankName;
	private String bankbranchcde;
	private String bankNo;
	private int buildCd;
	private int roomInfo;
	
	private Date createdAt, updatedAt;
    private String deleteFlg;
}
