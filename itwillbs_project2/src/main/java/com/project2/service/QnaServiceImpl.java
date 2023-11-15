package com.project2.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.domain.QnaVO;
import com.project2.persistence.QnaDAO;

@Service
public class QnaServiceImpl implements QnaService {

	private static final Logger logger = LoggerFactory.getLogger(QnaServiceImpl.class);

	@Inject
	private QnaDAO qdao;  
	
	@Override
	public void insert(QnaVO vo) throws Exception {
		qdao.create(vo);		
	}

	@Override
	public List<QnaVO> listAll() throws Exception {
		
		return qdao.getQnaListAll();
	}

	@Override
	public QnaVO getQna(Integer qna_num) throws Exception {
		
		return qdao.getQna(qna_num);
	}

	@Override
	public void modifyQna(QnaVO vo) throws Exception {
		qdao.modifyQna(vo); 
		
	}

	@Override
	public int removeQna(Integer qna_num) throws Exception {
		
		return qdao.deleteQna(qna_num);
	}

	@Override
	public void insertAnswer(QnaVO vo) throws Exception {
		qdao.createAnswer(vo);
		
	}

	@Override
	public int removeAnswer(Integer qna_num) throws Exception {

		return qdao.deleteAnswer(qna_num);
	}

	@Override
	public List<QnaVO> adminListAll() throws Exception {
		
		return qdao.getAdminListAll();
	}
	
	@Override
	public List<QnaVO> getQnaPage(Criteria cri) throws Exception {
		
		return qdao.getQnaPage(cri); 
	}	
	
	@Override
	public int getQnaCount() throws Exception {
		
		return qdao.getQnaCount();
	}
	
	
	
	
	
	
	
	
}
