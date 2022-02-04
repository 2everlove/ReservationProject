package com.reservation.service;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.reservation.dto.PageRequestDTO;
import com.reservation.dto.PageResultDTO;
import com.reservation.dto.ReserveDTO;
import com.reservation.dto.RoomInfoDTO;
import com.reservation.entity.Reserve;
import com.reservation.entity.RoomInfo;

public interface ReserveService {
	
	@Transactional
	Long registerReserve(ReserveDTO reserveDTO);//reserve 登録
	
	List<Object[]> getDateList(Calendar date);
	
	List<Object[]> getDateListAccToBuildCdAndRoomNum(Calendar date, int buildCd, Long roomNo);
	
	List<Object[]> getDateListAccToBuildCd(Calendar date, int buildCd);
	
	PageResultDTO<ReserveDTO, Object[]> getList(PageRequestDTO requestDTO);
	
	//이름,폰으로 예약 검색
	PageResultDTO<Object[], Object[]> findReserveByNameAndPhoneAndDeleteFlg(PageRequestDTO pageable, String name, String phone);
	
	List<ReserveDTO> getDateList(Date dateStart, Date dateEnd, Long roomno);
	
	List<Object[]> getDateObjectList(Date dateStart, Date dateEnd, Long roomno);
	
	List<ReserveDTO> getReserveAndRoomSpecificDate(Date dateStart, Date dateEnd, Long roomno);

	ReserveDTO getReserve(ReserveDTO dto);

	List<Object[]> getDateListWithOutReserveNo(Date dateStart, Date dateEnd, Long roomno, Long reserveno);

	Long modifyReserve(ReserveDTO reserveDTO);

	int modifyCancelReserve(ReserveDTO dto);

	int modifyDeleteReserve(ReserveDTO dto);

	int modifyPaymentReserve(ReserveDTO dto);

	List<Object[]> findReserveByNameAndPhone(String name, String phone, Long reserveNo);

	
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
	default Object[] entityToDtoObject(RoomInfo roomInfo, Reserve reserve) {
		ReserveDTO reserveDto = ReserveDTO.builder()
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
		RoomInfoDTO roomInfoDto = RoomInfoDTO.builder()
				.no(roomInfo.getNo())
				.roomNum(roomInfo.getRoomNum())
				.roomTitle(roomInfo.getRoomTitle())
				.max(roomInfo.getMax())
				.adultCost(roomInfo.getAdultCost())
				.childCost(roomInfo.getChildCost())
				.explanation(roomInfo.getExplanation())
				.images(Arrays.asList(roomInfo.getImages().split(",")))
				.colorCd(roomInfo.getColorCd())
				.buildCd(roomInfo.getBuildCd())
				.deleteFlg(roomInfo.getDeleteFlg())
				.createdAt(roomInfo.getCreatedAt())
				.updatedAt(roomInfo.getUpdatedAt())
			.build();
		Object[] list = new Object[2];
		list[0] = reserveDto;
		list[1] = roomInfoDto;
		return list;
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

	List<Object[]> modifyStatusOnReserve(ReserveDTO dto);
}
