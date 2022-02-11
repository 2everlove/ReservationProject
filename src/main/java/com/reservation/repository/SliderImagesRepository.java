package com.reservation.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.repository.query.Param;

import com.reservation.entity.Sliderimages;

public interface SliderImagesRepository extends JpaRepository<Sliderimages, Long>, QuerydslPredicateExecutor<Sliderimages> {
	
	@Modifying
	@Query("update Sliderimages s set s.deleteFlg = :deleteFlg where s.no = :no")
	int updateDeleteFlg(@Param("deleteFlg") String deleteFlg, @Param("no") Long no);
	
	@Modifying
	@Query("update Sliderimages s set s.activity = :activity where s.no = :no")
	int updateActiveFlg(@Param("activity") String activity, @Param("no") Long no);
	
	@Query("select s from Sliderimages s where s.deleteFlg = :deleteFlg and s.activity = :activity order by s.sortNo")
	List<Sliderimages> getSlideListForUser(@Param("deleteFlg") String deleteFlg,@Param("activity") String activity);
	
	@Query("select s from Sliderimages s order by s.sortNo")
	List<Sliderimages> getSlideListForAdmin();
}
