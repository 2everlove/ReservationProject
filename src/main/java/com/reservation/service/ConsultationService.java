package com.reservation.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.reservation.entity.Consultation;
import com.reservation.repository.ConsultationRepository;

@Transactional
@Service
public class ConsultationService {

	@Autowired
	ConsultationRepository consultationRepository;
	
	
	public int write(Consultation consultation) {
		consultationRepository.save(consultation);
		return consultation.getNo();
	}
}
