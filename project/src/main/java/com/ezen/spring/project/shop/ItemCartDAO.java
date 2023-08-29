package com.ezen.spring.project.shop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.pagehelper.PageInfo;
import com.github.pagehelper.PageHelper;

import jakarta.transaction.Transactional;

@Repository

public class ItemCartDAO 
{
	@Autowired
	private ItemCartMapper icMapper;

	@Autowired
	private ItemMapper iMapper;
	
	@Transactional
	public boolean addCart(ItemCartVO cart) {
		iMapper.CartCnt(cart.getGoods());
		return icMapper.addCart(cart)>0; 
	}
	
	public ItemCartVO getCart(int cartNum) {
		return icMapper.getCart(cartNum);
	}

	public List<ItemCartVO> getList(String uid) {
		return icMapper.getList(uid);
	}

	public int delete(int cartNum) {
		return icMapper.delete(cartNum);
	}

	public int clear(String user) {
		return icMapper.clear(user);
	}

	public int update(ItemCartVO cart) {
		return icMapper.update(cart);
	}

	public ItemCartVO findCartByUserAndGoods(ItemCartVO qtycart) {
		return icMapper.findCartByUserAndGoods(qtycart);
	}

	public List<ItemCartVO> del(List<ItemCartVO> c) {
		return icMapper.del(c);
		
	}

	public PageInfo<Map> search(String category, String keyword, int pn) {
		PageHelper.startPage(pn, 10);
		PageInfo<Map> pageInfo = new PageInfo<>(icMapper.search(category, keyword));
		return pageInfo;
	}

	public PageInfo<Map> getList2(int pn,String uid) {
		PageHelper.startPage(pn,5);
		PageInfo<Map> pageInfo = new PageInfo<>(icMapper.getList2(uid));
		return pageInfo;
	}

	
}