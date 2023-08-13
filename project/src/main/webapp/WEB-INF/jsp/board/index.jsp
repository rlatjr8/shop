<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시판 메뉴</title>
<style type="text/css">
	li a { text-decoration: none; color:blue; }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout() {
	if(!confirm('로그아웃할까요?')) return;
	$.ajax({
		url : '/user/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공':'로그아웃 실패');
			if(res.logout) location.href='/user/login';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}
</script>
</head>
<body>
<main>
	<h2>게시판 메뉴</h2>
		<nav>
		<ul>
			<li><a href="/board/add">게시판 글쓰기</a></li>
			<li><a href="/board/list">게시판 목록</a></li>
			<li><a href="/user/login">로그인</a></li>
			<li><a href="javascript:logout();">로그아웃</a></li>
		</ul>
	</nav>
</main>
</body>
</html>