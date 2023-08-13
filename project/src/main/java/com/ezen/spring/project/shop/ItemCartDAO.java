package com.ezen.spring.project.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
}
