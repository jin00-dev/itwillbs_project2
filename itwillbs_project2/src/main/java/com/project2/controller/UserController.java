package com.project2.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project2.domain.Criteria;
import com.project2.domain.PageVO;
import com.project2.domain.ReportVO;
import com.project2.domain.UserVO;
import com.project2.service.MailSendServiceImpl;
import com.project2.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/user/*")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService uService;
	
	// 메일 관련 서비스 주입
	@Autowired
	private MailSendServiceImpl mss; 
	
	@Autowired
    private BCryptPasswordEncoder passEncoder;
	
	
	// 회원가입 약관 페이지로 이동
		@RequestMapping(value="/clouse")
		public String clouse() throws Exception{
			return "user/clouse";
		}
		
	// http://localhost:8088/user/join
	// 회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGET() throws Exception {

		logger.debug("회원가입 페이지 진입");
		return "/user/join";
	}

	// 회원가입 프로세스
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(/* @ModelAttribute */ UserVO vo) throws Exception {

		// 전달정보 저장(회원가입 정보)
		logger.debug("vo " + vo);

		String hashPw = BCrypt.hashpw(vo.getUser_pw(), BCrypt.gensalt());
		vo.setUser_pw(hashPw);

		uService.insertUser(vo);
		logger.debug(" 회원가입 완료! ");

		// 로그인 페이지로 이동(redirect)
		return "redirect:/user/login";
		// return "redirect:../";
	}
	
	//이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) throws Exception{
		logger.debug("이메일 인증 요청 들어옴 @@@@@");
		logger.debug("인증 이메일 : " + email );
		
		return mss.joinEmail(email); 
	}

