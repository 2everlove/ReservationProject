package com.reservation.controller;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.Consultation;
import com.reservation.entity.RoomInfo;
import com.reservation.service.ConsultationService;
import com.reservation.service.NoticeService;
import com.reservation.service.RoomInfoService;

import lombok.extern.log4j.Log4j2;


@Controller
@Log4j2
public class AdminController {
	
			
	@Autowired
	RoomInfoService roomInfoService;
	@Autowired
	ConsultationService consultationService;
	@Autowired
	NoticeService noticeService;
	
	@GetMapping("/admin")
	public String admin() {
		return "/admin/main";
	}
	
	@GetMapping("/admin/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/admin/booking")
	public String booking(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		System.out.println("booking");
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getList(requestDTO);
		log.info(list);
		model.addAttribute("buildCdList", roomInfoService.getBuildCd());
		model.addAttribute("roomInfoList", list.getDtoList());
		return "/admin/booking";
	}
	
	
	///
	@GetMapping("/admin/consultation")
	public String consultationList(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		Calendar cal = Calendar.getInstance();
		PageResultDTO<ConsultationDTO, Consultation> list = consultationService.getAdminList(requestDTO);
		log.info(list);
		model.addAttribute("now", cal.getTime());
		model.addAttribute("result", consultationService.getList(requestDTO));
		model.addAttribute("now", cal.getTime());
		return "/admin/consultation";
	}
	
	@GetMapping("/admin/consultation/{no}")
	public String getConsultationOne(@PathVariable("no")Long no ,PageRequestDTO pageRequestDTO, Model model) {
		log.info("getOne: "+no);
		ConsultationDTO dto =  consultationService.get(no);
		model.addAttribute("result", dto);
		model.addAttribute("page", pageRequestDTO);
		return "/admin/detailConsultation"; 
	}
	
	@PostMapping("/admin/consultation/register")
	public String registerConsultationAdminPost(ConsultationDTO dto, PageRequestDTO pageRequestDTO, RedirectAttributes rttr) {
		System.out.println("/admin/consultation/register: "+dto);
		rttr.addFlashAttribute("msg", consultationService.wrtiteConsultation(dto));
		return "redirect:/admin/consultation";
	}
	
	///
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
	
	@ResponseBody
	@GetMapping("/api/getListBuildCd")
	public ResponseEntity<RoomInfoDTO> getListBuildCd(@RequestBody RoomInfoDTO dto) {
		log.info("roomManageModifyPost: "+dto);
		roomInfoService.modify(dto);
		return new ResponseEntity<RoomInfoDTO>(roomInfoService.findAllSpecifyRoom(dto.getNo()), HttpStatus.OK);
	}
	
	@ResponseBody
	@PostMapping("/api/roomManage/register")
	public ResponseEntity<RoomInfoDTO> roomManageRegisterPost(@RequestBody RoomInfoDTO dto) {
		log.info("roomManageRegisterPost: "+dto);
		
		return new ResponseEntity<RoomInfoDTO>(roomInfoService.roomRegister(dto), HttpStatus.OK);
	}
	
	///
	@GetMapping("/admin/notice")
	public String list(PageRequestDTO pageRequestDTO, Model model) {
		log.info("list: "+pageRequestDTO);
		Calendar cal = Calendar.getInstance();
		model.addAttribute("now", cal.getTime());
		model.addAttribute("result", noticeService.getListAdmin(pageRequestDTO));
		return "/admin/notice";
	}
	
	
	//register-get
	@GetMapping("/admin/notice/register")
	public String register(PageRequestDTO pageRequestDTO, Model model) {
		model.addAttribute("buildCdList", roomInfoService.getBuildCd());
		model.addAttribute("page", pageRequestDTO);
		return "/admin/detailNotice";
	}
	
	//register-post
	@PostMapping("/admin/notice/register")
	public String registerPost(NoticeDTO dto, PageRequestDTO pageRequestDTO, Model model, RedirectAttributes rttr) {
		log.info("registerPost: "+dto);
		Long result = noticeService.registerNoticec(dto);
		model.addAttribute("page", pageRequestDTO);
		rttr.addAttribute("msg", result);
		return "redirect:/admin//notice";
	}
	
	//getAnobject
	@GetMapping("/admin/notice/{no}")
	public String getOne(@PathVariable("no")Long no ,PageRequestDTO pageRequestDTO, Model model) {
		log.info("getOne: "+no);
		model.addAttribute("result", noticeService.get(no));
		model.addAttribute("page", pageRequestDTO);
		return "/admin/detailNotice";
	}
	
	
}
