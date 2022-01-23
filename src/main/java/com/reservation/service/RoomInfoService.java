package com.reservation.service;

import java.util.Arrays;
import java.util.List;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.RoomInfo;

public interface RoomInfoService {
	
	Long roomRegister(RoomInfoDTO dto);
	
	PageResultDTO<RoomInfoDTO,RoomInfo> getList(PageRequestDTO requestDTO);
	
	List<RoomInfoDTO> findAll();
	
	RoomInfoDTO findAllSpecifyRoom(Long no);
	
	List<Integer> getBuildCd();
	
	void modify(RoomInfoDTO dto);
	
	default RoomInfoDTO entityToDTO(RoomInfo entity) {
		RoomInfoDTO dto = RoomInfoDTO.builder()
				.no(entity.getNo())
				.roomNum(entity.getRoomNum())
				.roomTitle(entity.getRoomTitle())
				.max(entity.getMax())
				.adultCost(entity.getAdultCost())
				.childCost(entity.getChildCost())
				.explanation(entity.getExplanation())
				.images(Arrays.asList(entity.getImages().split(",")))
				.colorCd(entity.getColorCd())
				.buildCd(entity.getBuildCd())
				.deleteFlg(entity.getDeleteFlg())
				.createdAt(entity.getCreatedAt())
				.updatedAt(entity.getUpdatedAt())
				.build();
		return dto;
	}
	
	default RoomInfo dtoToEntity(RoomInfoDTO dto) {
		StringBuilder imgsb = new StringBuilder();
		dto.getImages().forEach(i -> imgsb.append(i+","));
		RoomInfo entity = RoomInfo.builder()
				.no(dto.getNo())
				.roomNum(dto.getRoomNum())
				.roomTitle(dto.getRoomTitle())
				.max(dto.getMax())
				.adultCost(dto.getAdultCost())
				.childCost(dto.getChildCost())
				.explanation(dto.getExplanation())
				.images(imgsb.toString())
				.colorCd(dto.getColorCd())
				.buildCd(dto.getBuildCd())
				.deleteFlg(dto.getDeleteFlg())
				.build();
		return entity;
	}

	

	
}
