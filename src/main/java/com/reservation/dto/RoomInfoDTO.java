package com.reservation.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.deser.LocalDateTimeDeserializer;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RoomInfoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long no;
	private String roomNum;
	private String roomTitle;
	private int max;
	private Long adultCost;
	private Long childCost;
	private String explanation;
	private transient List<String> images;
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
	public List<String> getImages() {
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
	public void setNo(Long no) {
		this.no = no;
	}
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}
	public void setRoomTitle(String roomTitle) {
		this.roomTitle = roomTitle;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public void setAdultCost(Long adultCost) {
		this.adultCost = adultCost;
	}
	public void setChildCost(Long childCost) {
		this.childCost = childCost;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public void setImages(String images) {
		this.images = Arrays.asList(images.split(","));
	}
	public void setColorCd(String colorCd) {
		this.colorCd = colorCd;
	}
	public void setBuildCd(int buildCd) {
		this.buildCd = buildCd;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	public void setDeleteFlg(String deleteFlg) {
		this.deleteFlg = deleteFlg;
	}
    
    
}
