package com.project2.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/mail/*")
public class MailController {
	@Autowired
	private JavaMailSender mailSender;
	
	private static final Logger logger = LoggerFactory.getLogger(MailController.class);
    
	//----------------------------메일발송 JSP 로 이동------------------------
	@RequestMapping(value = "/mailSend", method = RequestMethod.GET)
	public void getMailSend() {
		logger.info("메일발송 JSP진입");
	}
	
	//--------------------------------메일발송-----------------------------
	//mailSend 코드
	@RequestMapping(value = "/mailSend", method = RequestMethod.POST)
	public String mailSend(HttpServletRequest request,String email) {
		//난수 생성(인증번호)
				Random r = new Random();
				int num = r.nextInt(888888) + 111111;  //111111 ~ 999999
				System.out.println("인증번호:" + num);
				
				/* 이메일 보내기 */
		        String setFrom = "shareverni@gmail.com"; //보내는 이메일
		        String toMail = email; //받는 사람 이메일
		        String title = "회원가입 인증 이메일 입니다.";
		        String content = 
		                "share verni 홈페이지를 방문해주셔서 감사합니다." +
		                "<br><br>" + 
		                "인증 번호는 " + num + "입니다." + 
		                "<br>" + 
		                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		        
		        try {
		            
		            MimeMessage message = mailSender.createMimeMessage();
		            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		            helper.setFrom(setFrom);
		            helper.setTo(toMail);
		            helper.setSubject(title);
		            helper.setText(content,true);
		            mailSender.send(message);
		            
		        }catch(Exception e) {
		            e.printStackTrace();
		        }
		        
		        String rnum = Integer.toString(num);  //view로 다시 반환할 때 String만 가능
		        
		        return rnum;
		 
				
			}
		}
		 
