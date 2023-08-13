package com.ezen.spring.project.shop;

import java.util.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import java.io.File;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;


@Service
public class ReviewSvc 
{
	@Autowired
	private ReviewDAO reviewDAO;
	
	public ReviewVO getReview(int reviewNum)
	{
		List<Map<String, String>> list = reviewDAO.getReview(reviewNum);
		ReviewVO r = getReviewIn(list.get(0));
	    r.setReviewattList(new ArrayList<ReviewAttachVO>());

	    for(int i=0;i<list.size();i++) { //list.size() 첨부파일의 갯수와 일치
	         Map<String, String> m = list.get(i);
	         
	         List<ReviewAttachVO> attList = getReviewAttachIn(m);
	         if (attList != null) {
	             r.setReviewattList(attList);
	         }
	      }
	   return r;

	}
	
	 private List<ReviewAttachVO> getReviewAttachIn(Map m)
	   {
		   if(m.get("reviewattachName") == null || m.get("reviewattachNums") == null || m.get("reviewattachfSize") == null) {
		        return null;
		    }
	      
	      String reviewAttachNums = m.get("reviewattachNums").toString();
	      String reviewAttachNames = m.get("reviewattachName").toString();
	      String reviewFileSizes = m.get("reviewattachfSize").toString();
	      
	      String[] nums = reviewAttachNums.split(",");
	      String[] names = reviewAttachNames.split(",");
	      String[] rSizes = reviewFileSizes.split(",");
	      
	      List<ReviewAttachVO> rattlist = new ArrayList<>();
	      for(int i=0; i<nums.length; i++) {
	         int reviewattNum = Integer.parseInt(nums[i]);
	         String reviewattName = names[i];
	         float fsize = Float.parseFloat(rSizes[i]);
	         
	         ReviewAttachVO ratt = new ReviewAttachVO();
	         ratt.setReviewattachNum(reviewattNum);
	         ratt.setReviewattachName(reviewattName);
	         ratt.setReviewattachfSize(fsize);
	         
	         rattlist.add(ratt);
	      }
	      
	      return rattlist;
	   }
	   
	 private ReviewVO getReviewIn(Map m) {
		    int reviewNum = Integer.parseInt(m.get("reviewNum").toString());
		    String reviewTitle = m.get("reviewTitle") != null ? m.get("reviewTitle").toString() : "";
		    String reviewContents = m.get("reviewContents") != null ? m.get("reviewContents").toString() : "";
		    String reviewAuthor = m.get("reviewAuthor") != null ? m.get("reviewAuthor").toString() : "";
		    java.sql.Date reviewDate = null;
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    if (m.get("reviewDate") != null) {
		        try {
		            reviewDate = new java.sql.Date(sdf.parse(m.get("reviewDate").toString()).getTime());
		        } catch (ParseException e) {
		            e.printStackTrace();
		        }
		    }
		    int reviewLikeCnt = m.get("reviewLikeCnt") != null ? Integer.parseInt(m.get("reviewLikeCnt").toString()) : 0;

		    ReviewVO r = new ReviewVO();
		    r.setReviewNum(reviewNum);
		    r.setReviewTitle(reviewTitle);
		    r.setReviewContents(reviewContents);
		    r.setReviewAuthor(reviewAuthor);
		    r.setReviewdate(reviewDate);
		    r.setReviewLikeCnt(reviewLikeCnt);

		    return r;
		}
	   
	 

}
