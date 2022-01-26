package com.revervation.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.Consultation;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.ConsultationRepository;
import com.reservation.service.ConsultationService;
import com.reservation.service.RoomInfoService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class RoomServiceTests {

	@Autowired
	RoomInfoService roomInfoService;
	
	//@Transactional
	@Test
	public void wrtieTest() throws Exception {
		List<String> imgs = new ArrayList<String>();
		imgs.add("a");
		imgs.add("b");
		imgs.add("c");
		imgs.add("d");
		RoomInfoDTO roominfo = RoomInfoDTO.builder()
				.roomNum("70")
				.roomTitle("Title")
				.max(5)
				.adultCost(20000L)
				.childCost(10000L)
				.explanation("good"+(int)(Math.random()*10))
				.images(imgs)
				.colorCd("#ff6b81")
				.deleteFlg("0")
				.buildCd(7)
				.build();
		System.out.println(roominfo.toString());
		roomInfoService.roomRegister(roominfo);
	}
	
	@Test
	public void testPagingOriginList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(1).size(10).build();
		PageResultDTO<RoomInfoDTO, RoomInfo> resultDTO = roomInfoService.getList(pageRequestDTO);
		for(RoomInfoDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
	}
	
	@Test
	public void testPagingList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(1).size(10).build();
		PageResultDTO<RoomInfoDTO, RoomInfo> resultDTO = roomInfoService.getList(pageRequestDTO);
		System.out.println("PREV: "+resultDTO.isPrev());
		System.out.println("NEXT: "+resultDTO.isNext());
		System.out.println("TOTAL: "+resultDTO.getTotalPage());
		for(RoomInfoDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
		System.out.println("=============");
		resultDTO.getPageList().forEach(i -> System.out.println(i));
	}
	
	@Test
	public void getListPageOnMain() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(1).size(10).build();
		PageResultDTO<RoomInfoDTO, RoomInfo> resultDTO = roomInfoService.getListPageOnMain(pageRequestDTO, "20220127", "20220129", 5);
		System.out.println("PREV: "+resultDTO.isPrev());
		System.out.println("NEXT: "+resultDTO.isNext());
		System.out.println("TOTAL: "+resultDTO.getTotalPage());
		for(RoomInfoDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
		System.out.println("=============");
		resultDTO.getPageList().forEach(i -> System.out.println(i));
	}
	
	@Test
	public void getListOnSelectedCalendar() {
		List<RoomInfoDTO> resultDTO = roomInfoService.getListOnSelectedCalendar("20220127", "20220129");
		for(RoomInfoDTO dto : resultDTO) {
			System.out.println(dto);
		}
	}
}
