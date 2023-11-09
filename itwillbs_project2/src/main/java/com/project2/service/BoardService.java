package com.project2.service;

import java.util.List;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;

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

	// 페이징처리 후 리스트 목록조회
	public List<BoardVO> getBoardPage(Criteria cri) throws Exception;

	// 게시판 글 총 개수 조회
	public int getBoardCount() throws Exception;
	
	// 게시판 검색
	public List<BoardVO> searchByTitle(String title);

	/////////////////////////////////// 이벤트/////////////////////////////////////////////

	// 최대 enf_event_num 조회
	public Integer getMaxEnfEventNum() throws Exception;

	// 이벤트 게시판 글쓰기
	public void evinsert(BoardVO vo) throws Exception;

	// 이벤트 게시판 전체 목록 조회
	public List<BoardVO> evListAll() throws Exception;

	// 이벤트 특정 게시판 글 정보 조회
	public BoardVO evGetBoard(Integer enf_event_num) throws Exception;

	// 특정 글 정보 수정
	public void eventUpdateBoard(BoardVO vo) throws Exception;

	// 특정 글 정보 삭제
	public int eventRemoveBoard(Integer enf_event_num) throws Exception;

	// 페이징처리 후 리스트 목록조회
	public List<BoardVO> getEventPage(Criteria cri) throws Exception;

	// 이벤트 글 총 개수 조회
	public int getEventCount() throws Exception;

}
