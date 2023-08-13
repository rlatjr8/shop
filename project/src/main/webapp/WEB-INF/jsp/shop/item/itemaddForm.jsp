<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>아이템 추가</title>
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
function addBoard() {
	  var formData = new FormData($('#addForm')[0]);
	  $.ajax({
	    url : '/item/add',
	    method:'post',
	    enctype:'multipart/form-data',
	    cache:false,
	    processData: false,
	    contentType: false,
	    data: formData,
	    dataType:'json',
	    success:function(res){
	      alert(res.added ? '등록완료':'등록실패');
	      location.href='/item/list/1';
	   
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
	<h3>아이템 추가</h3>
	<form id="addForm" action="/item/add" method="post" 
										onsubmit="return addBoard();"  enctype="multipart/form-data">
		
		<div><label for="goods">상품명</label>
			<input type="text" id="goods" name="goods">
		</div>
		<div><label for="price">상품가격</label>
			<input type="text" id="price" name="price">
		</div>
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
		<textarea rows="5" cols="25" name="explain" id="explain" required>
		</textarea>
		</div>
		<div>
		  <label for="items">상품사진</label>
		  <input type="file" id="files" name="files" multiple>
		  <img id="preview" src="" alt="미리보기 이미지" style="display:none; max-width:200px;">
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