package com.project2.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.project2.domain.Criteria;
import com.project2.domain.PaymentVO;

@Repository
public class PaymentDAOImpl implements PaymentDAO {
	

	private static final Logger logger = LoggerFactory.getLogger(PaymentDAOImpl.class);
	@Inject
	private SqlSession sqlSession;
	
	
	private static final String NAMESPACE
	= "com.project2.mapper.PaymentMapper";

	// 결제한 회원의 모든 결제 리스트로 출력
	@Override
	public List<PaymentVO> paymentList(Criteria vo) throws Exception {
		logger.debug("서비스 paymentList 호출"+vo);
		return sqlSession.selectList(NAMESPACE+".paymentList", vo);
	}
	
	// 결제한 회원의 상세 결제정보 출력
	@Override
	public PaymentVO boardPaymentList(Criteria vo) throws Exception {
		logger.debug("결제한 회원 호출");
		return sqlSession.selectOne(NAMESPACE+".paymentInfo", vo);
	}

	// 사업자(회원)이 등록한 클래스의 모든 회원의 결제 리스트 출력
	@Override
	public List<PaymentVO> hostList(Criteria vo) throws Exception {
		return sqlSession.selectList(NAMESPACE+".hostList", vo);
	}
	
	// 관리자 페이지의 모든 회원의 결제 리스트 출력
	@Override
	public List<PaymentVO> adminOrderBoard(Criteria cri) throws Exception {
		return sqlSession.selectList(NAMESPACE+".adminList", cri);
	}
	

	@Override
	public PaymentVO selectPayInfo(Integer order_num) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".selectPayinfo", order_num);
	}

	@Override
	public int updatePayCancel(PaymentVO vo) throws Exception {
		return sqlSession.update(NAMESPACE+".updateCancelPay", vo);
	}

	@Override
	public int paymentListCount(String user_id) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".paymentListCount", user_id);
	}

	@Override
	public int adminOrderListCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE+".adminOrderListCount");
	}

	@Override
	public int hostOrderListCount(Criteria cri) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".hostOrderListCount", cri);
	}


	
	

}
