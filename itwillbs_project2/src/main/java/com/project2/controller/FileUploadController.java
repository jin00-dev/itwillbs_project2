package com.project2.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileUploadController {

	private static final Logger logger = LoggerFactory.getLogger(FileUploadController.class);

	// 파일업로드 페이지열기
	@RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
	public void uploadForm() throws Exception {
		logger.debug(" uploadForm() 호출 ->뷰페이지 연결");

	}

	// 파일 업로드 처리
	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	public /* ModelAndView */ String fileUploadPOST(MultipartHttpServletRequest multiRequest,
			HttpServletResponse response, Model model) throws Exception {
		logger.debug(" fileUploadPOST() 실행 ");

		multiRequest.setCharacterEncoding("UTF-8");
		// 1. 전달정보(파라메터) 저장
		Map paramMap = new HashMap();
		// multiRequest.getParameter(name);

		Enumeration enu = multiRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			logger.debug(" name : 	" + name);
			String value = multiRequest.getParameter(name);
			logger.debug(" value : 	" + value);
			// 모든 파라메터정보를 map 저장
			paramMap.put(name, value);
		}
		logger.debug(" " + paramMap);

		// 2. 파일 업로드 처리
		List<String> fileList = fileProcess(multiRequest);

		paramMap.put("fileList", fileList);

		model.addAttribute("paramMap", paramMap);

		return "/result";
	}// fileUploadPOST

	// 파일 업로드 처리 메서드
	private List<String> fileProcess(MultipartHttpServletRequest multiRequest) throws Exception {
		logger.debug(" fileProcess() - 파일업로드 처리 시작");

		// 업로드한 파일의 정보를 저장하는 리스트
		List<String> fileList = new ArrayList<String>();
		// form태그-input/file태그의 이름 정보 모두를 가져오기
		Iterator<String> fileNames = multiRequest.getFileNames();
		while (fileNames.hasNext()) {
			// form태그-input/file태그의 이름 정보
			String fileName = fileNames.next();
			logger.debug(" fileName : " + fileName);

			// 업로드한 파일을 임시 저장
			MultipartFile mFile = multiRequest.getFile(fileName);
			// 임시저장된 파일의 원본이름을 리스트에 저장
			String oFileName = mFile.getOriginalFilename();
			fileList.add(oFileName);

			// 업로드 저장경로 생성 /WEB-INF/upload (가상경로)
			// 임시저장된 파일을 생성하기 위한 준비 (실제파일 생성)
			// File file = new File("D:\\springupload2\\"+fileName);
			File file = new File(multiRequest.getRealPath("\\upload") + "\\" + fileName);
			logger.debug(" realPath : " + multiRequest.getRealPath("\\upload"));
			if (mFile.getSize() != 0) { // 첨부파일(업로드한 임시파일)이 존재할때 진행
				if (!file.exists()) { // 해당파일이 존재하는지 체크
					// 해당경로에 파일이 없을경우,자동으로 폴더 생성후 진행
					if (file.getParentFile().mkdirs()) {
						file.createNewFile();
						file.delete();
						logger.debug(" 임시파일 생성완료-삭제 (첨부파일 폴더생성)! ");
					}
				}
				// 임시로 생성된(저장된) 파일mFile -> 실제파일로 데이터 전송
				// mFile.transferTo(new File("D:\\springupload2\\"+oFileName));
				mFile.transferTo(new File(multiRequest.getRealPath("\\upload") + "\\" + oFileName));
			}
			logger.debug(" 파일 업로드 성공! ");

		} // while
		logger.debug(" fileList : " + fileList);

		logger.debug(" fileProcess() - 파일업로드 처리 끝");

		return fileList;
	}
	// 파일 업로드 처리 메서드
	
	// 파일 다운로드 처리
		@RequestMapping(value = "/download",method = RequestMethod.GET)
		public void fileDownloadGET(@RequestParam("fileName") String fileName,
				                    HttpServletRequest request,
				                    HttpServletResponse response) throws Exception{
			logger.debug(" fileDownloadGET() 호출 ");
			
			// 다운로드할 폴더 (= 업로드한 폴더)에 있는 파일정보
			String downFile = request.getRealPath("\\upload")+"\\"+fileName;
			logger.debug(" 다운로드할 파일 : "+downFile);
			
			// 다운로드할 파일을 준비
			File file = new File(downFile);
			
			// 파일명이 한글일때 인코딩문제 해결
			fileName = URLEncoder.encode(fileName,"UTF-8");
			
			// 다운로드 정보를 응답설정 
			// => 모든 파일이 일반적인 다운로드형태로 표시
			response.setHeader("Cache-Control", "no-cache");
			response.addHeader("Content-disposition", "attachment; fileName="+fileName);
			
			// 파일 전송(다운로드 처리)
			// 출력객체
			OutputStream out = response.getOutputStream();
			// 파일 읽기 객체
			FileInputStream fis = new FileInputStream(file);
			
			byte[] buffer = new byte[1024*8];
			int data = 0;
			while( (data = fis.read(buffer)) != -1) { //파일이 끝날때까지 파일읽기
				out.write(buffer,0,data);
			}
		
			//자원해제 
		    out.close();
			fis.close();
			
		}
	

}// controller
