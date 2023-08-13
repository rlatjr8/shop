package com.ezen.spring.project.shop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class ItemDAO 
{
	@Autowired
	private ItemMapper itemMapper;

	public PageInfo<Map> getList(int pageNum) {
		PageHelper.startPage(pageNum, 10);
		PageInfo<Map> pageInfo = new PageInfo<>(itemMapper.getList());
		return pageInfo;
	}
	
	public List<Map<String, String>> getList()
	{
		return itemMapper.getList();
	}

	public List<Map<String, String>> getItem(int itemNum) {
		
	    return itemMapper.getItem(itemNum);
		
	}

	@Transactional
	public boolean addItem(ItemVO item)
	{
		boolean iSaved = itemMapper.addItem(item)>0;
		int itempNum =item.getItemNum();
		
		List<ItemAttachVO> list = item.getItemattList();
		for(int i=0;i<list.size();i++)
		{
			list.get(i).setItemparentsNum(itempNum);
		}
		boolean aSaved = false;
	      if(item.getItemattList().size()>0) {
	         aSaved = itemMapper.addItemAttach(item.getItemattList())>0;
	      }else {
	         aSaved = true;
	      }

		return iSaved && aSaved ;
	}

	public PageInfo<Map> search(String category, String keyword, int pn) {
		  PageHelper.startPage(pn, 10);
		  PageInfo<Map> pageInfo = new PageInfo<>(itemMapper.search(category, keyword));
		  return pageInfo;
	}
	
	public boolean update(ItemVO item) 
	{
		return itemMapper.updateItem(item)>0;
	}
	
	public boolean delete(int itemNum)
	{
		return itemMapper.deleteItem(itemNum)>0;
	}

	public ItemVO findByItem(int itemNum) {
		return itemMapper.findByItem(itemNum);
	}

    public ItemVO getGoods(String goods) {
    	return itemMapper.getGoods(goods);
    }
    
    public List<Map<String, String>> getTopItems(int limit) {
        return itemMapper.getTopItems(limit);
    }
	
}
