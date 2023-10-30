package com.project2.controller;

import java.lang.annotation.Inherited;
import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project2.persistence.TestDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"}
		)
public class DataSourceTest {
	
	private static final Logger logger = LoggerFactory.getLogger(DataSourceTest.class);
	
	@Inject
	private DataSource ds;
	
	@Autowired
	public TestDAO tdao;
	
//	@Test
	public void ds_test() {
		logger.debug("ds_test �떎�뻾 ");
		
		try {
			Connection con = ds.getConnection();
			logger.debug("con : " + con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void sql援щЦ�떎�뻾�뀒�뒪�듃() {
		logger.debug("sql 援щЦ �떎�뻾 �뀒�뒪�듃");
		
		logger.debug(tdao.getTime());
	}
	
}//DataSourceTest
