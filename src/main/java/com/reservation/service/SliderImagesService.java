package com.reservation.service;

import com.reservation.dto.NoticeDTO;
import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.SliderImagesDTO;
import com.reservation.entity.Notice;
import com.reservation.entity.Sliderimages;

public interface SliderImagesService {
	
	
	default Sliderimages dtoToEntity(SliderImagesDTO dto) {
		Sliderimages entity = Sliderimages.builder()
				.no(dto.getNo())
				.filename(dto.getFilename())
				.sortNo(dto.getSortNo())
				.activity(dto.getActivity())
				.deleteFlg(dto.getDeleteFlg())
				.build();
		return entity;
	}
	
	default SliderImagesDTO entityToDTO(Sliderimages entity) {
		SliderImagesDTO dto = SliderImagesDTO.builder()
				.no(entity.getNo())
				.filename(entity.getFilename())
				.sortNo(entity.getSortNo())
				.activity(entity.getActivity())
				.deleteFlg(entity.getDeleteFlg())
				.createdAt(entity.getCreatedAt())
				.updatedAt(entity.getUpdatedAt())
				.build();
		return dto;
	}
}
