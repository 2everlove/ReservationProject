package com.reservation.controller;

import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.service.ConsultationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequiredArgsConstructor
@Log4j2
public class UserConsultationController {

	private final ConsultationService consultationService;
	
	@GetMapping("/consultation")
	public String list(PageRequestDTO pageRequestDTO, Model model) {
		log.info("list: "+pageRequestDTO);
		Calendar cal = Calendar.getInstance();
		model.addAttribute("now", cal.getTime());
		model.addAttribute("result", consultationService.getList(pageRequestDTO));
		return "consultation";
	}
	
	@GetMapping("/consultation/{no}")
	public String getOne(@PathVariable("no")Long no ,PageRequestDTO pageRequestDTO, Model model) {
		log.info("getOne: "+no);
		ConsultationDTO dto =  consultationService.get(no);
		if(dto.getDeleteFlg().equals("0")) {
			model.addAttribute("result", dto);
		} else {
			model.addAttribute("result", "delete");
		}
			
		model.addAttribute("page", pageRequestDTO);
		return "detailConsultation"; 
	}
	
	
	@GetMapping("/consultation/register")
	public String register(PageRequestDTO pageRequestDTO, Model model) {
		model.addAttribute("page", pageRequestDTO);
		return "detailConsultation";
	}
	
	@PostMapping("/consultation/register")
	public String registerPost(ConsultationDTO dto, PageRequestDTO pageRequestDTO, RedirectAttributes rttr, Model model) {
		System.out.println("/consultation/register: "+dto);
		model.addAttribute("page", pageRequestDTO);
		rttr.addFlashAttribute("msg", consultationService.wrtiteConsultation(dto));
		return "redirect:/consultation";
	}
}
