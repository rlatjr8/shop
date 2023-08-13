package com.ezen.spring.project.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Coupon")
public class CouponController 
{
	@Autowired
	private CouponDAO couponDAO;
	
	@GetMapping("/")
	public String index()
	{
		return "shop/Couponindex";
	}
}
