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
import com.project2.service.ExpServiceImpl;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	private ExpServiceImpl service;
	
	//메인페이지 -------------------------------------
	//http://localhost:8088/

	@GetMapping("/")
	public String mainGET(Model model,
			String category,String region1,String region2, String sort, Criteria cri) throws Exception{
		ExpVO vo = new ExpVO();
		
		//category exp_category
		//region exp_region,exp_name
		//sort exp_ad_state 1(cnt), 2(star), 3(price desc), 4(price asc)
		
		if(category == null || category == "") {
			vo.setExp_category("공예");
		}else {
			vo.setExp_category(category);
		}
		
		if(sort == null || sort =="") {
			sort = "star";
		}
		
		if(region1 == null || region2 == null || region1 == "" || region2 =="") {
			vo.setExp_region("전체");
			vo.setExp_name("");
		}else {
			vo.setExp_region(region1);
			vo.setExp_name(region2);
		}
		
		switch(sort){
		case "star":
			vo.setExp_ad_state("avg(r.rev_star) desc");
			break;
		case "priceDesc":
			vo.setExp_ad_state("e.exp_price desc");
			break;
		case "priceAsc":
			vo.setExp_ad_state("e.exp_price");
			break;
		}
		
		
		logger.debug("@@@@@@@@@@@@@"+ vo);
		List<ExpVO> list = service.getExpList(vo);
		
		model.addAttribute("list", list);
		
		return "/home";
	}
	
	
	
	
	
}//controller

