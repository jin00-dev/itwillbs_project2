package com.project2.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

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
	public List<PaymentVO> paymentList(PaymentVO vo) throws Exception {
		logger.debug("서비스 paymentList 호출"+vo);
		return sqlSession.selectList(NAMESPACE+".paymentList", vo);
	}
	
	// 결제한 회원의 상세 결제정보 출력
	@Override
	public PaymentVO boardPaymentList(PaymentVO vo) throws Exception {
		logger.debug("결제한 회원 호출");
		return sqlSession.selectOne(NAMESPACE+".paymentInfo", vo);
	}

	@Override
	public List<PaymentVO> hostList(PaymentVO vo) throws Exception {
		return sqlSession.selectList(NAMESPACE+".hostList", vo);
	}

	@Override
	public int payment(PaymentVO vo) throws Exception {
		return sqlSession.insert(NAMESPACE+".getPayment", vo);
	}

	
	
	
	

}
