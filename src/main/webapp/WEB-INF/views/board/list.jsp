<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>list.jsp</h1>
<div>
	<c:forEach items="${list}" var="b">
		제목 : ${b.title }	<br>
		내용 : ${b.content } <br>
		작성자 : ${b.writer } <br>
		<hr>
	</c:forEach>	
</div>
</body>
</html>