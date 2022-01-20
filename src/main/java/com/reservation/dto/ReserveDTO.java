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
public class ReserveDTO {

	private Long no;
	private String name;
	private String phone;
	private String adult;
	private String child;
	private String startDate;
	private String endDate;
	private String options;
	private String paymentFlg;
	private int totalCost;
	private String cancelFlg;
	private String bankName;
	private String bankbranchcde;
	private String bankNo;
	private int buildCd;
	private Long roomNo; //join table Roominfo
	
	@JsonDeserialize(using = LocalDateTimeDeserializer.class) 
	@JsonSerialize(using = LocalDateTimeSerializer.class)
	private LocalDateTime createdAt, updatedAt;
    private String deleteFlg;
	public Long getNo() {
		return no;
	}
	public String getName() {
		return name;
	}
	public String getPhone() {
		return phone;
	}
	public String getAdult() {
		return adult;
	}
	public String getChild() {
		return child;
	}
	public String getStartDate() {
		return startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public String getOptions() {
		return options;
	}
	public String getPaymentFlg() {
		return paymentFlg;
	}
	public int getTotalCost() {
		return totalCost;
	}
	public String getCancelFlg() {
		return cancelFlg;
	}
	public String getBankName() {
		return bankName;
	}
	public String getBankbranchcde() {
		return bankbranchcde;
	}
	public String getBankNo() {
		return bankNo;
	}
	public int getBuildCd() {
		return buildCd;
	}
	public Long getRoomNo() {
		return roomNo;
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
