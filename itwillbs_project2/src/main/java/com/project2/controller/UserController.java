package com.project2.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.project2.domain.UserVO;
import com.project2.service.UserService;

import lombok.Data;

import com.project2.persistence.UserDAO;

@Controller
@RequestMapping(value = "/user/*")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService uService;

	@Autowired
	private UserService userService;

	// http://localhost:8088/user/join
	// 회원가입 페이지 이동
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String joinGET() throws Exception {

		logger.info("회원가입 페이지 진입");
		return "/user/join";

	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(/* @ModelAttribute */ UserVO vo) throws Exception {

		// 전달정보 저장(회원가입 정보)
		logger.debug("vo " + vo);

		// uService.userJoin(vo);
		logger.debug(" 회원가입 완료! ");

		// 로그인 페이지로 이동(redirect)
		return "redirect:/user/login";
	}

//   http://localhost:8088/user/login

	// 로그인 동작 메서드 생성 - 입력받는거 / 받은 거 처리

	// 로그인 GET (사용자가 정보를 입력받을 수 있게 만드는 페이지 생성)
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGET() {
		logger.debug(" loginGET() 호출 ");
		logger.debug(" 연결된 뷰페이지로 이동 ");

		return "/user/login";
	}

	// 로그인 POST (받은 거 가져가서 DB에서 확인하는 것)
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPOST(UserVO vo, HttpSession session) {
		logger.debug(" loginPOST() 호출 ");
		logger.debug(" 연결된 뷰페이지로 이동 ");
		// 전달정보 저장
		logger.debug(" vo : " + vo);
		logger.debug("@@@@@@@@@@@@@@" + vo);
		// 서비스 -> DAO (DB직접호출X)
		UserVO resultVO = uService.userLogin(vo);

		logger.debug(" resultVO : " + resultVO);

		// 로그인 처리 결과에 따른 페이지 이동
		if (resultVO == null) {
			// 로그인 실패 -> 로그인 페이지로 이동
			return "redirect:/user/login";
		}

		// 로그인 성공
		// 세션에 로그인 아이디를 저장
		session.setAttribute("id", resultVO.getUser_id());

		return "redirect:/user/userMain";
	}
	// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

// 메인페이지 호출
	@RequestMapping(value = "/userMain", method = RequestMethod.GET)
	public String mainGET() {
		logger.debug(" mainGET() 호출 ");
		// 패턴3 (처리동작, 화면출력)
		return "/user/userMain";
	}

	// 로그아웃 처리
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logoutGET(HttpSession session) {
		logger.debug(" logoutGET() 호출 ");

		// 로그아웃 처리 => 세션정보 초기화
		session.invalidate();
		// 메인페이지로 이동
		// redirect = 패턴2 (디비사용,화면이동)
		return "redirect:/user/userMain";
	}

//  http://localhost:8088/user/main
	// 회원정보 조회
	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String infoGET(HttpSession session, Model model) {

		logger.debug(" infoGET() 호출 ");
		// 사용자의 아이디정보 => 세션영역에 있는 정보 가져오기
		String id = (String) session.getAttribute("id");

		// 서비스 -> DB에 저장된 회원정보
		UserVO resultVO = uService.userInfo(id);

		// 연결된 뷰페이지에 출력=> 컨트롤러의 정보를 view페이지로 전달
		// Model객체를 사용
		model.addAttribute("vo", resultVO);

		return "/user/userInfo";
	}

//  http://localhost:8088/user/login
	// 회원정보 수정GET
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String updateGET(HttpSession session, Model model) {
		logger.debug(" updateGET() 호출 ");

		// 로그인한 회원 아이디조회
		String id = (String) session.getAttribute("id");

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
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(UserVO vo) {
		logger.debug(" updatePOST() 호출 ");
		// 수정할 정보를 저장(파라메터)
		logger.debug(" vo " + vo);

		// 서비스 -> DAO 회원정보 수정
		uService.userUpdate(vo);
		// 메인페이지로 이동
		return "redirect:/user/userMain";
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
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listGET(HttpSession session, Model model) {
		logger.debug(" listGET() ");
		// 관리자가 아닌경우 로그인페이지로 이동
		String id = (String) session.getAttribute("id");

		if (id == null || !id.equals("admin")) {
			return "redirect:/user/userMain";
		}
		// 서비스 -> DAO 회원목록 조회
		List<UserVO> userList = uService.userList();
		// memberList.add(dto); 리턴의 결과를 수정할 수 있다.
		// List로 전달된 회원정보를 view 페이지로 전달 출력
		// => Model 객체
		model.addAttribute("userList", userList);
		// model.addAllAttributes(attributeValues)
		// model.addAttribute("memberList", mService.memberList());

		return "/user/userList";
	}

	// 회원 등급 변경POST

	@RequestMapping(value = "/changeGrade", method = RequestMethod.POST)
	public String changeGradePOST(@ModelAttribute UserVO user) {
		logger.debug(" changeGradePOST() 호출 ");
		uService.updateUserGrade(user);
		return "redirect:/user/list";
	}

	// http://localhost:8088/user/login
	// 이메일

	// 아이디찾기
<<<<<<< Updated upstream
	@RequestMapping(value = "/findId")
	public String showFindIdPage() {
		return "/user/findId"; // 아이디 찾기 폼 뷰 페이지로 이동
	}

	@RequestMapping(value = "/findId", method = RequestMethod.POST)
	public String findUserId(@RequestParam("user_name") String user_name, @RequestParam("user_phone") String user_phone,
			Model model, HttpSession session) {
		UserVO user = userService.findUserByNameAndPhone(user_name, user_phone);

		if (user != null) {
			model.addAttribute("userId", user.getUser_id());
		} else {
			model.addAttribute("message", "일치하는 아이디를 찾을 수 없습니다.");
=======
		@RequestMapping(value = "/findId")
		public String showFindIdPage() {
			return "/user/findId"; // 아이디 찾기 폼 뷰 페이지로 이동
>>>>>>> Stashed changes
		}

		@RequestMapping(value = "/findId", method = RequestMethod.POST)
		public String findUserId(@RequestParam("user_name") String user_name, @RequestParam("user_phone") String user_phone,
				Model model, HttpSession session) {
			UserVO user = uService.findUserByNameAndPhone(user_name, user_phone);

<<<<<<< Updated upstream
	// 회원 상세 페이지로 이동

	@RequestMapping(value = "/userDetail", method = RequestMethod.GET)
	public String userDetail(String user_id, Model model) {
		logger.debug("@@@@@@@@@@@@@회원상세페이지이동");
		// userId를 사용하여 해당 유저의 정보를 가져옴
		UserVO user = userService.getUserById(user_id);

		// 가져온 정보를 모델에 추가하여 View로 전달
		model.addAttribute("user", user);

		// userDetail.jsp로 이동
		return "/user/userDetail";
	}

	// 수정후 페이지

	@RequestMapping(value = "/userDetail", method = RequestMethod.POST)
	public String userDetaill(UserVO vo, Model model) {
		logger.debug("@@@@@@@@@@@@@회원정보수정");
		userService.updateUser(vo);

		// userDetail.jsp로 이동
		return "redirect:/user/userDetail?user_id=" + vo.getUser_id();
	}
//회원삭제
	/* @RequestMapping(value = "/deleteUser/{user_id}", method = RequestMethod.GET)
	public String deleteUser(UserVO deleteVO, Model model) {
	    // 회원 삭제 서비스 호출
	    userService.deleteUser(deleteVO);
	    logger.debug(" 회원삭제 호출 !!!!!!!!!!!!!!!!!1");
	    // 회원 목록 페이지로 리다이렉트
	    return "redirect:/user/list";
	}*/
	

	
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
	}


=======
			if (user != null) {
				model.addAttribute("userId", user.getUser_id());
			} else {
				model.addAttribute("message", "일치하는 아이디를 찾을 수 없습니다.");
			}

			return "/user/findIdResult"; // 아이디 찾기 결과 뷰 페이지로 이동
		}
		
		
	//비번찾기
		@RequestMapping(value = "/findPassword")
		public String showFindPwPage() {
			return "/user/findPassword"; // 비번 찾기 폼 뷰 페이지로 이동
		}
		
		// 비밀번호 찾기 기능
		@RequestMapping(value = "/findPassword", method = RequestMethod.POST)
		public String findPassword(@RequestParam("user_name") String user_name,
		                           @RequestParam("user_id") String user_id,
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
		
		//새비번
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
>>>>>>> Stashed changes
