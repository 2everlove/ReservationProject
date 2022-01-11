package com.revervation.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Consultation;
import com.reservation.repository.ConsultationRepository;
import com.reservation.service.ConsultationService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ConsultServiceTests {

	@Autowired
	ConsultationService consultationService;
	@Autowired
	ConsultationRepository consultationRepository;
	
	//@Transactional
	@Test
	public void wrtieTest() throws Exception {
		ConsultationDTO consultationDTO = ConsultationDTO.builder()
				.name("tester")
				.depth(0)
				.grgrod(2)
				.grno(1)
				.title("testT")
				.contents("testC")
				.passwd("1234")
				.build();
		System.out.println("==============================================================");
		System.out.println("=============================================================="+consultationDTO);
		int saveNo = consultationService.wrtiteConsultation(consultationDTO);
		System.out.println("=============================================================="+saveNo);
		//assertEquals(consultation, consultationRepository.findOne(saveNo));
	}
	
	@Test
	public void testPagingOriginList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(2).size(10).build();
		PageResultDTO<ConsultationDTO, Consultation> resultDTO = consultationService.getList(pageRequestDTO);
		for(ConsultationDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
	}
	
	@Test
	public void testPagingList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(2).size(10).build();
		PageResultDTO<ConsultationDTO, Consultation> resultDTO = consultationService.getList(pageRequestDTO);
		System.out.println("PREV: "+resultDTO.isPrev());
		System.out.println("NEXT: "+resultDTO.isNext());
		System.out.println("TOTAL: "+resultDTO.getTotalPage());
		for(ConsultationDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
		System.out.println("=============");
		resultDTO.getPageList().forEach(i -> System.out.println(i));
	}
}
