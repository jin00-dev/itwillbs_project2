package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class TestVO {
	
	// exp
	private int exp_num;
	private int user_num;
	private String exp_name;
	private Timestamp exp_date;
	private int exp_price;
	private String exp_region;
	private String exp_category;
	private int capacity;
	private int exp_ad_state;
	private String exp_summary_img;
	private String exp_detail_img;
	
	//payment
	private int payment_num;
	private int order_num;
	private int patment_state;
	private Timestamp payment_date;
	private String payment_pg;
	private String payment_method;
	
	//user
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private Timestamp user_regdate;
	private Timestamp user_last_access;
	private int user_type;
	private int user_report_state;
	private int user_delete_state;

}
