package com.reservation.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.reservation.entity.Notice;
import com.reservation.repository.search.SearchNoticeRepository;

public interface NoticeRepository extends JpaRepository<Notice, Long>, SearchNoticeRepository {
	
	@Modifying
	@Query("update Notice n set n.deleteFlg = :deleteFlg where n.no = :no")
	int modifyDeleteByNo(@Param("no") Long no, @Param("deleteFlg") String deleteFlg);
	
	@Query("select n from Notice n where n.deleteFlg = 0")
	Page<Notice> getAllWithOutDelete(Pageable pageable);
}
