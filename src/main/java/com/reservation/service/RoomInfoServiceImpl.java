package com.reservation.service;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
		Page<RoomInfo> result = roomInfoRepository.findAllByDeleteFlg(pageable, "0");
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		return new PageResultDTO<RoomInfoDTO, RoomInfo>(result, fn);
	}
	
	@Override
	public PageResultDTO<RoomInfoDTO, RoomInfo> getListForAdmin(PageRequestDTO requestDTO) {
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
	
	@Transactional
	@Override
	public RoomInfoDTO roomRegister(RoomInfoDTO dto) {
		System.out.println("RoomInfoDTO: "+dto);
		RoomInfo roomInfo = dtoToEntity(dto);
		roomInfoRepository.save(roomInfo);
		Optional<RoomInfo> resultEntity = roomInfoRepository.findById(roomInfo.getNo());
		RoomInfoDTO result = entityToDTO(resultEntity.get());
		return result;
	}
	
	@Transactional
	@Override
	public void modify(RoomInfoDTO dto) {
		StringBuilder imgsb = new StringBuilder();
		dto.getImages().forEach(i -> imgsb.append(i+","));
		
		RoomInfo entity = roomInfoRepository.getOne(dto.getNo());
		
		entity.changeAdultCost(dto.getAdultCost());
		entity.changeBuildCd(dto.getBuildCd());
		entity.changeChildCost(dto.getChildCost());
		entity.changeColorCd(dto.getColorCd());
		entity.changeExplanation(dto.getExplanation());
		entity.changeImages(imgsb.toString());
		entity.changeMax(dto.getMax());
		entity.changeRoomTitle(dto.getRoomTitle());
		entity.changeDeleteFlg(dto.getDeleteFlg());
		
		roomInfoRepository.save(entity);
	}
	
	//중복날짜 없는 dto 가져오기
	@Override
	public PageResultDTO<RoomInfoDTO, RoomInfo> getListPageOnMain(PageRequestDTO requestDTO, String dateStart, String dateEnd, int max) {
		Page<RoomInfo> result = roomInfoRepository.getListPageOnMain(requestDTO.getPageable(Sort.by("no").ascending()), dateStart, dateEnd, max);
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		log.info("getListPageOnMain: "+result.getContent());
		return new PageResultDTO<RoomInfoDTO, RoomInfo>(result, fn);
	}
	
	//해당 날짜 dto 가져오기
	@Override
	public List<RoomInfoDTO> getListOnSelectedCalendar(String dateStart, String dateEnd) {
		List<RoomInfo> entityResult = roomInfoRepository.getListOnSelectedCalendar(dateStart, dateEnd);
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		List<RoomInfoDTO> result = entityResult.stream().map(fn).collect(Collectors.toList());
		log.info("getListPageOnMain: "+result);
		return result;
	}

	@Override
	public List<RoomInfoDTO> findRoominfoByBuildCd(int buildCd) {
		Function<RoomInfo, RoomInfoDTO> fn = (entity -> entityToDTO(entity));
		return roomInfoRepository.findRoominfoByBuildCd(buildCd).stream().map(fn).collect(Collectors.toList());
	}
	
	

}
