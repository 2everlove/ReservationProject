package com.reservation.service;

import java.util.function.Function;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Consultation;
import com.reservation.repository.ConsultationRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class ConsultationServiceImpl implements ConsultationService {
	
	private final ConsultationRepository consultationRepository;
	
	@Transactional
	@Override
	public Long wrtiteConsultation(ConsultationDTO dto) {
		log.info("DTO------");
		log.info(dto);
		
		Consultation entity = dtoToEntity(dto);
		
		log.info(entity);
		
		consultationRepository.save(entity);
		entity.changeGrno(entity.getNo());
		consultationRepository.save(entity);
		return entity.getNo();
	}

	@Override
	public PageResultDTO<ConsultationDTO, Consultation> getList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(new Sort(Direction.DESC, "no"));
		Page<Consultation> result = consultationRepository.getAllWithOutDelete(pageable);
		Function<Consultation, ConsultationDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<ConsultationDTO, Consultation>(result, fn);
	}
	
	@Override
	public PageResultDTO<ConsultationDTO, Consultation> getAdminList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(new Sort(Direction.DESC, "no"));
		Page<Consultation> result = consultationRepository.findAll(pageable);
		Function<Consultation, ConsultationDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<ConsultationDTO, Consultation>(result, fn);
	}

	@Override
	public ConsultationDTO get(Long no) {
		Consultation tesmpResult = consultationRepository.findOne(no);
		ConsultationDTO result = entityToDTO(tesmpResult);
		return result;
	}
	
	@Transactional
	@Override
	public void modify(ConsultationDTO dto) {
		Consultation entity = consultationRepository.getOne(dto.getNo());
		
		entity.changeTitle(dto.getTitle());
		entity.changeContent(dto.getContents());
		entity.changeDeleteFlg(dto.getDeleteFlg());
		entity.changeLockFlg(dto.getLockFlg());
		entity.changePasswd(dto.getPasswd());
		
		consultationRepository.save(entity);
	}

	@Override
	public int modifyDeleteByNo(Long no, String deleteFlg) {
		int result = consultationRepository.modifyDeleteByNo(no, deleteFlg);
		return result;
	}
}
