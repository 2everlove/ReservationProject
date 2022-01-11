package com.reservation.entity;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

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
@SequenceGenerator(
		name = "CONSULTATION_SEQ_GENERATOR",
		sequenceName = "CONSULTATION_SEQ",
		initialValue = 1, allocationSize = 1)
@AttributeOverrides({
	@AttributeOverride(name="createdAt", column = @Column(name="createdAt")),
	@AttributeOverride(name="updatedAt", column = @Column(name="updatedAt")),
	@AttributeOverride(name="deleteFlg", column = @Column(name="deleteFlg")),
})
public class Consultation extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CONSULTATION_SEQ_GENERATOR")
	private int no;
	
	private int grno;
	private int grgrod;
	private int depth;
	private String title;
	private String contents;
	private String name;
	private String passwd;
	private String lockFlg;
	
}
