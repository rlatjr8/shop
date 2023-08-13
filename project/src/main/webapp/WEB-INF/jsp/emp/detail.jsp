<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>사원정보 상세보기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function deleteIt() {
	if(!confirm('정말로 삭제하시겠어요?')) return;
	$.ajax({
		url:'/emp/delete',
		method:'post',
		data:{"empno":${emp.empno}},
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.deleted ? '삭제성공':'삭제실패');
			location.href='/emp/list';
			if(res.cause){
				alert(res.cause);
				location.href='/user/login';
			}
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
	<h3>사원정보 상세보기</h3>
	<div><label>번호</label>${emp.empno}</div>
	<div><label>이름</label>${emp.ename}</div>
	<div><label>입사</label>
	<fmt:formatDate value="${emp.hiredate}" pattern="yyyy-mm-dd" type="date"/>
	</div>
	<div><label>급여</label>${emp.sal}</div>
	<nav>
		[<a href="/emp/update/${emp.empno}">수정</a>]
		[<a href="javascript:deleteIt();">삭제</a>]
	
	
	</nav>
</main>
</body>
</html>