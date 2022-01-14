package com.reservation.service;

import java.util.List;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.RoomInfo;

public interface RoomInfoService {
	
	PageResultDTO<RoomInfoDTO,RoomInfo> getList(PageRequestDTO requestDTO);
	
	List<RoomInfoDTO> findAll();
	
	RoomInfoDTO findAllSpecifyRoom(Long no);
	
	default RoomInfoDTO entityToDTO(RoomInfo entity) {
		RoomInfoDTO dto = RoomInfoDTO.builder()
				.no(entity.getNo())
				.roomNum(entity.getRoomNum())
				.roomTitle(entity.getRoomTitle())
				.max(entity.getMax())
				.adultCost(entity.getAdultCost())
				.childCost(entity.getChildCost())
				.explanation(entity.getExplanation())
				.images(entity.getImages())
				.colorCd(entity.getColorCd())
				.buildCd(entity.getBuildCd())
				.deleteFlg(entity.getDeleteFlg())
				.createdAt(entity.getCreatedAt())
				.updatedAt(entity.getUpdatedAt())
				.build();
		return dto;
	}
	
	default RoomInfo dtoToEntity(RoomInfoDTO dto) {
		RoomInfo entity = RoomInfo.builder()
				.no(dto.getNo())
				.roomNum(dto.getRoomNum())
				.roomTitle(dto.getRoomTitle())
				.max(dto.getMax())
				.adultCost(dto.getAdultCost())
				.childCost(dto.getChildCost())
				.explanation(dto.getExplanation())
				.images(dto.getImages())
				.colorCd(dto.getColorCd())
				.buildCd(dto.getBuildCd())
				.deleteFlg(dto.getDeleteFlg())
				.build();
		return entity;
	}

	
}
