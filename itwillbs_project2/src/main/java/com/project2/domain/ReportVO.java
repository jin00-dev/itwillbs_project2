package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReportVO {

	private Integer report_num; //신고번호(pk)
	private Integer user_num; // 유저번호(신고당한사람)
	private Integer report_user_num; // 신고자
	private String report_content; // 신고내용
	private Timestamp report_regdate; // 신고날짜
	private Timestamp report_updatedate; // 처리날짜
	private int report_state; // 처리상태(default 0, 0은 처리안됨, 1은 처리완료, 2는 반려)
	
}
