package com.reservation.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import lombok.*;


@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString(exclude = "roomInfo")
public class Reserve extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private int no;
	
	private String name;
	private String phone;
	private String adult;
	private String child;
	private String startDate;
	private String endDate;
	private String option;
	private String paymentFlg;
	private int totalCost;
	private String cancelFlg;
	private String bankName;
	private String bankbranchcde;
	private String bankNo;
	private int buildCd;
	
	@ManyToOne(fetch = FetchType.LAZY)
	private RoomInfo roomInfo;
	
}
