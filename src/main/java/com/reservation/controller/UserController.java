package com.reservation.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.RoomInfo;
import com.reservation.service.ReserveService;
import com.reservation.service.RoomInfoService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequiredArgsConstructor
@Log4j2
public class UserController {

	private final RoomInfoService roomInfoService;
	private final ReserveService reserveService;
	
	@GetMapping({"/","/main"})
	public String main() {
		return "main";
	}
	
	//방 목록
	@GetMapping("/booking")
	public void bookingRoomList(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getList(requestDTO);
		model.addAttribute("roomInfoList", list.getDtoList());
		log.info(list);
		System.out.println("booking");
	}
	
	//방에 따른 예약정보
	@GetMapping("/booking/{roomNum}")
	public String bookingRoom(@PathVariable("roomNum") Long roomno, Model model) {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, -1);
		Date dateStart = cal.getTime();
		cal.add(cal.MONTH, 1);
		Date dateEnd = cal.getTime();
		List<Object[]> result = reserveService.getDateList(dateStart, dateEnd, roomno);
		model.addAttribute("result", result);
		model.addAttribute("roomNum", roomno);
		return "roomInfo";
	}
	
	@GetMapping("/notice")
	public String notice(Model model) {
		
		return "notice";
	}
}
