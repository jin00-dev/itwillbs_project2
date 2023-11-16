package com.project2.controller;

import java.util.List;

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

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.domain.PageVO;
import com.project2.domain.PaymentVO;
import com.project2.domain.UserVO;
import com.project2.service.paymentService;

@Controller
@RequestMapping("/class/*")
public class PaymentController {

	@Inject
	paymentService pService;

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	// 마이페이지 - 예매내역 ( 한명의 회원이 주문한 모든 클래스 리스트)
	@RequestMapping(value = "/paymentList")
	public String hostaymentList(Criteria cri, Model model,HttpSession session) {

		try {
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			String id = (String) session.getAttribute("user_id");
			cri.setUser_id(id);
			pageVO.setTotalCount(pService.paymentListCount(cri.getUser_id()));

			// 리스트 사이즈 확인

			// 페이지 이동시 받아온 페이지 번호
			if (cri.getPage() > pageVO.getEndPage()) {
				// 잘못된 페이지 정보를 입력 받았을때
				cri.setPage(pageVO.getStartPage());
			}

			model.addAttribute("list", pService.paymentList(cri));
			// 페이징처리 정보를 뷰페이지로 전달
			model.addAttribute("pageVO", pageVO);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pm/paymentList";
	}

	// 주문한 내역 하나를 눌렀을때 상세 내역 출력
	@RequestMapping(value = "/paymentInfo")
	public String paymentInfo(Model model, Criteria cri, HttpSession session) {
		
		String user_id = (String)session.getAttribute("user_id");
		cri.setUser_id(user_id);
		try {
		PaymentVO resultVO = pService.boardPaymentList(cri);
			model.addAttribute("testVO", resultVO);
			logger.debug("vo : " + resultVO);

		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.debug("paymentList view 호출");
		return "/pm/paymentInfo";
	}

	// 한 사업자 클래스를 예매한 모든 회원의 리스트 출력
	@RequestMapping(value = "/hostPage")
	public String hostPaymentList(Criteria cri, Model model, HttpSession session) {
		try {
			
			PageVO pageVO = new PageVO();
			int num = Integer.parseInt(String.valueOf(session.getAttribute("user_num")));
			cri.setUser_num(num);
			pageVO.setCri(cri);
			pageVO.setTotalCount(pService.hostOrderListCount(cri));

			// 리스트 사이즈 확인

			// 페이지 이동시 받아온 페이지 번호
			if (cri.getPage() > pageVO.getEndPage()) {
				// 잘못된 페이지 정보를 입력 받았을때
				cri.setPage(pageVO.getStartPage());
			}

			// 페이징처리 정보를 뷰페이지로 전달
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("list", pService.hostList(cri));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pm/hostList";
	}

	// 관리자 페이지에서 클래스를 결제한 모든 회원의 리스트 출력
	@RequestMapping(value = "/admnOrderBoard")
	public String adminPaymentList(Criteria cri, Model model) {
		try {
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(pService.adminOrderListCount());

			// 리스트 사이즈 확인

			// 페이지 이동시 받아온 페이지 번호
			if (cri.getPage() > pageVO.getEndPage()) {
				// 잘못된 페이지 정보를 입력 받았을때
				cri.setPage(pageVO.getStartPage());
			}

			// 페이징처리 정보를 뷰페이지로 전달
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("list", pService.adminOrderBoard(cri));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/pm/adminList";
	}

	@RequestMapping(value = "/payment")
	public String paymentGET() {
		return "/pm/actionPayment";
	}

	// 결제 취소
	@RequestMapping(value = "/cancelPay", method = RequestMethod.POST)
	@ResponseBody
	public String userCancelPayment(@RequestBody int order_num) {
		logger.debug("결제취소 실행 ");
		logger.debug("order_num : " + order_num);
		try {
			// 결제정보 가져오기
			PaymentVO re = pService.selectPayInfo(order_num);
			String token = pService.getToken();
			if (re.getStatus().equals("cancelled")) {
				return "already refund";
			}
			PaymentVO result = pService.cancelPayAction(token, re);
			pService.updatePayCancel(result);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "ok";
	}
	
	
	// 회원결제리스트에서 환불 버튼 눌렀을때
	@RequestMapping(value = "/cancelPayCheck", method = RequestMethod.POST)
	@ResponseBody
	public String cancelPayCheck(@RequestBody UserVO vo) {
		logger.debug("vo"+vo);
		try {
		UserVO result =  pService.pwCheck(vo);
	
			if(result != null) {
				return "true";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "false";
	}

}