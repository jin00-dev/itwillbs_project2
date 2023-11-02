package com.project2.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.domain.MemberVO;
import com.project2.domain.TestVO;
import com.project2.service.paymentService;



@Controller
@RequestMapping("/class/*")
public class PaymentController {
	
	@Inject
	 paymentService pService;
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	// 결제한 회원의 상세 리스트 출력
	@RequestMapping(value = "/paymentList")
	public String payment(Model model, TestVO vo, HttpSession session) {
		String id = (String)session.getAttribute("user_id");
		model.addAttribute("testVO", vo);
		try {
			TestVO resultVO = pService.boardPaymentList(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
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