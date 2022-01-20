package com.reservation.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.entity.Reserve;
import com.reservation.entity.RoomInfo;

public interface ReserveService {
	
	@Transactional
	Long registerReserve(ReserveDTO reserveDTO);//reserve 登録
	
	List<Object[]> getDateList(Calendar date);
	
	PageResultDTO<ReserveDTO, Object[]> getList(PageRequestDTO requestDTO);
	
	List<ReserveDTO> getDateList(Date dateStart, Date dateEnd, Long roomno);
	
	List<Object[]> getDateObjectList(Date dateStart, Date dateEnd, Long roomno);
	
	default ReserveDTO entityToDTO(RoomInfo roomInfo, Reserve reserve) {
		ReserveDTO dto = ReserveDTO.builder()
				.no(reserve.getNo())
				.roomNo(roomInfo.getNo())
				.name(reserve.getName())
				.phone(reserve.getPhone())
				.adult(reserve.getAdult())
				.child(reserve.getChild())
				.startDate(reserve.getStartDate())
				.endDate(reserve.getEndDate())
				.options(reserve.getOptions())
				.paymentFlg(reserve.getPaymentFlg())
				.totalCost(reserve.getTotalCost())
				.cancelFlg(reserve.getCancelFlg())
				.bankName(reserve.getBankName())
				.bankbranchcde(reserve.getBankbranchcde())
				.bankNo(reserve.getBankNo())
				.deleteFlg(reserve.getDeleteFlg())
				.createdAt(reserve.getCreatedAt())
				.updatedAt(reserve.getUpdatedAt())
				.buildCd(reserve.getBuildCd())
				.build();
		return dto;
	}
	default ReserveDTO entityToDTO(Reserve reserve) {
		ReserveDTO dto = ReserveDTO.builder()
				.no(reserve.getNo())
				.roomNo(reserve.getRoomNo().getNo())
				.name(reserve.getName())
				.phone(reserve.getPhone())
				.adult(reserve.getAdult())
				.child(reserve.getChild())
				.startDate(reserve.getStartDate())
				.endDate(reserve.getEndDate())
				.options(reserve.getOptions())
				.paymentFlg(reserve.getPaymentFlg())
				.totalCost(reserve.getTotalCost())
				.cancelFlg(reserve.getCancelFlg())
				.bankName(reserve.getBankName())
				.bankbranchcde(reserve.getBankbranchcde())
				.bankNo(reserve.getBankNo())
				.deleteFlg(reserve.getDeleteFlg())
				.createdAt(reserve.getCreatedAt())
				.updatedAt(reserve.getUpdatedAt())
				.buildCd(reserve.getBuildCd())
				.build();
		return dto;
	}
	
	default Reserve dtoToEntity(ReserveDTO dto) {
		RoomInfo roomInfo = RoomInfo.builder().no(dto.getRoomNo()).build();
		Reserve entity = Reserve.builder()
				.no(dto.getNo())
				.roomNo(roomInfo)
				.name(dto.getName())
				.phone(dto.getPhone())
				.adult(dto.getAdult())
				.child(dto.getChild())
				.startDate(dto.getStartDate())
				.endDate(dto.getEndDate())
				.options(dto.getOptions())
				.paymentFlg(dto.getPaymentFlg())
				.totalCost(dto.getTotalCost())
				.cancelFlg(dto.getCancelFlg())
				.bankName(dto.getBankName())
				.bankbranchcde(dto.getBankbranchcde())
				.bankNo(dto.getBankNo())
				.deleteFlg(dto.getDeleteFlg())
				.buildCd(dto.getBuildCd())
				.build();
		return entity;
	}
}
