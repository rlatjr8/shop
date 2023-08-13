<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 보기</title>
<style type="text/css">
	main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px; background-color: black; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
    #aa {color:white;}
    a { text-decoration: none; color:blue; }
	main { width:fit-content; margin:0.5em auto;}
	main > h3 {text-align:center; }
	label {width:3em; padding:0.2em 1em; text-align: right;font-weight: bolder; }
	
	nav { text-align: center; margin:0.5em;}
	nav > a {text-decoration: none;}
	textarea { width:23em; margin-top:0.5em;}
	.product {
        width: 400px;
        border: 1px solid #ddd;
        padding: 0.5em;
        margin: 0.5em;
        text-align: center;
        background-color: white;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
	.product img {
        width: 100%;
        height: auto;
    }
    
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>리뷰</h3>
	
	<div class="product">
	<c:forEach var="list" items="${r.reviewattList}">
            <img src="<c:url value='/review/${list.reviewattachName}' />">
    </c:forEach>
	
	<div><label>제목-</label>${review.reviewTitle}</div>
	<div><label>작성자-</label>${review.reviewAuthor}</div>
	<div><label>작성일-</label>${review.reviewdate}</div>
	<div><label>리뷰내용-</label>${review.reviewContents}</div>
	
	</div>
	
		
	<c:if test="${userid != null && userid == 'admin'}">
	
	<a href="/review/update/${reviewNum}">수정</a>
	
	</c:if>	
	
	
	
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>