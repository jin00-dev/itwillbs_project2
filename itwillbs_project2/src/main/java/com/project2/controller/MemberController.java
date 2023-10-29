package com.project2.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project2.domain.MemberVO;
import com.project2.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService service;
	
	//회원가입 -------------------------------------
	@GetMapping(value = "/insert")
	public String insertMemberGET() {
		logger.debug("insertMemberGET() 호출");
		
		return "/member/memberJoin";
	}//insertMemberGET()
	
	@PostMapping(value = "/insert")
	public String insertMemberPOST(MemberVO vo) {
		logger.debug("insertMemberPOST() 호출");
		logger.debug("userInfo: "+vo);
		
		int result = service.memberJoin(vo);
		logger.debug("회원가입 동작 끝");
		
		if(result == 1) {
			return "redirect:/member/login";
		}else {
			return "/member/memberJoin";
		}
	}//insertMemberPOST(MemberVO vo)

	//로그인 -------------------------------------
	@GetMapping(value = "/login")
	public String loginGET() {
		logger.debug("loginGET() 호출");
		
		return "/member/memberLogin";
	}//loginGET()
	
	@PostMapping(value = "/login")
	public String logintPOST(MemberVO vo, HttpSession session) {
		logger.debug("loginPOST() 호출");
		logger.debug("userInfo: "+vo);
		
		MemberVO resultVO = service.memberLogin(vo);
		
		if(resultVO == null) {
			logger.debug("로그인 실패");
			return "redirect:/member/login";
		}
		session.setAttribute("id", vo.getUser_id());
		logger.debug("로그인 성공");
		
		return "redirect:/member/info";
	}//logintPOST(MemberVO vo)
	
	// 로그아웃 ----------------------------------------
	@RequestMapping(value = "/logout", method = {RequestMethod.GET,RequestMethod.POST})
	public String logout(HttpSession session) {
		logger.debug("logout() 호출");
		session.invalidate();
		
		return "redirect:/member/info";
	}//logout(HttpSession session)
	
	//회원정보 조회 ------------------------------------------
	@GetMapping(value = "/info")
	public String infoGET(HttpSession session, Model model) {
		logger.debug("infoGET() 호출");
		
		String id = (String)session.getAttribute("id");
		MemberVO vo = service.getMemberInfo(id);
		
		model.addAttribute(vo);
		
		return "/member/memberInfo";
	}//infoGET()
	
	//회원정보 수정 ---------------------------------------------
	@GetMapping(value = "/update")
	public String updateGET(HttpSession session, MemberVO vo, Model model) {
		logger.debug("updateGET() 호출");
		
		String id = (String) session.getAttribute("id");
		
		vo = service.getMemberInfo(id);
		model.addAttribute(vo);
		
		return "/member/memberUpdate";
	}//updateGET()
	
	@PostMapping(value = "/update")
	public String updatePOST(MemberVO vo) {
		logger.debug("updatePOST() 호출");
		
		service.updateMemberInfo(vo);
		
		logger.debug("정보수정 완료");
		
		return "redirect:/";
	}//updatePOST
	
	//회원 탈퇴 ----------------------------------------------
	@GetMapping(value = "/delete")
	public String deleteGET() {
		logger.debug("deleteGET() 호출");
		
		
		return "/member/memberDelete";
	}
	
	@PostMapping(value = "/delete")
	public String deletePost(MemberVO vo) {
		logger.debug("deleteGET() 호출");
		
		// 정상적으로 삭제 1, 삭제실패 0
		int result = service.deleteMember(vo);
		
		if(result == 1) {
			return "redirect:/member/logout";
		}
		
		return "redirect:/member/delete";
		
	}
	
	//회원 리스트 조회 ---------------------------------------------
	
	@GetMapping(value = "/list")
	public String listGET(Model model, HttpSession session) {
		logger.debug("listGET() 호출");
		String id = (String) session.getAttribute("id");
		
		if(id == null || !id.equals("admin"))
			return "redirect:/";
		
		model.addAttribute(service.getMemberList());
		
		return "/member/memberList";
	}
	
	
	
	
	
	
}//controller
