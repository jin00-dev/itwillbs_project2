package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;



@Data
public class MemberVO { /*MemberDTO*/
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	
	private Timestamp user_regdate;
	private Timestamp user_last_access;
	
	private int user_type;
	private int user_place_name;
	private int user_report_state;
	private int user_delete_state;
	
	// get/set메서드
	// toString메서드	
	

}
