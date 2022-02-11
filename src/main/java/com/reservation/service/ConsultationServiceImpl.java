package com.reservation.service;

import java.util.Optional;
import java.util.function.Function;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Consultation;
import com.reservation.entity.QConsultation;
import com.reservation.repository.ConsultationRepository;
import com.reservation.utils.TableStatus;

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
		
		//순서 조정
		if(dto.getGrgrod() > 0) {
			consultationRepository.changeGrgrod(dto.getGrno(),dto.getGrgrod());
		}
		
		//답글 등록(원글이 있을때)
		if(null != entity.getGrno()) {
			Optional<Consultation> originEntity =consultationRepository.findById(entity.getGrno());
			if(originEntity.get().getPasswd() != null) {
				entity.changeLockFlg(originEntity.get().getLockFlg());
				entity.changePasswd(originEntity.get().getPasswd());
			}
		}
		
		log.info(entity);
		consultationRepository.save(entity);
		
		//원글 등록
		if(null == entity.getGrno()) {
			entity.changeGrno(entity.getNo());
			consultationRepository.save(entity);
		}
		
		return entity.getNo();
	}
	
	//user
	@Override
	public PageResultDTO<ConsultationDTO, Consultation> getList(PageRequestDTO requestDTO) {
		requestDTO.setSize(20);
		Pageable pageable = requestDTO.getPageable(Sort.by("grno").descending().and(Sort.by("grgrod").ascending()).and(Sort.by("depth").ascending()).and(Sort.by("createdAt").descending()));
		//BooleanBuilder booleanBuilder = getSearch(requestDTO);
		Page<Consultation> result = consultationRepository.findConsultationByDeleteFlg(pageable,TableStatus.Y.getCode());
		Function<Consultation, ConsultationDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<ConsultationDTO, Consultation>(result, fn);
	}
	
	//admin
	@Override
	public PageResultDTO<ConsultationDTO, Consultation> getAdminList(PageRequestDTO requestDTO) {
		requestDTO.setSize(20);
		Pageable pageable = requestDTO.getPageable(Sort.by("grno").descending().and(Sort.by("grgrod").ascending()).and(Sort.by("depth").ascending()).and(Sort.by("createdAt").descending()));
		Page<Consultation> result = consultationRepository.findAll(pageable);
		Function<Consultation, ConsultationDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<ConsultationDTO, Consultation>(result, fn);
	}

	@Override
	public ConsultationDTO get(Long no) {
		Optional<Consultation> tesmpResult = consultationRepository.findById(no);
		
		return tesmpResult.isPresent()?entityToDTO(tesmpResult.get()): null;
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
	
	@Transactional
	@Override
	public int modifyDeleteByNo(Long no, String deleteFlg) {
		Optional<Consultation> entityContent = consultationRepository.findById(no);
		int result = 0;
		if(entityContent.get().getGrno() == no) {
			result = consultationRepository.modifyDeleteByGrno(no, deleteFlg);
		} else {
			result = consultationRepository.modifyDeleteByNo(no, deleteFlg);
		}
		
		return result;
	}
	
	private BooleanBuilder getSearch(PageRequestDTO requestDTO) {
		String type = requestDTO.getType();
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		QConsultation qConsultation = QConsultation.consultation;
		String keyword = requestDTO.getKeyword();
		BooleanExpression expression = qConsultation.no.gt(0L);
		booleanBuilder.and(expression);
		if(type == null || type.trim().length() == 0) {
			return booleanBuilder;
		}
		
		BooleanBuilder condiBuilder = new BooleanBuilder();
		
		if(type.contains("t")) {
			condiBuilder.or(qConsultation.title.contains(keyword));
		}
		if(type.contains("c")) {
			condiBuilder.or(qConsultation.contents.contains(keyword));
		}
		if(type.contains("w")) {
			condiBuilder.or(qConsultation.name.contains(keyword));
		}
		
		booleanBuilder.and(condiBuilder);
		
		return booleanBuilder;
	}
}
