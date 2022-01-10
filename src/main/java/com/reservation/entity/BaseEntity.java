package com.reservation.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

import lombok.Getter;



@MappedSuperclass
@Embeddable
@Getter
public class BaseEntity {
    @Column(updatable = false) // (2)
    private Date createdAt;
    private Date updatedAt;
    private String deleteFlg;

    @PrePersist // (3)
    public void before() {
    	Date now = new Date();
        this.createdAt = now;
        this.updatedAt = now;
    }

    @PreUpdate // (4)
    public void always() {
        this.updatedAt = new Date();
    }
}
