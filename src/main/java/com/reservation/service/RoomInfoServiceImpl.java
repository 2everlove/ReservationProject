package com.reservation.service;

import java.util.List;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.RoomInfoRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class RoomInfoServiceImpl implements RoomInfoService {
	
	private final RoomInfoRepository RoomInfoRepository;

	@Override
	public PageResultDTO<RoomInfoDTO, RoomInfo> getList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(new Sort(Direction.DESC, "no"));
		Page<RoomInfo> result = RoomInfoRepository.findAll(pageable);
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<RoomInfoDTO, RoomInfo>(result, fn);
	}

}
