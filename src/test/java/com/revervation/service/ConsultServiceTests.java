package com.revervation.service;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

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
		Consultation consultation = Consultation.builder()
				.name("tester")
				.depth(0)
				.grgrod(2)
				.grno(1)
				.title("testT")
				.contents("testC")
				.passwd("1234")
				.build();
		System.out.println("==============================================================");
		System.out.println("=============================================================="+consultation);
		int saveNo = consultationService.write(consultation);
		System.out.println("=============================================================="+saveNo);
		//assertEquals(consultation, consultationRepository.findOne(saveNo));
	}
}
