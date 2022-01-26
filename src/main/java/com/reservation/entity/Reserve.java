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
	@Column(nullable = false)
	private String name;
	@Column(length = 11, nullable = false)
	private String phone;
	@Column(length = 1, nullable = false)
	private String adult;
	@Column(length = 1)
	private String child;
	@Column(length = 8, nullable = false)
	private String startDate;
	@Column(length = 8, nullable = false)
	private String endDate;
	private String options;
	private int totalCost;
	@Column(nullable = false)
	private String bankName;
	@Column(length = 3, nullable = false)
	private String bankbranchcde;
	private String bankNo;
	@Column(nullable = false)
	private int buildCd;
	
	@Column(length = 1, nullable = false, columnDefinition = "varchar(1) default '0'")
	private String paymentFlg;
	@Column(length = 1, nullable = false, columnDefinition = "varchar(1) default '0'")
	private String cancelFlg;
	@Column(length = 1, nullable = false, columnDefinition = "varchar(1) default '0'")
	private String deleteFlg;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "roomNo")
	private RoomInfo roomNo;

	public void setName(String name) {
		this.name = name;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setAdult(String adult) {
		this.adult = adult;
	}

	public void setChild(String child) {
		this.child = child;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public void setTotalCost(int totalCost) {
		this.totalCost = totalCost;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public void setBankbranchcde(String bankbranchcde) {
		this.bankbranchcde = bankbranchcde;
	}

	public void setBankNo(String bankNo) {
		this.bankNo = bankNo;
	}

	public void setBuildCd(int buildCd) {
		this.buildCd = buildCd;
	}

	public void setPaymentFlg(String paymentFlg) {
		this.paymentFlg = paymentFlg;
	}

	public void setCancelFlg(String cancelFlg) {
		this.cancelFlg = cancelFlg;
	}

	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}

	public void setRoomNo(RoomInfo roomNo) {
		this.roomNo = roomNo;
	}
	
}
