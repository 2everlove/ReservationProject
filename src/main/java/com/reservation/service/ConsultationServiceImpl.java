package com.reservation.service;

import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.reservation.dto.ConsultationDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.entity.Consultation;
import com.reservation.repository.ConsultationRepository;
import com.reservation.repository.RoomInfoRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class ConsultationServiceImpl implements ConsultationService {
	
	private final ConsultationRepository consultationRepository;
	
	@Override
	public Long wrtiteConsultation(ConsultationDTO dto) {
		log.info("DTO------");
		log.info(dto);
		
		Consultation entity = dtoToEntity(dto);
		
		log.info(entity);
		
		consultationRepository.save(entity);
		return entity.getNo();
	}

	@Override
	public PageResultDTO<ConsultationDTO, Consultation> getList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(new Sort(Direction.DESC, "no"));
		Page<Consultation> result = consultationRepository.findAll(pageable);
		Function<Consultation, ConsultationDTO> fn = (entity -> entityToDto(entity));
		return new PageResultDTO<ConsultationDTO, Consultation>(result, fn);
	}
}
