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
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@SessionAttributes("userid")
@Slf4j
public class ReviewController 
{
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired 
	private ItemOrderDAO ioDAO;
	
	@Autowired
	private ItemDAO iDAO;
	
	@Autowired
	private ReviewSvc reviewsvc;
	
	@GetMapping("/add")
	public String add(@RequestParam("goods") String goods,Model model,@SessionAttribute(value="userid", required=false) String uid,
			HttpServletRequest request)
	{
		
		ItemVO item = iDAO.getGoods(goods);
		int ItemNum = item.getItemNum();
		model.addAttribute("ItemNum", ItemNum);
		log.info("itemNum={}",ItemNum);
		ReviewVO review = new ReviewVO();
	    review.setReviewAuthor(uid);
	    model.addAttribute("userid",review.getReviewAuthor());
	    ItemOrderVO order = ioDAO.getGoods(goods);
		model.addAttribute("o",order);
		return "shop/review/reviewaddForm";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(ReviewVO review,@RequestParam("files")MultipartFile[] mfiles,
			HttpServletRequest request,@SessionAttribute(value="userid", required=false) String uid)
	{
		
		review.setReviewAuthor(uid);
		
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/review");
		
		List<ReviewAttachVO> attList = new ArrayList<>();
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
				
				ReviewAttachVO att = new ReviewAttachVO();
				att.setReviewattachName(originName);
				att.setReviewattachfSize(fSize/1024);
				att.setReviewattachfContentType(cType);
				
				attList.add(att);
			}
			
			
			review.setReviewattList(attList);
			boolean added = reviewDAO.addReview(review);
			
			Map<String,Object> map = new HashMap<>();
			map.put("added", added);
			map.put("num", review.getReviewNum());
			
			
			return map;
		}
		 catch(Exception ex) {
			ex.printStackTrace();
		}
		Map<String, Object> map = new HashMap<>();
		map.put("added", false);
		return map;
	}
	
	@GetMapping("/list/{pn}")
	public String list(Model model,@PathVariable int pn,
			@SessionAttribute(value="userid", required=false) String uid,
			@RequestParam(value="category", required=false) String category,
			@RequestParam(value="keyword" , required=false) String keyword)
	{
		PageInfo<Map> pageInfo = null;
		if(category!=null) {		
			pageInfo = reviewDAO.search(category, keyword, pn);
			model.addAttribute("category",category);
			model.addAttribute("keyword",keyword);
			
		} else {
			
			pageInfo = reviewDAO.getList(pn);
		}
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userid",uid);
		return "shop/review/reviewList";
	}
	
	@GetMapping("/detail/{reviewNum}")
	public String getReview(@PathVariable int reviewNum,Model model,
			@SessionAttribute(value="userid", required=false) String uid)
	{
		ReviewVO review = reviewsvc.getReview(reviewNum);
		
		
		model.addAttribute("review",review);
		model.addAttribute("userid",uid);
		return "shop/review/reviewdetail";
	}
}
