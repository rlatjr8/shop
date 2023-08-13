<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항</title>
<style type="text/css">
main{width:fit-content; margin:0.5em auto; }
main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px;}

main>h3 {text-align:center; }
table { border:1px solid black; border-spacing: 0; border-collapse: collapse;}
th { background-color: #eee; padding:0.2em 1em; border-bottom: 3px double black;}
th, td { border-right: 1px solid black;}
td {padding:0.2em 1em; border-bottom: 1px dashed black;}
a {text-decoration: none; color:blue;}
#aa {color:black;}


    /* 전체 스타일 */
    * {
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #fafafa;
        margin: 0;
        padding: 0;
    }

    /* 헤더(상단) */
    header {
        position: relative;
        background-color: #367fa9;
        color: white;
        padding: 10px 20px;
    }

    header h1 {
        margin: 0;
        font-size: 1.3rem;
    }

    /* 메인 콘텐츠 */
    main {
        width: fit-content;
        margin: 0.5em auto;
        padding: 1em;
        background-color: white;
        border: 1px solid #ddd;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        position: relative;
    }

    main h3 {
        text-align: center;
        margin: 0 0 1em;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th,
    td {
        text-align: left;
        padding: 12px 20px;
        border-bottom: 1px solid #ddd;
    }

    th:first-child,
    td:first-child {
        width: 60%;
    }

    th {
        background-color: #f5f5f5;
    }

    tr:nth-child(even) td {
        background-color: #fafafa;
    }

    /* 링크 스타일 */
    a {
        text-decoration: none;
        color: #367fa9;
    }

    a:hover {
        color: #154c72;
    }

    

    .writebutton:hover {
        background-color: #154c72;
    }
	.write-button-container {
    position: absolute;
    right: 1rem;
    bottom: 1rem;
	}
    /* 반응형 웹 디자인 */
    @media screen and (max-width: 600px) {
        th:first-child,
        td:first-child {
            width: auto;
        }

        th,
        td {
            padding: 8px 10px;
        }

        main {
            width: 100%;
            margin: 0;
        }
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>공지사항</h3>
	
	<table>
		<tr><th>제목</th><th>작성자</th><th>작성일</th></tr>
		<c:forEach var="n" items="${list}">
			<tr>
				
				<td>
					<a href="/notice/detail/${n.noticeNum}">${n.noticeTitle}</a>
				</td>
				<td>${n.noticeAuthor}</td>
				<td>${n.noticedate}</td>
						
			</tr>
		</c:forEach>
	</table>
	
		
		<c:if test="${userid != null && userid == 'admin'}">
		<a href="/notice/add">글쓰기</a></div>
		</c:if>
		<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>
