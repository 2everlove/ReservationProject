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
		name = "NOTICE_SEQ_GENERATOR",
		sequenceName = "NOTICE_SEQ",
		initialValue = 1, allocationSize = 1)
public class Notice extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "NOTICE_SEQ_GENERATOR")
	private Long no;
	
	private String title;
	private String contents;
	private int buildCd;
	
	@Column(columnDefinition = "varchar(1) default '0'")
	private String deleteFlg;

	public void changeTitle(String title) {
		this.title = title;
	}
	
	public void changeContent(String contents) {
		this.contents = contents;
	}
	
	public void changeDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}
	
}
