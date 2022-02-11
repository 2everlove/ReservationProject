package com.reservation.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.dto.SliderImagesDTO;
import com.reservation.dto.UserDTO;
import com.reservation.entity.RoomInfo;
import com.reservation.service.ReserveService;
import com.reservation.service.RoomInfoService;
import com.reservation.service.SliderImagesService;
import com.reservation.utils.TableStatus;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Controller
@RequiredArgsConstructor
@Log4j2
public class UserBookingController {

	private final UserDTO ADMIN = UserDTO.builder().name("Admin").passwd("admin").role("ROLE_ADMIN").build();
	private final RoomInfoService roomInfoService;
	private final ReserveService reserveService;
	private final SliderImagesService sliderImagesService;
	
	@GetMapping({"/","/main"})
	public String main(HttpServletRequest request, HttpServletResponse response,RedirectAttributes rttr, Model model) {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") == null)
			session.setAttribute("loginFlg",TableStatus.Y.getCode());
		System.out.println("main========="+session.getAttribute("loginFlg"));
		String interceptorMsg = "";
		//Intercepter에서 받은 flashMapManager가 !null
		if(null != RequestContextUtils.getInputFlashMap(request)) {
			interceptorMsg = (String) RequestContextUtils.getInputFlashMap(request).get("interceptorMsg");
		}
		rttr.addAttribute("interceptorMsg", interceptorMsg);
		
		
		if(null != request.getSession().getServletContext().getContext("/").getAttribute("popupNotice")) {
			Cookie cookie = new Cookie("popupNotice", request.getSession().getServletContext().getContext("/").getAttribute("popupNotice").toString());
			int time = 3 * 24 * 60 *60;
			cookie.setMaxAge(time);
			//cookie.setSecure(true); // Https 일때만 전송
			//cookie.setHttpOnly(true); //document.cookie 값 노출 안되게하는 것
			cookie.setPath("/");
			
			response.addCookie(cookie);
		}
		
		List<SliderImagesDTO> slideList = sliderImagesService.getSlideListForUser("0", "0","user");
		model.addAttribute("slideList", slideList);
		
		return "main";
	}
	@PostMapping("/main")
	public String login(HttpServletRequest request, UserDTO userDTO) {
		System.out.println(userDTO);
		HttpSession session = request.getSession();
		String tempUri ="";
		if(ADMIN.getName().equals(userDTO.getName()) && ADMIN.getPasswd().equals(userDTO.getPasswd())){
			userDTO = ADMIN;
			tempUri = (String)session.getAttribute("tempUri");
			session.setAttribute("user", userDTO);
			System.out.println(userDTO);
			if(tempUri != null) {
				System.out.println("loginInter"+tempUri);
				return "redirect:"+tempUri;
			} else {
				return "redirect:/admin";
			}
		}
		return "redirect:/main";
	}
	
	//방 목록
	@GetMapping("/booking")
	public void bookingRoomList(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, ReserveDTO reserveDTO, Model model) {
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getList(requestDTO);
		model.addAttribute("roomInfoList", list.getDtoList());
		model.addAttribute("dateObject", reserveDTO);
		log.info(list);
		System.out.println("booking");
	}
	
	//방 목록
	@GetMapping("/booking/reserveSearch")
	public void bookingReseveSearch(@ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model, ReserveDTO reserve) {
		model.addAttribute("result", reserveService.findReserveByNameAndPhoneAndDeleteFlg(requestDTO, reserve.getName(), reserve.getPhone()));
		System.out.println("booking");
	}
	
	//방 검색
	@GetMapping("/booking/search")
	public String bookingSearchedRoomList(ReserveDTO reserveDTO, @ModelAttribute("requestDTO") PageRequestDTO requestDTO, Model model) {
		System.out.println("startDate: "+reserveDTO.getStartDate());
		System.out.println("endDate: "+reserveDTO.getEndDate());
		int max = Integer.parseInt(reserveDTO.getAdult())+Integer.parseInt(reserveDTO.getChild());
		System.out.println("people: "+max);
		PageResultDTO<RoomInfoDTO, RoomInfo> list = roomInfoService.getListPageOnMain(requestDTO, reserveDTO.getStartDate(), reserveDTO.getEndDate(), max);
		model.addAttribute("roomInfoList", list.getDtoList());
		model.addAttribute("dateObject", reserveDTO);
		if(list.getDtoList().isEmpty()) {
			model.addAttribute("showingKey", "0");
		}
		log.info(list);
		System.out.println("booking");
		return "booking";
	}
	
	//방에 따른 예약정보
	@GetMapping("/booking/{roomNum}")
	public String bookingRoom(ReserveDTO reserveDTO, @PathVariable("roomNum") Long roomno, Model model) {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, -1);
		Date dateStart = cal.getTime();
		cal.add(cal.MONTH, 1);
		Date dateEnd = cal.getTime();
		List<ReserveDTO> result = reserveService.getDateList(dateStart, dateEnd, roomno);
		RoomInfoDTO roomInfo = roomInfoService.findAllSpecifyRoom(roomno);
		if(roomInfo.getDeleteFlg().equals("1")) {
			model.addAttribute("msg", roomno);
			return "/booking";
		}
		model.addAttribute("dateObject", reserveDTO);
		model.addAttribute("result", result);
		model.addAttribute("roomInfo", roomInfo);
		model.addAttribute("roomNum", roomno);
		return "roomInfo";
	}
	
}
