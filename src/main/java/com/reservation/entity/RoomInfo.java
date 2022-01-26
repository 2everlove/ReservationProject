package com.reservation.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import lombok.*;


@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@ToString
@SequenceGenerator(
		name = "ROOMINFO_SEQ_GENERATOR",
		sequenceName = "ROOMINFO_SEQ",
		initialValue = 1, allocationSize = 1)
public class RoomInfo extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ROOMINFO_SEQ_GENERATOR")
	private Long no;
	@Column(nullable = false, columnDefinition="VARCHAR(3)")
	private String roomNum;
	@Column(nullable = false, columnDefinition="VARCHAR(100)")
	private String roomTitle;
	@Column(length = 1, nullable = false)
	private int max;
	@Column(length = 2, nullable = false)
	private Long adultCost;
	@Column(length = 2, nullable = false)
	private Long childCost;
	@Column(columnDefinition="VARCHAR(4000)", nullable = false)
	private String explanation;
	@Column(columnDefinition="VARCHAR(2000)")
	private String images;
	@Column(nullable = false, columnDefinition="VARCHAR(7)")
	private String colorCd;
	@Column(nullable = false)
	private int buildCd;
	
	@Column(nullable = false, columnDefinition = "varchar(1) default '0'")
	private String deleteFlg;
	
	public void changeRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}
	public void changeMax(int max) {
		this.max = max;
	}
	public void changeAdultCost(Long adultCost) {
		this.adultCost = adultCost;
	}
	public void changeChildCost(Long childCost) {
		this.childCost = childCost;
	}
	public void changeExplanation(String explanation) {
		this.explanation = explanation;
	}
	public void changeImages(String images) {
		this.images = images;
	}
	public void changeColorCd(String colorCd) {
		this.colorCd = colorCd;
	}
	public void changeBuildCd(int buildCd) {
		this.buildCd = buildCd;
	}
	public void changeDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}
	
	
}
