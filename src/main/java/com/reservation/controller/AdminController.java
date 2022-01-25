package com.reservation.controller;

import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.reservation.dto.ConsultationDTO;
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
		System.out.println("booking");
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getList(requestDTO);
		log.info(list);
		model.addAttribute("roomInfoList", list.getDtoList());
		return "/admin/booking";
	}
	
	@GetMapping("/admin/roomManage")
	public String roomManageList(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		Calendar cal = Calendar.getInstance();
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getListForAdmin(requestDTO);
		log.info(list);
		model.addAttribute("buildCdList", roomInfoService.getBuildCd());
		model.addAttribute("result", list);
		model.addAttribute("now", cal.getTime());
		return "/admin/roomMange";
	}
	
	@GetMapping("/admin/roomManage/{no}")
	public String getRoom(@PathVariable("no") Long no, PageRequestDTO requestDTO, Model model) {
		model.addAttribute("buildCdList", roomInfoService.getBuildCd());
		model.addAttribute("page", requestDTO);
		return "/admin/detailRoom";
	}
	
	@GetMapping("/admin/roomManage/register")
	public String roomManageRegister(PageRequestDTO requestDTO, Model model) {
		model.addAttribute("buildCdList", roomInfoService.getBuildCd());
		model.addAttribute("page", requestDTO);
		return "/admin/detailRoom";
	}
	
	@PostMapping("/admin/roomManage/register")
	public String roomManageRegisterPost(PageRequestDTO requestDTO, RoomInfoDTO dto, Model model, RedirectAttributes rttr) {
		
		int result = 0;
		model.addAttribute("page", requestDTO);
		rttr.addFlashAttribute("msg", result);
		return "/admin/roomManage";
	}
	
	@ResponseBody
	@PostMapping("/api/roomManage")
	public ResponseEntity<RoomInfoDTO> roomManageModifyPost(@RequestBody RoomInfoDTO dto) {
		log.info("roomManageModifyPost: "+dto);
		roomInfoService.modify(dto);
		return new ResponseEntity<RoomInfoDTO>(roomInfoService.findAllSpecifyRoom(dto.getNo()), HttpStatus.OK);
	}
}
