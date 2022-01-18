package com.reservation.service;

import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Notice;

public interface NoticeService {
	
	PageResultDTO<NoticeDTO, Notice> getList(PageRequestDTO requestDTO);
	
	Long registerNoticec(NoticeDTO dto);
	
	NoticeDTO get(Long no);
	
	int modifyDeleteByNo(Long no, String deleteFlg);
	
	void modify(NoticeDTO noticeDTO);
	
	default Notice dtoToEntity(NoticeDTO dto) {
		Notice entity = Notice.builder()
				.no(dto.getNo())
				.title(dto.getTitle())
				.contents(dto.getContents())
				.deleteFlg(dto.getDeleteFlg())
				.build();
		return entity;
	}
	
	default NoticeDTO entityToDTO(Notice entity) {
		NoticeDTO dto = NoticeDTO.builder()
				.no(entity.getNo())
				.title(entity.getTitle())
				.contents(entity.getContents())
				.deleteFlg(entity.getDeleteFlg())
				.createdAt(entity.getCreatedAt())
				.updatedAt(entity.getUpdatedAt())
				.build();
		return dto;
	}
}
