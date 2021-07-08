<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="includes/header.jsp" %>


<div class="row">
    <div class="panel panel-info">
        <div class="panel-heading"><span>최신글</span></div>
        <div class="panel-body">
            <ul>
	             <c:forEach var="b" items="${lastest}">
             		<li><strong>[${b.cateName}]</strong>
             		<a href="/board/get?bno=${b.bno}"> 
             		<span> ${b.title}</span></a></li>	
	             </c:forEach>		                       
            </ul>
        </div>
    </div>
</div>

<!-- 뉴스 -->
<div class="row">
    <div class="panel panel-info">
        <div class="panel-heading"><span>뉴스</span><span class="more"><a href="#">+more...</a></span></div>
        <div class="panel-body">
            <div class="col-sm-4">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <img src="http://placehold.it/400x300" class="img-responsive margin" style="width:100%" alt="Image">
              </div>
              <div class="col-sm-4"> 
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <img src="http://placehold.it/400x300" class="img-responsive margin" style="width:100%" alt="Image">
              </div>
              <div class="col-sm-4"> 
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <img src="http://placehold.it/400x300" class="img-responsive margin" style="width:100%" alt="Image">
              </div>
        </div>
    </div>
</div>

<!--  공지사항, 자유게시판   -->
<div class="row">    
       <div class="col-sm-6 notice">
           <div class="panel panel-info">
               <div class="panel-heading">
                   <span>공지사항</span>
                   <span class="more"><a href="/board/list?category=notice">+more...</a></span>
               </div>
               <div class="panel-body">
                   <ul>
	                   <c:forEach var="b" items="${notice}">
	                   		<li>
	                   			<strong style="color:blue;">[공지사항]</strong> 
	                   			<a href="/board/get?bno=${b.bno}"> <span>${b.title}</span></a>
	                   		</li>	
	                   </c:forEach>		                                    
                   </ul>
               </div>
           </div>    
       </div>
       <div class="col-sm-6" >
           <div class="panel panel-info free">
               <div class="panel-heading">
                   자유게시판
                   <span class="more"><a href="/board/list?category=free">+more...</a></span>
               </div>
               <div class="panel-body">
                   <ul>
	                   <c:forEach var="b" items="${free}">
	                   		<li><strong style="color:red">[자유게시판]</strong>
	                   		<a href="/board/get?bno=${b.bno}"> <span> ${b.title}</span></a></li>	
	                   </c:forEach>		                       
                   </ul>
               </div>
           </div>
       </div> <!--end col-lg-6 -->
   </div>    <!--end row -->
   
   <!-- 전략 전술 -->
   <div class="row">    
       <div class="col-sm-6 notice">
           <div class="panel panel-info">
               <div class="panel-heading">
                   <span>전략/전술</span>
                   <span class="more"><a href="#">+more...</a></span>
               </div>
               <div class="panel-body">
                   <ul>
	                   <c:forEach var="b" items="${strategy}">
	                   		<li><strong style="color:blue;">[전략/전술]</strong><a href="/board/get?bno=${b.bno}"> <span> ${b.title}</span></a></li>	
	                   </c:forEach>		                                    
                   </ul>
               </div>
           </div>    
       </div>
       <div class="col-sm-6" >
           <div class="panel panel-info free">
               <div class="panel-heading">
                   묻고답하기
                   <span class="more"><a href="#">+more...</a></span>
               </div>
               <div class="panel-body">
                   <ul>
	                   <c:forEach var="b" items="${qna}">
	                   		<li><strong style="color:red">[묻고답하기]</strong><a href="/board/get?bno=${b.bno}"><span>${b.title}</span></a></li>	
	                   </c:forEach>		                       
                   </ul>
               </div>
           </div>
       </div> <!--end col-sm-6 -->
   </div> <!--end row -->
<%@include file="includes/footer.jsp" %>
