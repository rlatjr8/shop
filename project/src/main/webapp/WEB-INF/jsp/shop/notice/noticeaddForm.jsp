<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 추가</title>
<style type="text/css">
	main { width:fit-content; margin:1em auto;}
	main>h3 { text-align: center;}
	form {width:fit-content; border:1px solid black; padding:1em;}
	label {display:inline-block; width:4em; padding:0.3em 1em; text-align:right;}
	div:last-child { text-align: center; margin-top:0.5em;}
	input {width:15em;}
	textarea { width:202px; margin-top:2px;}
	#divContents>label { position:relative; top:-2.5em;}
	#divBtn { text-align:center; margin-top:0.5em;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function addBoard() {
	var serdata = $('#addForm').serialize();
	$.ajax({
		url : '/notice/add',
		method:'post',
		cache:false,
		data:serdata,
		dataType:'json',
		success:function(res){
			alert(res.added ? '등록완료':'등록실패');
			location.href='/notice/list';
			if(res.cause) {
				alert(res.cause);
			}
		},
		error:function(xhr,status,err){
			alert('에러:'+err);
		}
	});
	return false;
}
</script>
</head>
<body>
<main>
	<h3>게시글 추가</h3>
	<form id="addForm" action="/notice/add" method="post" 
										onsubmit="return addBoard();">
		
		<div><label for="noticeTitle">제목</label>
			<input type="text" id="noticeTitle" name="noticeTitle">
		</div>
		<div id="divContents">
		<label for="noticeContents">내용</label>
		<textarea rows="5" cols="25" name="noticeContents" id="noticeContents" required>
		</textarea>
		</div>
		<div>
			<button type="reset">취소</button>
			<button type="submit">저장</button>
		</div>
	</form>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>