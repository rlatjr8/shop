package com.ezen.spring.project.shop;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
@EqualsAndHashCode
public class CouponVO
{
	private int couponNum;
	private String couponName;
	private int discount;
	private java.sql.Date expirydate; 
}
