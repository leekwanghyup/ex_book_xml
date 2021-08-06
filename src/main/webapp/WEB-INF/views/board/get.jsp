<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/get.css">

<!-- 데이터 start -->
<input type="hidden" name="cateName" value="${board.cateName}">
<input type="hidden" name="title" value="${board.title}">
<input type="hidden" name="content" value="${board.content}">
<input type="hidden" name="writer" value="${board.writer}">
<input type="hidden" name="regDate" value="${board.regDate}">
<!-- 데이터 end -->

<sec:authentication property="principal" var="pinfo" />


<div class="row">
	<div class="col-lg-12">
		
		<div class="get_title">
			<h4>${board.title}</h4>
		</div>
		<div class="get_head">
			<div class="cateName">
				<img src="/resources/images/sc_icon.png" /> ${board.cateName}
			</div>
			<div class="custom-flex">
				<div class="bno">글번호 : ${board.bno}</div>
				<div class="writer">작성자 : ${board.writer}</div>
				<div class="date">
					작성일 :
					<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm" />
				</div>
			</div>
		</div>

		<div class="get_body">
			<div class="content">${board.content}</div>
		</div>
		<div class="get_tail" style="border-top : 1px solid #a2a2a2;">	
			<div class="custom-flex">
				<div class="hit">
					<b>조회</b>:!200!
				</div>
				<div class="reply">댓글 :!34!</div>
				<div class="recommend">
					<b>추천</b>:!10!
				</div>
			</div>
		</div>

		<form class="board_form">
			<input type="hidden" name="bno" id="bno" value="${board.bno}">
			<input type="hidden" name="writer" value="${board.writer}"> <input
				type="hidden" name="category" value="${board.category}">
			<button data-oper='list' class="btn getBtn">목록</button>

			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }">
			<sec:authorize access="isAuthenticated()">
				<c:if test="${pinfo.username eq board.writer}">
					<button data-oper='delete' class="btn getBtn pull-right mx-1">삭제</button>
					<button data-oper='modify' class="btn getBtn pull-right mx-1">수정</button>
				</c:if>
			</sec:authorize>
		</form>

	</div>
</div>
<!-- row end  -->

<sec:authorize access="isAuthenticated()">
	<div class="margin-top-80 replyWriteForm">
		<div class="py-2">
			<strong class="replyer">${pinfo.username}</strong>
		</div>
		<div>	
			<textarea class="form-control" rows="7"
				placeholder="저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관 및 관련 법률에 의해 제재를 받을 수 있습니다. 건전한 토론문화와 양질의 댓글 문화를 위해, 타인에게 불쾌감을 주는 욕설 또는 특정 계층/민족, 종교 등을 비하하는 단어들은 표시가 제한됩니다."></textarea>
		</div>
		<div class="clearfix">
			<button id="registerBtn" class="btn getBtn my-2 pull-right">등록</button>
		</div>
	</div>
</sec:authorize>

<ul class="list-group chat my-4"></ul>

<script>
	let bno = $('input[name="bno"]').val();
	
	$('button').on('click',function(e){
		e.preventDefault();
		let $board_form = $('.board_form');
		let oper = $(this).data('oper')
		let category = $('input[name="category"]').val();
		
		if(oper == 'list'){
			location.href = "/board/list?category="+category;
		}
		if(oper == 'modify'){
			location.href = "/board/modify?bno="+bno;
		}
		if(oper == 'delete'){
			$board_form.attr('method','post')
			$board_form.attr("action","/board/remove")
			$board_form.submit();
		}
	})
	
	let replyer = null;
	<sec:authorize access="isAuthenticated()">
	 	replyer = '${pinfo.username}';
	 	console.log(replyer);
	</sec:authorize>

	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
	}); 
</script>

<script src="/resources/js/reply.js"></script>
<script src="/resources/js/get.js"></script>

<%@ include file="../includes/footer.jsp"%>