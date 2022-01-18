package com.reservation.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.entity.Consultation;
import com.reservation.entity.Notice;
import com.reservation.entity.Reserve;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.NoticeRepository;
import com.reservation.repository.ReserveRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeRepository noticeRepository;

	@Override
	public PageResultDTO<NoticeDTO, Notice> getList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(new Sort(Direction.DESC, "no"));
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
		Notice result = noticeRepository.findOne(no);
		return entityToDTO(result);
	}

	@Transactional
	@Override
	public int modifyDeleteByNo(Long no, String deleteFlg) {
		int result = noticeRepository.modifyDeleteByNo(no, deleteFlg);
		return result;
	}

	@Override
	public void modify(NoticeDTO noticeDTO) {
		Notice notice = noticeRepository.getOne(noticeDTO.getNo());
		if(notice != null) {
			notice.changeTitle(noticeDTO.getTitle());
			notice.changeContent(noticeDTO.getContents());
			notice.changeDeleteFlg(noticeDTO.getDeleteFlg());
			
			noticeRepository.save(notice);
		}
	}
	
	

}
