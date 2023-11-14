package com.project2.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project2.domain.BoardVO;
import com.project2.domain.Criteria;
import com.project2.domain.PageVO;
import com.project2.service.BoardService;

@Controller
@RequestMapping(value = "/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Inject
	private BoardService bService;

	// 이미지 파일 저장 메서드
	private String saveImage(MultipartFile file, HttpServletRequest request) throws Exception {
		if (!file.isEmpty()) {
			// 실제 서버의 경로 얻기
			String realPath = request.getSession().getServletContext().getRealPath("/");
			String uploadPath = realPath + "resources/event_img/";

			// 디렉토리 생성 시도
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs(); // 폴더가 존재하지 않으면 폴더 생성
			}

			// 고유한 파일명 생성
			String originalFileName = file.getOriginalFilename();
			String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;

			// 저장할 파일 객체 생성
			File destinationFile = new File(uploadPath + uniqueFileName);

			// 파일 저장
			file.transferTo(destinationFile);

			// 파일 접근 경로 반환
			return "resources/event_img/" + uniqueFileName;
		}
		return null; // 파일이 없을 경우 null 반환
	}

	// http://localhost:8088/board/insert (o)
	// 공지사항 글쓰기 GET
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public void insertGET() throws Exception {
	}

	// 공지사항 글쓰기 POST
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertPOST(BoardVO vo) throws Exception {
		bService.insert(vo);

		return "redirect:/board/boardListAll";
	}

	// http://localhost:8088/board/boardListAll
	// 공지사항 리스트 조회GET
	@RequestMapping(value = "/boardListAll", method = RequestMethod.GET)
	public void boardlistAllGet(Criteria cri, Model model, HttpSession session) throws Exception {
		List<BoardVO> boardListAll = bService.listAll();

		model.addAttribute("boardListAll", boardListAll);

		// 고정할 공지의 번호 목록
		List<Integer> pinnedNotices = Arrays.asList(1);
		model.addAttribute("pinnedNotices", pinnedNotices);

		// 조회수 증가를 체크하기 위한 속성값 생성(session 영역에 저장)
		// viewcntCheck-on일 때만 조회수를 1증가
		session.setAttribute("viewcntCheck", "on");

		// 페이징처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(bService.getBoardCount());

		// 페이징처리 정보도 뷰페이지로 전달
		model.addAttribute("pageVO", pageVO);
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}

		// 서비스 -> DAO -> 페이징처리한 리스트 가져오기
		List<BoardVO> boardList = bService.getBoardPage(cri);

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("boardList", boardList);
	}

	// 공지사항 상세 글 조회 (Read) - DB에서 특정 글 정보를 조회해서 화면에 출력
	// http://localhost:8088/board/read?enf_notice_num=1
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void readGET(@RequestParam("enf_notice_num") int enf_notice_num, HttpSession session, Model model)
			throws Exception {

		// 전달정보 저장(bno)
		logger.debug(" enf_notice_num : " + enf_notice_num);

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

	// http://localhost:8088/board/update
	// 공지사항 상세 글 수정하기 GET
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateGET(@RequestParam("enf_notice_num") int enf_notice_num, Model model) throws Exception {
		logger.debug(" update() 호출 ");

		// 전달 정보 저장 bno
		logger.debug(" 수정할 글 번호 : " + enf_notice_num);

		// 특정 글 번호에 해당하는 글 정보를 뷰페이지에 출력
		model.addAttribute("resultVO", bService.getBoard(enf_notice_num));
	}

	// 공지사항 상세 글 수정하기 POST
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(/* @ModelAttribute */ BoardVO vo) throws Exception {

		// 서비스 -> DAO - 글 수정 메서드 호출
		bService.updateBoard(vo);

		return "redirect:/board/boardListAll";
	}

	// 공지사항 글 삭제
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String removePOST(int enf_notice_num) throws Exception {

		// 전달정보 bno 저장
		logger.debug(" 삭제할 글번호 : " + enf_notice_num);

		// 서비스 -> DAO -> 글정보 삭제
		int result = bService.removeBoard(enf_notice_num);

		if (result != 1) {
			// 삭제 실패
			return "redirect:/board/read?enf_notice_num=" + enf_notice_num;
		}
		return "redirect:/board/boardListAll";
	}

	// 공지사항 검색
	@RequestMapping(value = "/boardSearch", method = RequestMethod.GET)
	public String search(@RequestParam("searchTerm") String searchTerm, Model model) {
		List<BoardVO> searchResults = bService.searchByTitle(searchTerm);
		model.addAttribute("boardListAll", searchResults);
		return "board/boardListAll"; // 검색 결과를 표시하는 뷰
	}

	// 게시판 목록조회(페이징처리)
	@RequestMapping(value = "/boardListPage", method = RequestMethod.GET)
	public void boardListPageGET(Criteria cri, Model model, HttpSession session) throws Exception {
		logger.debug(" boardListPageGET 호출 ");

		// 페이징처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		// pageVO.setTotalCount(1664);
		pageVO.setTotalCount(bService.getBoardCount());

		logger.debug("" + pageVO);
		// 페이징처리 정보도 뷰페이지로 전달
		model.addAttribute("pageVO", pageVO);
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}

		// 서비스 -> DAO -> 페이징처리한 리스트 가져오기
		List<BoardVO> boardList = bService.getBoardPage(cri);

		// 고정할 공지의 번호 목록
		List<Integer> pinnedNotices = Arrays.asList(1);
		model.addAttribute("pinnedNotices", pinnedNotices);

		// 리스트 사이즈 확인
		logger.debug(" 글 개수 : " + boardList.size());

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("boardList", boardList);

		// 조회수 증가를 체크하기위한 속성값 생성(session 영역에 저장)
		// viewcntCheck-on일때만 조회수를 1증가
		session.setAttribute("viewcntCheck", "on");
	}

	/////////////////////////////////// 이벤트 게시판
	/////////////////////////////////// /////////////////////////////////////////

	// http://localhost:8088/board/eventListAll
	// 이벤트 리스트 조회GET
	@RequestMapping(value = "/eventListAll", method = RequestMethod.GET)
	public void eventListAllGet(Model model) throws Exception {

		List<BoardVO> eventListAll = bService.evListAll();

		model.addAttribute("eventListAll", eventListAll);

	}

	// http://localhost:8088/board/eventInsert
	// 이벤트 글쓰기
	@RequestMapping(value = "/eventInsert", method = RequestMethod.GET)
	public void eventInsertGET() throws Exception {
	}

	// http://localhost:8088/board/eventInsert
	// 이벤트 글쓰기 POST
	@RequestMapping(value = "/eventInsert", method = RequestMethod.POST)
	public String eventInsertPOST(BoardVO vo, HttpServletRequest request) throws Exception {
		MultipartFile file = vo.getFile();
		if (!file.isEmpty()) {
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			String uploadPath = rootPath + "resources/event_img/";

			String originalFileName = file.getOriginalFilename();
			String filePath = uploadPath + originalFileName;
			file.transferTo(new File(filePath)); // 파일 저장

			vo.setEnf_img(originalFileName); // 파일명을 VO에 저장
		}

		bService.evinsert(vo); // 이벤트 글쓰기 서비스 호출

		return "redirect:/board/eventListAll"; // 글쓰기 후 이벤트 목록으로 리다이렉트
	}

	// 이벤트 상세 글 조회 (eventRead)
	// http://localhost:8088/board/eventRead?enf_event_num=1
	@RequestMapping(value = "/eventRead", method = RequestMethod.GET)
	public void eventReadGET(@RequestParam("enf_event_num") int enf_event_num, Model model) throws Exception {

		// 전달정보 저장(bno)
		logger.debug(" enf_event_num : " + enf_event_num);

		// 서비스 -> DAO -> 특정 글정보를 조회하는 메서드
		BoardVO resultVO = bService.evGetBoard(enf_event_num);

		// 리턴받은 특정 글정보를 연결된 뷰페이지에 출력 (Model)
		model.addAttribute("resultVO", resultVO);

	}

	// http://localhost:8088/board/eventUpdate
	// 이벤트 상세 글 수정하기 GET
	@RequestMapping(value = "/eventUpdate", method = RequestMethod.GET)
	public void eventUpdateGET(@RequestParam("enf_event_num") int enf_event_num, Model model) throws Exception {

		// 특정 글 번호에 해당하는 글 정보를 뷰페이지에 출력
		model.addAttribute("resultVO", bService.evGetBoard(enf_event_num));

		// 연결된 뷰페이지(/board/update.jsp)로 이동
	}

	// 이벤트 상세 글 수정하기 POST
	@RequestMapping(value = "/eventUpdate", method = RequestMethod.POST)
	public String eventUpdatePOST(BoardVO vo, HttpServletRequest request) throws Exception {

		// 첨부 파일 확인
		MultipartFile file = vo.getFile();
		if (file != null && !file.isEmpty()) {
			// 파일이 있으면, 새로운 이미지로 교체
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			String uploadPath = rootPath + "resources/event_img/";

			String originalFileName = file.getOriginalFilename();
			String filePath = uploadPath + originalFileName;
			file.transferTo(new File(filePath)); // 파일 저장

			vo.setEnf_img(originalFileName); // 새 파일명을 VO에 저장
		} else {
			// 파일이 없으면, 기존 이미지 이름을 유지
			BoardVO currentBoard = bService.evGetBoard(vo.getEnf_event_num());
			vo.setEnf_img(currentBoard.getEnf_img());
		}

		// 서비스 -> DAO - 글 수정 메서드 호출
		bService.eventUpdateBoard(vo);

		return "redirect:/board/eventListAll";
	}

	// 이벤트 글 삭제
	@RequestMapping(value = "/eventRemove", method = RequestMethod.POST)
	public String eventRemovePOST(int enf_event_num) throws Exception {

		// 서비스 -> DAO -> 글정보 삭제
		int result = bService.eventRemoveBoard(enf_event_num);

		if (result != 1) {
			// 삭제 실패
			return "redirect:/board/read?enf_event_num=" + enf_event_num;
		}

		return "redirect:/board/eventListAll";
	}

	// http://localhost:8088/board/evListCri
	// 게시판 목록 조회(페이징처리)
	@RequestMapping(value = "/evListCri", method = RequestMethod.GET)
	public void evListCriGET(Criteria cri, Model model, HttpSession session) throws Exception {

		// 서비스 -> DAO -> 페이징 처리한 리스트 가져오기
		List<BoardVO> boardList = bService.getEventPage(cri);

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("boardList", boardList);
	}

	// http://localhost:8088/board/evListPage
	// 게시판 목록조회(페이징처리)
	@RequestMapping(value = "/evListPage", method = RequestMethod.GET)
	public void evListPageGET(Criteria cri, Model model, HttpSession session) throws Exception {
		logger.debug(" evListPageGET() 호출 ");

		// 페이징처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(bService.getEventCount());

		// 페이징처리 정보도 뷰페이지로 전달
		model.addAttribute("pageVO", pageVO);
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}

		// 서비스 -> DAO -> 페이징처리한 리스트 가져오기
		List<BoardVO> boardList = bService.getEventPage(cri);

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("boardList", boardList);
	}

	/////////////////////////////////// FAQ 게시판 ///////////////////

	// http://localhost:8088/board/faqInsert
	// FAQ 글쓰기
	@RequestMapping(value = "/faqInsert", method = RequestMethod.GET)
	public void faqInsertGET() throws Exception {
	}

	// http://localhost:8088/board/faqInsert
	// FAQ 글쓰기 POST
	@RequestMapping(value = "/faqInsert", method = RequestMethod.POST)
	public String faqInsertPOST(BoardVO vo) throws Exception {

		int maxFaqNum = bService.getMaxEnfFaqNum(); // 현재 최대값을 구합니다.
		vo.setEnf_faq_num(maxFaqNum + 1);

		bService.fainsert(vo);

		return "redirect:/board/faqListAll";
	}

	// http://localhost:8088/board/faqListAll
	// FAQ 리스트 조회GET
	@RequestMapping(value = "/faqListAll", method = RequestMethod.GET)
	public void faqListAllGet(Criteria cri, Model model, HttpSession session) throws Exception {

		List<BoardVO> faqListAll = bService.faListAll();

		model.addAttribute("faqListAll", faqListAll);

		// 페이징처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(bService.getFaqCount());

		// 페이징처리 정보도 뷰페이지로 전달
		model.addAttribute("pageVO", pageVO);
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		} 

		// 서비스 -> DAO -> 페이징처리한 리스트 가져오기
		List<BoardVO> faqList = bService.getFaqPage(cri);

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("faqList", faqList);

	}

	// FAQ 상세 글 조회 (Read) - DB에서 특정 글 정보를 조회해서 화면에 출력
	// http://localhost:8088/board/faqRead?enf_faq_num=1
	@RequestMapping(value = "/faqRead", method = RequestMethod.GET)
	public void faqReadGET(@RequestParam("enf_faq_num") int enf_faq_num, HttpSession session, Model model)
			throws Exception {

		// 서비스 -> DAO -> 특정 글정보를 조회하는 메서드
		BoardVO faqList = bService.getFaqBoard(enf_faq_num);

		// 리턴받은 특정 글정보를 연결된 뷰페이지에 출력 (Model)
		model.addAttribute("faqList", faqList);

	}

	// FAQ 상세 글 수정하기 GET
	@RequestMapping(value = "/faqUpdate", method = RequestMethod.GET)
	public void faqUpdateGET(@RequestParam("enf_faq_num") int enf_faq_num, Model model) throws Exception {
		model.addAttribute("faqList", bService.getFaqBoard(enf_faq_num));
	}
 
	// FAQ 상세 글 수정하기 POST
	@RequestMapping(value = "/faqUpdate", method = RequestMethod.POST)
	public String faqUpdatePOST(BoardVO vo, HttpServletRequest request) throws Exception {

		bService.faqUpdateBoard(vo);

		return "redirect:/board/faqListAll";
	}

	// FAQ 글 삭제
	@RequestMapping(value = "/faqRemove", method = RequestMethod.POST)
	public String faqRemovePOST(int enf_faq_num) throws Exception {

		// 서비스 -> DAO -> 글정보 삭제
		int result = bService.faqRemoveBoard(enf_faq_num);

		if (result != 1) {
			// 삭제 실패
			return "redirect:/board/faqRead?enf_faq_num=" + enf_faq_num;
		}

		return "redirect:/board/faqListAll";
	}
	

	//게시판 목록조회(페이징처리)
	@RequestMapping(value = "/faqListPage", method = RequestMethod.GET)
	public void faqListPageGET(Criteria cri, Model model) throws Exception {
		logger.debug(" boardListPageGET 호출 ");

		// 페이징처리( 페이지 블럭 처리 객체 )
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		// pageVO.setTotalCount(1664);
		pageVO.setTotalCount(bService.getFaqCount());

		logger.debug("" + pageVO);
		// 페이징처리 정보도 뷰페이지로 전달
		model.addAttribute("pageVO", pageVO);
		// 페이지 이동시 받아온 페이지 번호
		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage(pageVO.getEndPage());
		}  

		// 서비스 -> DAO -> 페이징처리한 리스트 가져오기
		List<BoardVO> faqList = bService.getFaqPage(cri);

		// Model 객체에 리스트 정보를 저장
		model.addAttribute("faqList", faqList);

	}

} // BoardController