package com.reservation.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Consultation;

@Repository
public interface ConsultationRepository extends JpaRepository<Consultation, Long>, QueryDslPredicateExecutor<Consultation> {
	
	@Modifying
	@Query("update Consultation c set c.deleteFlg = :deleteFlg where c.no = :no")
	int modifyDeleteByNo(@Param("no") Long no, @Param("deleteFlg") String deleteFlg);
	
	@Query("select c from Consultation c where c.deleteFlg = 0")
	Page<Consultation> getAllWithOutDelete(Pageable pageable);
	
}
