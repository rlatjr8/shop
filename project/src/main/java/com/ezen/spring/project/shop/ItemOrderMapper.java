package com.ezen.spring.project.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface ItemOrderMapper 
{
	public boolean addOrder(ItemOrderVO order);
	public List<ItemOrderVO> getList(String uid);
	public List<ItemOrderVO> getOrder(ItemOrderVO order);
	public ItemOrderVO getGoods(String goods);
}
