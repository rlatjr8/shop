<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>마이페이지</title>
<style type="text/css">
body {
      font-family: Arial, sans-serif;
    }

    main {
      width: 80%;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      background-color: #f8f8f8;
      border-radius: 10px;
      box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
    }

    h3 {
      text-align: center;
      margin-bottom: 20px;
    }

    div {
      margin-bottom: 10px;
    }

    label {
      display: inline-block;
      width: 100px;
      font-weight: bold;
    }

    nav {
      text-align: center;
      margin-top: 20px;
    }

    a {
      text-decoration: none;
      color: #448AFF;
    }

    a:hover {
      text-decoration: underline;
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">


</script>
</head>
<body>
<main>
	<h3>내 정보</h3>
	<div><label>이름</label>${mem.memberName}</div>
	<div><label>번호</label>${mem.memberPhone}</div>
	<div><label>주소</label>${mem.memberAddress}</div>
	<div><label>ID</label>${mem.memberID}</div>
	<div><label>이메일</label>${mem.memberEmail}</div>
	<div><label>성별</label>${mem.memberSex}</div>
	<div><label>국적</label>${mem.national}</div>
	<div><label>생일</label>${mem.memberBirth}</div>
	<div><label>관심사</label>${mem.interest}</div>
	<div><label>적립금</label>${mem.saveMoney}</div>
	<div><label>등급포인트</label>${mem.point}</div>
	<nav>
		[<a href="/member/update/${mem.memberID}">내 정보 수정</a>]
		[<a href="/member/">처음으로</a>]
		[<a href="/cart/list">장바구니</a>]
		[<a href="/order/list">결제내역</a>]
	</nav>
	
</main>
</body>
</html>