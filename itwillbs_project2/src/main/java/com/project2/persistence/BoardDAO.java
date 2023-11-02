package com.project2.persistence;

import java.util.List;

import com.project2.domain.BoardVO;

public interface BoardDAO {

	// 최대 글번호 조회
	public int getMaxNoticeNum() throws Exception;

	// 글쓰기(Create) 동작
	public void create(BoardVO vo) throws Exception;

	// 글목록 조회(Read) 동작
	public List<BoardVO> getBoardListAll() throws Exception;

	// 글 조회수 1증가(Update) 동작
	public void increaseViewCount(Integer enf_notice_num) throws Exception;

	// 특정 글 정보조회(Read) 동작
	public BoardVO getBoard(Integer enf_notice_num) throws Exception;

	// 특정 글정보 수정(Update) 동작
	public void updateBoard(BoardVO vo) throws Exception;

	// 특정 글정보 삭제(Delete) 동작
	public int removeBoard(Integer enf_notice_num) throws Exception;

}