package com.project2.service;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.project2.domain.UserVO;
import com.project2.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService{

	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Inject
	private UserDAO mdao;
	
	@Override
	public void userJoin(UserVO vo) {
		logger.debug(" DAO에 있는 회원 가입 메서드 호출 ");
		mdao.insertUser(vo);
	}

	

	@Override
	public UserVO userLogin(UserVO vo) {
		logger.debug(" 컨트롤러 호출로 DAO 메서드를 호출하겠다. ");
		UserVO resultVO = mdao.loginUser(vo);
		
		logger.debug(" DAO의 처리 결과를 컨트롤러로 전달하겠다.");
		
		
		return resultVO;
	}
	
	
}
