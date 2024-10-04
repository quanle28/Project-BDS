package com.javaweb.api.admin;

import com.javaweb.model.dto.AssignmentCustomerDTO;
import com.javaweb.model.dto.EditCustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.model.response.ResponseDTO;
import com.javaweb.service.CustomerService;
import com.javaweb.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController(value = "customerAPIOfAdmin")
@RequestMapping("/api/customer")
public class CustomerAPI {
    @Autowired
    private CustomerService customerService;

    @Autowired
    private TransactionService transactionService;

    @PostMapping
    public EditCustomerDTO addOrUpdateCustomer(@RequestBody EditCustomerDTO editCustomerDTO) {
        // xuong DB de them moi
        customerService.addOrUpdateCustomer(editCustomerDTO);
        return editCustomerDTO;
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id) {
        ResponseDTO result = customerService.listStaffs(id);
        return result;
    }

    @DeleteMapping("/{ids}")
    public void deleteCustomer(@PathVariable List<Long> ids) {
        customerService.deleteCustomer(ids);
    }

    @PostMapping("/assignment")
    public void updateAssignment(@RequestBody AssignmentCustomerDTO assignmentCustomerDTO) {
        customerService.updateAssignmentCustomer(assignmentCustomerDTO);
    }

    @PostMapping("/transaction")
    public void addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        transactionService.addOrUpdateTransaction(transactionDTO);
        System.out.println("OK");
    }

    @PostMapping("/contact")
    public void addContact(@RequestBody EditCustomerDTO editCustomerDTO) {
        customerService.addContact(editCustomerDTO);
        System.out.println("OK");
    }



}
