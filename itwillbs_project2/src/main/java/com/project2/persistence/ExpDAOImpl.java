package com.project2.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.ExpVO;
import com.project2.domain.OrderVO;
import com.project2.domain.ReportVO;
import com.project2.domain.RevVO;
import com.project2.domain.UserVO;

import lombok.val;

//@Repository : 스프링이 해당객체를 DAO로 인식하도록 함

@Repository(value = "expDAO")
public class ExpDAOImpl {

	private static final Logger logger = LoggerFactory.getLogger(ExpDAOImpl.class);

	@Autowired
	private SqlSession sqlSession;
	// => 디비연결정보 있음(연결,해제 자동)

	// memberMapper의 namespace정보 저장
	private static final String NAMESPACE = "com.project2.mapper.ExpMapper.";

	// 게시물리스트
	public List<ExpVO> getExpList(ExpVO vo) throws Exception {
		logger.debug(" DAOImpl : getExpList() 호출");

		if(vo.getExp_region().equals("전체")) {
			return sqlSession.selectList(NAMESPACE + "expListAllRegion", vo);
		}
		return sqlSession.selectList(NAMESPACE + "expList", vo);

	}

	//1개 개시물 리뷰목록 가저오기
	public List<RevVO> getExpRevList(Integer exp_num) throws Exception {
		logger.debug(" DAOImpl : getExpRevList() 호출");
		return sqlSession.selectList(NAMESPACE + "expRevList", exp_num);
	}

	//1개 개시물 리뷰평균
	public double getExpRevAvg(Integer exp_num) throws Exception {
		logger.debug(" DAOImpl : getExpRevAvg() 호출");
		return sqlSession.selectOne(NAMESPACE + "avgRevRating", exp_num);
	}

	//1개 개시물 정보가저오기
	public ExpVO getExpOne(Integer exp_num) throws Exception {
		logger.debug(" DAOImpl : getExpOne() 호출");
		return sqlSession.selectOne(NAMESPACE + "expOne", exp_num);
	}
	
	//리뷰 작성
	public int insertReview(RevVO vo) throws Exception{
		logger.debug(" DAOImpl :  insertReview() 호출");
		return sqlSession.insert(NAMESPACE + "insertReview", vo);
	}

	//리뷰 작성
	public int updateReview(RevVO vo) throws Exception{
		logger.debug(" DAOImpl :  updateReview() 호출");
		return sqlSession.insert(NAMESPACE + "updateReview", vo);
	}

	//리뷰 삭제
	public int deleteReview(RevVO vo) throws Exception{
		logger.debug(" DAOImpl :  deleteReview() 호출");
		return sqlSession.insert(NAMESPACE + "deleteReview", vo);
	}
	
	//신고 작성
	public int insertReport(ReportVO vo) throws Exception{
		logger.debug(" DAOImpl :  insertReport() 호출");
		return sqlSession.insert(NAMESPACE + "insertReport", vo);
	}
	
	//리뷰 작성자 번호 조회
	public int getRevUserNum(int rev_num) throws Exception{
		logger.debug(" DAOImpl :  getRevUserNum() 호출");
		return sqlSession.selectOne(NAMESPACE + "getRevUserNum", rev_num);
	}
	
	//유저 한명 정보
	public UserVO getUserOne(int user_num) throws Exception {
		logger.debug(" DAOImpl :  getUserOne() 호출");
		return sqlSession.selectOne(NAMESPACE + "getUserOne", user_num);
	}
	
	//체험 번호 하나
	public int getExpNumOne(String exp_name) throws Exception {
		logger.debug(" DAOImpl :  getExpNumOne() 호출");
		return sqlSession.selectOne(NAMESPACE + "getExpNumOne", exp_name);
	}
	
	//결제 처리
	public int paymentInsert(OrderVO vo) throws Exception{
		logger.debug(" DAOImpl :  paymentInsert() 호출");
		return sqlSession.insert(NAMESPACE + "insertOrderBoard", vo);
	}

}// DAOImpl
