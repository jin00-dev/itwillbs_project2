package com.project2.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

import com.project2.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{

	// 디비연결객체 정보를 주입(Inject또는 autowired)
		@Inject
		private SqlSessionFactory sqlFactory;
		// => 디비연결정보만 가지고있음(연결 수동)
		@Inject 
		private SqlSession sqlSession;
		// => 디비연결정보 있음(연결,해제 자동)
		
		// memberMapper의 namespace정보 저장
		private static final String NAMESPACE 
		="com.project2.mapper.UserMapper";

		@Override
		public void insertUser(UserVO vo) {
			// 디비연결-O		
			// SQL작성(Mapper)-O		
			//SQL실행(Mapper 호출)
			//sqlSession.insert(SQL구문);
			//sqlSession.insert(SQL구문,SQL전달할 정보);
			sqlSession.insert(NAMESPACE + ".insertUser", vo);
		}
		// 아이디 중복체크
		@Override
		public int idCheck(String user_id) {
			
			return sqlSession.selectOne(NAMESPACE+".idCheck", user_id);
		}

		//핸드폰 중복체크
		@Override
		public int phoneCheck(String user_phone) {
			
			return sqlSession.selectOne(NAMESPACE+".phoneCheck", user_phone);
		}

		@Override
		public UserVO loginUser(UserVO loginVO) {
			System.out.println(" DAOImpl : loginUser() 실행 ");
			System.out.println(" DAOImpl : 해당 SQL 구문 실행");
			
			UserVO resultVO
			=sqlSession.selectOne(NAMESPACE + ".loginUser",loginVO);
			
			System.out.println(" DAOImpl : 결과 "+resultVO);
			return resultVO;
		}

		@Override
		public UserVO getUser(String sessionUserid) {
			System.out.println(" DAOImpl : getUser(String sessionUserid)  호출 ");
			return sqlSession.selectOne(NAMESPACE + ".getUser", sessionUserid);
		}

		@Override
		public void updateUser(UserVO updateVO) {
			System.out.println(" DAOImpl : updateUser(UserVO updateVO) 호출");
			
			// SQL구문 호출
			sqlSession.update(NAMESPACE + ".updateUser", updateVO);
			
			System.out.println(" DAOImpl : 수정완료! ");
			
			
		}
//회원탈퇴
		@Override
		public int deleteUser(UserVO delVO) {
			System.out.println(" DAOImpl : 삭제 시작 ");
			
			// 정상적으로 삭제 1, 삭제실패 0
			// SQL구문 호출		
			return sqlSession.delete(NAMESPACE + ".deleteUser",delVO);
		}

		@Override
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
	    //아이디찾기
	    @Override
	    public UserVO findUserByNameAndPhone(String user_name, String user_phone) {
	        Map<String, String> params = new HashMap<>();
	        params.put("user_name", user_name);
	        params.put("user_phone", user_phone);
	        return sqlSession.selectOne(NAMESPACE+".findUserByNameAndPhone", params);
	    }
		//회원정보수정(관리자)
	    @Override
	    public void updateUserAdmin(UserVO vo) {
	    	sqlSession.update(NAMESPACE + ".updateList", vo);
	    	
	    }
	    //회원삭제
	 /*   @Override
	    public void UserDelete(UserVO deleteVO) {
	    	sqlSession.delete(NAMESPACE + ".deleteUser", deleteVO);
	    	
	    }*/
	    @Override
	    public int userDeleteById(String user_id) {
	        return sqlSession.delete(NAMESPACE + ".userDeleteById", user_id);
	    }
	    
}
