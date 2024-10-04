package com.javaweb.converter;

import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionDTOConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private CustomerRepository customerRepository;

    public TransactionEntity transactionDTOConverter(TransactionDTO transactionDTO) {
        TransactionEntity transactionEntity = modelMapper.map(transactionDTO, TransactionEntity.class);
        if (transactionDTO.getId() != null) {
            TransactionEntity findTransaction = transactionRepository.findById(transactionDTO.getId()).get();
            transactionEntity.setCreatedBy(findTransaction.getCreatedBy());
            transactionEntity.setCreatedDate(findTransaction.getCreatedDate());
        }
        transactionEntity.setNote(transactionDTO.getTransactionDetail());
        transactionEntity.setCustomer(customerRepository.findById(transactionDTO.getCustomerId()).get());
        return transactionEntity;
    }
}
