package com.project2.service;

import java.util.List;

import com.project2.domain.TestVO;

public interface paymentService {
	
	public TestVO boardPaymentList(TestVO vo) throws Exception;
	
	public List<TestVO> paymentList(TestVO vo) throws Exception;
	
	public List<TestVO> hostList(TestVO vo) throws Exception;

}
