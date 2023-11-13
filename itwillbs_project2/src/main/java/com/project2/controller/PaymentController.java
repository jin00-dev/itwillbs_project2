package com.project2.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project2.domain.PaymentVO;
import com.project2.service.paymentService;



@Controller
@RequestMapping("/class/*")
public class PaymentController {
	
	@Inject
	 paymentService pService;
	
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	
	// 마이페이지 - 예매내역 ( 한명의 회원이 주문한 모든 클래스 리스트)
	@RequestMapping(value = "/paymentList")
	public String hostaymentList(PaymentVO vo, Model model) {
		try {
			model.addAttribute("list", pService.paymentList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pm/paymentList";
	}
	
	// 주문한 내역 하나를 눌렀을때 상세 내역 출력
	@RequestMapping(value = "/paymentInfo")
	public String paymentInfo(Model model, PaymentVO vo, HttpSession session) {
		PaymentVO result;
		try {
			result = (PaymentVO)session.getAttribute("user_num");
//			if(result == null) {
//				return "redirect:로그인페이지로이동";
//			}
			PaymentVO resultVO = pService.boardPaymentList(vo);
			model.addAttribute("testVO", resultVO);
			logger.debug("vo : "+resultVO);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.debug("paymentList view 호출");
		return "/pm/paymentInfo";
	}
	
	// 한 사업자 클래스를 예매한 모든 회원의 리스트 출력
	@RequestMapping(value = "/hostPage")
	public String hostPaymentList(PaymentVO vo, Model model) {
		try {
			model.addAttribute("list",pService.hostList(vo));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pm/hostList";
	}
	
	@RequestMapping(value = "/payment")
	public String paymentGET() {
		return "/pm/actionPayment";
	}
	
	// 결제하기 버튼 링크로 가기
	@ResponseBody
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public boolean paymentPOST(PaymentVO vo) {
		logger.debug("actionPayment() 메서드 호출");
        int result;
        if(vo.isSuccess() == true) {
            try {
                result = pService.payment(vo);
                if(result == 1)
                    return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
	}
	
	// 결제 취소
	@RequestMapping(value = "/cancelPay", method = RequestMethod.POST)
	@ResponseBody
	public String cancelPayment(@RequestBody int order_num) {
		logger.debug("결제취소 실행 ");
		logger.debug("order_num : "+order_num);
		try {
			//  결제정보 가져오기
			PaymentVO re = pService.selectPayInfo(order_num);
			String token = pService.getToken();
			if(re.getStatus().equals("cancelled")) {
				return "already refund";
			}
			PaymentVO result = pService.cancelPayAction(token, re);
			pService.updatePayCancel(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "ok";
	}
	
	
	

	
	
	
	
	
	
	
	
	
	
	

}