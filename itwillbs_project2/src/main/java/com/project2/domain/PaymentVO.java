package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class PaymentVO {
	
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
	
	//payment
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
