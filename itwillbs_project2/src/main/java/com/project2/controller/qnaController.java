package com.project2.controller;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.project2.domain.Criteria;
import com.project2.domain.PageVO;
import com.project2.domain.QnaVO;
import com.project2.service.QnaService;
 
@Controller
@RequestMapping(value = "/qna/*")
public class qnaController {

	private static final Logger logger = LoggerFactory.getLogger(qnaController.class);

	@Inject
	private QnaService qService;

	// http://localhost:8088/qna/qnaCreate (o)
	// 1대1 문의 글쓰기 GET
	@RequestMapping(value = "/qnaCreate", method = RequestMethod.GET)
	public void qnaCreateGET() throws Exception {
		logger.debug("qnaCreateGET 호출");
		logger.debug(" 연결된 뷰페이지(/views/board/qnaCreate.jsp를 출력 ");
	}

	// 1대1 문의 글쓰기 POST
	@RequestMapping(value = "/qnaCreate", method = RequestMethod.POST)
	public String qnaCreatePOST(QnaVO vo) throws Exception {
		logger.debug("qnaCreatePOST 호출");

		logger.debug("글작성 정보 : " + vo);

		qService.insert(vo);

		logger.debug(" 연결된 ((/board/qnaListAll.jsp)페이지로 이동 ");

		return "redirect:/qna/qnaListAll";
	}

	// http://localhost:8088/qna/qnaListAll
	// 1대1 리스트 조회GET
	@RequestMapping(value = "/qnaListAll", method = RequestMethod.GET)
	public void qnaListAllGet(Criteria cri, Model model, HttpSession session) throws Exception {
		logger.debug(" boardlistAllGet() 호출! ");
		
		// 페이징처리( 페이지 블럭 처리 객체 )
				PageVO pageVO = new PageVO();
				pageVO.setCri(cri);
				// pageVO.setTotalCount(1664);
				pageVO.setTotalCount(qService.getQnaCount());

				logger.debug("" + pageVO);
				// 페이징처리 정보도 뷰페이지로 전달
				model.addAttribute("pageVO", pageVO);
				// 페이지 이동시 받아온 페이지 번호
				if (cri.getPage() > pageVO.getEndPage()) {
					// 잘못된 페이지 정보 입력
					cri.setPage(pageVO.getEndPage());
				}
			cri.setUser_num(Integer.parseInt(String.valueOf(session.getAttribute("user_num"))));
				
		// 서비스 -> DAO -> 글 목록을 조회하는 동작 수행
		List<QnaVO> qnaListAll = qService.listAll(cri);

		logger.debug("결과 리스트 크기 : " + qnaListAll.size());

		model.addAttribute("qnaListAll", qnaListAll);

		// View 이동 후 출력

	}

	// 1대1 상세 글 조회 (qnaRead) - DB에서 특정 글 정보를 조회해서 화면에 출력
	// http://localhost:8088/board/qnaRead?qna_num=3
	@RequestMapping(value = "/qnaRead", method = RequestMethod.GET)
	public void qnaReadGET(@RequestParam("qna_num") int qna_num, HttpSession session, Model model) throws Exception {

		logger.debug("qnaReadGET() 호출 ");

		// 전달정보 저장(bno)
		logger.debug(" enf_notice_num : " + qna_num);
		
		// 서비스 -> DAO -> 특정 글정보를 조회하는 메서드
		QnaVO resultVO = qService.getQna(qna_num);
		session.getAttribute("qna_state");
		// 리턴받은 특정 글정보를 연결된 뷰페이지에 출력 (Model)
		model.addAttribute("resultVO", resultVO);

	}

	// 1대1 상세 글 수정하기 GET
	@RequestMapping(value = "/updateQna", method = RequestMethod.GET)
	public void updateQnaGET(@RequestParam("qna_num") int qna_num, Model model) throws Exception {
		logger.debug(" updateQna() 호출 ");

		// 전달 정보 저장 bno
		logger.debug(" 수정할 글 번호 : " + qna_num);

		// 특정 글 번호에 해당하는 글 정보를 뷰페이지에 출력
		model.addAttribute("resultVO", qService.getQna(qna_num));

		// 연결된 뷰페이지(/board/update.jsp)로 이동
	}

