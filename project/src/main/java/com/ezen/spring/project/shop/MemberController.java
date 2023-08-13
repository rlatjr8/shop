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
import org.springframework.web.bind.support.SessionStatus;

import jakarta.transaction.Transactional;





@Controller
@RequestMapping("/member")
@SessionAttributes("userid")
public class MemberController 
{
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private ItemSvc itemsvc;
	
	@GetMapping("/")
	public String index(MemberVO member,Model model,@SessionAttribute(value="userid", required=false) String uid)
	{
		model.addAttribute("userid",uid);
		model.addAttribute("mem",member);
		List<Map<String, String>> topItems = itemsvc.getTopItems(10);
	    model.addAttribute("topItems", topItems);
		return "shop/member/index";
	}
	

	
	@GetMapping("/join")
	public String join()
	{
		return "shop/member/joinForm";
	}
	
	@PostMapping("/join")
	@ResponseBody
	public Map<String, Boolean> join(MemberVO member)
	{
		boolean saved = memberDAO.join(member);
		Map<String, Boolean> map = new HashMap<>();
		map.put("saved",saved);
		return map;
	}
	
	@GetMapping("/login")
	public String login()
	{
		return "shop/member/loginForm";
	}
	
	@PostMapping("/login")
	@ResponseBody
	public Map<String, Boolean> login(MemberVO member,Model model)
	{
		boolean login = memberDAO.login(member.getMemberID(),member.getMemberPwd());
		if(login) {
			model.addAttribute("userid",member.getMemberID());
		}
		Map<String, Boolean> map = new HashMap<>();
		map.put("login", login);
		return map;
	}
	
	@GetMapping("/logout")
	@ResponseBody
	public Map<String,Boolean> logout(SessionStatus status)
	{
		status.setComplete();
		Map<String, Boolean> map = new HashMap<>();
		map.put("logout", true);
		return map;
	}
	
	@GetMapping("/detail/{memberID}")
	public String detail(@PathVariable String memberID,Model model)
	{
		MemberVO mem = memberDAO.getBoard(memberID);
		model.addAttribute("mem",mem);
		return "shop/member/memberdetail";
	}
	
	@GetMapping("/update/{memberID}")
	public String update(@PathVariable String memberID, Model model)
	{
		MemberVO mem = memberDAO.getBoard(memberID);
		model.addAttribute("mem", mem);
		return "shop/member/updateForm";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> updateUser(MemberVO member)
	{
		boolean updated = memberDAO.updateUser(member);
		Map<String, Object> map = new HashMap<>();
		map.put("updated", updated);
		return map;
	}
	
	@GetMapping("/findid")
	public String findId()
	{
		return "shop/member/findid";
	}
	
	@PostMapping("/findid")
	public String findIdresult(MemberVO member, Model model)
	{
	    MemberVO findId = memberDAO.findIdresult(member.getMemberEmail());
	      
	    if(findId !=null) {
	       model.addAttribute("findid", findId.getMemberID());
	    }else {
	       model.addAttribute("findid", "일치하는 사용자를 찾을 수 없습니다.");
	    }
	    return "shop/member/findresult";
	}
	
	@GetMapping("/findpwd")
	public String findPwd()
	{
		return "shop/member/findpwd";
	}
	
	@PostMapping("/findpwd")
	public String findPwdresult(MemberVO member, Model model)
	{
		MemberVO findPwd = memberDAO.findPwdresult(member.getMemberID(), member.getMemberName());
		
		if(findPwd!=null) {
			model.addAttribute("findpwd", findPwd.getMemberPwd());
		} else {
			model.addAttribute("findpwd", "일치하는 정보가 없습니다");
		}
		return "shop/member/findpwdresult";
	}
	
	@GetMapping("/delete/{memberNum}")
	@ResponseBody
	public Map<String, Boolean> deleteUser(@PathVariable int memberNum,SessionStatus status)
	{
		status.setComplete();
		boolean deleted = memberDAO.deleteUser(memberNum);
		Map<String, Boolean> map = new HashMap<>();
		map.put("deleted", deleted);
		return map;
	}
	
	 @GetMapping("/attendance")
	 public String showAttendanceForm() {
	     return "shop/member/attendanceForm";
	 }

	 @PostMapping("/attendance")
	 @ResponseBody
	 public Map<String, Object> markAttendance(@SessionAttribute(value = "userid", required = false) String uid) {
		    Map<String, Object> map = new HashMap<>();
		    
		    if (uid == null) {
		        map.put("result", "error");
		        map.put("message", "로그인이 필요한 서비스입니다.");
		        return map;
		    }

		    boolean alreadyCheckedIn = memberDAO.hasAlreadyCheckedIn(uid);
		    if (alreadyCheckedIn) {
		        map.put("result", "error");
		        map.put("message", "오늘은 이미 출석체크를 완료했습니다.");
		    } else {
		        boolean attendanceMarked = memberDAO.markAttendance(uid);
		        if (attendanceMarked) {
		            map.put("result", "success");
		            map.put("message", "출석체크가 완료되었습니다.");
		        } else {
		            map.put("result", "error");
		            map.put("message", "출석체크에 실패했습니다. 다시 시도해주세요.");
		        }
		    }
		    
		    return map;
	 }
	 
	 @Transactional
	 @GetMapping("/attendanceData")
	 @ResponseBody
	 public List<Map<String, Object>> getAttendanceData(@SessionAttribute(value = "userid", required = false) String uid) {
		    return memberDAO.getAttendanceData(uid);
	}
}
