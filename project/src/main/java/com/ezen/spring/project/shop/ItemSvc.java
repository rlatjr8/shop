package com.ezen.spring.project.shop;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ItemSvc 
{
   @Autowired
   private ItemDAO itemDAO;
   
   public ItemVO getItem(int itemNum)
   {
      List<Map<String,String>> list = itemDAO.getItem(itemNum);
      
      ItemVO item = getItemIn(list.get(0));
      item.setItemattList(new ArrayList<ItemAttachVO>());
      
      for(int i=0;i<list.size();i++) { //list.size() 첨부파일의 갯수와 일치
         Map<String, String> m = list.get(i);
         
         List<ItemAttachVO> attList = getItemAttachIn(m);
         item.setItemattList(attList);;
      }
      return item;
   }

   private List<ItemAttachVO> getItemAttachIn(Map m) 
   {
      if(m.get("itemattachName")==null) return null;
      
      String itemAttachNums = m.get("itemattachNum").toString();
      String itemAttachNames = m.get("itemattachName").toString();
      String itemFileSizes = m.get("itemfSize").toString();
      
      String[] sNums = itemAttachNums.split(",");
      String[] sNames = itemAttachNames.split(",");
      String[] sSizes = itemFileSizes.split(",");
      
      List<ItemAttachVO> iattlist = new ArrayList<>();
      for(int i=0;i<sNums.length;i++) {
         int fnum = Integer.parseInt(sNums[i]);
         String fname = sNames[i];
         float fsize = Float.parseFloat(sSizes[i]);
         
         ItemAttachVO a = new ItemAttachVO();
         a.setItemattachNum(fnum);
         a.setItemattachName(fname);
         a.setItemfSize(fsize);
         
         iattlist.add(a);
      }
      
      return iattlist;
   }

   private ItemVO getItemIn(Map m) 
   {
      int itemNum = Integer.parseInt(m.get("itemNum").toString());
      String goods = m.get("goods").toString();
      int price = Integer.parseInt(m.get("price").toString());
      String explain= m.get("explain").toString();
      
      ItemVO item = new ItemVO();
      item.setItemNum(itemNum);
      item.setGoods(goods);
      item.setPrice(price);
      item.setExplain(explain);
      
      return item;
   }
   
    public List<Map<String, String>> getTopItems(int limit) {
	    return itemDAO.getTopItems(limit);
	}
}