	// 1대1 상세 글 수정하기 POST
	@RequestMapping(value = "/updateQna", method = RequestMethod.POST)
	public String updateQnaPOST(QnaVO vo, HttpServletRequest request) throws Exception {
		logger.debug(" eventUpdatePOST() 호출 ");

		logger.debug("" + vo);

		// 서비스 -> DAO - 글 수정 메서드 호출
		qService.modifyQna(vo);

		return "redirect:/qna/qnaListAll";
	}

	// 게시판 글 삭제
	@RequestMapping(value = "/removeQna", method = RequestMethod.POST)
	public String removeQnaPOST(int qna_num) throws Exception {
		logger.debug(" removeQnaPOST() 호출 ");
		// 전달정보 bno 저장
		logger.debug(" 삭제할 글번호 : " + qna_num);

		// 서비스 -> DAO -> 글정보 삭제
		int result = qService.removeQna(qna_num);

		if (result != 1) {
			// 삭제 실패
			return "redirect:/board/read?bno=" + qna_num;
		}
		// /board/listAll 페이지로 이동

		return "redirect:/qna/qnaListAll";
	}

	// http://localhost:8088/qna/noAnswer
	// 관리자 미답변 문의사항 리스트 조회GET
	@RequestMapping(value = "/noAnswer", method = RequestMethod.GET)
	public void noAnswerGet(Criteria cri,Model model, HttpSession session) throws Exception {
		logger.debug(" noAnswerGet() 호출! ");

		// 서비스 -> DAO -> 글 목록을 조회하는 동작 수행
		List<QnaVO> qnaListAll = qService.listAll(cri);

		logger.debug("결과 리스트 크기 : " + qnaListAll.size());

		model.addAttribute("qnaListAll", qnaListAll);

		// View 이동 후 출력
	}

	// 관리자 1대1 답변 글쓰기 GET
	@RequestMapping(value = "/qnaAnswer", method = RequestMethod.GET)
	public void qnaAnswerGET() throws Exception {

	}

	// 관리자 1대1 답변 글쓰기 POST
	@RequestMapping(value = "/qnaAnswer", method = RequestMethod.POST)
	public String qnaAnswerPOST(QnaVO vo, Model model) throws Exception {
		logger.debug("qnaCreatePOST 호출");

		logger.debug("글작성 정보 : " + vo);

		qService.insertAnswer(vo);

		logger.debug(" 연결된 ((/board/qnaRead.jsp)페이지로 이동 ");

		return "redirect:/qna/adminQnaListPage";
	}

	// 관리자 답변 삭제
	@RequestMapping(value = "/removeAnswer", method = RequestMethod.POST)
	public String removeAnswerPOST(int qna_num) throws Exception {

		qService.removeAnswer(qna_num);

		return "redirect:/qna/qnaListAll";

	}

	
	// 관리자 1대1 모든 리스트 조회GET
	@RequestMapping(value = "/adminQnaListAll", method = RequestMethod.GET)
	public void adminQnaListAllGet(Model model, HttpSession session) throws Exception {
		logger.debug(" boardlistAllGet() 호출! ");

		// 서비스 -> DAO -> 글 목록을 조회하는 동작 수행
		List<QnaVO> qnaListAll = qService.adminListAll();

		logger.debug("결과 리스트 크기 : " + qnaListAll.size());

		model.addAttribute("qnaListAll", qnaListAll);
			
		// View 이동 후 출력

	}

	// http://localhost:8088/qna/adminQnaListPage
	// 게시판 목록조회(페이징처리)
	@RequestMapping(value = "/adminQnaListPage", method = RequestMethod.GET)
	public void adminQnaListPageGET(Criteria cri, Model model, HttpSession session) throws Exception {
		logger.debug(" adminQnaListPageGET() 호출 ");

		// 페이징처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		// pageVO.setTotalCount(1664);
		pageVO.setTotalCount(qService.getQnaCount());

		logger.debug("" + pageVO);
		// 페이징처리 정보도 뷰페이지로 전달
		model.addAttribute("pageVO", pageVO);
		// cri.setPage(2);
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}

		// 서비스 -> DAO -> 페이징처리한 리스트 가져오기
		List<QnaVO> QnaList = qService.getQnaPage(cri); 

		// 리스트 사이즈 확인
		logger.debug(" 글 개수 : " + QnaList.size());

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("QnaList", QnaList);
		logger.debug("@@@@ qnaList : " + QnaList );
		// 페이지 이동(/board/listPage.jsp)
	}

}