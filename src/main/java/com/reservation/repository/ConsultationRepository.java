package com.reservation.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.querydsl.core.types.Predicate;
import com.reservation.entity.Consultation;
import com.reservation.repository.search.SearchConsultationRepository;

public interface ConsultationRepository extends JpaRepository<Consultation, Long>, SearchConsultationRepository {
	
	//delete
	@Modifying
	@Query("update Consultation c set c.deleteFlg = :deleteFlg where c.no = :no")
	int modifyDeleteByNo(@Param("no") Long no, @Param("deleteFlg") String deleteFlg);
	
	//modifyGrgrod
	@Modifying
	@Query("update Consultation c set c.grgrod = to_number(c.grgrod)+1 where c.grno = :grno and c.grgrod >= :grgrod")
	void changeGrgrod(@Param("grno") Long grno, @Param("grgrod") Long grgrod);
	
	//show not delete
	@Query("select c from Consultation c where c.deleteFlg = 0")
	Page<Consultation> getAllWithOutDelete(Predicate predicate, Pageable pageable);
	
	
	Page<Consultation> findConsultationByDeleteFlg(Pageable pageable, String deleteFlg);
	
	/*
	@Query(value = "SELECT c, count(c) "
			+ "FROM Consultation c "
			+ "LEFT JOIN Consultation c1 on c1.grno = c "
			+ "GROUP BY c")
	Page<Object[]> getConsultationWithGrgrodCount(Pageable pageable);
	*/
}
