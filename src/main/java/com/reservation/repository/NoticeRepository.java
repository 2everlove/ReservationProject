package com.reservation.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Notice;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long>, QueryDslPredicateExecutor<Notice> {
	
	@Modifying
	@Query("update Notice n set n.deleteFlg = ?2 where n.no = ?1")
	int modifyDeleteByNo(Long no, String deleteFlg);
}
