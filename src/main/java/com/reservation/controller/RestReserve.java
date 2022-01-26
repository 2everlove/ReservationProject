package com.reservation.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.reservation.dto.ReserveDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.service.ReserveService;
import com.reservation.service.RoomInfoService;
import com.reservation.utils.Bank;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class RestReserve {
	
	private final ReserveService reserveService;
	private final RoomInfoService roomInfoService;
	
	//search whole room
	@GetMapping(value = "/checkReserve", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<RoomInfoDTO>> AjaxCheckReserveDate(){
		log.info("AjaxCheckReserveDate " + "search whole room");
		return new ResponseEntity<List<RoomInfoDTO>>(roomInfoService.findAll(),HttpStatus.OK);
	}
	
	//search whole room
	@PostMapping(value = "/getReserve", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReserveDTO> AjaxGetReserveByNo(@RequestBody ReserveDTO dto){
		log.info("AjaxCheckReserveDate " + "search whole room");
		return new ResponseEntity<ReserveDTO>(reserveService.getReserve(dto) ,HttpStatus.OK);
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
		return new ResponseEntity<List<Object[]>>(reserveService.getDateObjectList(dateStart, dateEnd, roomNo),HttpStatus.OK);
	}
	
	//search whole booking on specify room without reserveNo
	@GetMapping(value = "/checkReserve/{amount}/{roomNo}/{reserveNo}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Object[]>> AjaxCheckReserveDate(@PathVariable("amount") int amount, @PathVariable("roomNo") Long roomNo,@PathVariable("reserveNo") Long reservno){
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, -1);
		Date dateStart = cal.getTime();
		cal.add(cal.MONTH, 1);
		Date dateEnd = cal.getTime();
		System.out.println("search whole booking on specify room without reserveNo");
		return new ResponseEntity<List<Object[]>>(reserveService.getDateListWithOutReserveNo(dateStart, dateEnd, roomNo, reservno),HttpStatus.OK);
	}
	
	//specify bank list
	@GetMapping(value = "/payment/list/{code}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Bank> showBank(@PathVariable("code") int bankCd){
		return new ResponseEntity<Bank>(Bank.fromValue(bankCd), HttpStatus.OK);
	}
	
	//bank whole list
	@GetMapping(value = "/payment/list", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Bank>> showBank(){
		return new ResponseEntity<List<Bank>>(Bank.getAll(), HttpStatus.OK);
		
	}
	
	//bank whole list
	@PostMapping("/reserve/register")
	public ResponseEntity<Long> registerReserve(@RequestBody ReserveDTO reserveDTO){
		log.info(reserveDTO);
		Long no = reserveService.registerReserve(reserveDTO);
		return new ResponseEntity<Long>(no, HttpStatus.OK);
	}
	
	//bank whole list
	@PostMapping("/reserve/modify")
	public ResponseEntity<Long> modifyReserve(@RequestBody ReserveDTO reserveDTO){
		log.info(reserveDTO);
		Long no = reserveService.modifyReserve(reserveDTO);
		return new ResponseEntity<Long>(no, HttpStatus.OK);
	}
	@PostMapping("/reserve/modify/payment")
	public ResponseEntity<Integer> paymentReserve(@RequestBody ReserveDTO reserveDTO){
		log.info(reserveDTO);
		int no = reserveService.modifyPaymentReserve(reserveDTO);
		return new ResponseEntity<Integer>(no, HttpStatus.OK);
	}
	@PostMapping("/reserve/modify/cancel")
	public ResponseEntity<Integer> cancelReserve(@RequestBody ReserveDTO reserveDTO){
		log.info(reserveDTO);
		int no = reserveService.modifyCancelReserve(reserveDTO);
		return new ResponseEntity<Integer>(no, HttpStatus.OK);
	}
}
