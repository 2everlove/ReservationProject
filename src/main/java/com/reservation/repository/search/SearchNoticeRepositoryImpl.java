package com.reservation.repository.search;

import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.PathBuilder;
import com.querydsl.jpa.JPQLQuery;
import com.reservation.entity.Notice;
import com.reservation.entity.QNotice;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class SearchNoticeRepositoryImpl extends QuerydslRepositorySupport implements SearchNoticeRepository {

	public SearchNoticeRepositoryImpl() {
		super(Notice.class);
	}
	
	@Override
	public Notice search1() {
		log.info("search1.....................");
		return null;
	}

	@Override
	public Page<?> searchPage(String type, String keyword, Pageable pageable) {
		log.info("searchPage............");
		
		QNotice notice = QNotice.notice;
		JPQLQuery<Notice> jpqlQuery1 = from(notice);
		JPQLQuery<Notice> jpqlQuery = jpqlQuery1.select(notice);
		BooleanBuilder booleanBuilder = new BooleanBuilder();
		BooleanExpression expression = notice.no.gt(0L);
		
		booleanBuilder.and(expression);
		
		if(type != null) {
			String[] typeArr = type.split("");
			BooleanBuilder conditionBuilder = new BooleanBuilder();
			for(String t: typeArr) {
				switch (t) {
				case "t":
					conditionBuilder.or(notice.title.contains(keyword));
					break;
				case "c":
					conditionBuilder.or(notice.contents.contains(keyword));
					break;
				case "b":
					conditionBuilder.or(notice.buildCd.eq(Integer.parseInt(keyword)));
					break;

				default:
					break;
				}
			}
			booleanBuilder.and(conditionBuilder);
		}
		jpqlQuery.where(booleanBuilder);
		
		Sort sort = pageable.getSort();
		
		sort.stream().forEach(order -> {
			Order direction = order.isAscending()? Order.ASC: Order.DESC;
			String prop = order.getProperty();
			
			PathBuilder<Notice> orderByExpression = new PathBuilder(Notice.class, "notice");
			
			jpqlQuery.orderBy(new OrderSpecifier(direction, orderByExpression.get(prop)));
		});
		jpqlQuery.offset(pageable.getOffset());
		jpqlQuery.limit(pageable.getPageSize());
		List<Notice> result = jpqlQuery.fetch();
		
		log.info(result);
		final int start = (int)pageable.getOffset();
		final int end = (int) Math.min((start + pageable.getPageSize()), jpqlQuery.fetchCount());
		long count = jpqlQuery.fetchCount();
		
		return new PageImpl<>(result.subList(start, end), pageable, count);
		
	}
	
}
