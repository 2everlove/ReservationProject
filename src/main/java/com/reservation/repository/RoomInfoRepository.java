package com.reservation.repository;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.reservation.entity.RoomInfo;

@Repository
public interface RoomInfoRepository extends JpaRepository<RoomInfo, Long>, QueryDslPredicateExecutor<RoomInfo> {
	/*
	 * Paged List about rooominfo & reserve joined table
	 */
	@Query("select i, r.startDate, r.endDate from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " + 
			"where RPAD(to_char(add_months(sysdate,-1),'yyyymm'),8,'00') < RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(sysdate,1),'yyyymm'),8,'00') > RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00')"
			)
	Page<Object[]> getListPage(Pageable pageable);
	
	/*
	 * List about rooominfo & reserve joined table on dynamic date
	 */
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " +
			"where RPAD(to_char(add_months(:date,-1),'yyyymm'),8,'00') < RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(:date,1),'yyyymm'),8,'00') > RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00')"
			)
	List<Object[]> getDateList(@Param("date") Calendar date);
}
