package com.reservation.service;

import java.util.Optional;
import java.util.function.Function;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Notice;
import com.reservation.repository.NoticeRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeRepository noticeRepository;

	@Override
	public PageResultDTO<NoticeDTO, Notice> getList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(Sort.by("no").descending());
		Page<Notice> result = noticeRepository.getAllWithOutDelete(pageable);
		Function<Notice, NoticeDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<NoticeDTO, Notice>(result, fn);
	}
	
	@Override
	public PageResultDTO<NoticeDTO, Notice> getListAdmin(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(Sort.by("no").descending());
		Page<Notice> result = noticeRepository.findAll(pageable);
		Function<Notice, NoticeDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<NoticeDTO, Notice>(result, fn);
	}

	@Override
	public Long registerNoticec(NoticeDTO dto) {
		log.info("registerNoticec: "+dto);
		Notice notice = dtoToEntity(dto);
		noticeRepository.save(notice);
		return notice.getNo();
	}
	
	@Override
	public NoticeDTO get(Long no) {
		Optional<Notice> tesmpResult = noticeRepository.findById(no);
		NoticeDTO result = entityToDTO(tesmpResult.get());
		return result;
	}
	
	@Transactional
	@Override
	public int modifyDeleteByNo(Long no, String deleteFlg) {
		int result = noticeRepository.modifyDeleteByNo(no, deleteFlg);
		return result;
	}
	
	@Transactional
	@Override
	public void modify(NoticeDTO noticeDTO) {
		Optional<Notice> notice = noticeRepository.findById(noticeDTO.getNo());
		if(notice != null) {
			notice.get().changeTitle(noticeDTO.getTitle());
			notice.get().changeContent(noticeDTO.getContents());
			notice.get().changeDeleteFlg(noticeDTO.getDeleteFlg());
			
			noticeRepository.save(notice.get());
		}
	}
	
	

}
