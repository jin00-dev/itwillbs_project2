package com.project2.service;

import java.util.List;

import com.project2.domain.BoardVO;

public interface BoardService {

	// 게시판 글쓰기
	public void insert(BoardVO vo) throws Exception;

	// 게시판 전체 목록 조회
	public List<BoardVO> listAll() throws Exception;

	// 게시판 글 조회수 1증가
	public void increaseViewCount(Integer enf_notice_num) throws Exception;

	// 특정 게시판 글 정보 조회
	public BoardVO getBoard(Integer enf_notice_num) throws Exception;

	// 특정 글 정보 수정
	public void updateBoard(BoardVO vo) throws Exception;
	
	// 특정 글 정보 삭제
	public int removeBoard(Integer enf_notice_num) throws Exception;

}
