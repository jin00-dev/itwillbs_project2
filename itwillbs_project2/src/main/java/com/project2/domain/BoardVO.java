package com.project2.domain;

import java.sql.Timestamp;


import org.springframework.web.multipart.MultipartFile;


import lombok.Data;

@Data
public class BoardVO {


	private int enf_category;
    private int enf_event_num;
    private int enf_notice_num;
    private String enf_title;
    private String enf_content;
    private int enf_faq_num;
    private Timestamp enf_regdate; 
    private Timestamp enf_updatedate;
    private int enf_event_type; 
    private String enf_img;
    private int enf_viewcnt;
    
    public void setEnfNoticeNum(int enf_notice_num) {
        this.enf_notice_num = enf_notice_num;
    }

    private MultipartFile file;
	

}
