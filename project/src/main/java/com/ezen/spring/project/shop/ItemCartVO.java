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
public class ItemCartVO
{ 
	private int cartNum;
	private String goods;
	private int price;
	private int qty;
	private String user;
}
