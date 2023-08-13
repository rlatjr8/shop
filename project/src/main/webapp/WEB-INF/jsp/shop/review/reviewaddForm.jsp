<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>리뷰 작성</title>
<style type="text/css">
	main { width:fit-content; margin:1em auto;}
	main>h3 { text-align: center;}
	form {width:fit-content; border:1px solid black; padding:1em;}
	label {display:inline-block; width:4em; padding:0.3em 1em; text-align:right;}
	div:last-child { text-align: center; margin-top:0.5em;}
	input {width:15em;}
	textarea { width:202px; margin-top:2px;}
	#divContents>label { position:relative; top:-2.5em;}
	#divBtn { text-align:center; margin-top:0.5em;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function addReview() {
	  var formData = new FormData($('#addForm')[0]);
	  $.ajax({
	    url : '/review/add',
	    method:'post',
	    enctype:'multipart/form-data',
	    cache:false,
	    processData: false,
	    contentType: false,
	    data: formData,
	    dataType:'json',
	    success:function(res){
	      alert(res.added ? '등록완료':'등록실패');
	      location.href='/review/list/1';
	   
	    },
	    error:function(xhr,status,err){
	      alert('에러:'+err);
	    }
	  });
	  return false;
}
$(document).ready(function() {
	  $("#files").change(function() {
	    previewImage(this);
	  });
	
	
$("button[type='reset']").click(function() {
  $('#preview').attr('src', ''); // 이미지 src 비우기
  $('#preview').css('display', 'none'); // 이미지 숨기기
});
});
function previewImage(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();

	    reader.onload = function(e) {
	      $('#preview').attr('src', e.target.result);
	      $('#preview').css('display', 'block');
	    }
	    reader.readAsDataURL(input.files[0]);
	  }
}
</script>
</head>
<body>
<main>
	<h3>리뷰 작성</h3>
	<form id="addForm" action="/review/add" method="post" 
										onsubmit="return addReview();"  enctype="multipart/form-data">
		<input type="hidden" name="reviewparentsNum" value="${ItemNum}">
		<div><label for="goods">상품명</label>${o.goods}</div>
		<div><label for="price">상품가격</label>${o.price}</div>
		<div><label for="reviewAuthor">작성자</label>${userid}</div>
		<div><label for="reviewTitle">제목</label>
		<input type="text" id="reviewTitle" name="reviewTitle" required>
		</div>
		<div id="divContents">
		<label for="reviewContents">리뷰</label>
		<textarea rows="5" cols="25" name="reviewContents" id="reviewContents" required>
		</textarea>
		</div>
		<div>
		  <label for="review">리뷰사진 첨부</label>
		  <input type="file" id="files" name="files" multiple>
		  <img id="preview" src="" alt="미리보기 이미지" style="display:none; max-width:200px;">
		</div>
		<div>
			<button type="reset">취소</button>
			<button type="submit">저장</button>
		</div>
	</form>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>