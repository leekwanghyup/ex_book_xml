<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>누구나 접근가능한 페이지</h2>
	<sec:authorize access="isAnonymous()">
		<a href="#">로그인</a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<a href="#">로그아웃</a>
	</sec:authorize>
</body>
</html>