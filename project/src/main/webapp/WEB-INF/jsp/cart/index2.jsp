<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>책판매목록</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout() {
	if(!confirm('로그아웃할까요?')) return;
	$.ajax({
		url : '/book/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공':'로그아웃 실패');
			if(res.logout) location.href='/book/';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function login(){
		location.href='/book/login';
}
</script>
</head>
<body>
<main>
<h3>책 판매 목록</h3>
	<div>
		로그인 한 계정 : ${userid}
		
		<button type="button" onclick="javascript:logout();">로그아웃</button>
	</div>
	<ul>
		<li><a href="/book/1">도서정보 보기1</a></li>
		<li><a href="/book/2">도서정보 보기2</a></li>
		<li><a href="/book/3">도서정보 보기3</a></li>
	
	</ul>
</main>
</body>
</html>