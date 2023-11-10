package com.project2.service;

import java.util.List;

import com.project2.domain.PaymentVO;

public interface paymentService {
	
	public PaymentVO boardPaymentList(PaymentVO vo) throws Exception;
	
	public List<PaymentVO> paymentList(PaymentVO vo) throws Exception;
	
	public List<PaymentVO> hostList(PaymentVO vo) throws Exception;
	
	public int payment(PaymentVO vo) throws Exception;
	
	public PaymentVO selectPayInfo(int order_num) throws Exception;
	
	public String getToken() throws Exception;
	
	public PaymentVO cancelPayAction(String accessToken, PaymentVO rvo) throws Exception; 
	
	public int updatePayCancel(PaymentVO vo) throws Exception;
}
