package com.reservation.repository;

import java.util.Calendar;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.reservation.dto.PageRequestDTO;
import com.reservation.entity.RoomInfo;

@Repository
public interface RoomInfoRepository extends JpaRepository<RoomInfo, Long>, QuerydslPredicateExecutor<RoomInfo> {
	/*
	 * Paged List about rooominfo & reserve joined table
	 */
	@Query("select i, r.startDate, r.endDate from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " + 
			"where RPAD(to_char(add_months(sysdate,-1),'yyyymm'),8,'00') < RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(sysdate,1),'yyyymm'),8,'00') > RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00')"
			)
	Page<Object[]> getListPage(Pageable pageable);
	
	
	Page<RoomInfo> findAllByDeleteFlg(Pageable pageable, String deleteFlg);
	
	//available
	@Query("select distinct i from RoomInfo i  where i.no not in (select i.no from RoomInfo i left join Reserve r on r.roomNo.no = i "
			+ "where to_date(r.startDate,'YYYYMMDD') between to_date(:dateStart,'YYYYMMDD') and to_date(:dateEnd,'YYYYMMDD') "
			+ "or to_date(r.endDate,'YYYYMMDD') between to_date(:dateStart,'YYYYMMDD') and to_date(:dateEnd,'YYYYMMDD') "
			+ "and r.paymentFlg = 0 and r.cancelFlg = 0 and r.deleteFlg = 0) and i.max >= :max order by i.no asc"
			)
	Page<RoomInfo> getListPageOnMain(Pageable pageable,@Param("dateStart") String dateStart, @Param("dateEnd") String dateEnd, @Param("max") int max);
	
	
	
	
	
	/*
	 * List about rooominfo & reserve joined table on dynamic date
	 */
	@Query("select i, r from RoomInfo i " +
			"left join Reserve r on r.roomNo.no = i " +
			"where RPAD(to_char(add_months(:date,-1),'yyyymm'),8,'00') < RPAD(to_char(to_date(r.startDate,'yyyy/mm/dd'),'yyyymm'),8,'00') " + 
			"and RPAD(to_char(add_months(:date,1),'yyyymm'),8,'00') > RPAD(to_char(to_date(r.endDate,'yyyy/mm/dd'),'yyyymm'),8,'00')"
			)
	List<Object[]> getDateList(@Param("date") Calendar date);
	
	@Query("select i.buildCd from RoomInfo i group by i.buildCd")
	List<Integer> getBuildCd();
	
}
