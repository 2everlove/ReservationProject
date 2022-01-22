package com.reservation.repository.search;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;

import com.querydsl.core.Tuple;
import com.querydsl.core.types.CollectionExpression;
import com.querydsl.jpa.JPQLQuery;
import com.reservation.entity.Consultation;
import com.reservation.entity.QConsultation;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class SearchConsultationRepositoryImpl extends QuerydslRepositorySupport implements SearchConsultationRepository {

	public SearchConsultationRepositoryImpl() {
		super(Consultation.class);
	}

	@Override
	public Page<?> searchPage(String type, String keyword, Pageable pageable) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Consultation searchCountorder(Long no) {
		QConsultation consultation = QConsultation.consultation;
		JPQLQuery<Consultation> jpqlQuery = from(consultation);
		
		JPQLQuery<Consultation> tuple = jpqlQuery.select(consultation);
		log.info("------------------------------");
		log.info(tuple);
		log.info("------------------------------");
		List<Consultation> result =tuple.fetch();
		log.info(result);
		return null;
	}
	
	
	
}
