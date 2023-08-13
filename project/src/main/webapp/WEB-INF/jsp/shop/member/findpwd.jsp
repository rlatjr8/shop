<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>
</head>
<body>
<main>
	<h3>비밀번호 찾기</h3>
	<form action="/member/findpwd" method="post">
    <div>
        <label for="memberID">가입 시 아이디</label>
        <input type="text" name="memberID" id="memberID">
    </div>
     <div>
        <label for="memberName">가입 시 이름</label>
        <input type="text" name="memberName" id="memberName">
    </div>
    <div>
        <button type="submit" >찾기</button>
    </div>
	</form>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>