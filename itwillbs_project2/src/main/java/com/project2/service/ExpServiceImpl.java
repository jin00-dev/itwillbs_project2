package com.project2.service;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project2.domain.ExpVO;
import com.project2.domain.PaymentVO;
import com.project2.domain.ReportVO;
import com.project2.domain.RevVO;
import com.project2.domain.UserVO;
import com.project2.persistence.ExpDAOImpl;

@Service(value = "expService")
public class ExpServiceImpl {

	private static final Logger logger = LoggerFactory.getLogger(ExpServiceImpl.class);

	@Autowired
	private ExpDAOImpl dao;

	// 게시물 리스트 가저오기
	public List<ExpVO> getExpList() throws Exception {
		logger.debug("getMemberList() 호출");

		return dao.getExpList();
	}

	// 게시물 리스트 가저오기(조건)
	public List<ExpVO> getExpList(ExpVO vo) throws Exception {
		logger.debug("getMemberList(조건) 호출");

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

	// 1개 개시물 정보가저오기
	public ExpVO getExpOne(Integer exp_num) throws Exception {
		return dao.getExpOne(exp_num);
	}

	// 리뷰 작성
	public int insertReview(RevVO vo) throws Exception {
		return dao.insertReview(vo);
	}

	// 리뷰 작성
	public int updateReview(RevVO vo) throws Exception {
		return dao.updateReview(vo);
	}

	// 리뷰 삭제
	public int deleteReview(RevVO vo) throws Exception {
		return dao.deleteReview(vo);
	}

	// 리뷰 작성자 번호 가저오기
	public int getRevUserNum(int rev_num) throws Exception {
		return dao.getRevUserNum(rev_num);
	}

	// 신고 작성
	public int insertReport(ReportVO vo) throws Exception {
		return dao.insertReport(vo);
	}
	
	//신고 상세 내역 
	public ReportVO repoInfo (Integer report_num) throws Exception {
		return dao.repoInfo(report_num);
	}

	// 유저 한명 정보
	public UserVO getUserOne(int user_num) throws Exception {
		return dao.getUserOne(user_num);
	}

	// 체험 번호 하나
	public int getExpNumOne(String exp_name) throws Exception {
		return dao.getExpNumOne(exp_name);
	}

	// 결제 처리
	public int paymentInsert(PaymentVO vo) throws Exception {
		return dao.paymentInsert(vo);
	}

	// 리뷰 파일 업로드 처리 메서드
	public String revFileUpload(MultipartFile ufile, HttpServletRequest req) throws Exception {
		logger.debug(" revFileUpload() - 파일업로드 처리 시작");

		// form태그-input/file태그의 이름 정보
		String fileName = ufile.getName();
		logger.debug(" fileName : " + fileName);

		// 업로드한 파일을 임시 저장
		MultipartFile mFile = ufile;
		// 임시저장된 파일의 원본이름을 리스트에 저장
		String oFileName = mFile.getOriginalFilename();
		logger.debug(" oFileName : " + oFileName);

		// 업로드 저장경로 생성 /WEB-INF/upload (가상경로)
		// 임시저장된 파일을 생성하기 위한 준비 (실제파일 생성)
		// File file = new File("D:\\springupload2\\"+fileName);
		File file = new File(req.getRealPath("/upload") +"/" + fileName);
		logger.debug(" realPath : " + req.getRealPath("/upload"));
		if (mFile.getSize() != 0) { // 첨부파일(업로드한 임시파일)이 존재할때 진행
			if (!file.exists()) { // 해당파일이 존재하는지 체크
				// 해당경로에 파일이 없을경우,자동으로 폴더 생성후 진행
				if (file.getParentFile().mkdirs()) {
					file.createNewFile();
					file.delete();
					logger.debug(" 임시파일 생성완료-삭제 (첨부파일 폴더생성)! ");
				}
			}
			// 임시로 생성된(저장된) 파일mFile -> 실제파일로 데이터 전송
			// mFile.transferTo(new File("D:\\springupload2\\"+oFileName));
			mFile.transferTo(new File(req.getRealPath("/upload") +"/" + oFileName));
		}
		logger.debug(" 파일 업로드 성공! ");

		logger.debug(" revFileUpload() - 파일업로드 처리 끝");

		return oFileName;
	}

	// 찜목록 가저오기
	public List<ExpVO> getWishList(Integer user_num) throws Exception {
		return dao.getWishList(user_num);
	}

	// 찜목록 갯수
	public int getWishCnt(ExpVO vo) throws Exception {
		return dao.getWishCnt(vo);
	}

	// 찜 추가
	public int insertWish(ExpVO vo) throws Exception {
		return dao.insertWish(vo);
	}

	// 찜 삭제
	public int deleteCnt(ExpVO vo) throws Exception {
		return dao.deleteWish(vo);
	}

	// 체험 검색
	public List<ExpVO> searchExp(String search) throws Exception {
		return dao.searchExp(search);
	}

}///////
