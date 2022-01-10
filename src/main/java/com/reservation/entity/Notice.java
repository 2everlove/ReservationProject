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
		name = "NOTICE_SEQ_GENERATOR",
		sequenceName = "NOTICE_SEQ",
		initialValue = 1, allocationSize = 1)
public class Notice extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "NOTICE_SEQ_GENERATOR")
	private int no;
	
	private String title;
	private String contents;
	private int buildCd;

	
}
