package com.reservation.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.stereotype.Repository;

import com.reservation.entity.Consultation;


@Repository
public interface ConsultationRepository extends JpaRepository<Consultation, Integer>, QueryDslPredicateExecutor<Consultation> {
}
