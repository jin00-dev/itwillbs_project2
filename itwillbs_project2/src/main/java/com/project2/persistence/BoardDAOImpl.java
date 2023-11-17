package com.project2.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.domain.ExpVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
 
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOImpl.class);

	@Inject
	private SqlSession sqlSession;

	// 사용하는 mapper의 이름
	private static final String NAMESPACE = "com.project2.mapper.BoardMapper";

	@Override
	public void create(BoardVO vo) throws Exception {
		logger.debug(" service -> DAO 호출 ");

		int maxNoticeNum = getMaxNoticeNum();
		vo.setEnfNoticeNum(maxNoticeNum + 1); // 새로운 글번호 설정

		// DB에 글쓰기(insert) 수행
		int result = sqlSession.insert(NAMESPACE + ".createBoard", vo);

		if (result >= 1) {
			logger.debug(" DB 글쓰기 완료! ");
		}
	}

	@Override
	public List<BoardVO> getBoardListAll() throws Exception {
		logger.debug(" getBoardListAll() 호출 - 연결된 매퍼 호출 ");

		logger.debug(" 결과를 서비스로 리턴 ");
		return sqlSession.selectList(NAMESPACE + ".getListAll");
	}

	@Override
	public int getMaxNoticeNum() throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getMaxNoticeNum");
	}

	@Override
	public void increaseViewCount(Integer enf_notice_num) throws Exception {
		logger.debug(" updateViewCnt(Integer enf_notice_num) 호출 ");

		int result = sqlSession.update(NAMESPACE + ".increaseViewCount", enf_notice_num);

		if (result > 0) {
			logger.debug(enf_notice_num + "번 글조회수 1증가!!!");
		}

	}

	@Override
	public BoardVO getBoard(Integer enf_notice_num) throws Exception {
		logger.debug(" getBoard(Integer enf_notice_num) 호출 ");
		// sql 구문 호출
		return sqlSession.selectOne(NAMESPACE + ".getBoard", enf_notice_num);
	}

	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		logger.debug("updateBoard(BoardVO vo) 호출");

		sqlSession.update(NAMESPACE + ".updateBoard", vo);
	}

	@Override
	public int removeBoard(Integer enf_notice_num) throws Exception {
		logger.debug(" deleteBoard(Integer enf_notice_num) ");

		return sqlSession.delete(NAMESPACE + ".removeBoard", enf_notice_num);
	}

	@Override
	public List<BoardVO> getBoardPage(Integer page) throws Exception {
		if (page <= 0) {
			page = 1;
		}
		// 1 -> 1페이지 / 2 -> 2페이지
		// page가 1이라면 if문 안 들어가고 밑에 코드는 값이 0임.
		page = (page - 1) * 10;

		return sqlSession.selectList(NAMESPACE + ".boardPage", page);
	}

	@Override
	public List<BoardVO> getBoardPage(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".boardCri", cri);
	}

	@Override
	public int getBoardCount() throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".boardCount");
	}

	@Override
	public int getEventCount() throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".eventCount");
	}

	@Override
	public List<BoardVO> searchByTitle(String title) {

		return sqlSession.selectList(NAMESPACE + ".searchByTitle", title);
	}

///////////////////////////////////이벤트///////////////////////////////////////////// 

	@Override
	public void evinsert(BoardVO vo) throws Exception {
		logger.debug(" event insert -> DAO 호출 ");

		Integer maxEnfEventNum = sqlSession.selectOne(NAMESPACE + ".getMaxEnfEventNum");
		if (maxEnfEventNum == null) {
			maxEnfEventNum = 0;
		}
		vo.setEnf_event_num(maxEnfEventNum + 1);

		sqlSession.insert(NAMESPACE + ".createEvent", vo);
	}

	@Override
	public List<BoardVO> getEvListAll() throws Exception {
		logger.debug(" getEvListAll() 호출 - 연결된 매퍼 호출 ");

		logger.debug(" 결과를 서비스로 리턴 ");
		return sqlSession.selectList(NAMESPACE + ".getEvListAll");
	}

	@Override
	public Integer getMaxEnfEventNum() throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getMaxEnfEventNum");
	}

	@Override
	public BoardVO evGetBoard(Integer enf_event_num) throws Exception {
		logger.debug(" evGetBoard() 호출 - 연결된 매퍼 호출 ");

		logger.debug(" 결과를 서비스로 리턴 ");
		return sqlSession.selectOne(NAMESPACE + ".evGetBoard", enf_event_num);
	}

	@Override
	public void eventUpdateBoard(BoardVO vo) throws Exception {

		sqlSession.update(NAMESPACE + ".eventUpdateBoard", vo);
	}

	@Override
	public int eventRemoveBoard(Integer enf_event_num) throws Exception {

		return sqlSession.delete(NAMESPACE + ".eventRemoveBoard", enf_event_num);
	}

	@Override
	public List<BoardVO> getEventPage(Integer page) throws Exception {

		if (page <= 0) {
			page = 1;
		}
		// 1 -> 1페이지 / 2 -> 2페이지
		// page가 1이라면 if문 안 들어가고 밑에 코드는 값이 0임.
		page = (page - 1) * 10;

		return sqlSession.selectList(NAMESPACE + ".eventPage", page);
	}

	@Override
	public List<BoardVO> getEventPage(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".eventCri", cri);
	}

///////////////////////////////////FAQ///////////////////////////////////////////// 

	@Override
	public int getMaxEnfFaqNum() throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getMaxEnfFaqNum");
	}

	@Override
	public void faInsert(BoardVO vo) throws Exception {
		// DB에 글쓰기(insert) 수행
		int result = sqlSession.insert(NAMESPACE + ".createFaq", vo);

		if (result >= 1) {
			logger.debug(" DB 글쓰기 완료! ");
		}

	}

	@Override
	public List<BoardVO> getFaListAll() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getFaListAll");
	}

	@Override
	public BoardVO getFaqBoard(Integer enf_faq_num) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getFaqBoard", enf_faq_num);
	}

	@Override
	public void faqUpdateBoard(BoardVO vo) throws Exception {

		sqlSession.update(NAMESPACE + ".faqUpdateBoard", vo);
	}

	@Override
	public int faqRemoveBoard(Integer enf_faq_num) throws Exception {

		return sqlSession.delete(NAMESPACE + ".faqRemoveBoard", enf_faq_num);
	}

	@Override
	public List<BoardVO> getFaqPage(Integer page) throws Exception {
		if (page <= 0) {
			page = 1;
		}
		// 1 -> 1페이지 / 2 -> 2페이지
		// page가 1이라면 if문 안 들어가고 밑에 코드는 값이 0임.
		page = (page - 1) * 10;

		return sqlSession.selectList(NAMESPACE + ".faqPage", page);
	}

	@Override
	public List<BoardVO> getFaqPage(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".faqCri", cri);
	}

	@Override
	public int getFaqCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".faqCount");
	}

	
	// 클래스 등록 
	@Override
	public void classInsert(ExpVO vo) throws Exception {
		logger.debug("######################"+vo.getUser_num());
		sqlSession.insert(NAMESPACE + ".classCreate", vo);
		
	}

	
	
} 
