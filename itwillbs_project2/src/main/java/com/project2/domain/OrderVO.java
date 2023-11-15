package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderVO {
	private int order_num;
	private int exp_num;
	private String order_id;
	private int user_num;
	private int order_cnt;
	private Timestamp order_date;
	private String payment_id;
	private int payment_price;
	private int payment_state;
	private Timestamp payment_date;
	private String payment_pg;
	private String payment_method;
}
