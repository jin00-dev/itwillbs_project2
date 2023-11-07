package com.project2.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class UserVO {
   
   private Integer user_num;
   private String user_id;
   private String user_pw;
   private String user_name;
   private String user_phone;
   private Timestamp user_regdate;
   private Timestamp user_last_access;
   private Integer user_type;
   private Integer user_report_state;
   private Integer user_delete_state;
   
   
   
   
   

}