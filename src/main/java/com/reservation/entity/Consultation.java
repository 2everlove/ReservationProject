package com.reservation.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@ToString
@DynamicInsert
@DynamicUpdate
@SequenceGenerator(
		name = "CONSULTATION_SEQ_GENERATOR",
		sequenceName = "CONSULTATION_SEQ",
		initialValue = 1, allocationSize = 1)
public class Consultation extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CONSULTATION_SEQ_GENERATOR")
	private Long no;
	
	private Long grno;
	private Long grgrod;
	private int depth;
	private String title;
	private String contents;
	private String name;
	private String passwd;
	private String lockFlg;
	
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
	
	public void changePasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public void changeLockFlg(String lockFlg) {
		this.lockFlg = lockFlg;
	}
	
	public void changeGrno(Long grno) {
		this.grno = grno;
	}
	
	public void changeGrgrord(Long grgrord) {
		this.grgrod = grgrord;
	}
}
