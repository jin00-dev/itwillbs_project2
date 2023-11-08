package com.project2.domain;


import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentVO {
	private int order_num;
	private String merchant_uid;
	private String buyer_email;
	private String buyer_name;
	private String buyer_tel;
	private String name;
	private String custom_data;
	private String imp_uid;
	private int paid_amount;
	private String status;
	private Timestamp payment_date;
	private String pg_provider;
	private String pay_method;
	private String card_name;
	private boolean success;
	
	
}
