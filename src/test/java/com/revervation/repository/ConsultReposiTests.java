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
@Transactional
public class ConsultReposiTests {
	
	@Autowired
	private ConsultationRepository repository;

	@Test
	public void test() {
		IntStream.range(1, 100).forEach(i -> {
			Consultation con = Consultation.builder()
					.depth(0)
					.grgrod(2)
					.grno(1)
					.title("testT"+i)
					.contents("testC")
					.build();
			
			repository.save(con);
		});
		
	}

}
