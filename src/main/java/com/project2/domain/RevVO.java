package com.project2.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class RevVO {
	private int rev_num;
	private int user_num;
	private int exp_num;
	private String rev_content;
	private Timestamp rev_regdate;
	private int rev_star;
	private String rev_img;
	
	private String user_name;
	
}
