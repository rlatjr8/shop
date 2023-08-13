<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>질문 목록</title>
<style type="text/css">
main{width:fit-content; margin:0.5em auto; }
main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px;}
#aa {color:black;}
main>h3 {text-align:center; }
table { border:1px solid black; border-spacing: 0; border-collapse: collapse;}
th { background-color: #eee; padding:0.2em 1em; border-bottom: 3px double black;}
th, td { border-right: 1px solid black;}
td {padding:0.2em 1em; border-bottom: 1px dashed black;}
a {text-decoration: none; color:blue;}
.user-info { position: absolute; top: 0; right: 0; }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function mypage(){
	location.href='/member/detail/${userid}';
}
function logout() {
	if(!confirm('로그아웃할까요?')) return;
	$.ajax({
		url : '/member/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공':'로그아웃 실패');
			if(res.logout) location.href='/question/list';
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
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>FAQ 게시판</h3>
	<form action="/question/get/${question.questionNum}" method="get">
	<table>
		<tr><th>글번호</th><th>제목</th><th>ID</th><th>작성일</th></tr>
		<c:forEach var="q" items="${list}">
			<tr>
				<td>${q.questionNum}</td>
				<td>
				<c:choose>
                    <c:when test="${q.questionAuthor == userid || userid == 'admin'}">
					<a href="/question/get/${q.questionNum}">${q.questionTitle}</a>
					</c:when>
					<c:otherwise>
                      🔒작성자만 볼수있는 글입니다
                    </c:otherwise>
                </c:choose>
				</td>
				<td>${q.questionAuthor}</td>
				<td>${q.questionDate}</td>
				
			</tr>
		</c:forEach>
	</table>
	</form>
		<c:if test="${userid == null}">
			<div class="user-info">
			<div>
			<a href="/member/login">로그인</a>
			<a href="/member/join">회원가입</a>
			</div>
			</div>
		</c:if>
		<c:if test="${userid != null}">
		<div class="user-info">
		<div>
			ID: ${userid}
			<button type="button" onclick="javascript:logout();">로그아웃</button>
			<button type="button" onclick="javascript:mypage();">마이페이지</button>
		</div>
		</div>
		</c:if>
		<div><a href="/question/add">글쓰기</a></div>
<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>
