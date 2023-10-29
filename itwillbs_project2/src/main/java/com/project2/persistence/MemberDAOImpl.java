package com.project2.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.MemberVO;

//@Repository : 스프링이 해당객체를 DAO로 인식하도록 함

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	// 디비연결객체 정보를 주입
//	@Inject
//	private SqlSessionFactory sqlFactory;
	// => 디비연결정보만 가지고있음(연결 수동)
	@Autowired
	private SqlSession sqlSession;
	// => 디비연결정보 있음(연결,해제 자동)
	
	// memberMapper의 namespace정보 저장
	private static final String NAMESPACE
	      ="com.project2.mapper.MemberMapper.";
	
	
	@Override
	public String getTime() {
		logger.debug("getTime() 호출");
		//디비연결
//		SqlSession sqlSessionF 
//		     = sqlFactory.openSession();
		
		//SQL작성 & pstmt객체
		//SQL실행
		String time 
		 = sqlSession.selectOne(NAMESPACE+ "getTime");
		
		return time;
	}


	@Override
	public int insertMember(MemberVO vo) {
		// 디비연결-O		
		// SQL작성(Mapper)-O		
		//SQL실행(Mapper 호출)
		//sqlSession.insert(SQL구문);
		//sqlSession.insert(SQL구문,SQL전달할 정보);
		return sqlSession.insert(NAMESPACE + "insertMember", vo);
	}


	@Override
	public MemberVO loginMember(MemberVO loginVO) {
		System.out.println(" DAOImpl : loginMember() 실행 ");
		System.out.println(" DAOImpl : 해당 SQL구문 실행 ");
		System.out.println(" DAO VO : "+ loginVO);
		
		MemberVO resultVO = null;
		resultVO = sqlSession.selectOne(NAMESPACE + "loginMember2",loginVO);	
		
		System.out.println(" DAOImpl : 결과 "+resultVO);
		
		return resultVO;
	}


	@Override
	public MemberVO loginMember(String userid, String userpw) {
		System.out.println(" DAOImpl : loginMember(userid, userpw) 호출 ");
		
//		MemberVO vo = new MemberVO();
//		vo.setUserid(userid);
//		vo.setUserpw(userpw);
		
		// Map => 데이터 저장시 key,value 쌍으로값을 저장
		// =>> 하나의 객체로 저장이 불가능한 경우 사용(join)
		Map<String,	Object> paramMap 
		     = new HashMap<String, Object>();
		
		//paramMap.put("mapper에서 사용되는 이름", 값);
		paramMap.put("userid", userid);
		paramMap.put("userpw", userpw);
		
		System.out.println(paramMap);
		
		
		// 해당 SQL구문 호출
//		sqlSession.selectOne(NAMESPACE + ".loginMember", vo);

		// VO객체에 정보를 수정(추가로 저장/변경)작업을 포함해서 리턴.
//		MemberVO vo 
//		   = sqlSession.selectOne(NAMESPACE + ".loginMember",paramMap );
//		vo.setUserid("아이디수정");
//		return vo;
		
		// VO객체를 받은 그대로 리턴.
		return sqlSession.selectOne(NAMESPACE + "loginMember",paramMap );
		
	}


	@Override
	public MemberVO getMember(String sessionUserid) {
		System.out.println(" DAOImpl : getMember(String sessionUserid) 호출 ");
		
		return sqlSession.selectOne(NAMESPACE + "getMember",sessionUserid);
	}


	@Override
	public void updateMember(MemberVO updateVO) {
		System.out.println(" DAOImpl : updateMember(MemberVO updateVO) 호출");
		
		// SQL구문 호출
		sqlSession.update(NAMESPACE + "updateMember", updateVO);
		
		System.out.println(" DAOImpl : 수정완료! ");
		
	}


	@Override
	public int deleteMember(MemberVO delVO) {
		System.out.println(" DAOImpl : 삭제 시작 ");
		
		// 정상적으로 삭제 1, 삭제실패 0
		// SQL구문 호출		
		return sqlSession.delete(NAMESPACE + "deleteMember",delVO);
	}


	@Override
	public List<MemberVO> getMemberList() {
		System.out.println(" DAOImpl : getMemberList() 호출");
		
		
		return sqlSession.selectList(NAMESPACE + "getMemberList");
	}

	
	
	

}//DAOImpl
