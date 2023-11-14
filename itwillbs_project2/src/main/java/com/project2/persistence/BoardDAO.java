package com.project2.persistence;

import java.util.List;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;

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

	// 페이징처리 후 리스트 목록 조회
	public List<BoardVO> getBoardPage(Integer enf_notice_num) throws Exception;

	// 페이징처리 후 리스트 목록 조회
	public List<BoardVO> getBoardPage(Criteria cri) throws Exception;

	// 게시판 글 총 개수 조회
	public int getBoardCount() throws Exception;

	// 게시판 검색
	public List<BoardVO> searchByTitle(String title);

	/////////////////////////////////// 이벤트
	/////////////////////////////////// /////////////////////////////////////////////////////////////

	// 최대 enf_event_num 조회
	public Integer getMaxEnfEventNum() throws Exception;

	// 글쓰기(Create) 동작
	public void evinsert(BoardVO vo) throws Exception;

	// 글목록 조회(Read) 동작
	public List<BoardVO> getEvListAll() throws Exception;

	// 특정 글 정보조회(Read) 동작
	public BoardVO evGetBoard(Integer enf_event_num) throws Exception;

	// 특정 글정보 수정(Update) 동작
	public void eventUpdateBoard(BoardVO vo) throws Exception;

	// 특정 글정보 삭제(Delete) 동작
	public int eventRemoveBoard(Integer enf_event_num) throws Exception;

	// 페이징처리 후 리스트 목록 조회
	public List<BoardVO> getEventPage(Integer enf_event_num) throws Exception;

	// 페이징처리 후 리스트 목록 조회
	public List<BoardVO> getEventPage(Criteria cri) throws Exception;

	// 게시판 글 총 개수 조회
	public int getEventCount() throws Exception;

	/////////////////////////////////// FAQ
	/////////////////////////////////// /////////////////////////////////////////

	// 최대 글번호 조회
	public int getMaxEnfFaqNum() throws Exception;

	// 글쓰기(Create) 동작
	public void faInsert(BoardVO vo) throws Exception;

	// 글목록 조회(Read) 동작
	public List<BoardVO> getFaListAll() throws Exception;

	// 특정 글 정보조회(Read) 동작
	public BoardVO getFaqBoard(Integer enf_faq_num) throws Exception;

	// 특정 글정보 수정(Update) 동작
	public void faqUpdateBoard(BoardVO vo) throws Exception;

	// 특정 글정보 삭제(Delete) 동작
	public int faqRemoveBoard(Integer enf_faq_num) throws Exception;

	// 페이징처리 후 리스트 목록 조회
	public List<BoardVO> getFaqPage(Integer enf_faq_num) throws Exception;

	// 페이징처리 후 리스트 목록 조회
	public List<BoardVO> getFaqPage(Criteria cri) throws Exception;

	// 게시판 글 총 개수 조회
	public int getFaqCount() throws Exception;
}