<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="pinfo"/>

<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-sm-12">
		<div class="panel panel-default">
			<div class="panel-heading">글수정</div>
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="category" value="${board.category}"> 
					<div class="form-group">
						<label>번호</label>
						<input type="text" name="bno" class="form-control" value="${board.bno}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>title</label>
						<input type="text" name="title" class="form-control" value="${board.title}">
					</div>
					<div class="form-group">
						<label>content</label>
						<textarea rows="8" cols="" class="form-control" name="content">
							${board.content}
						</textarea>
					</div>
					<div class="form-group">					
						<label>writer</label>
						<input type="text" name="writer" class="form-control" value="${board.writer}" readonly="readonly">
					</div>
					
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer}">
							<button type="submit" data-oper="modify" class="btn btn-default">수정</button>	
						</c:if>
					</sec:authorize>
					<button type="submit" data-oper="list" class="btn btn-primary">목록</button>
				</form>
			</div>
		</div>
	</div>
</div>