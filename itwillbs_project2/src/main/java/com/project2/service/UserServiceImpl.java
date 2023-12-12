package com.project2.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project2.domain.Criteria;
import com.project2.domain.UserVO;
import com.project2.domain.ReportVO;
import org.springframework.transaction.annotation.Transactional;

import com.project2.domain.UserVO;
import com.project2.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Autowired
	private UserDAO udao;

	@Autowired
	private UserDAO userDAO;

	@Override
	public void insertUser(UserVO vo) {
		logger.debug(" DAO에 있는 회원 가입 메서드 호출 ");
		udao.insertUser(vo);
	}

	// 아이디 중복체크
	@Override
	public int idCheck(String id) {
		return udao.idCheck(id);
	}

	@Override
	public UserVO userLogin(UserVO vo) {
		logger.debug(" 컨트롤러 호출로 DAO 메서드를 호출하겠다. ");
		UserVO resultVO = udao.loginUser(vo);

		logger.debug(" DAO의 처리 결과를 컨트롤러로 전달하겠다.");

		return resultVO;
	}

	@Override
	public UserVO userInfo(String id) {
		logger.debug("  userInfo(String id) 호출 ");

		// 디비동작 (DAO)중에서 회원정보 조회
		UserVO resultVO = udao.getUser(id);

		return resultVO;
		// return mdao.getMember(id);;
	}

	//회원정보 수정(내정보변경)
		@Override
		public Integer userUpdate(UserVO updateVO) {
			logger.debug(" userUpdate(updateVO) 호출 ");
			logger.debug(" @@@@@"+updateVO);
			udao.updateUser(updateVO);
			 if (updateVO != null) {
			        logger.debug("DAO의 처리 결과: {}", updateVO.toString());
			    } else {
			        logger.debug("DAO의 처리 결과는 null입니다.");
			    }
				logger.debug(" DAO의 처리 결과를 컨트롤러로 전달하겠다.");
				return udao.updateUser(updateVO);
			}
		
		// 비밀번호 조회
		@Override
		public String pwCheck(String user_id){
		return udao.pwCheck(user_id);
		}

	// 회원등급변경
	@Override
	public void updateUserGrade(UserVO updateVO) {
		logger.debug("Service: 회원 등급 변경 메서드 호출");
		logger.debug("@@@@@vo :" + updateVO);
		// 등급 변경을 원하지 않는 경우 현재 등급 값을 그대로 업데이트
		if (updateVO.getUser_type() == null) {
			UserVO currentUser = userDAO.getUser(updateVO.getUser_id());
			updateVO.setUser_type(currentUser.getUser_type());
		}

		// user_type 업데이트
		userDAO.updateUserGrade(updateVO);
	}

	@Override
	public int phoneCheck(String phone) {
		return 0;
	}
	
	//회원비번 변경
		@Override                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		public int pwUpdate(String user_id, String hashedPw){
			return udao.pwUpdate(user_id, hashedPw);
		}
	

	// 비밀번호 찾기
	@Override
	public UserVO findUserByNameAndId(String user_name, String user_id) {
		return udao.findUserByNameAndId(user_name, user_id);
	}

	// 새비번
	@Override
	@Transactional
	public void changePassword(String userId, String newPassword) {
		userDAO.updateUserPassword(userId, newPassword);
	}

	// 회원정보 탈퇴상태로 변경
	@Override
	public Integer updateState(UserVO updateVO) {
		logger.debug(" updateState 호출 ");
		logger.debug("@@@@@vo :"+updateVO);
		
		if(updateVO.getUser_delete_state() == 0) {
			UserVO currentUser = userDAO.getUser(updateVO.getUser_id());
			updateVO.setUser_delete_state(currentUser.getUser_delete_state());
		}
		
		return userDAO.updateState(updateVO);
	}


	// 회원목록 + 페이징 처리
	@Override
	public List<UserVO> userList(Criteria cri) throws Exception {
		logger.debug(" userList() 호출 ");

		List<UserVO> userList = udao.getUserList(cri);

		return userList;
	}

	// 총 회원 수 조회
	@Override
	public int getUserCount() throws Exception {
		logger.debug("getUserCount() 호출");
		return udao.getUserCount();
	}

	// 아이디찾기
	@Override
	public UserVO findUserByNameAndPhone(String user_name, String user_phone) {
		// 사용자 이름과 휴대폰 번호를 이용하여 아이디를 찾는 로직을 수행
		// userDAO의 메서드를 호출하여 데이터베이스에서 조회하도록 구현
		return userDAO.findUserByNameAndPhone(user_name, user_phone);
	}

	@Override

	public UserVO getUserById(String user_id) {
		logger.debug("Service: 특정 회원 정보 조회 메서드 호출");
		return userDAO.getUserByUserId(user_id);
	}

	// 관리자 신고 목록 조회
	@Override
	public List<ReportVO> adminReport(Criteria cri) throws Exception {
		logger.debug("Service : 신고목록 조회");
		List<ReportVO> adminReport = udao.adminReport(cri);

		return adminReport;
	}

	// 신고목록 총 갯수 조회
	@Override
	public int reportList() throws Exception {
		return udao.reportList();
	}

	// 회원정보수정(관리자)
	@Override
	public void updateUser(UserVO vo) {
		userDAO.updateUserAdmin(vo);

	}

	// 회원삭제
	// @Override
	// public void deleteUser(UserVO deleteVO) {

