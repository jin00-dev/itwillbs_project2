package com.project2.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project2.domain.UserVO;
import com.project2.persistence.UserDAO;

	   @Service
	   public class UserServiceImpl implements UserService{

	   private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	   
	   @Inject
	   private UserDAO mdao;
	   
	   @Autowired
	    private UserDAO userDAO; 
	   
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
	   
	   @Override
		public UserVO userInfo(String id) {
			logger.debug("  memberInfo(String id) 호출 ");
			
			//디비동작 (DAO)중에서 회원정보 조회
			UserVO resultVO = mdao.getUser(id);
			
			return resultVO;
			//return mdao.getMember(id);;
		}
	   @Override
	   public void userUpdate(UserVO updateVO) {
	       logger.debug("userUpdate(updateVO) 호출");

	       // user_pw가 null이 아닌지 먼저 확인하고 업데이트 수행
	       if (updateVO.getUser_pw() != null && !updateVO.getUser_pw().isEmpty()) {
	           // user_pw가 null이 아니면 업데이트 수행
	           userDAO.updateUser(updateVO);
	       } else {
	           // user_pw가 null이거나 비어 있으면 에러 처리 또는 다른 로직 수행
	           // 예를 들어, 에러 메시지 설정 또는 예외 던지기 등
	           // 이 부분을 프로젝트의 요구사항에 따라 적절하게 처리하십시오.
	       }
	       
	       // 등급 변경을 원하지 않는 경우 현재 등급 값을 그대로 업데이트
	       if (updateVO.getUser_type() == null) {
	           UserVO currentUser = userDAO.getUser(updateVO.getUser_id());
	           updateVO.setUser_type(currentUser.getUser_type());
	       }

	       // user_type 업데이트
	       userDAO.updateUserGrade(updateVO);
	   }


	   @Override
	   public int userDelete(UserVO deleteVO) {
	      logger.debug(" userDelete(deleteVO) 호출 ");
	      
	      int result = mdao.deleteUser(deleteVO);
	      
	      return result;
	   }



	   @Override
	   public List<UserVO> userList() {
	      logger.debug(" userList() 호출 ");
	      
	      List<UserVO> userList = mdao.getUserList();
	      
	      return userList;
	   }


    @Override
   
    public UserVO getUserById(String user_id) {
        logger.debug("Service: 특정 회원 정보 조회 메서드 호출");
        return userDAO.getUserByUserId(user_id);
    }

    @Override
    public void updateUserGrade(UserVO userVO) {
        logger.debug("Service: 회원 등급 변경 메서드 호출");
        userDAO.updateUserGrade(userVO);
    }
    
    // 이메일

}