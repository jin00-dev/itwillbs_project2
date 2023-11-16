package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QnaVO {

	private int qna_num; // 문의 번호 (제약조건: PK, NN, AI) 
	private int user_num; // 회원 번호 (제약조건: FK, NN)
	private String qna_title; // 제목 (제약조건: NN)
	private String qna_content; // 내용 (제약조건: NN)
	private Timestamp qna_regdate; // 작성일 (제약조건: NN), (Default: CURRENT_TIMESTAMP)
	private Timestamp qna_updatedate; // 수정일 (제약조건:없음), (Default: CURRENT_TIMESTAMP)
	private int qna_state; // 문의 답변 여부 (제약조건: NN), (Default: 0)
	private String qna_answer; // 문의 답변 내용 (제약조건:없음), (Default: NULL)

}
