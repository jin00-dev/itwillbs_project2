package com.project2.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;

import com.project2.domain.Criteria;
import com.project2.domain.KakaoVO;
import com.project2.domain.ReportVO;
import com.project2.domain.UserVO;

public interface UserService {

	
	// 실제로 구현해야 하는 기능 정의
	// 회원가입 동작 실행
	public void insertUser(UserVO vo);

	// 로그인 체크 동작
	public UserVO userLogin(UserVO vo);

	// 회원정보 조회 동작
	public UserVO userInfo(String id);

	// 회원정보 수정 동작
	public Integer userUpdate(UserVO updateVO);
	
	// 현재 로그인한 회원의 암호화된 비밀번호 조회 
	public String pwCheck(String user_id);

	// 회원정보 삭제 동작
	public Integer updateState(UserVO userVO);

	// 회원정보 목록조회 동작
	public List<UserVO> userList(Criteria cri) throws Exception;
	
	//전체 회원 수 조회 
	public int getUserCount() throws Exception;

	// 아이디 중복체크
	public int idCheck(String id);

	// 휴대폰번호 중복체크
	public int phoneCheck(String phone);

	// 회원등급변경
	public UserVO getUserById(String user_id);

	public void updateUserGrade(UserVO userVO);

	// 아이디 찾기
	UserVO findUserByNameAndPhone(String user_name, String user_phone);
	
	//신고 목록 조회
	public List<ReportVO> adminReport(Criteria cri) throws Exception;
	
	//총 신고 목록 조회 
	public int reportList() throws Exception;
	
	//회원수정
	public void updateUser(UserVO vo);
	
	// 회원비번 변경 동작
	public int pwUpdate(String user_id, String hashedPw);
		
	//비번찾기 
	UserVO findUserByNameAndId(String user_name, String user_id);
	
	//새비번
	void changePassword(String userId, String newPassword);
	
	// 회원정보 삭제 동작
	//	public void deleteUser(UserVO deleteVO);
	int userDeleteById(String user_id);
	
	//비밀번호 변경 전 아이디 이메일 확인
	public UserVO findPw(UserVO vo);
	
	// access_Token 요청
	public String getAccessToken(String authorize_code);
	
	 // 카카오 로그인 - 액세스 토큰을 이용하여 사용자 정보를 가져오는 메서드
    public UserVO getUserInfo(String access_Token); 
    
 // 카카오 사용자 정보 저장
    public void kakaoInsert(HashMap<String, Object> userInfo);

    // 카카오 사용자 정보 조회
    public UserVO findKakao(HashMap<String, Object> userInfo);
    
    public UserVO kakaoNumber(UserVO userInfo);
}
	
