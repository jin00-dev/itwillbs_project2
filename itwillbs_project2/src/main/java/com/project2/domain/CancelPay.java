package com.project2.domain;

import lombok.Data;

@Data
public class CancelPay {
	private String merchant_uid; // 주문번호
	private int cancel_request_amount; // 환불금액
	private String reason; // 환불사유
	private String refundHolder; // 환불 수령계좌 예금주
	private String refundBank; // 환불 수령계좌 은행코드
	private String refundAccount; // 환불 수령계좌 번호
}
