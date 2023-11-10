package com.project2.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.domain.QnaVO;

@Repository
public class QnaDAOImpl implements QnaDAO {

	private static final Logger logger = LoggerFactory.getLogger(QnaDAOImpl.class);

	@Inject
	private SqlSession sqlSession;

	// 사용하는 mapper의 이름
	private static final String NAMESPACE = "com.project2.mapper.QnaMapper";

	@Override
	public void create(QnaVO vo) throws Exception {
		logger.debug(" service -> DAO 호출 ");

		// DB에 글쓰기(insert) 수행
		int result = sqlSession.insert(NAMESPACE + ".createQna", vo);

		if (result >= 1) {
			logger.debug(" DB 글쓰기 완료! ");
		}

	}

	@Override
	public List<QnaVO> getQnaListAll() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getListAll");
	}

	@Override
	public QnaVO getQna(Integer qna_num) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getQna", qna_num);
	}

	@Override
	public void modifyQna(QnaVO vo) throws Exception {

		sqlSession.update(NAMESPACE + ".modifyQna", vo);
	}

	@Override
	public int deleteQna(Integer qna_num) throws Exception {

		return sqlSession.delete(NAMESPACE + ".removeQna", qna_num);
	}

	@Override
	public void createAnswer(QnaVO vo) throws Exception {
		logger.debug(" service -> DAO 호출 ");

		sqlSession.update(NAMESPACE + ".updateAnswer", vo);

	}

	@Override
	public int deleteAnswer(Integer qna_num) throws Exception {

		return sqlSession.delete(NAMESPACE + ".removeAnswer", qna_num);
	}

	@Override
	public List<QnaVO> getAdminListAll() throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getAdminListAll");
	}

	@Override
	public List<QnaVO> getQnaPage(Integer page) throws Exception {
		if (page <= 0) {
			page = 1;
		}
		page = (page - 1) * 10;

		return sqlSession.selectList(NAMESPACE + ".QnaPage", page);
	}

	@Override
	public List<QnaVO> getQnaPage(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".QnaCri", cri);
	}

	@Override 
	public int getQnaCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".QnaCount");
	}
	
	

}
