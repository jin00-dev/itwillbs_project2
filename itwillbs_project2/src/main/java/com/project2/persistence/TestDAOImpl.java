package com.project2.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Repository;

@Repository
public class TestDAOImpl implements TestDAO {
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Inject
	private SqlSession sqlSession;

	private static final String NAMESPACE  = "com.project2.mapper.TestMapper";

	@Override
	public String getTime() {
		SqlSession SqlSession = sqlFactory.openSession();
		
		String time = SqlSession.selectOne(NAMESPACE+ ".getTime");
				
		
		return time;
	}
	
	
}
