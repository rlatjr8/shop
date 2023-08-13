<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>상품 수정</title>
<style type="text/css">
	main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px;}
	#aa {color:black;}
	body {
	      font-family: Arial, sans-serif;
	    }

	textarea { width:202px; margin-top:2px;}
	#divContents>label { position:relative; top:-2.5em;}
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
function delItem(itemNum) {
    if (!confirm('정말로 삭제하시겠어요?')) return;
    $.ajax({
        url: '/item/delete/' + itemNum,
        method: 'get',
        cache: false,
        dataType: 'json',
        success: function (res) {
            alert(res.deleted ? '삭제성공' : '삭제실패');
            location.href = '/item/list/1';

        },
        error: function (xhr, status, err) {
            alert('에러:' + status + '/' + err);
        }
    });
    return false;
}

function updateItem() {
	var serdata = $('#updateForm').serialize();
	$.ajax({
		url:'/item/update',
		method:'post',
		cache:false,
		data:serdata,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정 성공':'수정 실패');
			if(res.updated) location.href='/item/detail/${itemNum}';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	return false;
}
</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>상품 수정</h3>
	<form id="updateForm" onsubmit="return updateItem();">
		<input type="hidden" name="itemNum" value="${item.itemNum}">
	<table>
		<div><label>상품명</label><input type="text" name="goods" value="${item.goods}"></div>
		<div><label>가격</label><input type="text" name="price" value="${item.price}"></div>
		<div><label for="category">카테고리</label>
		<select name="category">
			<option value="상의">상의</option>
			<option value="하의">하의</option>
			<option value="아우터">아우터</option>
			<option value="신발">신발</option>
			<option value="가방">가방</option>
			<option value="모자">모자</option>
			<option value="악세사리">악세사리</option>
			<option value="뷰티">뷰티</option>
		</select>
		</div>
		<div id="divContents">
		<label for="explain">상품설명</label>
		<textarea rows="5" cols="25" name="explain" required>${item.explain}
		</textarea>
		</div>
		
		
	</table>
	<div id="btn">
		
		<button type="submit">수정</button>
	</div>
	</form>
	<nav>
		[<a href='/item/detail/${itemNum}'>취소</a>]
		[<a href="javascript:delItem(${item.itemNum});">삭제</a>]
	</nav>
	
	<jsp:include page="../sidebar.jsp" />
	
</main>
</body>
</html>