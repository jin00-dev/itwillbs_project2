package com.project2.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.ExpVO;
import com.project2.domain.MemberVO;

//@Repository : 스프링이 해당객체를 DAO로 인식하도록 함

@Repository
public class ExpDAOImpl implements ExpDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(ExpDAOImpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	// => 디비연결정보 있음(연결,해제 자동)
	
	// memberMapper의 namespace정보 저장
	private static final String NAMESPACE
	      ="com.project2.mapper.ExpMapper.";
	
	
	
	


	
	
		
	

	@Override
	public List<ExpVO> getExpList() {
		System.out.println(" DAOImpl : getMemberList() 호출");
		
		
		return sqlSession.selectList(NAMESPACE + "selectExp");
	}

	
	
	

}//DAOImpl
