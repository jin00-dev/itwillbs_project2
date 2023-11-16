package com.project2.domain;

import lombok.Data;

@Data
public class PageVO {
	
	private int totalCount; // 총 글의 수
	private int startPage;
	private int endPage;
	private boolean preview; // 이전
	private boolean next; // 다음
	
	private int displayPageNum = 10; // 페이지 블럭의 크기
	
	private Criteria cri; // 페이지 정보, 페이지 사이즈 저장 객체

	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPageData();
	}
	
	
	public void calcPageData() {
		endPage 
		= (int)(Math.ceil(cri.getPage()/(double)displayPageNum) * displayPageNum);
		
		startPage
		= (endPage - displayPageNum) + 1;
		
		int tmpEndPage
		= (int)(Math.ceil(totalCount/(double)cri.getPageSize()));
		
		if(endPage > tmpEndPage) {
			endPage = tmpEndPage;
		}
		
		preview = startPage != 1;
		
		next = endPage * cri.getPageSize() < totalCount;
		
		System.out.println(startPage + endPage + "@@@@@@@@@@@@@@@@@@@@@@");
	}
	

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPreview() {
		return preview;
	}

	public void setPreview(boolean preview) {
		this.preview = preview;

	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}


	
	
	
	

}

