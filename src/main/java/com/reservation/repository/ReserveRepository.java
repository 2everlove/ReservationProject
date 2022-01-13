package com.reservation.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Reserve;

@Repository
public interface ReserveRepository extends JpaRepository<Reserve, Long>, QueryDslPredicateExecutor<Reserve> {
}
