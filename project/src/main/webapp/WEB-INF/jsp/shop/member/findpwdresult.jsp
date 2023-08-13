<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 찾기 결과</title>
</head>
<body>
 <h3>찾은 비밀번호</h3>
 PWD : ${findpwd}
 <p>
 [<a href="/member/login">로그인</a>]
 <jsp:include page="../sidebar.jsp" />
</body>
</html>