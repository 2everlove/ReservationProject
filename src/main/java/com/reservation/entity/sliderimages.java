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
@DynamicInsert
@DynamicUpdate
@SequenceGenerator(
		name = "SLIDERIMAGES_SEQ_GENERATOR",
		sequenceName = "SLIDERIMAGES_SEQ",
		initialValue = 1, allocationSize = 1)
public class sliderimages extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SLIDERIMAGES_SEQ_GENERATOR")
	private Long no;
	
	private String filename;
	private String sortNo;
	
	@Column(columnDefinition = "varchar(1) default '0'")
	private String Activity;
	@Column(columnDefinition = "varchar(1) default '0'")
	private String deleteFlg;
	
}
