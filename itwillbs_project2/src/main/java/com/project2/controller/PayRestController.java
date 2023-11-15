package com.project2.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.project2.domain.PaymentVO;
import com.project2.service.RsrvPayServiceImpl;

@RequestMapping("/payrest")
@RestController
public class PayRestController {
	private static final Logger logger = LoggerFactory.getLogger(PayRestController.class);

	@Autowired
	private RsrvPayServiceImpl payService;
//	@Autowired
//	private SubscriptionService subsService;

//	// 주문번호 가져오기 TH(0504수정)
//	@RequestMapping(value = "/getP_no", method = RequestMethod.POST)
//	public String p_noPost() throws Exception {
//		logger.debug(" p_noPost() 호출 ");
//		String pno = payService.makeP_no();
//		logger.debug("pno : " + pno);
//		return pno;
//	}
//	// 주문번호 가져오기 TH(0504수정)
//
//	// 결제 처리하기 TH
//	@RequestMapping(value = "/orderSuccess", method = RequestMethod.POST)
//	public Integer orderSuccess(@RequestBody PayDTO pdto) throws Exception {
//		int cnt = 0;
//		logger.debug("orderSuccess() 호출 ");
//		logger.debug("pdto : " + pdto);
//		if (pdto.getC_no() == null) {
//			cnt = subsService.insertSubs(pdto.getM_id());
//			logger.debug("구독 insert 완료" + cnt);
//		} else {
//			cnt = payService.modifyOrder(pdto.getP_no());
//			logger.debug("주문 update 완료" + cnt);
//		}
//		return cnt;
//
//	}
//	// 결제 처리하기 TH
//
//	@RequestMapping(value = "/insertPaymentInfo", method = RequestMethod.POST)
//	public String insertPaymentInfo(@RequestBody PayDTO pdto) {
//		logger.debug("insertPaymentInfo 호출 ");
//		// STEP5-3. 결제 정보 검증 후 저장하기
//		// 처음에 요청했던 금액 저장하기
//		try {
//			payService.insertPaymentInfo(pdto);
//			return "ok";
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.debug("e" + e);
//			return "ng";
//		}
//	}
//
//	@RequestMapping(value = "/complete", method = RequestMethod.POST)
//	public ResponseEntity<String> completePOST(@RequestBody PayDTO pdto) throws Exception {
//		logger.debug("completePOST() 호출");
//		logger.debug("pdto : " + pdto);
//		int result = 0;
//		ResponseEntity<String> respEntity = null;
//
//		logger.debug("pdto:" + pdto);
//		// STEP5. 결제 정보 검증 및 저장하기
//		try {
//			// STEP5-2. 결제 정보 조회하기
//			// 액세스 토큰(access token) 발급 받기
//			String accessToken = payService.getAccessToken();
//			logger.debug("token" + accessToken);
//			// imp_uid로 아임포트 서버에서 결제 정보 조회
//			RsrvPayVO paymentInfo = payService.getPaymentInfo(accessToken, pdto);
//
//			logger.debug("결제정보조회" + paymentInfo);
//			// STEP5-3. 결제 정보 검증 후 저장하기
//			// 결제되어야 하는 금액 조회
//			int selectPrice = payService.selectPrice(pdto.getP_no());
//			logger.debug("selectPrice" + selectPrice);
//			int amount = paymentInfo.getP_price();
//			logger.debug("db에 입력된 금액" + selectPrice + ",결제된 금액" + amount);
//
//			// 결제 검증하기
//			if (selectPrice == amount) {
//				payService.updatePaymentInfo(paymentInfo); // DB에 결제 정보 저장
//				logger.debug("update" + pdto);
//				if (paymentInfo.getP_status().equals("paid")) { // 결제 완료
//					respEntity = new ResponseEntity<String>("success", HttpStatus.OK);
//
//				} else {
//					respEntity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); // error 400
//				}
//			} else { // 결제금액 불일치. 위/변조 된 결제
//				respEntity = new ResponseEntity<String>("ddd", HttpStatus.BAD_REQUEST);
//			}
//
//		} catch (Exception e) {
//			respEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
//		}
//
//		return respEntity;
//	}
//
//	@RequestMapping(value = "/checkPayment", method = RequestMethod.POST)
//	public String checkPaymentPOST(@RequestBody String p_no) throws Exception {
//		logger.debug("checkPaymentPOST() 호출");
//		logger.debug("p_no: " + p_no);
//		RsrvPayVO resultVO = payService.selectPayInfo(p_no);
//		logger.debug(resultVO + "");
//		return p_no;
//	}

	@RequestMapping(value = "/cancelPay", method = RequestMethod.POST)
	public String refundPOST(@RequestBody int order_num) throws Exception {
		logger.debug("refundPOST() 호출");
		logger.debug("order_num : "+order_num);

		// 엑세스 토큰
		String accessToken = payService.getAccessToken();
		logger.debug("accessToken : "+accessToken);
		// 결제정보 조회
		PaymentVO resultVO = payService.selectPayInfo(order_num);
		logger.debug("status :" + resultVO.getStatus());
		if (resultVO.getStatus().equals("cancelled")) {
			return "already refund";
		}
		PaymentVO cancelInfo = payService.getCancelInfo(accessToken, resultVO);
		// 환불결과 동기화
		payService.updatePaymentInfo(cancelInfo);
//		payService.modifyOrder(order_num);

		return "ok";
	}

}
