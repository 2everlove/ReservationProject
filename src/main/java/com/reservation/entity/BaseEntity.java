package com.reservation.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

import com.reservation.utils.LocalDateTimeAttributeConverter;

import lombok.Getter;



@MappedSuperclass
@Getter
public class BaseEntity {
    @Column(updatable = false) // (2)
    @Convert(converter =  LocalDateTimeAttributeConverter.class)
    private LocalDateTime createdAt;
    @Convert(converter =  LocalDateTimeAttributeConverter.class)
    private LocalDateTime updatedAt;
    

    @PrePersist // (3)
    public void before() {
    	LocalDateTime now = LocalDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
    }

    @PreUpdate // (4)
    public void always() {
        this.updatedAt = LocalDateTime.now();
    }
}
