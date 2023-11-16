package com.project2.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.project2.domain.ExpVO;
import com.project2.domain.PaymentVO;
import com.project2.domain.ReportVO;
import com.project2.domain.RevVO;
import com.project2.domain.UserVO;
import com.project2.service.ExpServiceImpl;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/exp/*")
public class ExpController {

	private static final Logger logger = LoggerFactory.getLogger(ExpController.class);

	@Autowired
	private ExpServiceImpl service;

	// 클래스 상세페이지
	@GetMapping("/exp/info")
	public String infoGET(ExpVO vo, Model model, HttpSession session, HttpServletRequest req) {

		if (vo.getExp_num() == 0 || vo == null) {
			return "redirect:/";
		}
		
		int user_num = 0; 
		int wish = 0;
		
		if(session.getAttribute("user_num") != null) {
			user_num = Integer.parseInt( String.valueOf(session.getAttribute("user_num")));
			vo.setUser_num(user_num);
		}
		
		
		try {
			wish = service.getWishCnt(vo);
			UserVO userVO = service.getUserOne(user_num);
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
			
			if(userVO == null) userVO =new UserVO();
			
			model.addAttribute("wish",wish);
			model.addAttribute(userVO);
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

	// 리뷰 작성
	@PostMapping("/reviewInsert")
	public String insertRevGET(RevVO vo, HttpSession session, @RequestParam("rev_img_file") MultipartFile file,
			HttpServletRequest req, Model model, RedirectAttributes re) {
		logger.debug("리뷰작성 실행");

		if (session.getAttribute("user_id") == null) {
			re.addFlashAttribute("isRogin", false);
			return "redirect:/exp/info?exp_num=" + vo.getExp_num();
		}

		vo.setUser_num(Integer.parseInt((String) session.getAttribute("user_num")));

		try {
			String fileName = service.revFileUpload(file, req);
			vo.setRev_img(fileName);
			int result = service.insertReview(vo);

			if (result == 1) {
				re.addFlashAttribute("isWork", true);
				return "redirect:/exp/info?exp_num=" + vo.getExp_num();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		re.addFlashAttribute("isWork", false);
		return "redirect:/exp/info?exp_num=" + vo.getExp_num();
	}

	// 리뷰 수정
	@PostMapping("/revUpdate")
	public String reviewUpdate(RevVO vo, HttpSession session, RedirectAttributes re) {

		if (session.getAttribute("user_id") == null) {
			re.addFlashAttribute("isRogin", false);
			return "redirect:/exp/info?exp_num=" + vo.getExp_num();
		}

		vo.setUser_num(Integer.parseInt((String) session.getAttribute("user_num")));

		try {
			int result = service.updateReview(vo);

			if (result == 1) {
				return "redirect:/exp/info?exp_num=" + vo.getExp_num();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/exp/info?exp_num=" + vo.getExp_num();
	}

	// 리뷰 신고 작성
	@PostMapping("/revReport")
	public String insertReport(ReportVO vo, HttpSession session, RedirectAttributes re) {

		if (session.getAttribute("user_id") == null) {
			re.addFlashAttribute("isRogin", false);
			return "redirect:/exp/info?exp_num=" + vo.getExp_num();
		}

		// 신고자
		vo.setReport_user_num(Integer.parseInt((String) session.getAttribute("user_num")));

		try {
			// 신고 당하는 사람
			vo.setUser_num(service.getRevUserNum(vo.getRev_num()));

			// 신고 게시판 작성
			int result = service.insertReport(vo);

			if (result == 1) {
				re.addFlashAttribute("isWork", true);
				return "redirect:/exp/info?exp_num=" + vo.getExp_num();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		re.addFlashAttribute("isWork", false);
		return "redirect:/exp/info?exp_num=" + vo.getExp_num();
	}

	// 리뷰 삭제
	@GetMapping("/revDel")
	public String deleteReview(RevVO vo, HttpSession session, RedirectAttributes re) {

		if (session.getAttribute("user_id") == null) {
			re.addFlashAttribute("isRogin", false);
			return "redirect:/exp/info?exp_num=" + vo.getExp_num();
		}

		vo.setUser_num(Integer.parseInt((String) session.getAttribute("user_num")));

		try {
			int result = service.deleteReview(vo);

			if (result == 1) {
				re.addFlashAttribute("isWork", true);
				return "redirect:/exp/info?exp_num=" + vo.getExp_num();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		re.addFlashAttribute("isWork", false);
		return "redirect:/exp/info?exp_num=" + vo.getExp_num();
	}

	// 결제 처리
	@PostMapping("/payment")
	@ResponseBody
	public boolean payment(PaymentVO vo, HttpSession session) {
		int result;

		try {
			result = service.paymentInsert(vo);

			if (result == 1)
				return true;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	// 내 주변 체험
	@GetMapping("/myLocation")
	public String myLocationGET(Model model) {
		try {
			List<ExpVO> list = service.getExpList();

			// Gson 객체 생성
			Gson gson = new Gson();

			// List<ExpVO>를 JSON 문자열로 변환
			String json = gson.toJson(list);

			model.addAttribute("list", json);
			model.addAttribute("region", "");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/exp/myLocation";
	}

	// 파일(썸네일) 다운로드 처리
	@RequestMapping(value = "/thumbDownload", method = RequestMethod.GET)
	public void fileThumbDownloadGET(@RequestParam("fileName") String fileName, @RequestParam("wid") int wid,
			@RequestParam("hei") int hei, HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug(" fileThumbDownloadGET() 호출 ");

		// 다운로드할 폴더 (= 업로드한 폴더)에 있는 파일정보
		String downFile = request.getRealPath("\\upload\\rev") + "\\" + fileName;
		logger.debug(" 다운로드할 파일 : " + downFile);

		// 다운로드할 파일을 준비
		File file = new File(downFile);

		// 업로드했던(다운로드할) 파일의 확장자 확인
		// "itwill.jpg"
		int lastIdx = fileName.lastIndexOf(".");
		// 파일의 확장자를 제외한 이름을 저장
		String thumbName = fileName.substring(0, lastIdx);

		// 파일명이 한글일때 인코딩문제 해결
		// thumbName = URLEncoder.encode(thumbName,"UTF-8");
		// 출력객체
		OutputStream out = response.getOutputStream();

		// File thumbNail = new File(request.getRealPath("\\upload\\rev") +
		// "\\thumbnail\\" + thumbName + ".png");

		if (file.exists()) {
			// 썸네일 폴더 생성
			// thumbNail.getParentFile().mkdirs();
			// 썸네일 파일 생성
			// Thumbnails.of(file).size(50, 50).outputFormat("png").toFile(thumbNail);
			Thumbnails.of(file).size(wid, hei).outputFormat("png").toOutputStream(out);
		}

		// 파일 전송(썸네일 이미지 출력)

		// 파일 읽기 객체
//				FileInputStream fis = new FileInputStream(thumbNail);
//				
//				byte[] buffer = new byte[1024*8];
//				int data = 0;
//				while( (data = fis.read(buffer)) != -1) { //파일이 끝날때까지 파일읽기
//					out.write(buffer,0,data);
//				}

		// 자원해제
		out.close();
//				fis.close();

	}

	// 찜목록
	@GetMapping("/wishList")
	public String wishList(HttpSession session, Model model) {
		logger.debug("찜목록 호출");
		
		String user_id = (String)session.getAttribute("user_id");
		int user_num=0;
		
		if(user_id == null) {
			return "redirect:/user/login";
		}
		
		if(session.getAttribute("user_num") != null)
			user_num = 
				Integer.parseInt(String.valueOf( session.getAttribute("user_num")));
		
		try {
			model.addAttribute("list", service.getWishList(user_num));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/exp/wishList";
	}
	
	//찜 등록 삭제
	 @PostMapping("/chooseWishBtn")
	 @ResponseBody
	 public String choose(@RequestParam("exp_num") int exp_num, HttpSession session) {
		 logger.debug("찜버튼 클릭");
		 
		 int user_num = 0;
		 int result = -1;
		 
		 if(session.getAttribute("user_num") != null) {
			 user_num=
					 Integer.parseInt(String.valueOf( session.getAttribute("user_num")));
		 }
		 
		 ExpVO vo = new ExpVO();
		 
		 logger.debug("유저번호 : "+user_num);
		 logger.debug("체험번호 : "+exp_num);
		 
		 vo.setUser_num(user_num);
		 vo.setExp_num(exp_num);
		 
		 try {
			result = service.getWishCnt(vo);
			logger.debug("리절트 : "+result);
			if(result ==0 && user_num != 0) {
				//찜 안함(insert)
				service.insertWish(vo);
			}else if(result !=0 && user_num != 0) {
				//찜 했음(delete)
				service.deleteCnt(vo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
		 
		 return "success";
	 }
	
	
	

}// controller
