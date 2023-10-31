package com.project2.persistence;

import com.project2.domain.UserVO;

public interface UserDAO {

	// 회원가입기능 
		public void insertUser(UserVO vo);
	
	// 로그인 기능 - 객체 사용
		public UserVO loginUser(UserVO loginVO);
	
	// 회원정보 조회
		public UserVO getUser(String sessionUserid);
}
