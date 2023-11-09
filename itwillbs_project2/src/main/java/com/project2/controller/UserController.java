package com.project2.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project2.domain.UserVO;
import com.project2.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value="/user/*")
public class UserController {
	

private static final Logger logger = LoggerFactory.getLogger(UserController.class);

@Inject
private UserService uService;

	//http://localhost:8088/user/join
	//회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGET() throws Exception{
		
		logger.debug("회원가입 페이지 진입");
		return "/user/join";
	}	
	 
	// 회원가입 프로세스
	@RequestMapping(value = "/join",method = RequestMethod.POST)
	public String joinPOST(/* @ModelAttribute */ UserVO vo) throws Exception{
		
		// 전달정보 저장(회원가입 정보)
		logger.debug("vo "+vo);
				
		String hashPw = BCrypt.hashpw(vo.getUser_pw(), BCrypt.gensalt());
		vo.setUser_pw(hashPw);
		
		uService.insertUser(vo);
		logger.debug(" 회원가입 완료! ");
		
		// 로그인 페이지로 이동(redirect)		
		return "redirect:/user/login";
		//return "redirect:../";
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
		
		return "redirect:/user/userMain";
	}
	
	// 정보조회, 정보입력받는 페이지의 대부분의 방식은 GET
		// 메인페이지 호출 - 내가 전달할 세션아이디를 출력
		@RequestMapping(value="/userMain", method=RequestMethod.GET)
		public String mainGET() {
			logger.debug(" mainGET() 호출 ");
			
			
			// 메인 페이지를 보여주기만 (패턴3-주소안바뀜)
			return "/user/userMain";
		}
		
		// 로그아웃 처리
		@RequestMapping(value = "/logout",method = { RequestMethod.GET, RequestMethod.POST })
		public String logoutGET(HttpSession session) {
			logger.debug(" logoutGET() 호출 ");
			logger.debug(" 연결된 뷰페이지로 이동 ");
			
			// 로그아웃 처리 => 세션 정보 초기화
			session.invalidate();
			// session.removeAttribute("login");
			// 메인페이지로 이동(패턴2-주소바뀜)
			
			return "redirect:/user/userMain";
		}
	
		// 회원정보 조회
		@RequestMapping(value = "/info",method = RequestMethod.GET)
		public String infoGET(HttpSession session,Model model) {
			
			logger.debug(" infoGET() 호출 ");
			//사용자의 아이디정보 => 세션영역에 있는 정보 가져오기	
			String id = (String) session.getAttribute("id");
			
			// 서비스 -> DB에 저장된 회원정보	
			UserVO resultVO = uService.userInfo(id);
			
			// 연결된 뷰페이지에 출력=> 컨트롤러의 정보를 view페이지로 전달
			// Model객체를 사용
			model.addAttribute("vo", resultVO);
			
			return "/user/userInfo";
		}
		
		// 회원정보 수정GET
		@RequestMapping(value = "/update",method = RequestMethod.GET)
		public String updateGET(HttpSession session,Model model) {
			logger.debug(" updateGET() 호출 ");
			
			// 로그인한 회원 아이디조회
			String id = (String)session.getAttribute("id");
			
			// 서비스 -> DAO : 회원정보 조회 호출
			UserVO resultVO =uService.userInfo(id);
			// 정보를 뷰페이지로 전달하기 위해서 Model객체 사용
			model.addAttribute("vo", resultVO);
			
			//model.addAttribute(mService.memberInfo(id));
			// => 이름 : memberVO (리턴타입의 클래스 첫글자를 소문자로 변경)
		
			// /member/memberUpdate.jsp
			return "/user/userUpdate";
		}
		
		// 회원정보 수정POST
		@RequestMapping(value = "/update",method = RequestMethod.POST)
		public String updatePOST(UserVO vo) {
			logger.debug(" updatePOST() 호출 ");
			// 수정할 정보를 저장(파라메터)
			logger.debug(" vo "+vo);
			
			// 서비스 -> DAO 회원정보 수정
			uService.userUpdate(vo);
			// 메인페이지로 이동
			return "redirect:/user/userMain";
		}
		
		// 회원정보 탈퇴GET
		@RequestMapping(value = "/delete",method = RequestMethod.GET)
		public String deleteGET() {
			logger.debug(" deleteGET() 호출 ");
			// 로그인 제어(생략)
			
			return "/user/userDelete";
		}
		
		// 회원정보 탈퇴POST
		@RequestMapping(value = "/delete",method = RequestMethod.POST)
		public String deletePOST(UserVO vo,HttpSession session) {
			logger.debug(" deletePOST() 호출 ");
			// 로그인 제어(생략)
			// 전달정보 저장(아이디,비밀번호)
			logger.debug(" vo : "+vo);
			
			// 서비스 -> DAO 회원정보 탈퇴 메서드
			int result = uService.userDelete(vo);
			
			// 페이지 이동(결과에 따른 이동)
			if(result == 1) { //삭제 성공
				// 회원의 로그인 세션제거
				session.invalidate();
			    return "redirect:/user/userMain";
			}
			// 삭제 실패(result == 0)
			return "redirect:/user/delete";
		}
		
		// 회원목록 조회GET
		@RequestMapping(value = "/list",method = RequestMethod.GET)
		public String listGET(HttpSession session,Model model) {
			logger.debug(" listGET() ");
			// 관리자가 아닌경우 로그인페이지로 이동
			String id = (String) session.getAttribute("id");
			
			if(id == null || !id.equals("admin")) {
				return "redirect:/user/userMain";
			}
			// 서비스 -> DAO 회원목록 조회
			List<UserVO> userList = uService.userList();
			// memberList.add(dto); 리턴의 결과를 수정할 수 있다.
			// List로 전달된 회원정보를 view 페이지로 전달 출력
			// => Model 객체 
			model.addAttribute("userList", userList);
			//model.addAllAttributes(attributeValues)
			//model.addAttribute("memberList", mService.memberList());
			
			return "/user/userList";
		}
		
		// 아이디 중복 체크
		@RequestMapping(value="/idCheck",method=RequestMethod.POST)
		@ResponseBody
		public int idCheck(String id, Model model) throws Exception{
			
			// 서비스 -> DB에 저장된 회원정보	
			//UserVO resultVO = uService.userInfo(id);
			
			
			return uService.idCheck(id);
		}
		
		// 휴대폰 중복 체크
		@RequestMapping(value="/phoneCheck",method=RequestMethod.POST)
		@ResponseBody
		public int phoneCheck(String phone,Model model)throws Exception{
			
			return uService.phoneCheck(phone);
			 
			
		}
			
		
		
		
	
}

