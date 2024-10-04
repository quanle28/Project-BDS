package com.javaweb.service;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.EditCustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.model.response.ResponseDTO;

import java.util.List;

public interface CustomerService {
    ResponseDTO listStaffs(Long customerId);

    List<CustomerSearchResponse> findCustomerByRequest(CustomerDTO customerDTO);

    void addOrUpdateCustomer(EditCustomerDTO editCustomerDTO);

    void deleteCustomer(List<Long> ids);

    void updateAssignmentCustomer(AssignmentCustomerDTO assignmentCustomerDTO);

    EditCustomerDTO toEditCustomer(Long id);

    void addContact(EditCustomerDTO editCustomerDTO);
}
