<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/get.css">

<!-- 데이터 start -->
<input type="hidden" name="cateName" value="${board.cateName}">
<input type="hidden" name="title" value="${board.title}">
<input type="hidden" name="content" value="${board.content}">
<input type="hidden" name="writer" value="${board.writer}">
<input type="hidden" name="regDate" value="${board.regDate}">
<!-- 데이터 end -->

<div class="row">
    <div class="col-lg-12">
        <h3>${board.cateName}</h3>
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="custom-flex">
                    <div class="bno">글번호 : ${board.bno}</div>
                    <div class="writer">작성자 : ${board.writer}</div>
                    <div class="date">작성일 : 
                    	<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </div>
                    <div class="hit"><b>조회</b>:!200!</div>
                    <div class="reply">댓글 :!34!</div>
                    <div class="recommend"><b>추천</b>:!10!</div>
                </div>
            </div>
            <div class="panel-body">
                <div class="title"><b>${board.title} </b></div><hr>
                <p class="content">
                   ${board.content}
                </p>
            </div>
        </div>
        <form class="board_form">
        	<input type="hidden" name="bno" value="${board.bno}">
        	<input type="hidden" name="category" value="${board.category}">
        	<button data-oper='list' class="btn btn-info">목록</button>
			<button data-oper='delete' class="btn btn-danger pull-right mx-1">삭제</button>
        	<button data-oper='modify' class="btn btn-default pull-right mx-1">수정</button>
        </form>
		
    </div>
</div>
<script>
	$('button').on('click',function(e){
		e.preventDefault();
		let $board_form = $('.board_form');
		let oper = $(this).data('oper')
		let category = $('input[name="category"]').val();
		let bno = $('input[name="bno"]').val();
		
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
</script>

<%@ include file="../includes/footer.jsp" %>