<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>사원정보 관리</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout(){
	if(!confirm("로그아웃 하시겠습니까?")) return;
	$.ajax({
		url:'/user/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공' : '로그아웃 실패');
			location.href='/user/login';
		},
		error:function(xhr, status, err){
			alert('에러:' + status+'/'+err);
		}
	});
	return false;
}
</script>
</head>
<body>
<main>
	<h2>사원정보 관리</h2>
		<div>
			<div><a href="/emp/add">사원정보 추가</a></div>
			<div><a href="/emp/list">사원정보 목록</a></div>
		</div>
		<div>
			<div><a href="/user/login">로그인</a></div>
			<div><a href="javascript:logout();">로그아웃</a></div>
		</div>
</main>
</body>
</html>