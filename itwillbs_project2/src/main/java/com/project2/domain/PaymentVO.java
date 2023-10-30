package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentVO {
	
	private int payment_num;
	private int order_num;
	private int patment_state;
	private Timestamp payment_date;
	private String payment_pg;
	private String payment_method;
	

}
