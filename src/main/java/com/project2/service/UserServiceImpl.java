package com.project2.service;

import java.security.SecureRandom;
import java.util.List;
import java.util.Optional;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project2.domain.Criteria;
import com.project2.domain.ReportVO;
import org.springframework.transaction.annotation.Transactional;

import com.project2.domain.UserVO;
import com.project2.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Inject
	private UserDAO udao;

	@Autowired
    private BCryptPasswordEncoder passEncoder;
	
	@Autowired
	private UserDAO userDAO;
	
	//회원가입
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

	//로그인
	@Override
	public UserVO userLogin(UserVO vo) {
		logger.debug(" 컨트롤러 호출로 DAO 메서드를 호출하겠다. ");
		UserVO resultVO = udao.loginUser(vo);
		// 로그 추가
	    if (resultVO != null) {
	        logger.debug("DAO의 처리 결과: {}", resultVO.toString());
	    } else {
	        logger.debug("DAO의 처리 결과는 null입니다.");
	    }
		logger.debug(" DAO의 처리 결과를 컨트롤러로 전달하겠다.");

        return resultVO;

	}

	// 내정보보기
	@Override
	public UserVO userInfo(String id) {
		logger.debug("  userInfo(String id) 호출 ");
		
		//디비동작 (DAO)중에서 회원정보 조회
	UserVO resultVO = udao.getUser(id);
		logger.debug("@@@@@"+resultVO);
		return resultVO;
		//return mdao.getMember(id);;
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
		
		//회원비번 변경
		@Override                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
		public void pwUpdate(String user_id, String hashedPw){
			udao.pwUpdate(user_id, hashedPw);
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

}
