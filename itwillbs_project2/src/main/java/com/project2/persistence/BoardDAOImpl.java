package com.project2.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.BoardVO;

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

	
	
	
}
