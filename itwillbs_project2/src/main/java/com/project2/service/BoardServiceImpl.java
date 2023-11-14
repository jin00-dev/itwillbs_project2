package com.project2.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	private static final Logger logger = LoggerFactory.getLogger(BoardServiceImpl.class);

	@Inject
	private BoardDAO bdao;

	@Override
	public void insert(BoardVO vo) throws Exception {
		bdao.create(vo);

	}

	@Override
	public List<BoardVO> listAll() throws Exception {

		return bdao.getBoardListAll();
	}

	@Override
	public void increaseViewCount(Integer enf_notice_num) throws Exception {

		bdao.increaseViewCount(enf_notice_num);
	}

	@Override
	public BoardVO getBoard(Integer enf_notice_num) throws Exception {

		return bdao.getBoard(enf_notice_num);
	}

	@Override
	public void updateBoard(BoardVO vo) throws Exception {

		bdao.updateBoard(vo);
	}

	@Override
	public int removeBoard(Integer enf_notice_num) throws Exception {

		return bdao.removeBoard(enf_notice_num);
	}

	@Override
	public List<BoardVO> getBoardPage(Criteria cri) throws Exception {

		return bdao.getBoardPage(cri);
	}

	@Override
	public int getBoardCount() throws Exception {

		return bdao.getBoardCount();
	}

	@Override
	public List<BoardVO> searchByTitle(String title) {

		return bdao.searchByTitle(title);
	}

	/////////////////////////////////// 이벤트/////////////////////////////////////////////

	@Override
	public Integer getMaxEnfEventNum() throws Exception {
		return bdao.getMaxEnfEventNum();
	}

	@Override
	public void evinsert(BoardVO vo) throws Exception {
		bdao.evinsert(vo);

	}

	@Override
	public List<BoardVO> evListAll() throws Exception {

		return bdao.getEvListAll();
	}

	@Override
	public BoardVO evGetBoard(Integer enf_event_num) throws Exception {

		return bdao.evGetBoard(enf_event_num);
	}

	@Override
	public void eventUpdateBoard(BoardVO vo) throws Exception {
		bdao.eventUpdateBoard(vo);
	}

	@Override
	public int eventRemoveBoard(Integer enf_event_num) throws Exception {

		return bdao.eventRemoveBoard(enf_event_num);
	}

	@Override
	public List<BoardVO> getEventPage(Criteria cri) throws Exception {

		return bdao.getEventPage(cri);
	}

	@Override
	public int getEventCount() throws Exception {
		return bdao.getEventCount();
	}

	/////////////////////////////////// FAQ
	/////////////////////////////////// /////////////////////////////////////////////

	@Override
	public Integer getMaxEnfFaqNum() throws Exception {
		return bdao.getMaxEnfFaqNum();
	}

	@Override
	public void fainsert(BoardVO vo) throws Exception {
		bdao.faInsert(vo);

	}

	@Override
	public List<BoardVO> faListAll() throws Exception {

		return bdao.getFaListAll();
	}

	@Override
	public List<BoardVO> getFaqPage(Criteria cri) throws Exception {

		return bdao.getFaqPage(cri);
	}

	@Override
	public BoardVO getFaqBoard(Integer enf_faq_num) throws Exception {

		return bdao.getFaqBoard(enf_faq_num);
	}

	@Override
	public void faqUpdateBoard(BoardVO vo) throws Exception {

		bdao.faqUpdateBoard(vo);
	}

	@Override
	public int faqRemoveBoard(Integer enf_faq_num) throws Exception {

		return bdao.faqRemoveBoard(enf_faq_num);
	}
	
	@Override
	public int getFaqCount() throws Exception {

		return bdao.getFaqCount();
	}

}