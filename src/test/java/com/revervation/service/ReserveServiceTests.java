package com.revervation.service;

import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.Consultation;
import com.reservation.entity.Reserve;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.ConsultationRepository;
import com.reservation.service.ConsultationService;
import com.reservation.service.ReserveService;
import com.reservation.service.RoomInfoService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReserveServiceTests {

	@Autowired
	ReserveService reserveService;
	
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
	public void getDateListTest() {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, 1);
		
		List<Object[]> result = reserveService.getDateList(cal);
		for(Object objects : result) {
			System.out.println(Arrays.asList(objects));
		}
	}
	
	@Test
	public void getPagingListSimpleTest() {
		PageRequestDTO pageRequestDTO = new PageRequestDTO();
		
		PageResultDTO<ReserveDTO, Object[]> result = reserveService.getList(pageRequestDTO);
		for(ReserveDTO reserveDTO : result.getDtoList()) {
			System.out.println(reserveDTO);
		}
	}
	
	@Test
	public void testPagingList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(1).size(10).build();
		PageResultDTO<ReserveDTO, Object[]> resultDTO = reserveService.getList(pageRequestDTO);
		System.out.println("PREV: "+resultDTO.isPrev());
		System.out.println("NEXT: "+resultDTO.isNext());
		System.out.println("TOTAL: "+resultDTO.getTotalPage());
		for(ReserveDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
		System.out.println("=============");
		resultDTO.getPageList().forEach(i -> System.out.println(i));
	}
}
