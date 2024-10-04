package com.javaweb.enums;

import java.util.Map;
import java.util.TreeMap;

public enum TransactionType {
    CSKH("Chăm sóc khách hàng"),
    DDX("Dẫn đi xem");

    private final String transactionName;
    TransactionType(String transactionName) {
        this.transactionName = transactionName;
    }

    public static Map<String, String> type(){
        Map<String, String> listTransactions = new TreeMap<>();
        for(TransactionType it : TransactionType.values()){
            listTransactions.put(it.toString(), it.transactionName);
        }
        return listTransactions;
    }
}
