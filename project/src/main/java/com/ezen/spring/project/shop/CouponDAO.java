package com.ezen.spring.project.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class CouponDAO
{
	@Autowired
	private CouponMapper couponMapper;
}
