package com.ezen.spring.project.shop;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/cart")
@SessionAttributes("userid")
@Slf4j
public class ItemCartController 
{
	@Autowired
	private ItemCartDAO icDAO;
	
	@Autowired
	private ItemSvc itemsvc;
	
	@Autowired
	private ItemDAO iDAO;
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> addCart(@SessionAttribute(name="userid",required = false) String uid,
			@RequestParam("itemNum") int itemNum,@RequestParam("qty") int qty)
	{
		Map<String, Object> map = new HashMap<>();
		if(uid==null) {
			map.put("added", false);
			map.put("cause", "로그인이 필요한 기능입니다");
		} else {
			ItemVO item = itemsvc.getItem(itemNum);
			String goods = item.getGoods();
			int price = item.getPrice();
			
			ItemCartVO qtycart = new ItemCartVO();
	        qtycart.setUser(uid);
	        qtycart.setGoods(goods);
	        
	        ItemCartVO existingCart = icDAO.findCartByUserAndGoods(qtycart);
	           if (existingCart != null) {
	               // 이미 장바구니에 같은 아이템이 있으면 수량만 증가
	              int existingQty = existingCart.getQty();
	               existingCart.setQty(existingQty + qty);
	               int updated = icDAO.update(existingCart);
	               map.put("added", updated);
	        }else {    
			
			ItemCartVO cart = new ItemCartVO();
			cart.setGoods(goods);
			cart.setPrice(price);
			cart.setQty(qty);
			cart.setUser(uid);
			boolean added = icDAO.addCart(cart);
			
			map.put("added", added);
			
	        }
		}
		return map;
	}
	
	@GetMapping("/list")
	public String list(Model model,@SessionAttribute(name="userid",required = false) String uid)
	{
		
		model.addAttribute("list", icDAO.getList(uid)); 
		return "shop/item/cartList";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> update(ItemCartVO cart, @RequestParam("qty") int qty)
	{
		  Map<String, Object> map = new HashMap<>();
		  cart.setQty(qty);
		  int updated = icDAO.update(cart);
		  map.put("modified", updated > 0);
		  return map;
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(@SessionAttribute(name="userid",required = false) String uid,@RequestBody List<Integer> cartNums)
	{
		
		Map<String, Object> map = new HashMap<>();
		List<ItemCartVO> cart = icDAO.getList(uid);
		
		if(cart==null) {
			map.put("deleted", false);
		} else {
			for(int i=0;i<cartNums.size();i++) {
				icDAO.delete(cartNums.get(i));				
			} 
			map.put("deleted", true);
			
			
		}
		return map;
	}
	
	@GetMapping("/clear")
	@ResponseBody
	public Map<String, Object> clear(@SessionAttribute(name="userid",required = false) String uid)
	{
		int cleared = icDAO.clear(uid);
		
		Map<String, Object> map = new HashMap<>();
		map.put("cleared", cleared>0);
		map.put("cleared", true);
		return map;
	}
	
}
