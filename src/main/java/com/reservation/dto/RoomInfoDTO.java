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
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Setter
@ToString
public class RoomInfoDTO {
	private Long no;
	private String roomNum;
	private String roomTitle;
	private int max;
	private Long adultCost;
	private Long childCost;
	private String explanation;
	private String images;
	private String colorCd;
	private int buildCd;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
	public Long getNo() {
		return no;
	}
	public String getRoomNum() {
		return roomNum;
	}
	public String getRoomTitle() {
		return roomTitle;
	}
	public int getMax() {
		return max;
	}
	public Long getAdultCost() {
		return adultCost;
	}
	public Long getChildCost() {
		return childCost;
	}
	public String getExplanation() {
		return explanation;
	}
	public String getImages() {
		return images;
	}
	public String getColorCd() {
		return colorCd;
	}
	public int getBuildCd() {
		return buildCd;
	}
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    @JsonDeserialize(using = LocalDateTimeDeserializer.class) 
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")
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
