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
	public String mainGET(Model model,
			String category,String region1,String region2, String sort, Criteria cri) throws Exception{
		ExpVO vo = new ExpVO();
		
		//category exp_category
		//region exp_region,exp_name
		//sort exp_ad_state 1(cnt), 2(star), 3(price desc), 4(price asc)
		
		if(category == null) {
			vo.setExp_category("공예");
			vo.setExp_region("전체");
		}else {
			vo.setExp_category(category);
		}
		
		if(sort == null) {
			vo.setExp_ad_state("cnt");
		}else {
			vo.setExp_ad_state(sort);
		}
		
		if(region1 != null && region2 != null) {
			vo.setExp_region(region1);
			vo.setExp_name(region2);
		}
		
		
		logger.debug("@@@@@@@@@@@@@"+ vo);
		List<ExpVO> list = service.getExpList(vo);
		
		model.addAttribute("list", list);
		
		return "/home";
	}
	
	
	
	
	
	
}//controller
