package com.project2.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.project2.domain.BoardVO;
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
		logger.debug(" 컨트롤러가 서비스를 호출 ");

		logger.debug(" DAO의 결과를 받아서 컨트롤러 전달");
		return bdao.getBoardListAll();
	}

	@Override
	public void increaseViewCount(Integer enf_notice_num) throws Exception {
		logger.debug(" 조회수 1증가!! ");
		bdao.increaseViewCount(enf_notice_num);
	}

	@Override
	public BoardVO getBoard(Integer enf_notice_num) throws Exception {
		logger.debug(" getBoard(Integer bno) 호출 ");

		return bdao.getBoard(enf_notice_num);
	}

	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		logger.debug(" updateBoard(BoardVO vo) 호출 @@@ ");

		bdao.updateBoard(vo);
	}

	@Override
	public int removeBoard(Integer enf_notice_num) throws Exception {
		logger.debug(" removeBoard(Integer enf_notice_num)  호출 ");

		return bdao.removeBoard(enf_notice_num);
	}

}