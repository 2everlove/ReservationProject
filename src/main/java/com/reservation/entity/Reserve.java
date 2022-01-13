package com.reservation.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString(exclude = "roomNo")
@DynamicInsert
@DynamicUpdate
@SequenceGenerator(
		name = "RESERVE_SEQ_GENERATOR",
		sequenceName = "RESERVE_SEQ",
		initialValue = 1, allocationSize = 1)
public class Reserve extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "RESERVE_SEQ_GENERATOR")
	private Long no;
	
	private String name;
	private String phone;
	private String adult;
	private String child;
	private String startDate;
	private String endDate;
	private String options;
	private int totalCost;
	private String bankName;
	private String bankbranchcde;
	private String bankNo;
	private int buildCd;
	
	@Column(columnDefinition = "varchar(1) default '0'")
	private String paymentFlg;
	@Column(columnDefinition = "varchar(1) default '0'")
	private String cancelFlg;
	@Column(columnDefinition = "varchar(1) default '0'")
	private String deleteFlg;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "roomNo")
	private RoomInfo roomNo;
	
}
