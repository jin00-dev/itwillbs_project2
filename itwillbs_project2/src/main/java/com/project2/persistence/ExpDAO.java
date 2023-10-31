package com.project2.persistence;

import java.util.List;

import com.project2.domain.ExpVO;


public interface ExpDAO {
	
	
	// 회원목록 조회
	public List<ExpVO> getExpList(ExpVO vo) throws Exception; 
	

}
