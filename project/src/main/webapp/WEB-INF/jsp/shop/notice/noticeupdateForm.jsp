<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 수정 폼</title>
<style type="text/css">
	main { width:fit-content; margin:0.5em auto; }
	main>h3 {text-align:center;}
	form {border:1px solid black; padding:1em;}
	label {display:inline-block; width:4em; padding-right:0.7em; text-align:right;}
	label#lbContents { position:relative; top:-2em;}
	input,textarea { width:300px; margin-top:0.5em;}
	textarea { position:relative; left:-5px; }
	#divBtn { margin-top:1em; text-align:center; }
	nav { text-align: center; margin-top:0.5em;}
	nav a { text-decoration: none; color:blue; }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function updateBoard() {
	var serdata = $('#updateForm').serialize();
	$.ajax({
		url:'/notice/update',	
		method:'post',
		data:serdata,
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정성공':'수정실패');
			location.href='/notice/list';
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
	<h3>게시글 수정</h3>
	<form id="updateForm" action="/notice/update" method="post"
						onsubmit="return updateBoard();">
		<input type="hidden" name="noticeNum" value="${notice.noticeNum}">
		<div>
		<label>제목</label><input type="text" id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}" >
		</div>
		<div>
		<label id="lbContents">내용</label>
			<textarea name="noticeContents" rows="5">${notice.noticeContents}</textarea>
		</div>
		<div id="divBtn">
			<button type="reset">취소</button>
			<button type="submit">수정</button>
		</div>
	</form>
<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>