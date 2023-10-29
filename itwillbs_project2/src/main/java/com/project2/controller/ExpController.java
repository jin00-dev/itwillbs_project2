package com.project2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project2.domain.ExpVO;
import com.project2.service.ExpService;

@Controller
@RequestMapping("/exp/*")
public class ExpController {
	
	private static final Logger logger = LoggerFactory.getLogger(ExpController.class);
	
	@Autowired
	private ExpService service;
	
	//회원가입 -------------------------------------
	@GetMapping("/expMain")
	public String mainGET(Model model) {
		
		List<ExpVO> list = service.getExpList();
		
		model.addAttribute("list", list);
		
		return "/home";
	}
	
	
	
	
	
	
}//controller
