package com.javaweb.repository.custom.impl;

import com.javaweb.entity.CustomerEntity;
import com.javaweb.model.dto.CustomerDTO;
import com.javaweb.repository.custom.CustomerRepositoryCustom;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable (CustomerDTO customerDTO, StringBuilder sql) {
        Long staffId = customerDTO.getStaffId();
        if (staffId != null && !staffId.equals("")) {
            sql.append(" INNER JOIN assignmentcustomer ON assignmentcustomer.customerid = c.id ");
        }
    }

    public static void queryNomal(CustomerDTO customerDTO, StringBuilder where) {
        try {
            Field[] fields = CustomerDTO.class.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                String fieldName = field.getName();
                if (!fieldName.equals("staffId")) {
                    Object value = field.get(customerDTO);
                    if (value != null && !value.equals("")) {
                        if (field.getType().getName().equals("java.lang.Long") || field.getType().getName().equals("java.lang.Integer")) {
                            where.append(" AND c."+fieldName+" = "+value+" ");
                        }else if(field.getType().getName().equals("java.lang.String")){
                            where.append(" AND c."+fieldName+" LIKE '%"+value+"%' ");
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void querySpecial(CustomerDTO customerDTO, StringBuilder where) {
        Long staffId = customerDTO.getStaffId();
        if (staffId != null && !staffId.equals("")) {
            where.append(" AND assignmentcustomer.staffid = "+ staffId + " ");
        }
    }

    @Override
    public List<CustomerEntity> findCustomerByRequest(CustomerDTO customerDTO) {
        StringBuilder sql = new StringBuilder("SELECT c.* FROM customer c ");
        joinTable(customerDTO, sql);
        StringBuilder where = new StringBuilder(" WHERE 1 = 1 ");
        queryNomal(customerDTO, where);
        querySpecial(customerDTO, where);
        where.append(" GROUP BY c.id ");
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);
        return query.getResultList();
    }
}
