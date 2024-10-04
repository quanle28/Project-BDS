package com.javaweb.repository;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<TransactionEntity, Long> {
    List<TransactionEntity> findByCodeAndCustomer(String code, CustomerEntity customer);
    TransactionDTO findByCustomer(Long customerId);
}
