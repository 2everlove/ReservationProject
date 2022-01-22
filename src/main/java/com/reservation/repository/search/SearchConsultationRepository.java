package com.reservation.repository.search;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.reservation.entity.Consultation;
import com.reservation.entity.Notice;

public interface SearchConsultationRepository {
	
	Consultation searchCountorder(Long no);
	
	Page<?> searchPage(String type, String keyword, Pageable pageable);
}
