package com.reservation.dto;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

import lombok.Builder;


public enum Bank {
	KB("국민", 1),
	BC("비씨", 2),
	SHINHAN("신한", 3),
	HYUNDAI("현대", 4),
	SAMSUNG("삼성", 5),
	LOTTE("롯데", 6),
	KEB("외환", 7),
	NH("농협", 8),
	KEBHANA("하나", 9),
	WOORI("우리", 10),
	KJ("광주", 11),
	SUHYUP("수협", 12),
	CITI("씨티", 13),
	JB("전북", 14),
	JEJU("제주", 15),
	KAKAO("카카오뱅크", 16),
	K("케이뱅크", 17),
	F("해외발급", 18);
	
	private final String bankName;
	private final int bankCd;
	
	private static List<Bank> allList;

	Bank(String bankName, int bankCd){
		this.bankName = bankName;
		this.bankCd = bankCd;
	}
	
	
	public String getBankName() {
		return bankName;
	}

	public int getBankCd() {
		return bankCd;
	}
	
	@JsonValue
	public  BankDto jsonValue() { 
		return BankDto.builder().bankName(this.bankName).bankCd(this.bankCd).build(); 
	} 
	
	@JsonCreator 
	public static Bank fromValue(int value) {
		switch (value) { 
			case 1: 
				return Bank.KB; 
			case 2: 
				return Bank.BC; 
			case 3: 
				return Bank.SHINHAN; 
			case 4: 
				return Bank.HYUNDAI; 
			case 5: 
				return Bank.SAMSUNG; 
			case 6: 
				return Bank.LOTTE; 
			case 7: 
				return Bank.KEB; 
			case 8: 
				return Bank.NH; 
			case 9: 
				return Bank.KEBHANA; 
			case 10: 
				return Bank.WOORI; 
			case 11: 
				return Bank.KJ; 
			case 12: 
				return Bank.SUHYUP; 
			case 13: 
				return Bank.CITI; 
			case 14: 
				return Bank.JB; 
			case 15: 
				return Bank.JEJU; 
			case 16: 
				return Bank.KAKAO; 
			case 17: 
				return Bank.K; 
			case 18: 
				return Bank.F; 
		} 
			return null; 
	} 
	
	public static List<Bank> getAll() { 
		if (Objects.isNull(allList)) { 
			allList = new ArrayList<>( 
					Arrays.asList(KB, BC, SHINHAN, HYUNDAI, SAMSUNG, LOTTE, KEB, NH, 
							KEBHANA, WOORI, KJ, SUHYUP, CITI, JB, JEJU, KAKAO, K, F) ); 
			} 
		return allList; 
	}



}
