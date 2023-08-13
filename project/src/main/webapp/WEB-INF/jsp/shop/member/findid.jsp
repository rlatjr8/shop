<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>아이디 찾기</title>
<style type="text/css">
main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px;}
main > h3 { text-align: center;}
a { text-decoration: none; }
#aa {color:black;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>아이디 찾기</h3>
	<form action="/member/findid" method="post">
    <div>
        <label for="memberEmail">가입 시 이메일</label>
        <input type="text" name="memberEmail" id="memberEmail">
    </div>
    <div>
        <button type="submit" >찾기</button>
    </div>
	</form>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>