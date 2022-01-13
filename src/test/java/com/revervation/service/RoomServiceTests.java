package com.revervation.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
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
		ConsultationDTO consultationDTO = ConsultationDTO.builder()
				.name("tester")
				.depth(0)
				.grgrod(2L)
				.grno(1L)
				.title("testT")
				.contents("testC")
				.passwd("1234")
				.build();
		System.out.println("==============================================================");
		System.out.println("=============================================================="+consultationDTO);
		//int saveNo = roomInfoService.wrtiteConsultation(consultationDTO);
		//System.out.println("=============================================================="+saveNo);
		//assertEquals(consultation, consultationRepository.findOne(saveNo));
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
}
