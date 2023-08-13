package com.ezen.spring.project.shop;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping("/notice")
@SessionAttributes("userid")
public class NoticeController 
{
	@Autowired
	private NoticeDAO noticeDAO;
	
	@GetMapping("/list")
	public String list(NoticeVO notice,Model model,@SessionAttribute(value="userid", required=false) String uid)
	{
		model.addAttribute("userid",uid);
		model.addAttribute("list", noticeDAO.getList());
		return "shop/notice/noticeList";
	}
	
	@GetMapping("/detail/{noticeNum}")
	public String getBoard(@PathVariable int noticeNum,Model model, @SessionAttribute(value="userid", required=false) String uid)
	{
		NoticeVO notice = noticeDAO.getBoard(noticeNum);
		
		model.addAttribute("notice",notice);
		model.addAttribute("userid",uid);
		return "shop/notice/noticedetail";
	}
	
	@GetMapping("/add")
	public String add()
	{
		return "shop/notice/noticeaddForm";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(NoticeVO notice, @SessionAttribute(value="userid", required=false) String uid)
	{
		Map<String, Object> map = new HashMap<>();
		
		if (uid == null) {
			map.put("added", false);
			map.put("cause", "관리자만 작성 가능합니다");
			return map;
	}
		
		
		notice.setNoticeAuthor(uid);
		if(notice.getNoticeAuthor().equals("admin"))
		{
			map.put("added", noticeDAO.addBoard(notice));
		}
		else { 
			
			map.put("added", false);
			map.put("cause", "관리자만 작성 가능합니다");
		} 
		return map;
	}
	
	@GetMapping("/update/{noticeNum}")
	public String update(@PathVariable int noticeNum, Model model)
	{
		NoticeVO notice = noticeDAO.getBoard(noticeNum);
		model.addAttribute("notice",notice);
		return "shop/notice/noticeupdateForm";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public Map<String,Object> update(NoticeVO notice)
	{
		boolean updated = noticeDAO.updateBoard(notice);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@GetMapping("/delete/{noticeNum}")
	@ResponseBody
	public Map<String, Boolean> delBoard(@PathVariable int noticeNum)
	{
		boolean deleted = noticeDAO.deleteBoard(noticeNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
}
