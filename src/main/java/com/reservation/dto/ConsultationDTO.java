package com.reservation.dto;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Setter
@ToString
public class ConsultationDTO {
	
	private Long no;
	private Long grno;
	private Long grgrod;
	private int depth;
	private String title;
	private String contents;
	private String name;
	private String passwd;
	private String lockFlg;
	
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
	public Long getNo() {
		return no;
	}
	public Long getGrno() {
		return grno;
	}
	public Long getGrgrod() {
		return grgrod;
	}
	public int getDepth() {
		return depth;
	}
	public String getTitle() {
		return title;
	}
	public String getContents() {
		return contents;
	}
	public String getName() {
		return name;
	}
	public String getPasswd() {
		return passwd;
	}
	public String getLockFlg() {
		return lockFlg;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class) 
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class) 
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public String getDeleteFlg() {
		return deleteFlg;
	}
    
    
}
