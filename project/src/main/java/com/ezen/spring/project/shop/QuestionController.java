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
@RequestMapping("/question")
@SessionAttributes("userid")
public class QuestionController 
{
	@Autowired
	private QuestionDAO questionDAO;
	
	@Autowired
	private AnswerDAO answerDAO;
	
	@GetMapping("/")
	public String index()
	{
		return "shop/faq/questionindex";
	}
	
	@GetMapping("/add")
	public String add()
	{
		return "shop/faq/questionaddForm";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public Map<String, Object> add(QuestionVO question,@SessionAttribute(value="userid", required=false) String uid)
	{
		Map<String, Object> map = new HashMap<>();
		question.setQuestionAuthor(uid);
		if(uid==null) {
			map.put("added", false);
			map.put("cause", "로그인이 필요한 기능입니다 \n먼저 로그인 해주세요");
		} else {
			
			map.put("added", questionDAO.addBoard(question));
		}
		return map;
		
	}
	
	@GetMapping("/list")
	public String list(QuestionVO question,Model model)
	{
	
		model.addAttribute("list", questionDAO.getList());
		return "shop/faq/questionList";
	}
	
	@GetMapping("/get/{questionNum}")
	public String getBoard(@PathVariable int questionNum, Model model,@SessionAttribute(value="userid", required=false) String uid)
	{
		
		  QuestionVO question = questionDAO.getBoard(questionNum);
		  AnswerVO answer = answerDAO.getAnswerByQuestion(questionNum);
		  model.addAttribute("a", answer);
		  model.addAttribute("question",question);
		  model.addAttribute("userid",uid);
		  return "shop/faq/questiondetail";
	}
	
	@GetMapping("/update/{questionNum}")
	public String update(@PathVariable int questionNum,Model model)
	{
		QuestionVO q = questionDAO.getBoard(questionNum);
		AnswerVO answer = answerDAO.getAnswerByQuestion(questionNum);
		model.addAttribute("a", answer);
		model.addAttribute("q",q);
		return "shop/faq/questionupdate";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> updateQuestion(QuestionVO q)
	{
		boolean updated = questionDAO.updateQuestion(q);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@GetMapping("/delete/{questionNum}")
	@ResponseBody
	public Map<String, Object> deleteQuestion(@PathVariable int questionNum)
	{
		boolean deleted = questionDAO.deleteQuestion(questionNum);
		Map<String, Object> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
}
