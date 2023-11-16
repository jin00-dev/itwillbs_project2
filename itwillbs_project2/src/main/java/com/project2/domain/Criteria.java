package com.project2.domain;


public class Criteria {
	
	private int page;
	private int pageSize;
	
	private String user_id;
	private int user_num;
	private int order_num;
	
	
	
	
	public int getOrder_num() {
		return order_num;
	}



	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public int getUser_num() {
		return user_num;
	}



	public void setUser_num(int user_num) {
		this.user_num = user_num;
	}




	public Criteria() {
		this.page = 1;
		this.pageSize = 10;
	}


	public void setPage(int page) {
		if (page <= 0) {

			this.page = 1;
			return;
		}
		this.page = page;
	}

	public void setPageSize(int pageSize) {
		if (pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
			return;
		}

		this.pageSize = pageSize;

	}

	// 변수를 저장하기위한 목적 아님
	// mapper에서 호출되는 메서드 # {pageStart}을 호출함
	public int getPageStart() {
		// 출력문 (필요에 따라)
		return (this.page - 1) * pageSize;
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
