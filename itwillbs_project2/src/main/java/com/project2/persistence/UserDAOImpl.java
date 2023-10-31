package com.project2.persistence;

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

	
		
		
}
