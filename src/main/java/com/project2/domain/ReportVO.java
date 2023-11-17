package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReportVO {
	private int report_num;
	private int rev_num;
	private int user_num;
	private int report_user_num;
	private String report_content;
	private Timestamp report_regdate;
	private Timestamp report_updatedate;
	private int report_state;
	
	private int exp_num;
}