//	}
	@Override
	public int userDeleteById(String user_id) {
		logger.debug("userDeleteById() 호출");
		return userDAO.userDeleteById(user_id);
	}

	// 비밀번호 변경 전 아이디 이름 확인 
	@Override
	public UserVO findPw(UserVO vo) {
		logger.debug("findPw(vo) 호출");
		return userDAO.findPw(vo);
	}
	
	// 카카오 로그인-토큰 요청
	@Override
	public String getAccessToken(String authorize_code) {
			String access_Token = "";
			String refresh_Token = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";

			try {
				URL url = new URL(reqURL);
	            
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				// POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	            
				conn.setRequestMethod("POST");
				conn.setDoOutput(true);
				// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
	            
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				StringBuilder sb = new StringBuilder();
				sb.append("grant_type=authorization_code");
	            
				sb.append("&client_id=b7aecba0d6b45f45c2c5b8d78a55f222"); //본인이 발급받은 key
				sb.append("&redirect_uri=http://localhost:8088/user/kakaoLogin"); // 본인이 설정한 주소
	            
				sb.append("&code=" + authorize_code);
				bw.write(sb.toString());
				bw.flush();
	            
				// 결과 코드가 200이라면 성공
				int responseCode = conn.getResponseCode();
				System.out.println("responseCode : " + responseCode);
	            
				// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String result = "";
	            
				while ((line = br.readLine()) != null) {
					result += line;
				}
				System.out.println("response body : " + result);
	            
				// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
				JsonParser parser = new JsonParser();
				JsonElement element = parser.parse(result);

				access_Token = element.getAsJsonObject().get("access_token").getAsString();
				refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

				System.out.println("access_token : " + access_Token);
				System.out.println("refresh_token : " + refresh_Token);

				br.close();
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return access_Token;
		}
	
	// 카카오 로그인 - 사용자 정보를 요청하는 내용 생성
	@Override
	public UserVO getUserInfo(String access_Token) {

		// 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			// 요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

			String user_name = properties.getAsJsonObject().get("nickname").getAsString();
			String user_id = kakao_account.getAsJsonObject().get("email").getAsString();

			userInfo.put("user_name", user_name);
			userInfo.put("user_id", user_id);

		} catch (IOException e) {
			e.printStackTrace();
		}

		// catch 아래 코드 추가.
		UserVO result = udao.findKakao(userInfo);
		// 위 코드는 먼저 정보가 저장되있는지 확인하는 코드.
		System.out.println("S:" + result);
		if (result == null) {
			// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
			udao.kakaoInsert(userInfo);
			// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임.
			return udao.findKakao(userInfo);
			// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
			// result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
		} else {
			return result;
//			// 정보가 이미 있기 때문에 result를 리턴함.
	}

	}

	@Override
	public void kakaoInsert(HashMap<String, Object> userInfo) {
		udao.kakaoInsert(userInfo);
		
	}

	@Override
	public UserVO findKakao(HashMap<String, Object> userInfo) {
		logger.debug(" findkakao 호출 ");
		
		UserVO resultVO = udao.findKakao(userInfo);
		return resultVO;
	}

	// 카카오 번호찾기
		@Override
		public UserVO kakaoNumber(UserVO userInfo) {
			return udao.kakaoNumber(userInfo);
		}
}

