package com.project2.controller;

import java.util.HashMap;
import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project2.service.UserService;

@RestController
@RequestMapping(value="/user/*")
public class RestUserController {
	/*
	 * private final HashMap<String, Object> data = new HashMap<>();
	 * 
	 * 
	 * @Inject private UserService uService;
	 * 
	 * @Autowired private JavaMailSender javaMailSender;
	 */
	
	// 아이디 중복체크
//	@PostMapping(value="phoneCheck")
//	public HashMap<String, Object> isExistId(String user_id){
//	HashMap<String, Object> data = new HashMap<String, Object>();
//	
//	boolean exist = uService.phoneCheck(user_id);
	
//	if(exist) {
//		data.put("result","fail");
//	} else {
//		data.put("result","success");
//	}
//	
//	return data;
//	}
//	
	// 이메일 유효성 검사
	/*
	 * @PostMapping(value="checkEmail") public HashMap<String, Object>
	 * checkEmail(String user_id){ HashMap<String, Object> data = new
	 * HashMap<String, Object>();
	 * 
	 * Random random = new Random(); int checkNum = random.nextInt(888888) + 111111;
	 * 
	 * // 메일 제목, 내용 String subject = "회원가입 인증 메일입니다."; String content =
	 * "홈페이지를 방문해주셔서 감사합니다." + "인증 번호는  "+ checkNum + " 입니다." + "\r\n" +
	 * "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
	 * 
	 * // 보내는 사람 String from = "kimseo131612@gmail.com";
	 * 
	 * try { // 메일 내용 넣을 객체와, 이를 도와주는 Helper 객체 생성 MimeMessage mail =
	 * javaMailSender.createMimeMessage(); MimeMessageHelper mailHelper = new
	 * MimeMessageHelper(mail, "UTF-8");
	 * 
	 * // 메일 내용을 채워줌 mailHelper.setFrom(from, "관리자"); //보내는사람
	 * mailHelper.setTo(user_id); //받는사람 mailHelper.setSubject(subject);
	 * mailHelper.setText(content);
	 * 
	 * // 메일 전송 javaMailSender.send(mail);
	 * 
	 * } catch(Exception e) { e.printStackTrace(); }
	 * 
	 * data.put("code", checkNum);
	 * 
	 * return data; }
	 */
}
