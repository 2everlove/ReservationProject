package com.revervation.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Commit;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

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
import com.reservation.utils.Bank;

import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class ReserveServiceTests {

	@Autowired
	private ReserveService reserveService;
	
	@Commit
	@Transactional
	@Test
	public void wrtieTest() throws Exception {
		IntStream.range(1, 40).forEach(i -> {
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


			ReserveDTO reserve = ReserveDTO.builder()
					.roomNo(roomInfo.getNo())
					.name("guest"+(int)(Math.random()*10)+i)
					.phone(String.valueOf((int)(Math.random()*10)+i))
					.adult("4")
					.child("1")
					.startDate(formattedStringS)
					.endDate(formattedStringE)
					.options("1,2,3,4,5")
					.totalCost(50000)
					.bankName(Bank.fromValue((int)(Math.random()*12)+1).getBankName())
					.bankbranchcde(String.valueOf((int)(Math.random()*3)+1))
					.bankNo(String.valueOf((Bank.fromValue((int)(Math.random()*12)+1).getBankCd())))
					.deleteFlg("0")
					.paymentFlg("0")
					.cancelFlg("0")
					.build();
			System.out.println(roomInfo.toString());
			System.out.println(reserve.toString());
			
			reserveService.registerReserve(reserve);
		});
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
	public void getDateList2Test() {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, -1);
		Date dateStart = cal.getTime();
		cal.add(cal.MONTH, 1);
		Date dateEnd = cal.getTime();
		Long roomNo = 1L;
		List<ReserveDTO> result = reserveService.getDateList(dateStart,dateEnd, roomNo);
		for(Object objects : result) {
			Arrays.asList(objects).forEach(i -> log.info(i.getClass().getName()));;
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
	
	/*@Test
	public void findReserveByNameAndPhoneOnpage() {
		PageRequestDTO pageRequestDTO = new PageRequestDTO();
		PageResultDTO<ReserveDTO, Reserve> result = reserveService.findReserveByNameAndPhone(pageRequestDTO, "鈴木", "01023582410");
		for(ReserveDTO reserveDTO : result.getDtoList()) {
			System.out.println(reserveDTO);
		}
	}
	
	@Test
	public void findReserveByNameAndPhoneWithoutPage() {
		List<Object[]> result = reserveService.findReserveByNameAndPhone("鈴木", "01023582410");
		for(Object reserveDTO : result) {
			System.out.println(Arrays.asList( reserveDTO).toString());
		}
	}*/
	
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
