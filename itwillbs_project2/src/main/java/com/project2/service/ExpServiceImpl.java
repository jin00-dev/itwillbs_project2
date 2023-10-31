package com.project2.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project2.domain.ExpVO;
import com.project2.persistence.ExpDAO;
import com.project2.persistence.MemberDAO;

@Service
public class ExpServiceImpl implements ExpService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ExpServiceImpl.class);
	
	@Autowired
	private ExpDAO dao;
	
	
	//회원목록 조회
	@Override
	public List<ExpVO> getExpList(ExpVO vo) throws Exception{
		logger.debug("getMemberList() 호출");
		
		return dao.getExpList(vo);
	}

	
	
}///////
