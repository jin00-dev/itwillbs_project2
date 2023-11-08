//package com.project2.controller;
//
//import java.sql.Timestamp;
//import java.text.SimpleDateFormat;
//
//import javax.servlet.http.HttpSession;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RestController;
//
//import com.project2.domain.OrderVO;
//import com.project2.domain.PaymentVO;
//import com.project2.service.RsrvPayServiceImpl;
//import com.wolclass.domain.RsrvPayVO;
//
//@RequestMapping("/payrest")
//@RestController
//public class PayRestController {
//	private static final Logger logger = LoggerFactory.getLogger(PayRestController.class);
//
//	@Autowired
//	private RsrvPayServiceImpl payService;
////	@Autowired
////	private SubscriptionService subsService;
////	
////	// 주문번호 가져오기 TH(0504수정)
////	@RequestMapping(value = "/getP_no", method = RequestMethod.POST)
////	public String p_noPost() throws Exception{
////		logger.info(" p_noPost() modify호출 ");
////		String pno = payService.makeP_no();
////		logger.info("pno : "+pno);
////		return pno;
////	}
////	// 주문번호 가져오기 TH(0504수정)
////	
////	//결제 처리하기 TH
////	@RequestMapping(value = "/orderSuccess", method = RequestMethod.POST)
////	public Integer orderSuccess(@RequestBody PayDTO pdto) throws Exception{
////		int cnt = 0;
////		logger.info("orderSuccess() 호출 ");
////		logger.info("pdto : "+pdto);
////		if(pdto.getC_no()==null) {
////			cnt = subsService.insertSubs(pdto.getM_id());
////			logger.info("구독 insert 완료"+cnt);
////		} else {
////			cnt = payService.modifyOrder(pdto.getP_no());
////			logger.info("주문 update 완료"+cnt);
////		}
////		return cnt;
////		
////	}
////	//결제 처리하기 TH
//	
////	@RequestMapping(value = "/insertPaymentInfo", method = RequestMethod.POST)
////	public String insertPaymentInfo(@RequestBody PayDTO pdto) {
////		logger.info("insertPaymentInfo 호출 ");
////		// STEP5-3. 결제 정보 검증 후 저장하기
////		// 처음에 요청했던 금액 저장하기
////		try {
////			payService.insertPaymentInfo(pdto);
////			return "ok";	
////		}catch(Exception e){
////			e.printStackTrace();
////			logger.info("e"+e);
////			return "ng";
////		}
////	}
////
////	@RequestMapping(value = "/complete", method = RequestMethod.POST)
////	public ResponseEntity<String> completePOST(@RequestBody PayDTO pdto) throws Exception{
////		logger.info("completePOST() 호출");
////		logger.info("pdto : "+pdto);
////		int result = 0;
////		ResponseEntity<String> respEntity = null;
////		
////		logger.info("pdto:"+pdto);
////		// STEP5. 결제 정보 검증 및 저장하기
////		try {
////			// STEP5-2. 결제 정보 조회하기
////			// 액세스 토큰(access token) 발급 받기
////			String accessToken = payService.getAccessToken();
////			logger.info("token"+accessToken);
////			// imp_uid로 아임포트 서버에서 결제 정보 조회
////			RsrvPayVO paymentInfo = payService.getPaymentInfo(accessToken, pdto);
////			
////			logger.info("결제정보조회"+paymentInfo);
////			// STEP5-3. 결제 정보 검증 후 저장하기
////			// 결제되어야 하는 금액 조회
////			int selectPrice = payService.selectPrice(pdto.getP_no());
////			logger.info("selectPrice"+selectPrice);
////			int amount = paymentInfo.getP_price(); 
////			logger.info("db에 입력된 금액"+selectPrice+",결제된 금액"+amount);
////
////			// 결제 검증하기
////			if(selectPrice == amount) {
////				payService.updatePaymentInfo(paymentInfo); // DB에 결제 정보 저장
////				logger.info("update"+pdto);
////				if(paymentInfo.getP_status().equals("paid")) { // 결제 완료
////					respEntity = new ResponseEntity<String>("success", HttpStatus.OK);
////
////				}else {
////					respEntity = new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); // error 400
////				}
////			}else { // 결제금액 불일치. 위/변조 된 결제
////				respEntity = new ResponseEntity<String>("ddd", HttpStatus.BAD_REQUEST);
////			}
////			
////		}catch(Exception e) {
////			respEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
////		}
////
////		return respEntity;		
////	}
//
////	@RequestMapping(value = "/checkPayment", method = RequestMethod.POST)
////	public String checkPaymentPOST(@RequestBody String p_no) throws Exception {
////		logger.info("checkPaymentPOST() 호출");
////		logger.info("p_no: "+p_no);
////		RsrvPayVO resultVO = payService.selectPayInfo(p_no);
////		logger.info(resultVO + "");
////		return p_no; 
////	}
//	
//	//결제 처리
//		@PostMapping("/insertPayment")
//		public String payment(PaymentVO vo, HttpSession session) {
//			logger.info("insertPaymentInfo 호출 ");
//			// STEP5-3. 결제 정보 검증 후 저장하기
//			// 처음에 요청했던 금액 저장하기
//			try {
//				payService.insertPaymentInfo(vo);
//				return "ok";	
//			}catch(Exception e){
//				e.printStackTrace();
//				logger.info("e"+e);
//				return "ng";
//			
//			}
//		}
//		
//	//결제 취소
//	@RequestMapping(value = "/refund", method = RequestMethod.POST)
//	public String refundPOST(@RequestBody String p_no) throws Exception {
//		logger.info("refundPOST() 호출");
//		logger.info("p_no: "+p_no);
//
//		//엑세스 토큰
//		String accessToken = payService.getAccessToken();
//		//결제정보 조회
//		RsrvPayVO resultVO = payService.selectPayInfo(p_no);
//		logger.info("p_status"+resultVO.getP_status());
//		if(resultVO.getP_status().equals("cancelled")) {
//			return "already refund";
//		}
//		RsrvPayVO cancelInfo = payService.getCancelInfo(accessToken, resultVO);
//		//환불결과 동기화
//		payService.updatePaymentInfo( );
//		payService.modifyOrder(p_no);
//		
//		return "ok";
//	}
//
//}
