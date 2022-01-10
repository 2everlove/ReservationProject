package com.reservation.repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import com.reservation.entity.Consultation;

@Repository
public class ConsultPerRepository {

	@PersistenceContext
	EntityManager em;
	
	public void save(Consultation consultation) {
		em.persist(consultation);
	}
	
	public Consultation findOne(int no) {
		return em.find(Consultation.class, no);
	}
}
