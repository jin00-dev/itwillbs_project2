package com.project2.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailSendService {

	private static final Logger logger = LoggerFactory.getLogger(MailSendService.class);

	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNum;
	
	// 인증번호 랜덤 생성 ( 범위 : 111111~999999)
	public void makeAuthNumber() {
		Random r = new Random();
		int checkNum = r.nextInt(888888)+111111;
		logger.debug("인증 번호 : " + checkNum);
		authNum = checkNum;
	}// makeAuthNumber
	
	public String joinEmail(String email) {
		makeAuthNumber();
		String setForm = "parkyeojin1995@gmail.com"; // 보내는 이메일 
		String toMail = email; // 받는 메일..?
		String title = "세모클래스 회원가입 인증 이메일 입니다."; // 이메일 제목 
		String content = "세상의 모든 클래스, 세모클래스에 방문을 환영합니다."
						+ "<br>"
						+ "인증번호는 " + authNum + "입니다."
						+ "<br>"
						+ "해당 인증번호를 입력란에 기입하여주십시오"; // 이메일 내용
		logger.debug("@@@@@ toMail : " + toMail);
		logger.debug("@@@@@ content : " + content);
		
		mailSend(setForm, toMail, title, content);
		return Integer.toString(authNum);
	}// joinEmail(String email)
	
	// 이메일 전송 메서드 
	public void mailSend(String setForm, String toMail, String title, String content) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setFrom(setForm);//보낼 메일주소
			helper.setTo(toMail);// 받는 메일 주소
			helper.setSubject(title);//제목
			helper.setText(content,true); // 내용 전달, html 형식으로 전송 (true) 
			mailSender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}//MailSendService
