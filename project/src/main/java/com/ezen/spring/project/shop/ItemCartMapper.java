package com.ezen.spring.project.shop;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface ItemCartMapper 
{
	public int addCart(ItemCartVO cart);
	public ItemCartVO getCart(int cartNum);
	public List<ItemCartVO> getList(String uid);
	public int update(ItemCartVO cart);
	public int delete(int cartNum);
	public int clear(String user);
	public ItemCartVO findCartByUserAndGoods(ItemCartVO qtycart);
	public List<ItemCartVO> del(List<ItemCartVO> c);
	public List<Map<String, String>> search(String category, String keyword);
	public List<Map<String, String>> getList2(String uid);
}