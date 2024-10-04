package com.javaweb.converter;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.entity.UserEntity;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.EditCustomerDTO;
import com.javaweb.model.response.CustomerSearchResponse;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.model.response.StaffResponseDTO;
import com.javaweb.repository.CustomerRepository;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CustomerDTOConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private CustomerRepository customerRepository;

    public CustomerSearchResponse toCustomerSearchResponse(CustomerEntity customerEntity) {
        CustomerSearchResponse customerSearchResponse = modelMapper.map(customerEntity, CustomerSearchResponse.class);
        return customerSearchResponse;
    }


    public CustomerEntity addOrUpdateCustomerConverter(EditCustomerDTO editCustomerDTO) {
        CustomerEntity customerEntity = modelMapper.map(editCustomerDTO, CustomerEntity.class);
        if (editCustomerDTO.getId() != null) {
            CustomerEntity customer = customerRepository.findById(editCustomerDTO.getId()).get();
            customerEntity.setCreatedBy(customer.getCreatedBy());
            customerEntity.setCreatedDate(customer.getCreatedDate());
            customerEntity.setUserEntityList(customer.getUserEntityList());
        }
        customerEntity.setIsactive(1);
        return customerEntity;
    }

    public ResponseDTO converterToResponseDTO(List<UserEntity> staffs, List<UserEntity> staffAssignment) {
        List<StaffResponseDTO> staffResponseDTOS = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();
        for (UserEntity it : staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setFullName(it.getFullName());
            staffResponseDTO.setStaffId(it.getId());
            if(staffAssignment.contains(it)){
                staffResponseDTO.setChecked("checked");
            }else {
                staffResponseDTO.setChecked("");
            }
            staffResponseDTOS.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOS);
        responseDTO.setMessage("Success");
        return responseDTO;
    }
}
