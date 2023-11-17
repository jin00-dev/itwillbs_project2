package com.project2.service;

import java.util.List;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.domain.QnaVO;

public interface QnaService {
 
	// QNA 글쓰기
	public void insert(QnaVO vo) throws Exception;

	// QNA 전체 목록 조회
	public List<QnaVO> listAll(Criteria cri) throws Exception;

	// 특정 QNA 정보 조회
	public QnaVO getQna(Integer qna_num) throws Exception;

	// 특정 QNA 정보 수정
	public void modifyQna(QnaVO vo) throws Exception;

	// 특정 QNA 정보 삭제
	public int removeQna(Integer qna_num) throws Exception;

	// QNA 답변 글쓰기
	public void insertAnswer(QnaVO vo) throws Exception;

	// 특정 QNA 정보 삭제
	public int removeAnswer(Integer qna_num) throws Exception;

	// QNA 전체 목록 조회
	public List<QnaVO> adminListAll() throws Exception;

	// 페이징처리 후 리스트 목록조회
	public List<QnaVO> getQnaPage(Criteria cri) throws Exception;

	// 게시판 글 총 개수 조회
	public int getQnaCount() throws Exception;

}
