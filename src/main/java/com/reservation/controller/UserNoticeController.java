package com.reservation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
		model.addAttribute("result", noticeService.getList(pageRequestDTO));
		return "notice";
	}
	
}
