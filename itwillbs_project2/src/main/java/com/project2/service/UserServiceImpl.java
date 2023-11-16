package com.project2.service;

import java.security.SecureRandom;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project2.domain.UserVO;
import com.project2.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService{

<<<<<<< Updated upstream
	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Inject
	private UserDAO udao; 
	
	@Autowired
	   private UserDAO userDAO;
	
	@Override
	public void insertUser(UserVO vo) {
		logger.debug(" DAO에 있는 회원 가입 메서드 호출 ");
		udao.insertUser(vo);
	}
=======
   private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
   
   @Inject
   private UserDAO udao; 
   
   @Autowired
   private UserDAO userDAO;
   
 
   
   @Override
   public void insertUser(UserVO vo) {
      logger.debug(" DAO에 있는 회원 가입 메서드 호출 ");
      udao.insertUser(vo);
   }
>>>>>>> Stashed changes

   // 아이디 중복체크
   @Override
   public int idCheck(String id) {
      return udao.idCheck(id);
   }


   // 휴대폰 중복체크
  /* @Override
   public int phoneCheck(String phone) {
      return udao.phoneCheck(콜);
   }*/

   


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


   //회원정보 수정(내정보변경)
   @Override
   public void userUpdate(UserVO updateVO) {
      logger.debug(" userUpdate(updateVO) 호출 ");
      
      udao.updateUser(updateVO);
      
   }


   // 회원정보 탈퇴 
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

   // 회원등급변경
      @Override
      public void updateUserGrade(UserVO updateVO) {
         logger.debug("Service: 회원 등급 변경 메서드 호출");
         logger.debug("@@@@@vo :"+updateVO);
         // 등급 변경을 원하지 않는 경우 현재 등급 값을 그대로 업데이트
         if (updateVO.getUser_type() == null) {
            UserVO currentUser = userDAO.getUser(updateVO.getUser_id());
            updateVO.setUser_type(currentUser.getUser_type());
         }

         // user_type 업데이트
         userDAO.updateUserGrade(updateVO);
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

	@Override
	public int phoneCheck(String phone) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	//비밀번호 찾기
	@Override
	public UserVO findUserByNameAndId(String user_name, String user_id) {
	    return udao.findUserByNameAndId(user_name, user_id);
	}
	//새비번
	@Override
    @Transactional
    public void changePassword(String userId, String newPassword) {
        userDAO.updateUserPassword(userId, newPassword);
    }


<<<<<<< Updated upstream
	//회원정보 수정(내정보변경)
	@Override
	public void userUpdate(UserVO updateVO) {
		logger.debug(" userUpdate(updateVO) 호출 ");
		
		udao.updateUser(updateVO);
		
	}


	// 회원정보 탈퇴 
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

	// 회원등급변경
	   @Override
	   public void updateUserGrade(UserVO updateVO) {
	      logger.debug("Service: 회원 등급 변경 메서드 호출");
	      logger.debug("@@@@@vo :"+updateVO);
	      // 등급 변경을 원하지 않는 경우 현재 등급 값을 그대로 업데이트
	      if (updateVO.getUser_type() == null) {
	         UserVO currentUser = userDAO.getUser(updateVO.getUser_id());
	         updateVO.setUser_type(currentUser.getUser_type());
	      }

	      // user_type 업데이트
	      userDAO.updateUserGrade(updateVO);
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
	   //회원정보수정(관리자)
	   @Override
	public void updateUser(UserVO vo) {
		   userDAO.updateUserAdmin(vo);
		
	}
	   
	   //회원삭제
	//   @Override
	//public void deleteUser(UserVO deleteVO) {
	
		
//	}
	   @Override
	   public int userDeleteById(String user_id) {
		   logger.debug("userDeleteById() 호출");
	       return userDAO.userDeleteById(user_id);
	   }
	   
}
=======
}
>>>>>>> Stashed changes
