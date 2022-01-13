package com.reservation.utils;

import lombok.Getter;

@Getter
public enum TableStatus {
	Y("0",true),
	N("1",false);
	private String code;
	private boolean value;
	
	TableStatus(String code, boolean value){
		this.code=code;
		this.value=value;
	}
	public String getCode() {
		return code;
	}
	
	public boolean isValue() {
		return value;
	}
}