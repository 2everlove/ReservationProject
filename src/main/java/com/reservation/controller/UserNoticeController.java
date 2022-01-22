package com.reservation.controller;

import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.service.NoticeService;
import com.reservation.service.RoomInfoService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequiredArgsConstructor
@Log4j2
public class UserNoticeController {

	private final NoticeService noticeService;
	private final RoomInfoService roomInfoService;
	
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
		model.addAttribute("page", pageRequestDTO);
		return "detailNotice";
	}
	
	@GetMapping("/notice/register")
	public String register(PageRequestDTO pageRequestDTO, Model model) {
		model.addAttribute("buildCdList", roomInfoService.getBuildCd());
		model.addAttribute("page", pageRequestDTO);
		return "detailNotice";
	}
	
	@PostMapping("/notice/register")
	public String registerPost(NoticeDTO dto, PageRequestDTO pageRequestDTO, Model model, RedirectAttributes rttr) {
		log.info("registerPost: "+dto);
		Long result = noticeService.registerNoticec(dto);
		model.addAttribute("page", pageRequestDTO);
		rttr.addAttribute("msg", result);
		return "redirect:/notice";
	}
	
}
