package com.project2.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping("/class/*")
public class PaymentController {
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	@RequestMapping(value = "/paymentList")
	public String payment() {
		logger.debug("paymentList view 호출");
		return "/pm/paymentList";
	}
	
//	@RequestMapping(value = "/paymentList", method = RequestMethod.POST)
//	public String afterPaymentList() {
//		logger.debug("afterPaymentList() 메서드 호출");
//		return "";
//	}
	
	// 결제하기 페이지 이동
	@RequestMapping(value = "/payment")
	public String paymentGET() {
		logger.debug("actionPayment() 메서드 호출");
		return "/pm/actionPayment";

	}
	
	@RequestMapping(value = "/hostList")
	public String hostList() {
		return "/pm/hostList";
	}

}