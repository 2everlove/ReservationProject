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
public class SliderImagesDTO {
	
	private Long no;
	private String filename;
	private String sortNo;
	private String Activity;
	
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
	public Long getNo() {
		return no;
	}
	public String getFilename() {
		return filename;
	}
	public String getSortNo() {
		return sortNo;
	}
	public String getActivity() {
		return Activity;
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
