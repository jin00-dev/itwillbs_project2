package com.project2.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.project2.domain.PaymentVO;
import com.project2.domain.TestVO;
import com.project2.persistence.PaymentDAO;

@Service
public class paymentServiceImpl implements paymentService {
	
	@Inject
	private PaymentDAO pdao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(paymentServiceImpl.class);

	
	// 결제한 회원의 상세 리스트 출력
	@Override
	public TestVO boardPaymentList(TestVO vo) throws Exception {
		return pdao.boardPaymentList(vo);
	}


	@Override
	public List<TestVO> paymentList(TestVO vo) throws Exception {
		return pdao.paymentList(vo);
	}


	@Override
	public List<TestVO> hostList(TestVO vo) throws Exception {
		return pdao.hostList(vo);
	}


	@Override
	public int payment(PaymentVO vo) throws Exception {
		return pdao.payment(vo);
	}

	
		

}
