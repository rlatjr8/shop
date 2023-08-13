package com.ezen.spring.project.shop;

import java.io.File;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;


import com.github.pagehelper.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/item")
@SessionAttributes("userid")
public class ItemController 
{
	@Autowired
	private ItemDAO itemDAO;
	
	@Autowired
	private ItemSvc itemsvc;
	
	@GetMapping("/list/{pn}")
	public String list(Model model,@PathVariable int pn,
			@SessionAttribute(value="userid", required=false) String uid,
			@RequestParam(value="category", required=false) String category,
			@RequestParam(value="keyword" , required=false) String keyword)
	{
		PageInfo<Map> pageInfo = null;
		if(category!=null) {		
			pageInfo = itemDAO.search(category, keyword, pn);
			model.addAttribute("category",category);
			model.addAttribute("keyword",keyword);
			
		} else {
			pageInfo = itemDAO.getList(pn);
		}
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userid",uid);
		return "shop/item/itemList";
	}
	
	
	@GetMapping("/detail/{itemNum}")
	public String getItem(@PathVariable int itemNum,Model model, @SessionAttribute(value="userid", required=false) String uid)
	{
		ItemVO item = itemsvc.getItem(itemNum);
		
		model.addAttribute("item",item);
		model.addAttribute("userid",uid);
		return "shop/item/itemdetail";
	}
	
	@GetMapping("/add")
	public String add()
	{
		return "shop/item/itemaddForm";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(ItemVO item, @RequestParam("files")MultipartFile[] mfiles,
			HttpServletRequest request )
	{
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/items");
		
		List<ItemAttachVO> attList = new ArrayList<>();
		try {
			for(int i=0;i<mfiles.length;i++) {
				if(mfiles[i].getSize()==0) continue;
				String originName = mfiles[i].getOriginalFilename();
				mfiles[i].transferTo(
				  new File(savePath+"/"+originName));
				/* MultipartFile 주요 메소드 */
				String cType = mfiles[i].getContentType();
				String pName = mfiles[i].getName();
				Resource res = mfiles[i].getResource();
				long fSize = mfiles[i].getSize();
				boolean empty = mfiles[i].isEmpty();
				
				ItemAttachVO att = new ItemAttachVO();
				att.setItemattachName(originName);
				att.setItemfSize(fSize/1024);
				att.setItemfContentType(cType);
				
				attList.add(att);
			}
			
			item.setItemattList(attList);
			boolean added = itemDAO.addItem(item);
			
			
			Map<String, Object> map = new HashMap<>();
			map.put("added", added);
			map.put("num", item.getItemNum());
			return map;
			
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}
		Map<String, Object> map = new HashMap<>();
		map.put("added", false);
		return map;
	}
	
	@GetMapping("update/{itemNum}")
	public String update(@PathVariable int itemNum, Model model)
	{
		ItemVO item = itemsvc.getItem(itemNum);	
		model.addAttribute("item",item);
		return "shop/item/itemupdate";
	}
	
	@PostMapping("update")
	@ResponseBody
	public Map<String, Object> update(ItemVO item)
	{
		boolean updated = itemDAO.update(item);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@GetMapping("delete/{itemNum}")
	@ResponseBody
	public Map<String, Boolean> delItem(@PathVariable int itemNum)
	{
		boolean deleted = itemDAO.delete(itemNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
	@GetMapping("/topitems")
	public String topItems(Model model) {
	    List<Map<String, String>> topItems = itemsvc.getTopItems(10);
	    model.addAttribute("topItems", topItems);
	    return "shop/item/topItems";
	}
}
