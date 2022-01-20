package com.reservation.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.reservation.dto.ConsultationDTO;
import com.reservation.service.ConsultationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class RestConsultation {
	private final ConsultationService consultationService;
	
	@PostMapping(value = "/consultation", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ConsultationDTO> modifyConsultation(@RequestBody ConsultationDTO consultationDTO){
		log.info(consultationDTO);
		System.out.println("modifyConsultation: "+consultationDTO);
		consultationService.modify(consultationDTO);
		return new ResponseEntity<ConsultationDTO>(consultationService.get(consultationDTO.getNo()), HttpStatus.OK);
	}
	
	@PostMapping(value = "/consultation/delete")
	public ResponseEntity<String> deleteNotice(@RequestBody ConsultationDTO consultationDTO){
		log.info(consultationDTO);
		String msg = "fail";
		int result = consultationService.modifyDeleteByNo(consultationDTO.getNo(), consultationDTO.getDeleteFlg());
		System.out.println("deleteNotice: "+result+", "+consultationDTO);
		if(result > 0)
			msg = "success";
		System.out.println(msg);
		return new ResponseEntity<>(msg, HttpStatus.OK);
	}
}
