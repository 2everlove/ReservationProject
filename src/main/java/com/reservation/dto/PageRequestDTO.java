package com.reservation.dto;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Builder
@AllArgsConstructor
@Data
public class PageRequestDTO {
	
	private int page;
	private int size;
	
	public PageRequestDTO() {
		this.page=1;
		this.size=10;
	}
	
	public Pageable getPageable(Sort sort) {
		return new PageRequest(page -1, size, sort);
	}
}
