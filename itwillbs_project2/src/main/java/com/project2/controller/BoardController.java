package com.project2.controller;

import java.util.Arrays;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project2.domain.BoardVO;
import com.project2.service.BoardService;

@Controller
@RequestMapping(value = "/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService bService;

	// http://localhost:8088/board/insert (o)
	// 공지사항 글쓰기 GET
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public void insertGET() throws Exception {
		logger.debug("insertGET 호출");
		logger.debug(" 연결된 뷰페이지(/views/board/insert.jsp를 출력 ");

	}

	// 공지사항 글쓰기 POST
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertPOST(/* @ModelAttribute */ BoardVO vo, RedirectAttributes rttr) throws Exception {
		logger.debug("insertPOST 호출");

		logger.debug("글작성 정보 : " + vo);

		bService.insert(vo);

		rttr.addFlashAttribute("result", "createOK");

		logger.debug(" 연결된 ((/board/listAll.jsp)페이지로 이동 ");

		return "redirect:/board/boardListAll";
	}

	// http://localhost:8088/board/boardListAll
	// 공지사항 리스트 조회GET
	@RequestMapping(value = "/boardListAll", method = RequestMethod.GET)
	public void boardlistAllGet(Model model, HttpSession session) throws Exception {
		logger.debug(" boardlistAllGet() 호출! ");

		// 서비스 -> DAO -> 글 목록을 조회하는 동작 수행
		List<BoardVO> boardListAll = bService.listAll();

		logger.debug("결과 리스트 크기 : " + boardListAll.size());

		model.addAttribute("boardListAll", boardListAll);
 
		// 고정할 공지의 번호 목록
		List<Integer> pinnedNotices = Arrays.asList(1);
		model.addAttribute("pinnedNotices", pinnedNotices);

		// 조회수 증가를 체크하기 위한 속성값 생성(session 영역에 저장)
		// viewcntCheck-on일 때만 조회수를 1증가
		session.setAttribute("viewcntCheck", "on");

		// View 이동 후 출력

	}

	// 공지사항 상세 글 조회 (Read) - DB에서 특정 글 정보를 조회해서 화면에 출력
	// http://localhost:8088/board/read?enf_notice_num=1
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void readGET(@RequestParam("enf_notice_num") int enf_notice_num, HttpSession session, Model model)
			throws Exception {

		logger.debug("readGET() 호출 ");

		// 전달정보 저장(bno)
		logger.debug(" bno : " + enf_notice_num);

		// 서비스 -> DAO -> 조회수 1증가 메서드
		if (session.getAttribute("viewcntCheck").equals("on")) {
			bService.increaseViewCount(enf_notice_num);

			session.setAttribute("viewcntCheck", "off");
		}

		// 서비스 -> DAO -> 특정 글정보를 조회하는 메서드
		BoardVO resultVO = bService.getBoard(enf_notice_num);

		// 리턴받은 특정 글정보를 연결된 뷰페이지에 출력 (Model)
		model.addAttribute("resultVO", resultVO);

	}

	// 공지사항 상세 글 수정하기 GET
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateGET(@RequestParam("enf_notice_num") int enf_notice_num, Model model) throws Exception {
		logger.debug(" update() 호출 ");

		// 전달 정보 저장 bno
		logger.debug(" 수정할 글 번호 : " + enf_notice_num);

		// 특정 글 번호에 해당하는 글 정보를 뷰페이지에 출력
		model.addAttribute("resultVO", bService.getBoard(enf_notice_num));

		// 연결된 뷰페이지(/board/update.jsp)로 이동
	}

	// 공지사항 상세 글 수정하기 POST
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(/* @ModelAttribute */ BoardVO vo) throws Exception {
		logger.debug(" updatePOST() 호출 ");

		logger.debug("" + vo);

		// 서비스 -> DAO - 글 수정 메서드 호출
		bService.updateBoard(vo);

		return "redirect:/board/boardListAll";
	}
  
	// 공지사항 글 삭제
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String removePOST(int enf_notice_num) throws Exception {
		logger.debug(" removePOST() 호출 ");
		
		// 전달정보 bno 저장
		logger.debug(" 삭제할 글번호 : " + enf_notice_num);

		// 서비스 -> DAO -> 글정보 삭제
		int result = bService.removeBoard(enf_notice_num);

		if (result != 1) {
			// 삭제 실패
			return "redirect:/board/read?enf_notice_num=" + enf_notice_num;
		} 
		
		// /board/boardListAll 페이지로 이동
 
		return "redirect:/board/boardListAll";
	}

} // BoardController