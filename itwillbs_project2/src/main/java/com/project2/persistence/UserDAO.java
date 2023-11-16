package com.project2.persistence;

import java.util.List;

import com.project2.domain.Criteria;
import com.project2.domain.ReportVO;
import java.util.Map;

import com.project2.domain.UserVO;

public interface UserDAO {

		// 회원가입기능 
		public void insertUser(UserVO vo);
	
		// 로그인 기능 - 객체 사용
		public UserVO loginUser(UserVO loginVO);
	
		// 회원정보 조회
		public UserVO getUser(String sessionUserid);
		
		// 회원정보 수정
		public void updateUser(UserVO updateVO);
		
		// 회원정보 삭제
		public int deleteUser(UserVO delVO);	
		
		// 회원목록 조회
		public List<UserVO> getUserList(Criteria cri) throws Exception; 
		
		//총 회원 수 조회 
		public int getUserCount() throws Exception;
		
		// 아이디 중복체크
			public int idCheck(String user_id);
			
		// 휴대폰 중복체크
			public int phoneCheck(String user_phone);
			
		//회원등급변경
			   
		    public UserVO getUserByUserId(String user_id);
		    public void updateUserGrade(UserVO userVO);
		    
		  //아이디찾기
		    UserVO findUserByNameAndPhone(String user_name, String user_phone);
		    
		// 신고 목록 조회 
		public List<ReportVO> adminReport(Criteria cri) throws Exception;
		    
		//신고 목록 전체
		public int reportList() throws Exception;
		
		  //회원정보수정(관리자)
		    public void updateUserAdmin(UserVO vo);
		    
		    //회원삭제
		   // void UserDelete(UserVO deleteVO);
		    int userDeleteById(String user_id);
		    
		    //비번찾기
		    UserVO findUserByNameAndId(String user_name, String user_id);
		    
		    //새비번
		    void updateUserPassword(String userId, String newPassword);
	}