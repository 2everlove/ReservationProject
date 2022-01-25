package com.revervation.repository;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
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
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.QRoomInfo;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.RoomInfoRepository;
import com.reservation.service.RoomInfoService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class RoomReposiTests {
	
	@Autowired
	private RoomInfoRepository roomInfoRepository;
	private RoomInfoService roomInfoService;
	

	@Test
	public void test() {
		IntStream.range(1, 6).forEach(i -> {
			String color = "";
			if(i == 1){
				color = "#ffa502";
			} else if (i==2) {
				color = "#2ed573";
			} else if (i==3) {
				color = "#1e90ff";
			} else if (i==4) {
				color = "#ff6b81";
			} else if (i==5) {
				color = "#dfe4ea";
			}
			RoomInfo roominfo = RoomInfo.builder()
					.roomNum("70"+i)
					.roomTitle("Title"+i)
					.max(5)
					.adultCost(20000L)
					.childCost(10000L)
					.explanation("good"+(int)(Math.random()*10)+i)
					.images("/save/"+i+"local")
					.colorCd(color)
					.deleteFlg("0")
					.buildCd(7)
					.build();
			System.out.println(roominfo.toString());
			roomInfoRepository.save(roominfo);
		});
		
	}
	
	@Test
	public void getListPageTests() {
		PageRequest pageRequest = PageRequest.of(0, 10, Sort.by("no").descending());;
		Page<Object[]> result = roomInfoRepository.getListPage(pageRequest);
		for(Object[] objects : result.getContent()) {
			System.out.println(Arrays.toString(objects));
		}
	}
	
	@Test
	public void getListPageOnMainTests() {
		PageRequest pageRequest = PageRequest.of(0, 10, Sort.by("no").descending());;
		Page<RoomInfoDTO> result = roomInfoService.entityToDTO(roomInfoRepository.getListPageOnMain(pageRequest, "20220127", "20220129", 5));
		for(RoomInfoDTO objects : result) {
			System.out.println(objects);
		}
	}
	
	@Test
	public void getListTests() {
		Calendar cal = Calendar.getInstance();
		cal.add(cal.MONTH, 1);
		
		List<Object[]> result = roomInfoRepository.getDateList(cal);
		for(Object[] objects : result) {
			System.out.println(Arrays.toString(objects));
		}
	}
	
	@Test
	public void testPagingQuery() {
		Pageable pageable = PageRequest.of(0, 10, Sort.by("no").descending());; //page, size, sort, sort baseProperty
		QRoomInfo qRoomInfo = QRoomInfo.roomInfo;
		String keyword = "t";
		BooleanBuilder builder = new BooleanBuilder();
		BooleanExpression expression = qRoomInfo.roomTitle.contains(keyword);
		builder.and(expression);
		Page<RoomInfo> result = roomInfoRepository.findAll(builder, pageable);
		
		result.getContent().stream().forEach(i -> {
			System.out.println(i+" "+i.getCreatedAt());
		});
	}

}
