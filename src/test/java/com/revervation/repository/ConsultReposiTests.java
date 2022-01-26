package com.revervation.repository;

import java.util.Arrays;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.reservation.entity.Consultation;
import com.reservation.entity.QConsultation;
import com.reservation.repository.ConsultationRepository;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ConsultReposiTests {
	
	@Autowired
	private ConsultationRepository consultationRepository;

	@Test
	public void test() {
		IntStream.range(1, 200).forEach(i -> {
			Consultation consultation = Consultation.builder()
					.name("tester"+i)
					.depth(0)
					.grgrod((long)0)
					.grno((long) i)
					.title("testT"+i)
					.contents("testC")
					.passwd("1234")
					.lockFlg("0")
					.deleteFlg("0")
					.build();
			System.out.println(consultation.toString());
			consultationRepository.save(consultation);
		});
	}
	
	@Test
	public void checkCount() {
	}
	@Test
	public void searchCountorder() {
		Consultation result = consultationRepository.searchCountorder(305L);
		System.out.println(result);
	}
	/*
	@Test
	public void testWithReplyCount() {
		Pageable pageable = PageRequest.of(0, 10, Sort.by("no").descending());
		Page<Object[]> result = consultationRepository.getConsultationWithGrgrodCount(pageable);
		result.get().forEach(row->{
			Object[] arr = (Object[])row;
			System.out.println(Arrays.toString(row));
		});
	}
	*/
	
	/*
	 * @Test public void testPagingQuery() { Pageable pageable = new PageRequest(0,
	 * 10, new Sort(Direction.DESC, "no")); //page, size, sort, sort baseProperty
	 * QConsultation qConsultation = QConsultation.consultation; String keyword =
	 * "t"; BooleanBuilder builder = new BooleanBuilder(); BooleanExpression
	 * expression = qConsultation.title.contains(keyword); builder.and(expression);
	 * Page<Consultation> result = consultationRepository.findAll(builder,
	 * pageable);
	 * 
	 * result.getContent().stream().forEach(i -> {
	 * System.out.println(i+" "+i.getCreatedAt()); }); }
	 */

}
