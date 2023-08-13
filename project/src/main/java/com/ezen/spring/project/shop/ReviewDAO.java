package com.ezen.spring.project.shop;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Repository
public class ReviewDAO
{
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Transactional
	public boolean addReview(ReviewVO review)
	{
		boolean rSaved = reviewMapper.addReview(review)>0;
		int reviewNum = review.getReviewNum();
		
		List<ReviewAttachVO> list = review.getReviewattList();
		for(int i=0;i<list.size();i++)
		{
			list.get(i).setReviewattachparentsNum(reviewNum);
		}
		boolean aSaved = false;
		  if(review.getReviewattList().size()>0) {
			  aSaved = reviewMapper.addReviewAttach(review.getReviewattList())>0;
		  } else {
			  aSaved = true;
		  }
		 return rSaved && aSaved;
	}

	public PageInfo<Map> search(String category, String keyword, int pn) {
		  PageHelper.startPage(pn, 10);
		  PageInfo<Map> pageInfo = new PageInfo<>(reviewMapper.search(category, keyword));
		  return pageInfo;
	}

	public PageInfo<Map> getList(int pn) {
		PageHelper.startPage(pn,5);
		PageInfo<Map> pageInfo = new PageInfo<>(reviewMapper.getList());
		return pageInfo;
	}
	
	public List<Map<String, Object>> getList()
	{
		return reviewMapper.getList();
	}
	
	public List<Map<String, String>> getReview(int reviewNum){
		return reviewMapper.getReview(reviewNum);
	}

	
}
