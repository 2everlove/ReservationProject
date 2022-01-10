package com.reservation.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

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
	private int no;
	
	private String roomNum;
	private String roomTitle;
	private int max;
	private int adultCost;
	private int childCost;
	private String explnation;
	private String images;
	private String colorCd;
	private int buildCd;

	
}
