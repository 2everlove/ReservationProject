package com.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.RoomInfo;
import com.reservation.service.RoomInfoService;

import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
public class AdminController {

	@Autowired
	RoomInfoService roomInfoService;
	
	@GetMapping("/admin")
	public String admin() {
		return "/admin/main";
	}
	
	@GetMapping("/admin/booking")
	public String booking(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getList(requestDTO);
		model.addAttribute("roomInfoList", list.getDtoList());
		log.info(list);
		System.out.println("booking");
		return "/admin/booking";
	}
}