//	http://localhost:8088/user/login

	// 로그인 동작 메서드 생성 - 입력받는거 / 받은 거 처리
	// 로그인 GET (사용자가 정보를 입력받을 수 있게 만드는 페이지 생성)
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGET() {
		logger.debug(" loginGET() 호출 ");
		logger.debug(" 연결된 뷰페이지로 이동 ");

		return "/user/login";
	}

	// 로그인 POST (받은 거 가져가서 DB에서 확인하는 것)
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String loginPOST(UserVO vo,
                      HttpServletRequest req,
                      HttpSession session,
                      RedirectAttributes ra,
                      Model model) throws Exception{
       logger.debug(" loginPOST() 호출 ");
       BCryptPasswordEncoder passEncoder = new BCryptPasswordEncoder();
       session = req.getSession();
       
       // 서비스 -> DAO (DB직접호출X)
       UserVO resultVO = uService.userLogin(vo);
       model.addAttribute("resultVO",resultVO);
       boolean isMatches = passEncoder.matches(vo.getUser_pw(),resultVO.getUser_pw());
       
       if (resultVO != null) { // 일치하는 아이디 존재시
    	   session.setAttribute("vo", resultVO);
       
          logger.debug("isMatches : "+isMatches);
          
          if (isMatches == true) {  // 비밀번호 비교(입력값, 암호화값) 성공하면 로그인
             // if (passEncoder.matches(inputPass, resultVO.getUser_pw())) { // 비밀번호 일치 여부 판단
             // resultVO.setUser_pw(""); // 인코딩된 비번 정보 지움
             logger.debug("비밀번호 일치. 로그인 성공.");
          
             session.setAttribute("vo", resultVO); // sesison에 사용자 정보 저장
             session.setAttribute("user_id", resultVO.getUser_id());
             session.setAttribute("user_name", resultVO.getUser_name());
             session.setAttribute("user_num", resultVO.getUser_num());
             session.setAttribute("user_type", resultVO.getUser_type());
             session.setMaxInactiveInterval(60 * 30); //세션 만료시간 설정(초단위)
             return "redirect:/";
          } else {   //비밀번호 틀렸을 때
             logger.debug("비밀번호 불일치. 로그인 실패.");
             session.setAttribute("vo", null);
             req.setAttribute("url","/user/login");
             req.setAttribute("msg", " 비밀번호가 일치하지 않습니다.");
             //ra.addFlashAttribute("msg", false);
             return "user/userAlert";
          }
       } // 일치하는 아이디 존재하지 않을 시
          session.setAttribute("vo", null);
          req.setAttribute("url","/user/login");
          req.setAttribute("msg", " 일치하는 회원정보가 없습니다.");
          ra.addFlashAttribute("msg", false);
          return "user/userAlert";
    }
      

	// 정보조회, 정보입력받는 페이지의 대부분의 방식은 GET
	// 메인페이지 호출 - 내가 전달할 세션아이디를 출력
    // update쪽으로 데이터 옮김 
	@RequestMapping(value = "/userMain", method = RequestMethod.GET)
	public String mainGET(HttpSession session, Model model) {
		logger.debug(" mainGET() 호출 ");

		// 사용자의 아이디정보 => 세션영역에 있는 정보 가져오기
		String id = (String) session.getAttribute("user_id");

		// 서비스 -> DB에 저장된 회원정보
		UserVO resultVO = uService.userInfo(id);

		// 연결된 뷰페이지에 출력=> 컨트롤러의 정보를 view페이지로 전달
		// Model객체를 사용
		model.addAttribute("vo", resultVO);

		// UserMain -> 마이페이지 (userInfo)로 변경
		return "/user/userMain";
	}

	// 로그아웃 처리
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logoutGET(HttpSession session) {
		logger.debug(" logoutGET() 호출 ");
		logger.debug(" 연결된 뷰페이지로 이동 ");

		// 로그아웃 처리 => 세션 정보 초기화
		session.invalidate();
		// session.removeAttribute("login");
		// 메인페이지로 이동(패턴2-주소바뀜)

		return "redirect:/";
	}

	// 회원정보 수정GET
	//마이페이지 첫화면 
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateGET(HttpSession session, Model model) {
		logger.debug(" updateGET() 호출 ");

		// 로그인한 회원 아이디조회
		String id = (String) session.getAttribute("user_id");

		// 서비스 -> DAO : 회원정보 조회 호출
		UserVO resultVO = uService.userInfo(id);
		// 정보를 뷰페이지로 전달하기 위해서 Model객체 사용
		model.addAttribute("vo", resultVO);

		// model.addAttribute(mService.memberInfo(id));
		// => 이름 : memberVO (리턴타입의 클래스 첫글자를 소문자로 변경)

		// /member/memberUpdate.jsp
		return "/user/userUpdate";
	}

	// 회원정보 수정POST
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public String updatePOST(UserVO vo,Model model,HttpServletRequest req,RedirectAttributes ra,HttpSession session) {
		
		logger.debug(" updatePOST() 호출 ");
		String id = vo.getUser_id();
		UserVO resultVO = null;
		session = req.getSession();
		// 여기서 user_pw는 암호화된 비번을 말한다.
		String user_pw = uService.pwCheck(vo.getUser_id());
		
	if (!passEncoder.matches(vo.getUser_pw(), user_pw)) {
		// 수정할 정보를 저장(파라메터)
		logger.debug(" vo " + vo);
		logger.debug("수정 실패");
		
		ra.addAttribute("msg", "0");
		return "redirect:/user/update";
		
	}
		// 서비스 -> DAO 회원정보 수정
		int result = uService.userUpdate(vo);
		
		if(result == 1) {
			 resultVO = uService.userInfo(id);
			 
		}
		// 페이지로 이동
		model.addAttribute("vo", resultVO);
		return "redirect:/user/update";
	}

	// 회원정보 탈퇴GET
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String deleteGET() {
		logger.debug(" deleteGET() 호출 ");
		// 로그인 제어(생략)

		return "/user/userDelete";
	}

	// 회원정보 탈퇴POST
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deletePOST(UserVO vo, HttpSession session) {
		logger.debug(" deletePOST() 호출 ");
		// 로그인 제어(생략)
		// 전달정보 저장(아이디,비밀번호)
		logger.debug(" vo : " + vo);

		// 서비스 -> DAO 회원정보 탈퇴 메서드
		int result = uService.userDelete(vo);

		// 페이지 이동(결과에 따른 이동)
		if (result == 1) { // 삭제 성공
			// 회원의 로그인 세션제거
			session.invalidate();
			return "redirect:/user/userMain";
		}
		// 삭제 실패(result == 0)
		return "redirect:/user/delete";
	}

	// 회원목록 조회GET
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String listGET(HttpSession session, Model model, Criteria cri) throws Exception {
		logger.debug(" listGET() ");
		// 관리자가 아닌경우 로그인페이지로 이동

		String id = (String) session.getAttribute("user_id");

		if (id == null || !id.equals("admin1")) {
			return "redirect:/";
		}
		
		//페이징 처리 
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(uService.getUserCount());

		logger.debug("" + pageVO);
		model.addAttribute("pageVO", pageVO);

		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage((pageVO.getEndPage()));
		}
		
		// 서비스 -> DAO 회원목록 조회
		List<UserVO> userList = uService.userList(cri);
		
		model.addAttribute("userList", userList);
		// model.addAllAttributes(attributeValues)
		// model.addAttribute("memberList", mService.memberList());

		return "/user/adminMain";
	}

	// 아이디 중복 체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	@ResponseBody
	public int idCheck(String id, Model model) throws Exception {

		// 서비스 -> DB에 저장된 회원정보
		// UserVO resultVO = uService.userInfo(id);

		return uService.idCheck(id);
	}

	// 휴대폰 중복 체크
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.POST)
	@ResponseBody
	public int phoneCheck(String phone, Model model) throws Exception {

		return uService.phoneCheck(phone);

	}

	// 회원 등급 변경POST

	@RequestMapping(value = "/changeGrade", method = RequestMethod.POST)
	public String changeGradePOST(@ModelAttribute UserVO user) {
		logger.debug(" changeGradePOST() 호출 ");
		uService.updateUserGrade(user);
		return "redirect:/user/list";
	}

	// 아이디찾기
	@RequestMapping(value = "/findId")
	public String showFindIdPage() {
		return "/user/findId"; // 아이디 찾기 폼 뷰 페이지로 이동
	}

	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findUserId(@RequestParam("user_name") String user_name, @RequestParam("user_phone") String user_phone,
			Model model, HttpSession session) {
		UserVO user = uService.findUserByNameAndPhone(user_name, user_phone);

		if (user != null) {
			model.addAttribute("userId", user.getUser_id());
		} else {
			model.addAttribute("message", "일치하는 아이디를 찾을 수 없습니다.");
		}

		return "/user/findIdResult"; // 아이디 찾기 결과 뷰 페이지로 이동
	}
	
	//신고 리스트 
	@RequestMapping(value = "/reportList", method = RequestMethod.GET)
	public String reportList(Criteria cri, HttpSession session, Model model) throws Exception {
		logger.debug("reportList() 호출 ");
		// 관리자가 아닌경우 로그인페이지로 이동
		String id = (String) session.getAttribute("user_id");

		if (id == null || !id.equals("admin1")) {
			return "redirect:/";
		}

		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(uService.reportList());

		logger.debug("" + pageVO);
		model.addAttribute("pageVO", pageVO);

		if (cri.getPage() > pageVO.getEndPage()) {
			// 잘못된 페이지 정보 입력
			cri.setPage((pageVO.getEndPage()));
		}

		List<ReportVO> reportList = uService.adminReport(cri);
		logger.debug("총 신고글 개수 : " + reportList.size());
		model.addAttribute("reportList", reportList);

		return "/user/adminReport";
	}

	// 회원 상세 페이지로 이동

	@RequestMapping(value = "/userDetail", method = RequestMethod.GET)
	public String userDetail(String user_id, Model model) {
		logger.debug("@@@@@@@@@@@@@회원상세페이지이동");
		// userId를 사용하여 해당 유저의 정보를 가져옴
		UserVO user = uService.getUserById(user_id);

		// 가져온 정보를 모델에 추가하여 View로 전달
		model.addAttribute("user", user);

		// userDetail.jsp로 이동
		return "/user/userDetail";
	}

	// 수정후 페이지

	@RequestMapping(value = "/userDetail", method = RequestMethod.POST)
	public String userDetaill(UserVO vo, Model model) {
		logger.debug("@@@@@@@@@@@@@회원정보수정");
		uService.updateUser(vo);

		// userDetail.jsp로 이동
		return "redirect:/user/userDetail?user_id=" + vo.getUser_id();
	}
