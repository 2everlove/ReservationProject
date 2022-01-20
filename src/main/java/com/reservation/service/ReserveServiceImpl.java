package com.reservation.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
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

	@Override
	public PageResultDTO<ReserveDTO, Object[]> getList(PageRequestDTO requestDTO) {
		Function<Object[], ReserveDTO> fn = (en -> entityToDTO((RoomInfo)en[0], (Reserve)en[1]));
		Page<Object[]> result = reserveRepository.getListPage(requestDTO.getPageable(new Sort(Direction.DESC, "no")));
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
	public List<Object[]> getDateObjectList(Date dateStart, Date dateEnd, Long roomno) {
		List<Object[]> result = reserveRepository.getDateList(dateStart, dateEnd, roomno);
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
	
	

}
