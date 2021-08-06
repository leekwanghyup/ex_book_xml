<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js'></script>
</head>
<body>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple"/>
	</div>	
	<button id='uploadBtn'>업로드</button>	
</body>
<script>
$(function(){
	$('#uploadBtn').on('click',function(e){
		let formData = new FormData(); 
		let inputFile = $('input[name="uploadFile"]'); 
		let files = inputFile[0].files;
		console.log(files);
		
		for(let i=0; i < files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false; 
			}
			formData.append("uploadFile", files[i]); 
		}
		
		$.ajax({
			url : '/uploadAjaxAction', 
			processData : false, 
			contentType : false, 
			data : formData, 
			type : 'POST', 
			success : function(result){
				alert('uploaded');
			}
		}); 		
	});
	
	// 파일 유효성 검사 및 확장자 제한
	 let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	 let maxSize = 5242880; 
	 
	 function checkExtension(fileName, fileSize){
		 if(fileSize >= maxSize){
			 alert('파일크기 초과'); 
			 return false;  
		 }
		 if(regex.test(fileName)){
			 alert('해당 종류의 파일은 업로드 할 수 없습니다.'); 
			 return false; 
		 }
		 return true;
	 }
}); 
</script>
</html>