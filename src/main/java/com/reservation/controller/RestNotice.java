package com.reservation.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.net.HttpHeaders;
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
	
	//수정
	@PostMapping(value = "/notice", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<NoticeDTO> modifyNotice(@RequestBody NoticeDTO noticeDTO){
		log.info(noticeDTO);
		System.out.println("modifyNotice: "+noticeDTO);
		noticeService.modify(noticeDTO);
		return new ResponseEntity<NoticeDTO>(noticeService.get(noticeDTO.getNo()), HttpStatus.OK);
	}
	
	//getOne
	@GetMapping(value = "/notice/{no}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<NoticeDTO> getOneNotice(@PathVariable Long no){
		return new ResponseEntity<NoticeDTO>(noticeService.get(no), HttpStatus.OK);
	}
	
	//createCookie for popup
	@PostMapping(value = "/notice/{no}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> createPopupCookie(@PathVariable String no, HttpServletResponse response, HttpSession session, HttpServletRequest request){
		if(null != request.getSession().getServletContext().getContext("/").getAttribute("popupNotice"))
			request.getSession().getServletContext().removeAttribute("popupNotice");
		
		Cookie cookie = new Cookie("popupNotice", no);
		int time = 3 * 24 * 60 *60;
		cookie.setMaxAge(time);
		//cookie.setSecure(true); // Https 일때만 전송
		//cookie.setHttpOnly(true); //document.cookie 값 노출 안되게하는 것
		cookie.setPath("/");
		
		response.addCookie(cookie);
		log.info(cookie.getValue());
		
		request.getSession().getServletContext().setAttribute("popupNotice", no);
		
		return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString()).body("OK");
	}
	
	//삭제
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
