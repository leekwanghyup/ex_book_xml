<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/list.css">

<!-- 데이터 -->
<input type="hidden" value="${param.category}" id="category">


<span id="board_cate"></span>

<div class="row margin-top-50">
	<div class="col-sm-8">
		<form id="searchForm" action="/board/list" method="get"
			class="form-inline">
			<select name="type" class="form-control search">
				<option value=""
					<c:out value="${pageMaker.cri.type == null ? 'selected':''}"/>>-------</option>
				<option value="T"
					<c:out value="${pageMaker.cri.type eq 'T' ? 'selected':''}"/>>제목</option>
				<option value="C"
					<c:out value="${pageMaker.cri.type eq 'C' ? 'selected':''}"/>>내용</option>
				<option value="W"
					<c:out value="${pageMaker.cri.type eq 'W' ? 'selected':''}"/>>작성자</option>
				<option value="TC"
					<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected':''}"/>>제목
					or 내용</option>
				<option value="TW"
					<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected':''}"/>>제목
					or 작성자</option>
				<option value="TWC"
					<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected':''}"/>>제목
					or 작성자 or 내용</option>
			</select> <input type='text' name='keyword' class='form-control keyword' placeholder="검색어를 입력하세요."> 
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
			<input type="hidden" name='category' value="${param.category}">
			<button class="btn searchBtn">검색</button>
		</form>
	</div>
	<div class="col-sm-4">
		<a href="#" class="btn pull-right" id="writeForm">글쓰기</a>
		<a class="btn pull-right">새로고침</a>
	</div>
</div>

<div class="row my-5">
	<input type="hidden" value="free" />
	<div class="col-sm-12">
		<c:forEach items="${list}" var="board">
			<ul class="board_list">
				<li>
					<b><a href="/board/get?bno=${board.bno}" style="color:#99bbff ">[${board.title}]</a></b>
					<span class="pull-right">${board.writer}</span> 
				</li>
				<li>
					<a href="/board/get?bno=${board.bno}" >${board.content}</a>
					<span class="pull-right">
						<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm" />
					</span>
				</li>
			</ul>
		</c:forEach>
	</div>
	<!-- col -->
</div>
<!-- row -->


<div class="row pageNav">
	<ul class="pagination">
		<li class="paginate_button"><a href="1">처음으로</a></li>
		<c:if test="${pageMaker.prev}">
			<li class="paginate_button previous"><a
				href="${pageMaker.startPage-1}">이전</a></li>
		</c:if>

		<c:forEach var="num" begin="${pageMaker.startPage}"
			end="${pageMaker.endPage}">
			<li
				class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
				<a href="${num}">${num}</a>
			</li>
		</c:forEach>

		<c:if test="${pageMaker.next}">
			<li class="paginate_button next"><a
				href="${pageMaker.endPage + 1}">다음</a></li>
		</c:if>
	</ul>

	<form action="/board/list" id="actionForm" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}" />
		<input type="hidden" name="category" value="${param.category}">
		<input type="hidden" id="cateName" name="cateName" >
	</form>
</div>


<script>
	$(function() {
		var category = $('#category').val();
		if (category === 'free') {
			$('#board_cate').html('자유게시판');
			$('#cateName').val('자유게시판')
		}
		if (category === 'notice') {
			$('#board_cate').html('공지사항');
			$('#cateName').val('공지사항')
		}
		if (category === 'strategy') {
			$('#board_cate').html('전략전술');
			$('#cateName').val('전략전술')
		}
		if (category === 'qna') {
			$('#board_cate').html('묻고답하기');
			$('#cateName').val('묻고답하기')
		}

		$('#writeForm').on('click', function(e) { //글쓰기 폼으로 이동 
			e.preventDefault();
			let category = "category=" + $('#category').val();
			let cateName = "cateName=" + $('#cateName').val()
			location.href = "/board/register?" + category + "&" + cateName;
		})

		// 페이지네비게이션 
		$(".paginate_button a").on(
				"click",
				function(e) {
					let $actionForm = $('#actionForm');
					e.preventDefault();
					console.log('click');
					$actionForm.find("input[name='pageNum']").val(
							$(this).attr("href"));
					$actionForm.submit();
				});

		// 검색 
		let $searchForm = $('#searchForm');
		$("#searchForm button").on("click", function(e) {
			e.preventDefault();
			if (!$searchForm.find("option:selected").val()) {
				alert('검색종류를 선택하세요');
				return false;
			}

			if (!$searchForm.find("input[name='keyword']").val()) {
				alert('키워드를 입력하세요');
				return false;
			}
			$searchForm.find("input[name='pageNum']").val("1");
			//let category = $('#category').val();

			searchForm.submit();
		});
	})
</script>
<%@include file="../includes/footer.jsp"%>
