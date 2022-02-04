package com.reservation.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.entity.Reserve;
import com.reservation.entity.RoomInfo;
import com.reservation.repository.ReserveRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class ReserveServiceImpl implements ReserveService {
	
	private final ReserveRepository reserveRepository;

	//admin-api-booking-calendar
	@Override
	public List<Object[]> getDateList(Calendar date) {
		log.info("ReserveService\ngetDateList");
		//Function<Object[], ReserveDTO> fn = (en -> entityToDTO((RoomInfo)en[0], (Reserve)en[1]));
		List<Object[]> result = reserveRepository.getDateList(date);
		System.out.println("ReserveService!getDateList--------------------");
		System.out.println(result.toString());
		System.out.println("--------------------");
		return result;
	}
	
	//admin-api-booking-calendar
	@Override
	public ReserveDTO getReserve(ReserveDTO dto) {
		log.info("getReserve");
		Optional<Reserve> result = reserveRepository.findById(dto.getNo());
		System.out.println("getReserve--------------------");
		System.out.println(result.toString());
		System.out.println("--------------------");
		return entityToDTO(result.get());
	}
	
	@Override
	public PageResultDTO<ReserveDTO, Object[]> getList(PageRequestDTO requestDTO) {
		Function<Object[], ReserveDTO> fn = (en -> entityToDTO((RoomInfo)en[0], (Reserve)en[1]));
		Page<Object[]> result = reserveRepository.getListPage(requestDTO.getPageable(Sort.by("no").descending()));
		return new PageResultDTO<>(result, fn);
	}
	
	
	@Override
	public List<ReserveDTO> getDateList(Date dateStart, Date dateEnd, Long roomno) {
		List<Object[]> tempResult = reserveRepository.getDateList(dateStart, dateEnd, roomno);
		Function<Object[], ReserveDTO> fn = (en -> entityToDTO((RoomInfo)en[0], (Reserve)en[1]));
		List<ReserveDTO> result = tempResult.stream().map(fn).collect(Collectors.toList());
		System.out.println("getDateList--------------------");
		System.out.println(result.toString());
		System.out.println("--------------------");
		return result;
	}
	
	
	
	@Override
	public List<ReserveDTO> getReserveAndRoomSpecificDate(Date dateStart, Date dateEnd, Long roomno) {
		List<Object[]> tempResult = reserveRepository.getReserveAndRoomSpecificDate(dateStart, dateEnd, roomno);
		Function<Object[], ReserveDTO> fn = (en -> entityToDTO((RoomInfo)en[0], (Reserve)en[1]));
		List<ReserveDTO> result = tempResult.stream().map(fn).collect(Collectors.toList());
		System.out.println("getDateList--------------------");
		System.out.println(result.toString());
		System.out.println("--------------------");
		return result;
	}
	
	//해당하는 방 가져옴(현재기준 1달 후, 1달 전)
	@Override
	public List<Object[]> getDateObjectList(Date dateStart, Date dateEnd, Long roomno) {
		List<Object[]> result = reserveRepository.getDateList(dateStart, dateEnd, roomno);
		return result;
	}
	
	//입력된 예약번호를 제외한 한달 전 후 방 정보
		@Override
		public List<Object[]> getDateListWithOutReserveNo(Date dateStart, Date dateEnd, Long roomno, Long reserveno) {
			List<Object[]> result = reserveRepository.getDateList(dateStart, dateEnd, roomno, reserveno);
			return result;
		}

	@Transactional
	@Override
	public Long registerReserve(ReserveDTO reserveDTO) {
		Long result = reserveRepository.getDateCount(reserveDTO.getStartDate(), reserveDTO.getEndDate(), reserveDTO.getRoomNo());
		System.out.println(result);
		boolean resultBoolean = 0L == result;
		System.out.println("registerReserve: "+resultBoolean);
		if(resultBoolean) {
			Reserve reserve = dtoToEntity(reserveDTO);
			reserveRepository.save(reserve);
			System.out.println("registerReserve: "+reserve);
			return reserve.getNo();
		}else {
			return 1L;
		}
	}

	@Transactional
	@Override
	public Long modifyReserve(ReserveDTO dto) {
		Reserve entity = reserveRepository.getOne(dto.getNo());
		
		entity.setAdult(dto.getAdult());
		entity.setBankbranchcde(dto.getBankbranchcde());
		entity.setBankName(dto.getBankName());
		entity.setBankNo(dto.getBankNo());
		entity.setBuildCd(dto.getBuildCd());
		entity.setChild(dto.getChild());
		entity.setEndDate(dto.getEndDate());
		entity.setName(dto.getName());
		entity.setPhone(dto.getPhone());
		entity.setStartDate(dto.getStartDate());
		entity.setStartDate(dto.getStartDate());
		entity.setTotalCost(dto.getTotalCost());
		log.info("modifyReserve: "+entity);
		reserveRepository.save(entity);
		
		return dto.getNo();
	}
	
	@Transactional
	@Override
	public int modifyPaymentReserve(ReserveDTO dto) {
		int result = reserveRepository.modifyPaymentByNo(dto.getNo(), dto.getPaymentFlg());
		return result;
	}
	@Transactional
	@Override
	public int modifyCancelReserve(ReserveDTO dto) {
		int result = reserveRepository.modifyCancelByNo(dto.getNo(), dto.getCancelFlg());
		return result;
	}
	
	@Transactional
	@Override
	public int modifyDeleteReserve(ReserveDTO dto) {
		int result = reserveRepository.modifyDeleteByNo(dto.getNo(), dto.getDeleteFlg());
		return result;
	}

	@Override
	public List<Object[]> getDateListAccToBuildCdAndRoomNum(Calendar date, int buildCd, Long roomNo) {
		return reserveRepository.getDateListAccToBuildCdAndRoomNum(date, buildCd, roomNo);
	}

	@Override
	public List<Object[]> getDateListAccToBuildCd(Calendar date, int buildCd) {
		return reserveRepository.getDateListAccToBuildCd(date, buildCd);
	}

	@Override
	public PageResultDTO<Object[], Object[]> findReserveByNameAndPhoneAndDeleteFlg(PageRequestDTO requestDTO, String name, String phone) {
		Pageable pageable = requestDTO.getPageable(Sort.by("no").descending());
		Page<Object[]> result = reserveRepository.findReserveByNameAndPhoneAndDeleteFlg(name, phone, "0",pageable);
		Function<Object[], Object[]> fn = (en -> entityToDtoObject((RoomInfo)en[0], (Reserve)en[1]));
		return new PageResultDTO<Object[], Object[]>(result, fn);
	}

	@Override
	public List<Object[]> findReserveByNameAndPhone(String name, String phone, Long reserveNo) {
		Function<Object[], Object[]> fn = (en -> entityToDtoObject((RoomInfo)en[0], (Reserve)en[1]));
		return reserveRepository.findReserveByNameAndPhone(name, phone, reserveNo).stream().map(fn).collect(Collectors.toList());
	}

	//예약 확인 - 상세 - 상태 변경
	@Transactional
	@Override
	public List<Object[]> modifyStatusOnReserve(ReserveDTO dto) {
		Function<Object[], Object[]> fn = (en -> entityToDtoObject((RoomInfo)en[0], (Reserve)en[1]));
		int status =reserveRepository.modifyStatusChange(dto.getNo(), dto.getDeleteFlg(), dto.getCancelFlg(), dto.getPaymentFlg());
		log.info("modifyStatusOnReserve: "+status);
		if(status >= 0)
			return reserveRepository.findReserveByReserveNo(dto.getNo()).stream().map(fn).collect(Collectors.toList());
		else
			return null;
	}
	
	

}
