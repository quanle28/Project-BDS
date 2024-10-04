package com.javaweb.service.impl;

import com.javaweb.converter.CustomerDTOConverter;
import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.TransactionEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.EditCustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.repository.TransactionRepository;
import com.javaweb.repository.UserRepository;
import com.javaweb.service.CustomerService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private CustomerDTOConverter customerDTOConverter;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private TransactionRepository transactionRepository;

    @Override
    public ResponseDTO listStaffs(Long customerId) {
        CustomerEntity customer = customerRepository.findById(customerId).get();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> staffAssignment = customer.getUserEntityList();
        ResponseDTO responseDTO = customerDTOConverter.converterToResponseDTO(staffs, staffAssignment);
        return responseDTO;
    }

    @Override
    public List<CustomerSearchResponse> findCustomerByRequest(CustomerDTO customerDTO) {
        List<CustomerEntity> customerEntities = customerRepository.findCustomerByRequest(customerDTO);
        List<CustomerSearchResponse> customerSearchResponses = new ArrayList<>();
        for (CustomerEntity it : customerEntities) {
            CustomerSearchResponse customer = customerDTOConverter.toCustomerSearchResponse(it);
            customerSearchResponses.add(customer);
        }
        return customerSearchResponses;
    }

    @Override
    @Transactional
    public void addOrUpdateCustomer(EditCustomerDTO editCustomerDTO) {
        CustomerEntity customerEntity = customerDTOConverter.addOrUpdateCustomerConverter(editCustomerDTO);
        customerRepository.save(customerEntity);
    }

    @Override
    @Transactional
    public void deleteCustomer(List<Long> ids) {
        for (Long id : ids) {
            CustomerEntity customerEntity = customerRepository.findById(id).get();
            customerEntity.setIsactive(0);
            customerRepository.save(customerEntity);
        }
    }

    @Override
    public void updateAssignmentCustomer(AssignmentCustomerDTO assignmentCustomerDTO) {
        CustomerEntity customer = customerRepository.findById(assignmentCustomerDTO.getCustomerId()).get();
        List<UserEntity> staffs = new ArrayList<>();
        for (Long staffId : assignmentCustomerDTO.getStaffs()) {
            staffs.add(userRepository.findById(staffId).get());
        }
        customer.setUserEntityList(staffs);
        customerRepository.save(customer);
    }

    @Override
    public EditCustomerDTO toEditCustomer(Long id) {
        CustomerEntity customerEntity = customerRepository.findById(id).get();
        EditCustomerDTO editCustomerDTO = modelMapper.map(customerEntity, EditCustomerDTO.class);
        return editCustomerDTO;
    }

    @Override
    public void addContact(EditCustomerDTO editCustomerDTO) {
        CustomerEntity customer = modelMapper.map(editCustomerDTO, CustomerEntity.class);
        customer.setIsactive(1);
        customerRepository.save(customer);
    }

}
