package com.project2.domain;

import lombok.Data;

/**
 *	페이징처리 (+페이지 블럭)
 *
 *  
 *  ex) 총 : 122개 / 페이지당 10개씩 출력
 *     => 페이지수 13  / displayPageNum = 10; 
 *  
 *  			startPage	endPage		prev	next
 * (3페이지) 		1			10		 X		  O	
 * (10페이지)	    1			10	     X		  O
 * (12페이지)       11			20->13   O		  X
 * 
 *  endPage =  (int)(Math.ceil(page/(double)displayPageNum)*displayPageNum);
 *  
 *  만약  endPage / 필요한 총페이지수를 비교하여 endPage가 더 클때
 *   필요한 총 페이지수를 endPage로 설정
 *  
 *  startPage = (endPage - displayPageNum) + 1;
 *  
 *  prev = startPage == 1? false:true;
 *  prev = startPage != 1;
 *  
 *  next = endPage * pageSize >= totalCount? false : true;
 *  next = endPage * pageSize < totalCount;
 *  
 *  totalCount => DB조회 select count()
 *  
 * 
 * 
 */
@Data
public class PageVO {

	private int totalCount;		// 총 글의 수
	private int startPage;		// 페이지 블럭 시작 번호
	private int endPage;		// 페이지 블럭 끝 번호
	private boolean prev;		// 이전
	private boolean next;		// 다음
	
	private int displayPageNum = 10;	//  페이지블럭의 크기
	
//	private int page;
//	private int pageSize;
	private Criteria cri;		// 페이지 정보, 사이즈 저장객체
	
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcPageData();
	}
	
	
	// 페이징처리에 필요한 정보를 계산하는 메서드
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
		
		
		prev = startPage != 1;
		
		next = endPage * cri.getPageSize() < totalCount;
		
	} // calcPageData
	
	
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

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
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