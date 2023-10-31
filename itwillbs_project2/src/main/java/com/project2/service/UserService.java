package com.project2.service;

import com.project2.domain.UserVO;

public interface UserService {

	
	// 실제로 구현해야 하는 기능 정의
		// 회원가입 동작 실행
		public void userJoin(UserVO vo);
		
		// 로그인 체크 동작
		public UserVO userLogin(UserVO vo);
}
