<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>품목</title>
<style type="text/css">
#sidebar {
    position: fixed;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 15%;
    padding: 10px;
    background-color: white;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    z-index: 1000;
    white-space: nowrap;
 
}
#aaa {
        text-decoration: none;
        color: black;
        font-weight: bold;
    }
 </style>
</head>
<body>
<div id="sidebar">

<a id="aaa" href="/item/list/1?category=상의">상의</a>
<a id="aaa" href="/item/list/1?category=하의">하의</a>
<a id="aaa" href="/item/list/1?category=아우터">아우터</a>
<a id="aaa" href="/item/list/1?category=모자">모자</a>
<a id="aaa" href="/item/list/1?category=가방">가방</a>
<a id="aaa" href="/item/list/1?category=악세사리">악세사리</a>
<a id="aaa" href="/item/list/1?category=신발">신발</a>
<a id="aaa" href="/item/list/1?category=뷰티">뷰티</a>


</div>
</body>
</html>