package com.project2.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project2.domain.ExpVO;
import com.project2.domain.RevVO;
import com.project2.persistence.ExpDAOImpl;

@Service(value = "expService")
public class ExpServiceImpl {

	private static final Logger logger = LoggerFactory.getLogger(ExpServiceImpl.class);

	@Autowired
	private ExpDAOImpl dao;

	// 회원목록 조회
	public List<ExpVO> getExpList(ExpVO vo) throws Exception {
		logger.debug("getMemberList() 호출");

		return dao.getExpList(vo);
	}

	// 1개 개시물 리뷰목록 가저오기
	public List<RevVO> getExpRevList(Integer exp_num) throws Exception {
		return dao.getExpRevList(exp_num);
	}

	// 1개 개시물 리뷰별점 평균
	public double getExpRevAvg(Integer exp_num) throws Exception {
		return dao.getExpRevAvg(exp_num);
	}
	
	//1개 개시물 정보가저오기
	public ExpVO getExpOne(Integer exp_num) throws Exception {
		return dao.getExpOne(exp_num);
	}
	
	//리뷰 작성
	public int insertReview(RevVO vo) throws Exception{
		return dao.insertReview(vo);
	}

}///////
