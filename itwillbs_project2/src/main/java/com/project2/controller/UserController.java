package com.project2.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project2.domain.UserVO;
import com.project2.service.UserService;

@Controller
@RequestMapping(value="/user/*")
public class UserController {



private static final Logger logger = LoggerFactory.getLogger(UserController.class);

@Inject
private UserService uService;

	//http://localhost:8088/join
	//회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGET() throws Exception{
		
		logger.info("회원가입 페이지 진입");
		return "/user/join";
	}	
	
	@RequestMapping(value = "/join",method = RequestMethod.POST)
	public String joinPOST(/* @ModelAttribute */ UserVO vo) throws Exception{
		
		// 전달정보 저장(회원가입 정보)
		logger.debug("vo "+vo);
				
		
		uService.userJoin(vo);
		logger.debug(" 회원가입 완료! ");
		
		// 로그인 페이지로 이동(redirect)		
		return "redirect:/user/login";
	}
	
//	http://localhost:8088/member/login
	
	// 로그인 동작 메서드 생성 - 입력받는거 / 받은 거 처리
	
	// 로그인 GET (사용자가 정보를 입력받을 수 있게 만드는 페이지 생성)
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String loginGET() {
		logger.debug(" loginGET() 호출 ");
		logger.debug(" 연결된 뷰페이지로 이동 ");
		
		
		
		return "/user/login";
	}
	// 로그인 POST (받은 거 가져가서 DB에서 확인하는 것)
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginPOST(UserVO vo,HttpSession session) {
		logger.debug(" loginPOST() 호출 ");
		logger.debug(" 연결된 뷰페이지로 이동 ");
		// 전달정보 저장
		logger.debug(" vo : "+vo);
		
		// 서비스 -> DAO (DB직접호출X)
		UserVO resultVO = uService.userLogin(vo);
		
		logger.debug(" resultVO : "+resultVO);
		
		// 로그인 처리 결과에 따른 페이지 이동
		if(resultVO == null) {
			// 로그인 실패 -> 로그인 페이지로 이동
			return "redirect:/user/login"; 
		}
		
		// 로그인 성공
		// 세션에 로그인 아이디를 저장
		session.setAttribute("id", resultVO.getUser_id());
		
		return "redirect:/user/main";
	}
	
	// 정보조회, 정보입력받는 페이지의 대부분의 방식은 GET
		// 메인페이지 호출 - 내가 전달할 세션아이디를 출력
		@RequestMapping(value="/main", method=RequestMethod.GET)
		public String mainGET() {
			logger.debug(" mainGET() 호출 ");
			
			
			// 메인 페이지로 이동
			return "/user/userMain";
		}
		
		// 로그아웃 처리
		@RequestMapping(value="/logout", method= RequestMethod.GET)
		public String logoutGET(HttpSession session) {
			logger.debug(" logoutGET() 호출 ");
			logger.debug(" 연결된 뷰페이지로 이동 ");
			
			// 로그아웃 처리 => 세션 정보 초기화
			session.invalidate();
			// 메인페이지로 이동
			
			return "redirect:/member/main";
		}
	
	
}

