package com.project2.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project2.domain.ExpVO;
import com.project2.domain.RevVO;
import com.project2.service.ExpService;

@Controller
@RequestMapping("/exp/*")
public class ExpController {

	private static final Logger logger = LoggerFactory.getLogger(ExpController.class);

	@Autowired
	private ExpService service;

	@GetMapping("/exp/info")
	public String infoGET(ExpVO vo, Model model) {
		try {
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
			
			model.addAttribute("rList", rList);
			model.addAttribute("ratings", ratings);
			model.addAttribute("avgStar", avgStar);
		} catch (

		Exception e) {
			e.printStackTrace();
		}

		return "/exp/info";
	}

}// controller
