package com.project2.domain;


import lombok.Data;

@Data
public class PaymentVO {
	private String buyer_email;
	private String custom_data;
	private String name;
	private String pg_provider;
	private String pay_method;
	private String imp_uid;
	private String merchant_uid;
	private int paid_amount;
	private boolean success;
	
	
}
