package com.ezen.spring.project.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ItemOrderDAO 
{
	@Autowired
	private ItemOrderMapper ioMapper;
	
	@Autowired
	private ItemMapper iMapper;
	
	@Autowired
	private MemberMapper mMapper;

	public boolean addOrder(ItemOrderVO order)	{
		iMapper.OrderCnt(order);
		
		return ioMapper.addOrder(order);
	}
	
	public List<ItemOrderVO> getList(String uid) {
		return ioMapper.getList(uid);
	}
	
	public List<ItemOrderVO> getOrder(ItemOrderVO order){
		return ioMapper.getOrder(order);
	}
	
	public int getTotalOrderAmountForUser(String uid) {
        List<ItemOrderVO> userOrders = getList(uid);
        int totalAmount = 0;
        for (ItemOrderVO order : userOrders) {
            totalAmount += order.getPrice() * order.getQty();
        }
        return totalAmount;
    }
	
	public ItemOrderVO getGoods(String goods)
	{
		return ioMapper.getGoods(goods);
	}
	
}
