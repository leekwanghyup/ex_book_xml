<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">글쓰기</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">글쓰기</div>
			<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<input type="hidden" name="category" value="${param.category}">
					<!-- 게시판 카테고리 -->
					<input type="hidden" name="cateName" value="${param.cateName}">
					<!-- 게시판 카테고리 이름 -->
					<div class="form-group">
						<label>title</label> <input type="text" name="title"
							class="form-control">
					</div>
					<div class="form-group">
						<label>content</label>
						<textarea rows="8" cols="" class="form-control" name="content"></textarea>
					</div>
					<div class="form-group">
						<label>writer</label> <input type="text" name="writer"
							class="form-control"
							value='<sec:authentication property="principal.username"/>'
							readonly="readonly">
					</div>
					<button type="submit" class="btn bnt-default">확인</button>
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }">
				</form>
			</div>
		</div>
	</div>
	<div class="attach_box">
		<h2>파일첨부</h2>
		<input type="file" name="uploadFile" multiple="multiple">
	</div>
	<div class="uploadResult">
		<ul></ul>
	</div>
</div>

<script>
	let csrfHeaderName ="${_csrf.headerName}"; 
	let csrfTokenValue="${_csrf.token}";

	//파일 유효성 검사 및 확장자 제한
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880;

	function checkExtension(fileName, fileSize) {
		if (fileSize >= maxSize) {
			alert('파일크기 초과');
			return false;
		}
		if (regex.test(fileName)) {
			alert('해당 종류의 파일은 업로드 할 수 없습니다.');
			return false;
		}
		return true;
	}

	$(function() {
		
		let formObj = $("form[role='form']");
		$("button[type='submit']").on("click", function(e) {
			e.preventDefault();
		});

		$("input[type='file']").on("change", function() {
			let formData = new FormData();
			let inputFile = $('input[name="uploadFile"]');
			let files = inputFile[0].files;
			
			for (let i = 0; i < files.length; i++) {
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log(result); 
					showUploadResult(result);
				}
			}); //$.ajax
		});

		function showUploadResult(uploadResultArr) {
			
			if (!uploadResultArr || uploadResultArr.length == 0) {
				return;
			}
			let uploadResult = $(".uploadResult ul");

			let str = "";

			$(uploadResultArr).each(function(i, obj){
			
				if (obj.image) {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+ obj.uuid + "_" + obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"'";
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str +" ><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
				str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str + "</li>";
				} else {
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/"
							+ obj.uuid + "_" + obj.fileName);
					let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
	
					str += "<li "
				str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
				str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str + "</li>";
				}
			});
			uploadResult.append(str);
		}
	});
</script>
<%@ include file="../includes/footer.jsp"%>