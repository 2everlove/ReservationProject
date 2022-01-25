package com.reservation.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

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
public class UserBookingController {

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
	
	//방 검색
	@GetMapping("/booking/search")
	public String bookingSearchedRoomList(ReserveDTO reserveDTO, Integer max, @ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		System.out.println("startDate: "+reserveDTO.getStartDate());
		System.out.println("endDate: "+reserveDTO.getEndDate());
		System.out.println("people: "+max);
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getListPageOnMain(requestDTO, reserveDTO.getStartDate(), reserveDTO.getEndDate(), max);
		model.addAttribute("roomInfoList", list.getDtoList());
		if(list.getDtoList().isEmpty()) {
			model.addAttribute("showingKey", "0");
		}
		log.info(list);
		System.out.println("booking");
		return "booking";
	}
	
	//방에 따른 예약정보
	@GetMapping("/booking/{roomNum}")
	public String bookingRoom(@PathVariable("roomNum") Long roomno, Model model) {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, -1);
		Date dateStart = cal.getTime();
		cal.add(cal.MONTH, 1);
		Date dateEnd = cal.getTime();
		List<ReserveDTO> result = reserveService.getDateList(dateStart, dateEnd, roomno);
		RoomInfoDTO roomInfo = roomInfoService.findAllSpecifyRoom(roomno);
		model.addAttribute("result", result);
		model.addAttribute("roomInfo", roomInfo);
		model.addAttribute("roomNum", roomno);
		return "roomInfo";
	}
	
}
