<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>관리자페이지</h2>
	<div class="row">
		<p>CustomeUser 객체 : <br> 
			<sec:authentication property="principal"/>
		<p>
			CustomUser객체의 getMember()메소드 호출 : <br>
			<sec:authentication property="principal.member"/>
		</p>
		<p>
			사용자 이름 : <sec:authentication property="principal.member.userName"/><br>
			사용자 아이디 : <sec:authentication property="principal.member.userid"/><br>
			사용자 권한 리스트 : <sec:authentication property="principal.member.authList"/>
		</p>
	</div>	
	<a href="/customLogout">Logout페이지</a>
</body>
</html>