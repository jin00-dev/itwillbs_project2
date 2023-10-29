package com.project2.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project2.domain.MemberVO;
import com.project2.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberDAO dao;
	
	//회원가입
	@Override
	public int memberJoin(MemberVO vo) {
		logger.debug("memberJoin() 호출");
		return dao.insertMember(vo);
	}//
	
	//로그인
	@Override
	public MemberVO memberLogin(MemberVO vo) {
		logger.debug("memberLogin() 호출");
		return dao.loginMember(vo);
	}
	
	//회원정보 조회
	@Override
	public MemberVO getMemberInfo(String id) {
		logger.debug("getMemberInfo() 호출");
		return dao.getMember(id);
	}
	
	//회원정보 수정
	@Override
	public void updateMemberInfo(MemberVO vo) {
		logger.debug("updateMemberInfo() 호출");
		dao.updateMember(vo);
	}
	
	//회원정보 삭제
	@Override
	public int deleteMember(MemberVO vo) {
		logger.debug("deleteMember() 호출");
		
		return dao.deleteMember(vo);
	}
	
	//회원목록 조회
	@Override
	public List<MemberVO> getMemberList() {
		logger.debug("getMemberList() 호출");
		
		return dao.getMemberList();
	}

	
	
}///////
