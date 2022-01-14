package com.reservation.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Notice;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Long>, QueryDslPredicateExecutor<Notice> {
	
}
