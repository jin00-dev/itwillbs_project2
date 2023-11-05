package com.project2.persistence;

import java.util.List;

import com.project2.domain.TestVO;

public interface PaymentDAO {
	
	TestVO boardPaymentList(TestVO vo) throws Exception;
	
	List<TestVO> paymentList(TestVO vo) throws Exception;
	
	List<TestVO> hostList(TestVO vo) throws Exception;
	

	}


