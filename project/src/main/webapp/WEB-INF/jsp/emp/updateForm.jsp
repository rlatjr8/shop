<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>사원정보 수정 폼</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function updateEmp() {
	var serdata = $('#updateForm').serialize();
	$.ajax({
		url:'/emp/update',	
		method:'post',
		data:serdata,
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정성공':'수정실패');
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
	<h3>사원정보 수정</h3>
	<form id="updateForm" action="/emp/update" method="post"
						onsubmit="return updateEmp();">
		<div>
		<label>번호</label><input type="text" id="empno" name="empno" value="${emp.empno}" readonly>
		</div>
		<div>
		<label>이름</label><input type="text" id="ename" name="ename" value="${emp.ename}" readonly>
		</div>
		<div>
		<label>입사</label><input type="text" id="hiredate" name="hiredate" value="<fmt:formatDate value="${emp.hiredate}" pattern="yyyy-mm-dd" type="date"/>"readonly>
		</div>
		<div>
		<label>급여</label><input type="text" id="sal" name="sal" value="${emp.sal}">
		</div>
			<div>
			<button type="reset" >취소</button>
			<button type="submit" >저장</button>
			</div>
	</form>

</main>
</body>
</html>