<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>쇼핑몰</title>
<style type="text/css">
   main {width:fit-content; margin:0.5em auto; }
   main h3 { text-align: center; }
 
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
			if(res.logout) location.href='/main/';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function mypage(){
		location.href='/member/detail/${userid}';
}
function faq(){
	location.href='/question/';
}

</script>
</head>
<body>
<main>
<h3>SHOP</h3>
	<div>
		ID: ${userid}
		<button type="button" onclick="javascript:logout();">로그아웃</button>
		<button type="button" onclick="javascript:mypage();">마이페이지</button>
		<button type="button" onclick="javascript:faq();">FAQ</button>
		<a href="/notice/list">공지사항</a>
	</div>


</main>
</body>
</html>