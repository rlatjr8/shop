<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 보기</title>
<style type="text/css">
	main { width:fit-content; margin:0.5em auto;}
	main > h1 {text-align:center; }
	label {width:3em; padding:0.2em 1em; text-align: right;font-weight: bolder; }
	main > div {border-bottom:1px dashed black; padding:0.3em 1em;}
	nav { text-align: center; margin:0.5em;}
	 a {text-decoration: none; color:blue;}
	textarea { width:23em; margin-top:0.5em;}
	 main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px; background-color: black; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
  	 #aa {color:white;
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delContents() {
	if(!confirm('정말 삭제하시겠습니까?')) return;
	
	$.ajax({
		url:'/question/delete/${question.questionNum}',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			if(res.deleted){
				location.href="/question/list";
			}
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function addAnswer() {
	var formdata = $('#answerForm').serialize();
	
	if (answerContents === '') {
		alert('답변 내용을 입력해주세요.');
		return;
	}
	
	$.ajax({
		url:'/answer/add',
		method:'post',
		cache:false,
		dataType:'json',
		data:formdata,
		success:function(res) {
			if (res.added) {
				alert('답변이 등록되었습니다.');
				location.reload();
			} else {
				alert('답변 등록에 실패했습니다.');
			}
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	
	return false;
}

$(document).ready(function() {
	$.ajax({
		url: '/answer/get/${questionNum}',
		method: 'get',
		cache: false,
		dataType: 'json',
		success: function(res) {
			if (res.a) {
				var answerAuthor = $('<p>').text(res.a.answerAuthor);
				var answerContents = $('<p>').text(res.a.answerContents);
				
				$('#answer').append(answerContents);
				
			}
		},
		error: function(xhr, status, err) {
			alert('에러:' + err);
		}
	});
});

function deleteAnswer(answerNum) {
    if (!confirm('정말 답변을 삭제하시겠습니까?')) return;
    
    $.ajax({
        url: '/answer/delete/' + answerNum,
        method: 'get',
        cache: false,
        dataType: 'json',
        success: function(res) {
            alert(res.deleted ? '답변 삭제 완료' : '답변 삭제 실패');
            if (res.deleted) {
                location.reload();
            }
        },
        error: function(xhr, status, err) {
            alert('에러:' + err);
        }
    });
}
</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h1>Question</h1>
	<div><label>글번호</label>${question.questionNum}</div>
	<div><label>제목</label>${question.questionTitle}</div>
	<div><label>작성자</label>${question.questionAuthor}</div>
	<div><label>작성일</label>${question.questionDate}</div>
	
	<div><label>내용</label>
	<textarea rows="6" readonly>${question.questionContents}</textarea>
	</div>
	<p>
	<c:if test="${userid == question.questionAuthor}">
		<a href="/question/update/${question.questionNum}">수정</a>
		<a href="javascript:delContents();">삭제</a>
		<a href="/question/list">목록으로</a>
	</c:if>
	</p>
	<h4>관리자의 답변</h4>
	
	<div id="answer"></div>
	
	<c:if test="${userid == 'admin'}">
		<c:if test="${not empty a}">
	        <a href="/answer/update/${a.answerNum}/${question.questionNum}">수정</a>
	        <a href="javascript:deleteAnswer(${a.answerNum});">삭제</a>
	    </c:if>
		</c:if>
	<p>
	<hr>
	<c:if test="${userid == 'admin'}">
	
	<h3>답변 작성</h3>
	<form id="answerForm" onsubmit="return addAnswer();">
	<input type="hidden" name="pQuestionNum" value="${question.questionNum }">
		<textarea id="answerContents" name="answerContents" rows="5" cols="50"></textarea><br>
		<button type="submit">답변 등록</button>
	</form>
	</c:if>		
	
<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>