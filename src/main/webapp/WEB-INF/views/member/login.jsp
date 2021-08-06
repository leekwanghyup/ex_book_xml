<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>	


<div class="signIn_wrap">
    <form class="signInForm" action="/login" method="post">
        <h1 class="h3">로그인</h1>
        <label for="" class="">아이디</label>
        <input type="text" name="username" class="form-control sign_input" placeholder="아이디" required autofocus>
        <label for="" class="visually-hidden">비밀번호</label>
        <input type="password" name="password" class="form-control sign_input" placeholder="비밀번호" required>
        <div>
            <label>
                <input type="checkbox" name="remember-me"> 로그인 상태 유지
            </label>
        </div>
        <button class="btn btn-lg btn-primary" type="submit">로그인</button>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>
