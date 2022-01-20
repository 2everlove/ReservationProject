package com.reservation.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.reservation.dto.NoticeDTO;
import com.reservation.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api")
public class RestNotice {
	private final NoticeService noticeService;
	
	@PostMapping(value = "/notice", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<NoticeDTO> modifyNotice(@RequestBody NoticeDTO noticeDTO){
		log.info(noticeDTO);
		System.out.println("modifyNotice: "+noticeDTO);
		noticeService.modify(noticeDTO);
		return new ResponseEntity<NoticeDTO>(noticeService.get(noticeDTO.getNo()), HttpStatus.OK);
	}
	
	@PostMapping(value = "/notice/delete")
	public ResponseEntity<String> deleteNotice(@RequestBody NoticeDTO noticeDTO){
		log.info(noticeDTO);
		String msg = "fail";
		int result = noticeService.modifyDeleteByNo(noticeDTO.getNo(), noticeDTO.getDeleteFlg());
		System.out.println("deleteNotice: "+result+", "+noticeDTO);
		if(result > 0)
			msg = "success";
		System.out.println(msg);
		return new ResponseEntity<>(msg, HttpStatus.OK);
	}
}
