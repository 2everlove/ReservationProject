package com.reservation.service;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

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
	
	private final RoomInfoRepository roomInfoRepository;

	
	
	@Override
	public PageResultDTO<RoomInfoDTO, RoomInfo> getList(PageRequestDTO requestDTO) {
		Pageable pageable = requestDTO.getPageable(Sort.by("no").ascending());
		Page<RoomInfo> result = roomInfoRepository.findAll(pageable);
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<RoomInfoDTO, RoomInfo>(result, fn);
	}

	@Override
	public List<RoomInfoDTO> findAll() {
		List<RoomInfo> tempResult = roomInfoRepository.findAll();
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		List<RoomInfoDTO> result =  tempResult.stream().map(fn).collect(Collectors.toList());
		return result;
	}
	
	@Override
	public RoomInfoDTO findAllSpecifyRoom(Long no) {
		Optional<RoomInfo> tempResult = roomInfoRepository.findById(no);
		log.info("findAllSpecifyRoom: "+tempResult);
		//Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		return entityToDTO(tempResult.get());
	}

	@Override
	public List<Integer> getBuildCd() {
		return roomInfoRepository.getBuildCd();
	}

	@Override
	public Long roomRegister(RoomInfoDTO dto) {
		System.out.println("RoomInfoDTO: "+dto);
		RoomInfo roomInfo = dtoToEntity(dto);
		roomInfoRepository.save(roomInfo);
		return roomInfo.getNo();
	}

}
