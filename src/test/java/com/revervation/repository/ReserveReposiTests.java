package com.revervation.repository;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
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
import com.reservation.dto.ReserveDTO;
import com.reservation.entity.QReserve;
import com.reservation.entity.Reserve;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.ReserveRepository;
import com.reservation.service.ReserveService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class ReserveReposiTests {
	
	@Autowired
	private ReserveRepository reserveRepository;
	
	@Autowired
	private ReserveService reserveService;

	@Test
	public void test() {
		IntStream.range(1, 200).forEach(i -> {
			Long no = (long)((Math.random()*5)+1);
			RoomInfo roomInfo = RoomInfo.builder().no(no).build();
			
			long minDay = LocalDate.of(2022, 1, 1).toEpochDay();
		    long maxDay = LocalDate.of(2022, 3, 31).toEpochDay();
		    long randomDay = ThreadLocalRandom.current().nextLong(minDay, maxDay);
		    LocalDate randomDateStart = LocalDate.ofEpochDay(randomDay);
		    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		    String formattedStringS = randomDateStart.format(formatter);
		    String formattedStringE = randomDateStart.plusDays((int)(Math.random()*5)+1).format(formatter);
		    System.out.println(randomDateStart);


			Reserve reserve = Reserve.builder()
					.roomNo(roomInfo)
					.name("guest"+(int)(Math.random()*10)+i)
					.phone(String.valueOf((int)(Math.random()*10)+i))
					.adult("4")
					.child("1")
					.startDate(formattedStringS)
					.endDate(formattedStringE)
					.options("1,2,3,4,5")
					.totalCost(50000)
					.bankName("bank")
					.bankbranchcde("bank"+String.valueOf((int)(Math.random()*10)))
					.bankNo(String.valueOf((int)(Math.random()*10)))
					.build();
			System.out.println(roomInfo.toString());
			System.out.println(reserve.toString());
			
			ReserveDTO dto = reserveService.entityToDTO(reserve);
			reserveService.registerReserve(dto);
		});
		
	}
	
	@Test
	public void testPagingQuery() {
		Pageable pageable = PageRequest.of(0, 10, Sort.by("no").descending()); //page, size, sort, sort baseProperty
		QReserve qReserve = QReserve.reserve;
		String keyword = "1";
		BooleanBuilder builder = new BooleanBuilder();
		BooleanExpression expression = qReserve.phone.contains(keyword);
		builder.and(expression);
		Page<Reserve> result = reserveRepository.findAll(builder, pageable);
		
		result.getContent().stream().forEach(i -> {
			System.out.println(i+" "+i.getCreatedAt());
		});
	}
	
	@Test
	public void getListTests() {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, 1);
		
		List<Object[]> result = reserveRepository.getDateList(cal);
		for(Object[] objects : result) {
			System.out.println(Arrays.toString(objects));
		}
	}

}
