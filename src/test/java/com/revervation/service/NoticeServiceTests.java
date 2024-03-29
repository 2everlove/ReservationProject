package com.revervation.service;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Notice;
import com.reservation.repository.NoticeRepository;
import com.reservation.service.NoticeService;

import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class NoticeServiceTests {

	@Autowired
	NoticeService noticeService;
	@Autowired
	NoticeRepository noticeRepository;
	
	@Test
	public void register() {
		IntStream.range(1, 150).forEach( i -> {
			NoticeDTO notice = NoticeDTO.builder()
					.title("test"+i)
					.contents("content"+i)
					.deleteFlg("0")
					.buildCd('7')
					.build();
			noticeService.registerNoticec(notice);
		});
	}
	
	
	@Test
	public void testSearchPage() {
		Pageable pageable = PageRequest.of(0,10,Sort.by("no").descending().and(Sort.by("title").ascending()));
		Page<?> result = noticeRepository.searchPage("t", "1", pageable);
		log.info(result);
	}
	
	@Test
	public void testPagingOriginList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(2).size(10).build();
		PageResultDTO<NoticeDTO, Notice> resultDTO = noticeService.getList(pageRequestDTO);
		for(NoticeDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
	}
	
	@Test
	public void testPagingList() {
		PageRequestDTO pageRequestDTO = PageRequestDTO.builder().page(1).size(10).build();
		PageResultDTO<NoticeDTO, Notice> resultDTO = noticeService.getList(pageRequestDTO);
		System.out.println("PREV: "+resultDTO.isPrev());
		System.out.println("NEXT: "+resultDTO.isNext());
		System.out.println("TOTAL: "+resultDTO.getTotalPage());
		for(NoticeDTO dto : resultDTO.getDtoList()) {
			System.out.println(dto);
		}
		System.out.println("=============");
		resultDTO.getPageList().forEach(i -> System.out.println(i));
	}
	
	@Test
	public void getNotice() {
		NoticeDTO result = noticeService.get(99L);
		System.out.println(result);
	}
	
	@Test
	public void deleteNotice() {
		NoticeDTO dto = NoticeDTO.builder()
				.no(99L)
				.deleteFlg("1")
				.build();
		
		int result = noticeService.modifyDeleteByNo(dto.getNo(), dto.getDeleteFlg());
		System.out.println(result);
	}
}
