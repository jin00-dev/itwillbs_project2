package com.project2.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.ExpVO;

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
	public List<ExpVO> getExpList(ExpVO vo) throws Exception{
		System.out.println(" DAOImpl : getMemberList() 호출");
		
		//category exp_category
		//region exp_region,exp_name
		//sort exp_ad_state 1(cnt), 2(star), 3(price desc), 4(price asc)
		
		
		//정렬기준 ---------------
		//인기순
		if(vo.getExp_ad_state().equals("cnt")) {
			vo.setExp_ad_state("r.rev_");
		}
		//별점순
		else if(vo.getExp_ad_state().contentEquals("star")) {
		}
		//최고가
		else if(vo.getExp_ad_state().contentEquals("price desc")) {
		}
		//최저가
		else if(vo.getExp_ad_state().contentEquals("price asc")) {
		}
		
		//지역전체
		if(vo.getExp_region().equals("전체"))
			return sqlSession.selectList(NAMESPACE + "selectExpReAll",vo);
		
	}

	
	
	

}//DAOImpl
