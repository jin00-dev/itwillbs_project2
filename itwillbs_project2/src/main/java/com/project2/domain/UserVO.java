package com.project2.domain;

import java.sql.Timestamp;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UserVO {
	
	private Integer user_num;
	
	@NotNull
	@Email
	@Pattern(regexp = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z]*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z] {2,3}$")
	private String user_id;
	
	@NotNull
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,20}$")
	private String user_pw;
	
	@NotNull
	@Length(min=2,max=5)
	private String user_name;
	
	@NotNull
	@Pattern(regexp = "^01([0|1|6|7|8|9])-?([0-9] {3,4})-?([0-9] {4})$")
	private String user_phone;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Timestamp user_regdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Timestamp user_last_access;
	private Integer user_type;
	private String user_place_name;
	private Integer user_report_cnt;
	private Integer user_delete_state;
	
}
