package com.reservation.controller;

import java.util.Calendar;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.reservation.dto.ReserveDTO;
import com.reservation.service.ReserveService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class ReserveAjaxController {
	
	private final ReserveService reserveService;
	
	@GetMapping(value = "/checkReserve/{amount}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Object[]>> AjaxCheckReserveDate(@PathVariable("amount") int amount){
		Calendar date = Calendar.getInstance();
		date.add(date.MONTH, amount);
		log.info("AjaxCheckReserveDate");
		System.out.println(date.MONTH);
		System.out.println(date.getTime());
		System.out.println(amount);
		return new ResponseEntity<List<Object[]>>(reserveService.getDateList(date),HttpStatus.OK);
	}
}
