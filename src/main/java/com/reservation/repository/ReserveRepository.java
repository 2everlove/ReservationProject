package com.reservation.repository;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Reserve;

@Repository
public interface ReserveRepository extends JpaRepository<Reserve, Long>, QuerydslPredicateExecutor<Reserve> {
	
	@Modifying
	@Query("update Reserve r set r.paymentFlg = :paymentFlg where r.no = :no")
	int modifyPaymentByNo(@Param("no") Long no, @Param("paymentFlg") String paymentFlg);
	
	@Modifying
	@Query("update Reserve r set r.cancelFlg = :cancelFlg where r.no = :no")
	int modifyCancelByNo(@Param("no") Long no, @Param("cancelFlg") String cancelFlg);
	
	@Modifying
	@Query("update Reserve r set r.cancelFlg = :deleteFlg where r.no = :no")
	int modifyDeleteByNo(@Param("no") Long no, @Param("deleteFlg") String deleteFlg);
	
	//이름,폰으로 예약 검색 with page
	@Query("select i, r from RoomInfo i "
			+ "left join Reserve r on r.roomNo.no = i "
			+ "where r.name = :name and r.phone = :phone")
	Page<Object[]> findReserveByNameAndPhone(@Param("name") String name, @Param("phone") String phone, Pageable pageable);
	
	//이름,폰으로 예약 검색
	@Query("select i,r from RoomInfo i left join Reserve r on r.roomNo.no = i where r.name = :name and r.phone = :phone and r.no = :reserveNo")
	List<Object[]> findReserveByNameAndPhone(@Param("name") String name, @Param("phone") String phone, @Param("reserveNo") Long reserveNo);
	
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " + 
			"where RPAD(to_char(add_months(sysdate,-1),'yyyymm'),8,'00') <= RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(sysdate,1),'yyyymm'),8,'00') >= RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	Page<Object[]> getListPage(Pageable pageable);
	
	//get a month data for fullcalendar on admin page
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " +
			"where RPAD(to_char(add_months(:date,-1),'yyyymm'),8,'00') <= RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(:date,1),'yyyymm'),8,'00') >= RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	List<Object[]> getDateList(@Param("date") Calendar date);
	
	//get a month according to buildCd & roomNum data for fullcalendar on admin page
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " +
			"where RPAD(to_char(add_months(:date,-1),'yyyymm'),8,'00') <= RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(:date,1),'yyyymm'),8,'00') >= RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 and r.buildCd = :buildCd order by r.roomNo.no"
			)
	List<Object[]> getDateListAccToBuildCd(@Param("date") Calendar date, @Param("buildCd") int buildCd);
	
	//get a month according to buildCd & roomNum data for fullcalendar on admin page
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " +
			"where RPAD(to_char(add_months(:date,-1),'yyyymm'),8,'00') <= RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(:date,1),'yyyymm'),8,'00') >= RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 and r.buildCd = :buildCd and r.roomNo.no = :roomNo order by r.roomNo.no"
			)
	List<Object[]> getDateListAccToBuildCdAndRoomNum(@Param("date") Calendar date, @Param("buildCd") int buildCd, @Param("roomNo") Long roomNo);
	
	//한달 전 후 방 정보
	@Query("select i, r from RoomInfo i " +
			"right join Reserve r on r.roomNo.no = i "
			+ "where r.roomNo.no = :roomno and to_date(r.startDate,'YYYYMMDD') > :dateStart and :dateEnd < to_date(r.endDate,'YYYYMMDD') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	List<Object[]> getDateList(@Param("dateStart") Date dateStart,@Param("dateEnd") Date dateEnd, @Param("roomno") Long roomno);
	
	//입력된 예약번호를 제외한 한달 전 후 방 정보
	@Query("select i, r from RoomInfo i " +
			"right join Reserve r on r.roomNo.no = i "
			+ "where r.roomNo.no = :roomno and to_date(r.startDate,'YYYYMMDD') > :dateStart and :dateEnd < to_date(r.endDate,'YYYYMMDD') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 and r.no != :reserveno order by r.roomNo.no"
			)
	List<Object[]> getDateList(@Param("dateStart") Date dateStart,@Param("dateEnd") Date dateEnd, @Param("roomno") Long roomno, @Param("reserveno") Long reserveno);
	
	//중복체크
	@Query("select count(*) from RoomInfo i " +
			"left outer join Reserve r on r.roomNo.no = i and r.roomNo.no = :roomno "
			+ "where to_date(r.startDate,'YYYYMMDD') between to_date(:dateStart,'YYYYMMDD') and to_date(:dateEnd,'YYYYMMDD') "
			+ "or to_date(r.endDate,'YYYYMMDD') between to_date(:dateStart,'YYYYMMDD') and to_date(:dateEnd,'YYYYMMDD') "
			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	Long getDateCount(@Param("dateStart") String dateStart, @Param("dateEnd") String dateEnd, @Param("roomno") Long roomno);
	
	/*
	 * //방&예약 정보
	 * 
	 * @Query("select i, r from RoomInfo i " +
	 * "left join Reserve r on r.roomNo.no = i and r.no = :reservNo " +
	 * "where r.roomNo.no = :roomNo" ) Object[] getReserveAndRoom(@Param("roomNo")
	 * Long roomNo, @Param("reservNo") Long reservNo);
	 */
	
	//특정날짜 예약 정보 및 방정보 가져오기
	@Query("select i, r from RoomInfo i " +
			"left outer join Reserve r on r.roomNo.no = i and r.roomNo.no = :roomno "
			+ "where to_date(r.startDate,'YYYYMMDD') between :dateStart and :dateEnd "
			+ "or to_date(r.endDate,'YYYYMMDD') between :dateStart and :dateEnd "			+ "and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	List<Object[]> getReserveAndRoomSpecificDate(@Param("dateStart") Date dateStart,@Param("dateEnd") Date dateEnd, @Param("roomno") Long roomno);

	
	
	
	
}
