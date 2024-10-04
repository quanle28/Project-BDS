package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;

import java.util.List;

public interface TransactionService {
    void addOrUpdateTransaction(TransactionDTO transactionDTO);

    List<TransactionEntity> listTransaction(String code, CustomerEntity customerEntity);
}
