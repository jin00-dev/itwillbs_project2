package com.project2.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class mainController {

	private static final Logger logger = LoggerFactory.getLogger(mainController.class);
	
	
	//http://localhost:8088/home
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainGET() {

		return "/home";
	}
	
	
}
