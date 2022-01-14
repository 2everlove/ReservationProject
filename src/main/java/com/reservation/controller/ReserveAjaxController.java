package com.reservation.controller;

import java.util.Calendar;
import java.util.Date;
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
import com.reservation.dto.RoomInfoDTO;
import com.reservation.service.ReserveService;
import com.reservation.service.RoomInfoService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class ReserveAjaxController {
	
	private final ReserveService reserveService;
	private final RoomInfoService roomInfoService;
	
	//search whole room
		@GetMapping(value = "/checkReserve", produces = MediaType.APPLICATION_JSON_VALUE)
		public ResponseEntity<List<RoomInfoDTO>> AjaxCheckReserveDate(){
			log.info("AjaxCheckReserveDate " + "search whole room");
			return new ResponseEntity<List<RoomInfoDTO>>(roomInfoService.findAll(),HttpStatus.OK);
		}
	
	//search whole booking
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
	
	//search whole booking on specify room
	@GetMapping(value = "/checkReserve/{amount}/{roomNo}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Object[]>> AjaxCheckReserveDate(@PathVariable("amount") int amount, @PathVariable("roomNo") Long roomNo){
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, -1);
		Date dateStart = cal.getTime();
		cal.add(cal.MONTH, 1);
		Date dateEnd = cal.getTime();
		System.out.println("search whole booking on specify room");
		return new ResponseEntity<List<Object[]>>(reserveService.getDateList(dateStart, dateEnd, roomNo),HttpStatus.OK);
	}
}
