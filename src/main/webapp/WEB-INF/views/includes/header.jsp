<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/common.css">
<body> 
<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#Navbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>                        
        </button>
            <!-- <a class="navbar-brand" href="#">Home</a> -->
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-left">
            	<li><a href="/">메인</a></li>
                <li><a href="/board/list?category=notice">공지사항</a></li>
                <li><a href="/board/list?category=news">뉴스</a></li>
                <li><a href="/board/list?category=free">자유게시판</a></li>
                <li><a href="/board/list?category=strategy">전략전술</a></li>
                <li><a href="/board/list?category=qna">묻고답하기</a></li>
                <li><a href="#">리플레이</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">회원가입</a></li>
                <li><a href="#">로그인</a></li>
            </ul>
        </div>
        <div class="jumbotron text-center">
            <h1>COMPANAY</h1> 
        </div>        
    </div>
</nav>

<div class="container">
