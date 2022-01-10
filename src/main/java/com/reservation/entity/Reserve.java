package com.reservation.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import lombok.*;


@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString(exclude = "roomInfo")
@SequenceGenerator(
		name = "RESERVE_SEQ_GENERATOR",
		sequenceName = "RESERVE_SEQ",
		initialValue = 1, allocationSize = 1)
public class Reserve extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "RESERVE_SEQ_GENERATOR")
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
	
	@ManyToOne(fetch = FetchType.LAZY)
	private RoomInfo roomInfo;
	
}
