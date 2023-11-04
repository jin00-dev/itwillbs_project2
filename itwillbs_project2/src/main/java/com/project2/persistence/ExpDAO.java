package com.project2.persistence;

import java.util.List;

import com.project2.domain.ExpVO;
import com.project2.domain.RevVO;


public interface ExpDAO {
	
	
	// 회원목록 조회
	public List<ExpVO> getExpList(ExpVO vo) throws Exception; 
	
	//1개 개시물 리뷰목록 가저오기
	public List<RevVO> getExpRevList(Integer exp_num) throws Exception;
	
	//1개 개시물 리뷰평균
	public double getExpRevAvg(Integer exp_num) throws Exception;
	
}
