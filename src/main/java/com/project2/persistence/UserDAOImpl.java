package com.project2.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.project2.domain.Criteria;
import com.project2.domain.ReportVO;
import com.project2.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	private static final Logger logger = LoggerFactory.getLogger(UserDAOImpl.class);

	// 디비연결객체 정보를 주입(Inject또는 autowired)
	@Inject
	private SqlSessionFactory sqlFactory;
	// => 디비연결정보만 가지고있음(연결 수동)
	@Inject
	private SqlSession sqlSession;
	// => 디비연결정보 있음(연결,해제 자동)

	@Autowired
    private BCryptPasswordEncoder passEncoder;
	
	// memberMapper의 namespace정보 저장
	private static final String NAMESPACE = "com.project2.mapper.UserMapper";
	
	// 회원가입
	@Override
	public void insertUser(UserVO vo) {
		
		 // DB에 저장되기 전에 비밀번호를 암호화     
		// String pass = passEncoder.encode(vo.getUser_pw());
        //vo.setUser_pw(pass);
        logger.debug("암호화된 비밀번호 : "+vo.getUser_pw());
        
		sqlSession.insert(NAMESPACE + ".insertUser", vo);
	}

	// 아이디 중복체크
	@Override
	public int idCheck(String user_id) {

		return sqlSession.selectOne(NAMESPACE + ".idCheck", user_id);
	}

	// 핸드폰 중복체크
	@Override
	public int phoneCheck(String user_phone) {

		return sqlSession.selectOne(NAMESPACE + ".phoneCheck", user_phone);
	}
	
	// 로그인
	@Override
	public UserVO loginUser(UserVO loginVO) {
		System.out.println(" DAOImpl : loginUser() 실행 ");
		System.out.println(" DAOImpl : 해당 SQL 구문 실행 전");
		
		UserVO resultVO
		=sqlSession.selectOne(NAMESPACE + ".loginBcrypt",loginVO);
		System.out.println(" DAOImpl : 해당 SQL 구문 실행 후");
		System.out.println(" DAOImpl : 결과 "+resultVO);
		
//		 if (resultVO != null) {
//		        // 데이터베이스에서 가져온 암호화된 패스워드
//			 String encodedPassword = resultVO.getUser_pw();
//
//	            // 입력된 패스워드를 암호화하여 비교  
//			System.out.println(passEncoder.encode(loginVO.getUser_pw())+"@@##@@@@@");
//			System.out.println(encodedPassword+"######");
//			
//	            if (passEncoder.matches(passEncoder.encode(loginVO.getUser_pw()), encodedPassword)) {
//	                return resultVO; // 비밀번호가 일치하는 경우에는 로그인 성공
//	            }
//	        }
//
//		    // 해당 정보을 가진 유저가 없거나 비밀번호 불일치
//		    return null; 
		return resultVO;
	}

	// 회원정보 조회
	@Override
	public UserVO getUser(String sessionUserid) {
		System.out.println(" DAOImpl : getUser(String sessionUserid)  호출 ");
		return sqlSession.selectOne(NAMESPACE + ".getUser", sessionUserid);
	}
	// 회원정보 수정
	@Override  
	public Integer updateUser(UserVO updateVO) {
		System.out.println(" DAOImpl : updateUser(UserVO updateVO) 호출");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_name", updateVO.getUser_name());
		map.put("user_phone", updateVO.getUser_phone());
		map.put("user_id", updateVO.getUser_id());
		
		
		// SQL구문 호출
		return sqlSession.update(NAMESPACE + ".updateUser", map);
		
	}
	
	// 현재 로그인한 회원의 암호화된 비밀번호 조회
			@Override
			public String pwCheck(String user_id)  {
			System.out.println(" 현재 비밀번호 조회");

			return sqlSession.selectOne(NAMESPACE + ".pwCheck", user_id);
			}
					
			// 회원 비번 변경
			@Override
			public void pwUpdate(String user_id, String hashedPw)  {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("user_id", user_id);
				map.put("user_pw", hashedPw);
				
				System.out.println(" DAOImpl : pwUpdate() 호출");
				
				// SQL구문 호출
				sqlSession.update(NAMESPACE + ".pwUpdate", map);
		
			}
	
	
	// 회원탈퇴(회원 탈퇴상태 변경)
	@Override
	public Integer updateState(UserVO userVO) {
		System.out.println(" DAOImpl : 회원 탈퇴 시작 ");
		
		// 정상적으로 삭제 1, 삭제실패 0
		// SQL구문 호출		
		return sqlSession.update(NAMESPACE + ".updateState",userVO);
	}


	@Override
	public List<UserVO> getUserList(Criteria cri) {
		System.out.println(" DAOImpl : getUserList() 호출");
		// 페이징 처리 추가
		return sqlSession.selectList(NAMESPACE + ".getUserList", cri);
	}

	// 총 회원 수 조회
	@Override
	public int getUserCount() throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".UserCount");
	}

	public List<UserVO> getUserList() {
		System.out.println(" DAOImpl : getUserList() 호출");

		return sqlSession.selectList(NAMESPACE + ".getUserList");
	}

	// 등급변경

	@Override
	public UserVO getUserByUserId(String user_id) {
		return sqlSession.selectOne(NAMESPACE + ".getUserByUserId", user_id);
	}

	@Override
	public void updateUserGrade(UserVO userVO) {
		sqlSession.update(NAMESPACE + ".updateUserGrade", userVO);
	}

	// 아이디찾기
	@Override
	public UserVO findUserByNameAndPhone(String user_name, String user_phone) {
		Map<String, String> params = new HashMap<>();
		params.put("user_name", user_name);
		params.put("user_phone", user_phone);
		return sqlSession.selectOne(NAMESPACE + ".findUserByNameAndPhone", params);
	}

	// 신고 목록 조회
	@Override
	public List<ReportVO> adminReport(Criteria cri) throws Exception {
		logger.debug("DAOImpl : adminReport(Criteria cri) 호출");

		return sqlSession.selectList(NAMESPACE + ".reportList", cri);
	}

	// 전체 신고 목록 조회
	@Override
	public int reportList() throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".reportCount");
	}

	// 회원정보수정(관리자)
	@Override
	public void updateUserAdmin(UserVO vo) {
		sqlSession.update(NAMESPACE + ".updateList", vo);

	}

	// 회원삭제
	/*
	 * @Override public void UserDelete(UserVO deleteVO) {
	 * sqlSession.delete(NAMESPACE + ".deleteUser", deleteVO);
	 * 
	 * }
	 */
	@Override
	public int userDeleteById(String user_id) {
		return sqlSession.delete(NAMESPACE + ".userDeleteById", user_id);
	}

	// 비벚찾기
	@Override
	public UserVO findUserByNameAndId(String user_name, String user_id) {
		Map<String, String> params = new HashMap<>();
		params.put("user_name", user_name);
		params.put("user_id", user_id);
		return sqlSession.selectOne(NAMESPACE + ".findUserByNameAndId", params);
	}

	// 새비번
	@Override
	public void updateUserPassword(String userId, String newPassword) {
		Map<String, String> params = new HashMap<>();
		params.put("userId", userId);
		params.put("newPassword", newPassword);
		sqlSession.update("updateUserPassword", params);
	}
}
