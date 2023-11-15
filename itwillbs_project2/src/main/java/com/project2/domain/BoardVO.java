package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class BoardVO {
	
	private Integer bno;
	private String title;
	private String content;
	private String writer;
	private int viewcnt;
	private Timestamp regdate;
	
	
	// Integer : 글번호.. 데이터를 가지고 다님.. bno
	// int : 디비에 있는거 가져온거, 디비에 저장ㄷ된 정보를 바꾸는거 viewcnt
}
