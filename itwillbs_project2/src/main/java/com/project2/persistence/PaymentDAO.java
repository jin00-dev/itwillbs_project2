package com.project2.persistence;

import java.util.List;

import com.project2.domain.PaymentVO;

public interface PaymentDAO {
	
	public PaymentVO boardPaymentList(PaymentVO vo) throws Exception;
	
	public List<PaymentVO> paymentList(PaymentVO vo) throws Exception;
	
	public List<PaymentVO> hostList(PaymentVO vo) throws Exception;
	
	public int payment(PaymentVO vo) throws Exception;
	
	public PaymentVO selectPayInfo(Integer order_num) throws Exception;
	
	public int updatePayCancel(PaymentVO vo) throws Exception;
	
	public List<PaymentVO> adminOrderBoard(PaymentVO vo) throws Exception;

}
