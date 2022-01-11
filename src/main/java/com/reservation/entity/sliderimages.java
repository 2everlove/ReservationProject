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
		name = "SLIDERIMAGES_SEQ_GENERATOR",
		sequenceName = "SLIDERIMAGES_SEQ",
		initialValue = 1, allocationSize = 1)
public class sliderimages extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SLIDERIMAGES_SEQ_GENERATOR")
	private int no;
	
	private String filename;
	private String sortNo;
	private String Activity;
	private String deleteFlg;
	
}
