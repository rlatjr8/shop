package com.ezen.spring.project.shop;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/order")
@SessionAttributes("userid")
public class ItemOrderController 
{
	@Autowired
	private ItemOrderDAO ioDAO;
	
	@Autowired
	private ItemCartDAO icDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> addOrder(@SessionAttribute(name="userid",required = false) String uid, @RequestBody List<Integer> cartNums)
	{
	   boolean ordered = false;
	   
	   java.sql.Date date = new java.sql.Date(new Date().getTime());
	   int paymentAmount = 0;
	   for(int i=0;i<cartNums.size();i++) {
	      ItemCartVO c = icDAO.getCart(cartNums.get(i));
	      String goods = c.getGoods();
	      int price = c.getPrice();
	      int qty = c.getQty();
	      paymentAmount += price * qty;
	      
	      ItemOrderVO o = new ItemOrderVO();
	      o.setGoods(goods);
	      o.setPrice(price);
	      o.setQty(qty);
	      o.setUser(uid);
	      o.setOrderdate(date);
	        
	      boolean added = ioDAO.addOrder(o);
	      if (added) {
	        ordered = true;
	        icDAO.delete(c.getCartNum());
	      }
	      }
	      int saveMoney = (int)(paymentAmount * 0.03);
	      int point = 100;
	      
	      MemberVO currentUser = memberDAO.getBoard(uid);
	      int newSaveMoney = currentUser.getSaveMoney() + saveMoney;
	      int newPoint = currentUser.getPoint() + point;
	      
	      currentUser.setSaveMoney(newSaveMoney);
	      currentUser.setPoint(newPoint);
	      memberDAO.updateUserSavingsAndPoints(currentUser);
	   
	      Map<String, Object> map = new HashMap<>();
	      map.put("ordered", ordered);
	      return map;
	   }
	
	@GetMapping("/list")
	public String list(@SessionAttribute(name="userid",required = false) String uid, Model model)
	{
		if(uid==null) {
			return "shop/member/loginForm";
		}else {
			List<ItemOrderVO> list = ioDAO.getList(uid);
			int totalOrderAmount = ioDAO.getTotalOrderAmountForUser(uid);
			model.addAttribute("list", list);
			model.addAttribute("totalOrderAmount", totalOrderAmount);
			model.addAttribute("userid", uid);
			return "shop/item/orderList";
		}
	}
	
	@GetMapping("/allList")
	public String orderlist(@SessionAttribute(name="userid",required = false) String uid, Model model,
				ItemOrderVO order)
	{
		List<ItemOrderVO> olist = ioDAO.getOrder(order);
		model.addAttribute("olist", olist);
		model.addAttribute("userid", uid);
		return "shop/item/orderList";
		
	}
}
