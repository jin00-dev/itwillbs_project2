package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ExpVO { 
	
	private int exp_num;
	private int user_num;
	private int exp_price;
	
	private String exp_name;
	private String exp_region;
	private String exp_category;
	private String exp_ad_state;
	private String exp_summary_img;
	private String exp_detail_img;
	
	private Timestamp exp_start_date;
	private Timestamp exp_end_date;

	//정렬기준
	private int rev_star;
	private double rev_avgStar;
	//exp_price;
	
	
	// get/set메서드
	// toString메서드	
	

}
