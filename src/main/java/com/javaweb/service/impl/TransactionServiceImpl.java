package com.javaweb.service.impl;


import com.javaweb.converter.TransactionDTOConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.service.TransactionService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
@Transactional
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private TransactionDTOConverter transactionDTOConverter;

    @Override
    public void addOrUpdateTransaction(TransactionDTO transactionDTO) {
        TransactionEntity transactionEntity = transactionDTOConverter.transactionDTOConverter(transactionDTO);
        transactionRepository.save(transactionEntity);
    }

    @Override
    public List<TransactionEntity> listTransaction(String code, CustomerEntity customer) {
        List<TransactionEntity> transaction = transactionRepository.findByCodeAndCustomer(code, customer);
        return transaction;
    }
}
