package com.project2.persistence;

import java.util.List;

import com.project2.domain.PaymentVO;

public interface PaymentDAO {
	
	PaymentVO boardPaymentList(PaymentVO vo) throws Exception;
	
	List<PaymentVO> paymentList(PaymentVO vo) throws Exception;
	
	List<PaymentVO> hostList(PaymentVO vo) throws Exception;
	
	int payment(PaymentVO vo) throws Exception;
	

	}


