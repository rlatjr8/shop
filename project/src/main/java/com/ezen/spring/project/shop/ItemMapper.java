package com.ezen.spring.project.shop;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;



@Component
@Mapper
public interface ItemMapper 
{
	public List<Map<String, String>> getList();
	public List<Map<String, String>> getItem(int itemNum);
	public int addItem(ItemVO item);
	public int addItemAttach(List<ItemAttachVO> list);
	public List<Map<String, String>> search(String category, String keyword);
	public int updateItem(ItemVO item);
	public int deleteItem(int itemNum);
	public ItemVO findByItem(int itemNum);
	public int CartCnt(String goods);
	public int OrderCnt(ItemOrderVO order);
	public ItemOrderVO getItem(String goods);
	public ItemVO getGoods(String goods);
	public List<Map<String, String>> getTopItems(int limit);
}
