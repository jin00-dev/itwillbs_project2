package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class TestVO {
	
	// exp
	private int exp_num;
	private String exp_phone;
	private String exp_place;
	private String exp_name;
	private Timestamp exp_start_date;
	private Timestamp exp_end_date;
	private int exp_price;
	private String exp_region;
	private String exp_category;
	private int exp_capacity;
	private int exp_ad_state;
	private int exp_inout;
	private String exp_summary_img;
	private String exp_detail_img;
	
	//order_board
	private int order_num;
	private int payment_num;
	private int order_cnt;
	private Timestamp order_date;
	private String payment_id;
	private int payment_price;
	private int payment_state;
	private Timestamp payment_date;
	private String payment_pg;
	private String payment_method;
	
	//user
	private int user_num;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private Timestamp user_regdate;
	private Timestamp user_last_access;
	private int user_type;
	private String user_place_name;
	private int user_report_cnt;
	private int user_delete_state;



}
