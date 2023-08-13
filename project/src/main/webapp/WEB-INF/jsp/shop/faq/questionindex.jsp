<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>FAQ 게시판</title>
<style type="text/css">
	main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px;}
	#aa {color:black;}
	li a { text-decoration: none; color:blue; }
	main h3 { text-align: center; }
	h2 a { text-decoration: none;}
	 .user-info { position: absolute; top: 0; right: 0; }
	 
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout() {
	if(!confirm('로그아웃할까요?')) return;
	$.ajax({
		url : '/member/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공':'로그아웃 실패');
			if(res.logout) location.href='/question/';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
function mypage(){
	location.href='/member/detail/${userid}';
}
</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>FAQ 게시판</h3>
	<c:if test="${userid == null}">
	<div class="user-info">
	<div>
		<a href="/member/login">로그인</a>
		<a href="/member/join">회원가입</a>
	</div>
	</div>
		<ul>
			<li><a href="/member/">메인 페이지</a></li>
			<li><a href="/question/add">질문하기</a></li>
			<li><a href="/question/list">질문 목록</a></li>	
		</ul>
	</c:if>
	<c:if test="${userid != null}">
	<div class="user-info">
	<div>
		ID: ${userid}
		<button type="button" onclick="javascript:logout();">로그아웃</button>
		<button type="button" onclick="javascript:mypage();">마이페이지</button>
	</div>
	</div>
		
		<ul>
			
			<li><a href="/question/add">질문 하기</a></li>
			<li><a href="/question/list">질문 목록</a></li>	
		</ul>
	</c:if>
<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>