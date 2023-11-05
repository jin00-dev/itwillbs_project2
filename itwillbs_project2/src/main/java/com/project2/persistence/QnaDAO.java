package com.project2.persistence;

import java.util.List;

import com.project2.domain.QnaVO;

public interface QnaDAO {

	// 글쓰기(Create) 동작
	public void create(QnaVO vo) throws Exception;

	// 글목록 조회(Read) 동작
	public List<QnaVO> getQnaListAll() throws Exception;

	// 특정 글 정보조회(Read) 동작
	public QnaVO getQna(Integer qna_num) throws Exception;

	// 특정 글정보 수정(Update) 동작
	public void modifyQna(QnaVO vo) throws Exception;

	// 특정 글정보 삭제(Delete) 동작
	public int deleteQna(Integer qna_num) throws Exception;

	// 답변 글쓰기(Create) 동작
	public void createAnswer(QnaVO vo) throws Exception;

	// 특정 글정보 삭제(Delete) 동작
	public int deleteAnswer(Integer qna_num) throws Exception;
	
	// 관리자 모든 문의글 조회 동작
	public List<QnaVO> getAdminListAll() throws Exception;
}
