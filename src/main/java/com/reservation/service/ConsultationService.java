package com.reservation.service;

import java.util.Optional;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Consultation;
import com.reservation.entity.QConsultation;

public interface ConsultationService {
	
	//상담글 작성
	public Long wrtiteConsultation(ConsultationDTO dto);
	
	//페이징 처리
	PageResultDTO<ConsultationDTO, Consultation> getList(PageRequestDTO requestDTO);
	
	PageResultDTO<ConsultationDTO, Consultation> getAdminList(PageRequestDTO requestDTO);
	
	ConsultationDTO get(Long no);
	
	void modify(ConsultationDTO dto);
	
	int modifyDeleteByNo(Long no, String deleteFlg);
	
	default Consultation dtoToEntity(ConsultationDTO dto) {
		Consultation entity = Consultation.builder()
				.no(dto.getNo())
				.grno(dto.getGrno())
				.grgrod(dto.getGrgrod())
				.depth(dto.getDepth())
				.title(dto.getTitle())
				.contents(dto.getContents())
				.name(dto.getName())
				.passwd(dto.getPasswd())
				.lockFlg(dto.getLockFlg())
				.deleteFlg(dto.getDeleteFlg())
				.build();
		return entity;
	}
	
	default ConsultationDTO entityToDTO(Consultation entity) {
		ConsultationDTO dto = ConsultationDTO.builder()
				.no(entity.getNo())
				.grno(entity.getGrno())
				.grgrod(entity.getGrgrod())
				.depth(entity.getDepth())
				.title(entity.getTitle())
				.contents(entity.getContents())
				.name(entity.getName())
				.passwd(entity.getPasswd())
				.lockFlg(entity.getLockFlg())
				.deleteFlg(entity.getDeleteFlg())
				.createdAt(entity.getCreatedAt())
				.updatedAt(entity.getUpdatedAt())
				.build();
		return dto;
	}

}
