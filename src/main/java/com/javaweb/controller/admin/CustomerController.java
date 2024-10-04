package com.javaweb.controller.admin;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.enums.District;
import com.javaweb.enums.StatusType;
import com.javaweb.enums.TransactionType;
import com.javaweb.enums.TypeCode;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.model.dto.EditBuildingDTO;
import com.javaweb.model.dto.EditCustomerDTO;
import com.javaweb.model.dto.TransactionDTO;
import com.javaweb.repository.CustomerRepository;
import com.javaweb.security.utils.SecurityUtils;
import com.javaweb.service.CustomerService;
import com.javaweb.service.TransactionService;
import com.javaweb.service.impl.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller(value="customerControllerOfAdmin")
public class CustomerController {
    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private TransactionService transactionService;

    @RequestMapping(value = "/admin/customer-list", method = RequestMethod.GET)
    public ModelAndView customerList(@ModelAttribute CustomerDTO customerDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/list");
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")){
            Long staffId = SecurityUtils.getPrincipal().getId();
            customerDTO.setStaffId(staffId);
            mav.addObject("searchResponses", customerService.findCustomerByRequest(customerDTO)); //where userid =
        }
        else { // manager
            mav.addObject("searchResponses", customerService.findCustomerByRequest(customerDTO));
        }
        mav.addObject("customerDTO", customerDTO);
        mav.addObject("listStaffs", userService.getStaffs());
        return mav;
    }

    @RequestMapping(value = "/admin/customer-edit", method = RequestMethod.GET)
    public ModelAndView buildingAdd(@ModelAttribute EditCustomerDTO editCustomerDTO, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        mav.addObject("editCustomer", editCustomerDTO);
        mav.addObject("listStatus", StatusType.type());
        return mav;
    }

    @RequestMapping(value = "/admin/customer-edit-{id}", method = RequestMethod.GET)
    public ModelAndView buildingEdit(@PathVariable("id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        // xuong db tim id theo id
        mav.addObject("editCustomer", customerService.toEditCustomer(id));
        mav.addObject("listTransactions", TransactionType.type());
        mav.addObject("listStatus", StatusType.type());
        CustomerEntity customer = customerRepository.findById(id).get();
        // 2 bảng danh sách giao dịch theo loại giao dịch       findByCodeAndCustomerId
        // listType1: CSKH
        mav.addObject("listTransaction_CSKH", transactionService.listTransaction("CSKH", customer));
        // listType2: DDX
        mav.addObject("listTransaction_DDX", transactionService.listTransaction("DDX", customer));
        return mav;
    }
}
