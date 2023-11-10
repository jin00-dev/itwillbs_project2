package com.project2.persistence;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project2.domain.PaymentVO;


@Repository(value = "rsrvPayDAO")
public class RsrvPayDAOImpl {
	private static final Logger logger = LoggerFactory.getLogger(RsrvPayDAOImpl.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	String NAMESPACE = "com.project2.mapper.ExpMapper";

/*	public String makeP_no() throws Exception {
		logger.info("dao - makiP_no 호출 ");
	    String orderNo = null;
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	    String today = dateFormat.format(new Date());
	    String lastOrderNo = sqlSession.selectOne(NAMESPACE+".lastP_no");
	    
	    logger.info("dao - makiP_no 쿼리 실행 ");
	    if (lastOrderNo != null && lastOrderNo.startsWith(today)) {
	        int lastNo = Integer.parseInt(lastOrderNo.substring(8));
	        orderNo = today + String.format("%03d", lastNo + 1);
	    } else {
	        orderNo = today + "001";
	    }
	    
	    logger.info("주문번호 "+orderNo);
	    return orderNo;		
	}*/

//	public void insertPaymentInfo(PayDTO pdto) throws Exception {
//		logger.info("dao.insertPay() 실행");
//		logger.info(pdto+"");
//		sqlSession.insert(NAMESPACE+".insertPay",pdto);
//	}

	public Integer updatePaymentInfo(PaymentVO rvo) throws Exception {
		logger.debug("@@@@@@@@@@rvo: "+rvo);
		return sqlSession.update(NAMESPACE+".updatePay",rvo);
	}

//	public Integer selectPrice(String p_no) throws Exception {
//		Integer price = sqlSession.selectOne(NAMESPACE+".selectPrice",p_no);
//		logger.info("daoPrice"+price);
//		return price;
//	}
	
	public PaymentVO selectPayInfo(int order_num) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".selectPay",order_num);
	}

//	public Integer modifyOrder(int order_num) throws Exception {
//		int cnt = 0;
//		
//		PaymentVO rvo = sqlSession.selectOne(NAMESPACE+".selectPay",order_num);
//		logger.info("rvo : " + rvo);
//		if(rvo.getStatus().equals("cancelled")) {
//			rvo.setP_peoplenum(rvo.getP_peoplenum()*(-1));
//			rvo.setP_subs(rvo.getP_subs()*(-1));
//			rvo.setP_usedpoint(rvo.getP_usedpoint()*(-1));
//		}
		
//		if(Math.abs(rvo.getP_peoplenum())>0) {
//		logger.info("peoplenum"+rvo.getP_peoplenum());
//		cnt += sqlSession.update(NAMESPACE+".updateT_rem_p", rvo);
//		logger.info("t_rem_p 완료"+cnt);
//		}
//		if(Math.abs(rvo.getP_usedpoint())>0) {
//			cnt += sqlSession.update(NAMESPACE+".updatePoint", rvo);
//			logger.info("point 완료"+cnt);
//		}
//		if(Math.abs(rvo.getP_subs())==1) {
//			cnt += sqlSession.update(NAMESPACE+".updateS_cnt", rvo);
//		}
		
//		logger.info("cnt(실행된 sql 개수) : "+cnt);
		
//		return cnt;
//	}
//
	
	
}
