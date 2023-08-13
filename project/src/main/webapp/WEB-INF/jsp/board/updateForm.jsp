<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 수정 폼</title>
<style type="text/css">
	main { width:fit-content; margin:0.5em auto; }
	main>h2 {text-align:center;}
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
		url:'/board/update',	
		method:'post',
		data:serdata,
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정성공':'수정실패');
			location.href='/board/list';
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
	<h3>게시글 수정</h3>
	<form id="updateForm" action="/board/update" method="post"
						onsubmit="return updateBoard();">
		<div>
		<label>번호</label><input type="text" id="num" name="num" value="${board.num}" readonly>
		</div>
		<div>
		<label>제목</label><input type="text" id="title" name="title" value="${board.title}" >
		</div>
		<div>
		<label>작성자</label><input type="text" id="author" name="author" value="${board.author}" readonly>
		</div>
		<div>
		<label id="lbContents">내용</label>
			<textarea name="contents" rows="5">${board.contents}</textarea>
		</div>
		<div id="divBtn">
			<button type="reset">취소</button>
			<button type="submit">저장</button>
		</div>
	</form>

</main>
</body>
</html>