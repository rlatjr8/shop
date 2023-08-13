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
public class ItemVO 
{
	private int itemNum;
	private String goods;
	private int price;
	private int purchaseCnt;
	private int cartCnt;
	private String category;
	private String explain;
	
	List<ItemAttachVO> itemattList;
	
}