//회원삭제
	/*
	 * @RequestMapping(value = "/deleteUser/{user_id}", method = RequestMethod.GET)
	 * public String deleteUser(UserVO deleteVO, Model model) { // 회원 삭제 서비스 호출
	 * userService.deleteUser(deleteVO);
	 * logger.debug(" 회원삭제 호출 !!!!!!!!!!!!!!!!!1"); // 회원 목록 페이지로 리다이렉트 return
	 * "redirect:/user/list"; }
	 */

	// 회원 삭제 GET 및 POST 모두 처리
	@RequestMapping(value = "/deleteUser", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteUser(@RequestParam("user_id") String user_id, HttpSession session) {
	    logger.debug("deleteUser GET/POST 호출");

	    // 로그인 제어(생략)
	    int result = uService.userDeleteById(user_id);

	    // 페이지 이동(결과에 따른 이동)
	    if (result == 1) { // 삭제 성공
	        // 회원의 로그인 세션 제거하지 않고 유지
	        logger.debug("@@@@@@@@@@@@@회원정보삭제");
	        return "redirect:/user/list";
	    }
	    // 삭제 실패(result == 0)
	    return "redirect:/user/userDetail";
	}

	// 비번찾기
	@RequestMapping(value = "/findPassword")
	public String showFindPwPage() {
		return "/user/findPassword"; // 비번 찾기 폼 뷰 페이지로 이동
	}

	// 비밀번호 찾기 기능
	@RequestMapping(value = "/findPassword", method = RequestMethod.POST)
	public String findPassword(@RequestParam("user_name") String user_name, @RequestParam("user_id") String user_id,
			Model model) {
		// 이름과 아이디로 사용자 정보 조회
		UserVO user = uService.findUserByNameAndId(user_name, user_id);

		if (user != null) {
			// 사용자 정보가 일치하면 새로운 비밀번호를 생성하고 DB에 업데이트
			String newPassword = generateRandomPassword();
			String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
			user.setUser_pw(hashedPassword);
			uService.userUpdate(user);

			// 생성된 비밀번호를 사용자에게 전송하거나, 다른 방법으로 제공할 수 있음
			model.addAttribute("newPassword", newPassword);
			return "/user/changePw"; // 비밀번호 표시 페이지로 이동
		} else {
			// 사용자 정보가 일치하지 않으면 에러 메시지 등을 처리할 수 있도록 하세요.
			model.addAttribute("error", "일치하는 정보를 찾을 수 없습니다.");
			return "/user/PwX";
		}
	}

	private String generateRandomPassword() {
		// TODO Auto-generated method stub
		return null;
	}

	// 새비번
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
		
		    public String changePassword(
		            @RequestParam("user_name") String userName,
		            @RequestParam("user_id") String userId,
		            @RequestParam("new_password") String newPassword,
		            @RequestParam("confirm_password") String confirmPassword,
		            Model model) {

		        // 비밀번호 유효성 검사 등을 수행할 수 있습니다.

		        if (newPassword.equals(confirmPassword)) {
		            // 비밀번호가 일치하면 비밀번호 변경 수행
		            uService.changePassword(userId, newPassword);

		            // 변경 성공 메시지를 모델에 추가
		            model.addAttribute("success", "비밀번호가 성공적으로 변경되었습니다.");
		        } else {
		            // 변경 실패 메시지를 모델에 추가
		            model.addAttribute("error", "비밀번호가 일치하지 않습니다. 다시 시도해주세요.");
		        }

		        // 결과 페이지로 이동
		        return "/user/changePasswordResult";
		    }

}
