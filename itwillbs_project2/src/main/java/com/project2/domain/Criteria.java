package com.project2.domain;

//페이징 처리 기준 정보 저장

public class Criteria {
	
	private int page;
	private int pageSize;
	
	public Criteria() {
		this.page = 1;
		this.pageSize = 10;
	}
	//-------set-----------------------------------------------
	public void setPage(int page) {
		if(page <=0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPageSize(int pageSize) {
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
		}
		
		this.pageSize = pageSize;
	}
	// -------get----------------------------------------------
	public int getPageStart() {
		return (this.page -1) * this.pageSize;
	}
	
	public int getPage() {
		return page;
	}

	public int getPageSize() {
		return pageSize;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageSize=" + pageSize + "]";
	}

	
	
	
}
