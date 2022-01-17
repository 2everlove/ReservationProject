package com.reservation.dto;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class BankDto {
	private String bankName;
	private int bankCd;
}
