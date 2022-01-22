package com.reservation.repository;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Reserve;

@Repository
public interface ReserveRepository extends JpaRepository<Reserve, Long>, QuerydslPredicateExecutor<Reserve> {
	
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " + 
			"where RPAD(to_char(add_months(sysdate,-1),'yyyymm'),8,'00') < RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(sysdate,1),'yyyymm'),8,'00') > RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00') "
			+ "and r.paymentFlg = 0 and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	Page<Object[]> getListPage(Pageable pageable);
	
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " +
			"where RPAD(to_char(add_months(:date,-1),'yyyymm'),8,'00') < RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(:date,1),'yyyymm'),8,'00') > RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00') "
			+ "and r.paymentFlg = 0 and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	List<Object[]> getDateList(@Param("date") Calendar date);
	
	@Query("select i, r from RoomInfo i " +
			"right join Reserve r on r.roomNo.no = i "
			+ "where r.roomNo.no = :roomno and to_date(r.startDate,'YYYYMMDD') > :dateStart and :dateEnd < to_date(r.endDate,'YYYYMMDD') "
			+ "and r.paymentFlg = 0 and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	List<Object[]> getDateList(@Param("dateStart") Date dateStart,@Param("dateEnd") Date dateEnd, @Param("roomno") Long roomno);
	
	//중복체크
	@Query("select count(*) from RoomInfo i " +
			"right join Reserve r on r.roomNo.no = i "
			+ "where r.roomNo.no = :roomno and to_date(r.startDate,'YYYYMMDD') between to_date(:dateStart,'YYYYMMDD') and to_date(:dateEnd,'YYYYMMDD') "
			+ "or to_date(r.endDate,'YYYYMMDD') between to_date(:dateStart,'YYYYMMDD') and to_date(:dateEnd,'YYYYMMDD') "
			+ "and r.paymentFlg = 0 and r.cancelFlg = 0 and r.deleteFlg = 0 order by r.roomNo.no"
			)
	Long getDateCount(@Param("dateStart") String dateStart, @Param("dateEnd") String dateEnd, @Param("roomno") Long roomno);
	
	
}
