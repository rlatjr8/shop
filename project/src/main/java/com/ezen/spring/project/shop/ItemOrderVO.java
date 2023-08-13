package com.ezen.spring.project.shop;

import java.util.List;

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
public class ItemOrderVO
{
	private int orderNum;
	private String goods;
	private String user;
	private int price;
	private int qty;
	private java.sql.Date orderdate;
}
