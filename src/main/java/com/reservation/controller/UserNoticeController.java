package com.reservation.controller;

import java.util.Calendar;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequiredArgsConstructor
@Log4j2
public class UserNoticeController {

	private final NoticeService noticeService;
	
	@GetMapping("/notice")
	public String list(PageRequestDTO pageRequestDTO, Model model) {
		log.info("list: "+pageRequestDTO);
		Calendar cal = Calendar.getInstance();
		model.addAttribute("now", cal.getTime());
		model.addAttribute("result", noticeService.getList(pageRequestDTO));
		return "notice";
	}
	
	@GetMapping("/notice/{no}")
	public String getOne(@PathVariable("no")Long no ,PageRequestDTO pageRequestDTO, Model model) {
		log.info("getOne: "+no);
		model.addAttribute("result", noticeService.get(no));
		return "detailNotice";
	}
	
}