package com.project2.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project2.domain.Criteria;
import com.project2.domain.PaymentVO;
import com.project2.persistence.PaymentDAO;

@Service
public class paymentServiceImpl implements paymentService {
	
	@Inject
	private PaymentDAO pdao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(paymentServiceImpl.class);

	
	// 결제한 회원의 상세 리스트 출력
	@Override
	public PaymentVO boardPaymentList(Criteria vo) throws Exception {
		return pdao.boardPaymentList(vo);
	}


	@Override
	public List<PaymentVO> paymentList(Criteria vo) throws Exception {
		return pdao.paymentList(vo);
	}


	@Override
	public List<PaymentVO> hostList(Criteria vo) throws Exception {
		return pdao.hostList(vo);
	}
	
	@Override
	public List<PaymentVO> adminOrderBoard(Criteria cri) throws Exception {
		return pdao.adminOrderBoard(cri);
	}


	@Override
	public PaymentVO selectPayInfo(Integer order_num) throws Exception {
		return pdao.selectPayInfo(order_num);
	}

	@Override
	public String getToken() throws Exception {
		String access_Token = "";
		String reqURL = "https://api.iamport.kr/users/getToken";
		String data = "{ \"imp_key\" : \"5061837186283432\", \"imp_secret\" : \"r9ZUZa1MP7DCYbxPE9X53bGbT3cFze8LvK1cHBTdlQecOpwViqQpCKkE55MBNWKIYvTX8LzQLlR344BC\"}";
		try {
			URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // POST 요청
	        conn.setDoOutput(true);
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	   
	        // data 넣기
	        try (OutputStream os = conn.getOutputStream()){
				byte request_data[] = data.getBytes("utf-8");
				os.write(request_data);
				os.close();
			} catch(Exception e) {
				e.printStackTrace();
			}	
	        
	        int responseCode = conn.getResponseCode();
	        if(responseCode == 200) { // 결과 코드가 200이면 성공
	        	// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	            
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }

	            // Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            
	            access_Token = element.getAsJsonObject().get("response").getAsJsonObject().get("access_token").getAsString();
	            br.close();	
	        }
		}catch(Exception e) {
	        e.printStackTrace();
		}
		logger.info("토큰"+access_Token);
		return access_Token;
	}

	@Override
	public PaymentVO cancelPayAction(String accessToken, PaymentVO rvo) throws Exception {
		PaymentVO cancelInfo = new PaymentVO();
		cancelInfo.setOrder_num(rvo.getOrder_num());
		
		String reqURL = "https://api.iamport.kr/payments/cancel";
		String data = "{ \"reason\" : \"사용자 요청\", "
				+ "\"imp_uid\" : \"" + rvo.getImp_uid() + "\"} ";
		try {
			URL url = new URL(reqURL);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        
	        // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	        conn.setDoOutput(true);
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-Type", "application/json");
	        conn.setRequestProperty("Authorization", accessToken);
	        
	        //data 넣기
	        try (OutputStream os = conn.getOutputStream()){
				byte request_data[] = data.getBytes("utf-8");
				os.write(request_data);
				os.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}	
	        
	        // 결과 코드가 200이라면 성공
	        int responseCode = conn.getResponseCode();
	        if(responseCode == 200) {
	        	// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            String line = "";
	            String result = "";
	            
	            while ((line = br.readLine()) != null) {
	                result += line;
	            }
	            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
	            JsonParser parser = new JsonParser();
	            JsonElement element = parser.parse(result);
	            
	            if(!element.getAsJsonObject().get("code").getAsString().equals("0")) { 
	            	return null;
	            }else {
	            	JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();
	            	
	            	if(!response.getAsJsonObject().get("amount").isJsonNull()) { cancelInfo.setPaid_amount(response.getAsJsonObject().get("amount").getAsInt()); }
	                if(!response.getAsJsonObject().get("status").isJsonNull()) { cancelInfo.setStatus(response.getAsJsonObject().get("status").getAsString()); }
	            	
	            }
	            br.close();	
	        }
		}catch(Exception e) {
	        e.printStackTrace();
		}
		
		return cancelInfo;
	}


	@Override
	public int updatePayCancel(PaymentVO vo) throws Exception {
		return pdao.updatePayCancel(vo);
	}


	@Override
	public int paymentListCount(String user_id) throws Exception {
		return pdao.paymentListCount(user_id);
	}


	@Override
	public int adminOrderListCount() throws Exception {
		return pdao.adminOrderListCount();
	}


	@Override
	public int hostOrderListCount(Criteria cri) throws Exception {
		return pdao.hostOrderListCount(cri);
	}
	
	


}
