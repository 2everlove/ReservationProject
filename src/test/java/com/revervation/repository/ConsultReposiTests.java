package com.revervation.repository;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.entity.Consultation;
import com.reservation.repository.ConsultationRepository;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ConsultReposiTests {
	
	@Autowired
	private ConsultationRepository consultationRepository;

	@Test
	public void test() {
		IntStream.range(1, 100).forEach(i -> {
			Consultation consultation = Consultation.builder()
					.name("tester"+i)
					.depth(0)
					.grgrod(2)
					.grno(1)
					.title("testT"+i)
					.contents("testC")
					.passwd("1234")
					.build();
			System.out.println(consultation.toString());
			consultationRepository.save(consultation);
		});
		
	}

}
