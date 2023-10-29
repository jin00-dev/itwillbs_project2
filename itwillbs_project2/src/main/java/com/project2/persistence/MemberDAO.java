package com.project2.persistence;

import java.util.List;

import com.project2.domain.MemberVO;


public interface MemberDAO {
	
	// 디비서버 시간정보 조회기능
	public String getTime();	
	
	// 회원가입기능 
	public int insertMember(MemberVO vo);
	
	// 로그인 기능
	public MemberVO loginMember(MemberVO loginVO);
	
	// 로그인 기능2
	public MemberVO loginMember(String userid,String userpw);
	
	// 회원정보 조회
	public MemberVO getMember(String sessionUserid);
	
	// 회원정보 수정
	public void  updateMember(MemberVO updateVO);
	
	// 회원정보 삭제
	public int deleteMember(MemberVO delVO);
	
	// 회원목록 조회
	public List<MemberVO> getMemberList(); 
	

}
