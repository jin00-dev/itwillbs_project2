package com.project2.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project2.domain.ExpVO;
import com.project2.domain.ReportVO;
import com.project2.domain.RevVO;
import com.project2.domain.UserVO;
import com.project2.service.ExpServiceImpl;

@Controller
@RequestMapping("/exp/*")
public class ExpController {

	private static final Logger logger = LoggerFactory.getLogger(ExpController.class);

	@Autowired
	private ExpServiceImpl service;

	//클래스 상세페이지
	@GetMapping("/exp/info")
	public String infoGET(ExpVO vo, Model model, HttpSession session) {
		
		if(vo.getExp_num() == 0) {
			return "redirect:/";
		}
		
		
		try {
			if(session.getAttribute("user_num") !=null) {
				UserVO uVo =service.getUserOne(Integer.parseInt( (String) session.getAttribute("user_num") ));
				model.addAttribute(uVo);
			}
			ExpVO expOne = service.getExpOne(vo.getExp_num());
			List<RevVO> rList = service.getExpRevList(vo.getExp_num());
			double avgStar = service.getExpRevAvg(vo.getExp_num());

			int[] ratings = new int[5];

			for (int i = 0; i < ratings.length; i++) {
				ratings[i] = 0;
			}

			for (RevVO i : rList) {
				switch (i.getRev_star()) {
				case 1:
					ratings[0] += 1;
					break;
				case 2:
					ratings[1] += 1;
					break;
				case 3:
					ratings[2] += 1;
					break;
				case 4:
					ratings[3] += 1;
					break;
				case 5:
					ratings[4] += 1;
					break;
				}
			}
			
			model.addAttribute(expOne);
			model.addAttribute("rList", rList);
			model.addAttribute("ratings", ratings);
			model.addAttribute("avgStar", avgStar);
		} catch (

		Exception e) {
			e.printStackTrace();
		}

		return "/exp/info";
	}
	
	//리뷰 작성
	@PostMapping("/reviewInsert")
	public String insertRevGET(RevVO vo, HttpSession session,Model model, RedirectAttributes re) {
		logger.debug("리뷰작성 실행");
		
		if(session.getAttribute("user_id") == null){
			re.addFlashAttribute("isInsertReview", false);
			return "redirect:/exp/info?exp_num="+vo.getExp_num();
		}
		
		vo.setUser_num(Integer.parseInt( (String) session.getAttribute("user_num") ));
		
		try {
			int result = service.insertReview(vo);
			
			if(result ==1 ) {
				re.addFlashAttribute("isInsertReview", true);
				return "redirect:/exp/info?exp_num="+vo.getExp_num();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		re.addFlashAttribute("isInsertReview", false);
		return "redirect:/exp/info?exp_num="+vo.getExp_num();
	}
	
	//리뷰 신고 작성
	@PostMapping("/revReport")
	public String insertReport(ReportVO vo, HttpSession session, RedirectAttributes re) {
		//신고자
		vo.setReport_user_num(Integer.parseInt( (String) session.getAttribute("user_num") ));
		
		try {
			//신고 당하는 사람
			vo.setUser_num(service.getRevUserNum(vo.getRev_num()));
			
			//신고 게시판 작성
			int result = service.insertReport(vo);
			
			if(result ==1 ) {
				re.addFlashAttribute("isInsertReport", true);
				return "redirect:/exp/info?exp_num="+vo.getExp_num();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		re.addFlashAttribute("isInsertReport", false);
		return "redirect:/exp/info?exp_num="+vo.getExp_num();
	}
	
	
	
	
	

}// controller
