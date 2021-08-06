<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp"%>

<div class="news latest_body contet_list margin-top-50">
	<div class="row ">
		<span class="latest_title">뉴스</span>
		<div class="col-sm-4">
			<p>2월 20일, 블리즈컨라인에서 스타크래프트 전설의 향연을 시청하세요!</p>
			<img src="/resources/images/new1.jpg" class="img-responsive margin"
				 alt="Image">
		</div>
		<div class="col-sm-4">
			<p>[당첨자 발표] 스타크래프트: 리마스터 런칭 기념 PC방 올나잇 랜파티! ‘GG 투게더 at Seoul’에 여러분을 초대합니다.</p>
			<img src="/resources/images/new2.jpg" class="img-responsive"
				 alt="Image">
		</div>
		<div class="col-sm-4">
			<p>스타크래프트: 리마스터 초상화 경연대회 후보작을 공개합니다!</p>
			<img src="/resources/images/new3.jpg" class="img-responsive"
				 alt="Image">
		</div>
	</div>
</div>



<div class="row margin-top-80">
	<div class="col-sm-6">
		<span class="latest_title">최신글</span>
		<ul class="latest_body">
			<c:forEach var="b" items="${lastest}">
				<li><strong class="main_color">[${b.cateName}]</strong> <a
					href="/board/get?bno=${b.bno}"> <span> ${b.title}</span></a></li>
			</c:forEach>
		</ul>
	</div>
	<div class="col-sm-6 contet_list">
		<span class="latest_title">자유게시판</span>
		<ul class="latest_body">
			<c:forEach var="b" items="${lastest}">
				<li><strong class="main_color">[${b.cateName}]</strong> <a
					href="/board/get?bno=${b.bno}"> <span> ${b.title}</span></a></li>
			</c:forEach>
		</ul>
	</div>
</div>


<!--  공지사항, 자유게시판   -->
<div class="row margin-top-50">
	<div class="col-sm-6">
		<span class="latest_title">공지사항</span>
		<ul class="latest_body">
			<c:forEach var="b" items="${notice}">
				<li><strong style="color: #1ed500;">[공지사항]</strong> <a
					href="/board/get?bno=${b.bno}"> <span>${b.title}</span></a></li>
			</c:forEach>
		</ul>
	</div>

	<div class="col-sm-6">
		<span class="latest_title">자유게시판</span>
		<ul class="latest_body">
			<c:forEach var="b" items="${free}">
				<li><strong class="main_color">[자유게시판]</strong> <a
					href="/board/get?bno=${b.bno}"> <span >
							${b.title}</span></a></li>
			</c:forEach>
		</ul>
	</div>
	<!--end col-lg-6 -->
</div>
<!--end row -->

<!-- 전략 전술 -->
<div class="row margin-top-50">
	<div class="col-sm-6">
		<span class="latest_title">전략/전술</span>
		<ul class="latest_body">
			<c:forEach var="b" items="${strategy}">
				<li><strong style="color: #1ed500;">[전략/전술]</strong><a
					href="/board/get?bno=${b.bno}"> <span>
							${b.title}</span></a></li>
			</c:forEach>
		</ul>
	</div>

	<div class="col-sm-6">
		<span class="latest_title">묻고답하기</span>
		<ul class="latest_body">
			<c:forEach var="b" items="${qna}">
				<li><strong class="main_color">[묻고답하기]</strong><a
					href="/board/get?bno=${b.bno}"> <span class="d7d7d7">${b.title}</span></a></li>
			</c:forEach>
		</ul>
	</div>
	<!--end col-sm-6 -->

</div>
<!--end row -->
<%@include file="includes/footer.jsp"%>
