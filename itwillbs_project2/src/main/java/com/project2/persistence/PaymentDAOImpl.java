package com.project2.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project2.domain.TestVO;

@Repository
public class PaymentDAOImpl implements PaymentDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	
	private static final String NAMESPACE
	= "com.project2.mapper.PaymentMapper";

	
	// 결제한 회원의 상세 리스트 출력
	@Override
	public TestVO boardPaymentList(TestVO vo) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".paymenttiket", vo);
	}
	
	
	
	

}
