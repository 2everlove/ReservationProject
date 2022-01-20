package com.reservation.controller;

import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
	
	@GetMapping("/notice/register")
	public String register(PageRequestDTO pageRequestDTO, Model model) {
		model.addAttribute("page", pageRequestDTO);
		return "detailNotice";
	}
	
}
