package com.project2.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project2.domain.Criteria;
import com.project2.domain.ExpVO;
import com.project2.service.ExpService;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private ExpService service;
	
	//메인페이지 -------------------------------------
	@GetMapping("/")
	public String mainGET(Model model,ExpVO vo, Criteria cri) throws Exception{
		if(vo.getExp_category() == null) {
			vo.setExp_category("공예");
			vo.setExp_region("전체");
		}
		
		logger.debug("@@@@@@@@@@@@@"+ vo);
		List<ExpVO> list = service.getExpList(vo);
		
		model.addAttribute("list", list);
		
		return "/home";
	}
	
	
	
	
	
	
}//controller
