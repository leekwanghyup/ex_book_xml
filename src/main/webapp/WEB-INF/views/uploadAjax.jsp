<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js'></script>
</head>
<style>
.uploadResult {
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
<body>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple" />
	</div>
	<button id='uploadBtn'>업로드</button>

	<div class="uploadResult">
		<ul>
			<li>업로드 결과 창1</li>
			<li>업로드 결과 창2</li>
		</ul>
	</div>

	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
</body>
<script>
$(function(){
	let cloneObj = $(".uploadDiv").clone(); 
	
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
			dataType : 'json',
			success : function(result){
				console.log(result);
				showUploadFile(result);	// 업로드 된 파일 표시 함수 실행 
				$('.uploadDiv').html(cloneObj.html());
			}
		}); 		
	});
	
	// 업로든 된 파일 목록 표시 
	let uploadResult = $(".uploadResult ul");
	function showUploadFile(uploadResultArr){
		let str = ""; 
		$(uploadResultArr).each(function(i, obj){
			if(!obj.image){
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				str += "<li><a href='/download?fileName="+fileCallPath+"'>" 
      		  			+"<img src='/resources/images/attach.png'>"+obj.fileName+"</a>"
      		  			+ "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>";
      		  			+"</li>"	
			} else {
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				let originPath = obj.uploadPath + "\\" +obj.uuid + "_" + obj.fileName; 
				originPath = originPath.replace(new RegExp(/\\/g), "/"); 
				str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
	              "<img src='display?fileName="+fileCallPath+"'></a>"+
	              "<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span><li>"; 
			}
		}); 
		uploadResult.append(str);
	}
	
	
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
	
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
			setTimeout(() => {
				$(this).hide();
			}, 1000);
		});
		
		// x표시에 대한 이벤트 
		$(".uploadResult").on("click","span", function(e){
			   
		  let targetFile = $(this).data("file");
		  let type = $(this).data("type");
		  console.log(targetFile);
		  
		  $.ajax({
		    url: '/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		      success: function(result){
		         alert(result);
		       }
		  }); //$.ajax
		  
		});
}); 


//showImage
function showImage(fileCallPath){
	$(".bigPictureWrapper").css("display","flex").show();  
	$(".bigPicture")
	  .html("<img src='/display?fileName="+fileCallPath+"'>")
	  .animate({width:'100%', height: '100%'}, 1000);
}

</script>
</html>