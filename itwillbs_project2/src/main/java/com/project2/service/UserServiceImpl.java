package com.project2.service;

import java.util.List;

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
	private UserDAO udao;
	
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


	// 휴대폰 중복체크
	@Override
	public int phoneCheck(String phone) {
		return udao.phoneCheck(phone);
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
		
		//디비동작 (DAO)중에서 회원정보 조회
	UserVO resultVO = udao.getUser(id);
		
		return resultVO;
		//return mdao.getMember(id);;
	}



	@Override
	public void userUpdate(UserVO updateVO) {
		logger.debug(" userUpdate(updateVO) 호출 ");
		
		udao.updateUser(updateVO);
		
	}



	@Override
	public int userDelete(UserVO deleteVO) {
		logger.debug(" userDelete(deleteVO) 호출 ");
		
		int result = udao.deleteUser(deleteVO);
		
		return result;
	}



	@Override
	public List<UserVO> userList() {
		logger.debug(" userList() 호출 ");
		
		List<UserVO> userList = udao.getUserList();
		
		return userList;
	}


	
}
