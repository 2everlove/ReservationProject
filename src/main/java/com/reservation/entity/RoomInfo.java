package com.reservation.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.*;


@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class RoomInfo extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
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
