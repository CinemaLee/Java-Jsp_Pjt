<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<meta name = "viewport" content = "width=device-width" , initial-scale="1"> <!-- 반응형 웹에 사용되는 메타 테그. -->
		<link rel = "stylesheet" href = "css/bootstrap.css"> <!-- 디자인을 담당하는 css 참조. -->
		<link rel = "stylesheet" href = "css/custom.css"> <!-- custom.css 를 만들어서 나만의 폰트 설정 가능. -->
		<title>JSP 게시판 웹 사이트</title> 
	</head> 
	<body>
	
		<% //세션 설정.
			String sessionID = null;
			if(session.getAttribute("userSessionID") != null) {
				sessionID = (String)session.getAttribute("userSessionID");
			}
		
		
		%>
	
	
	
		<!-- 네비게이션 구현 : 하나의 웹사이트의 전반적인 구성을 보여주는 역할. -->
		<nav class="navbar navbar-default">
			<div class="navbar-header"> <!-- 헤더 부분: 홈페이지의 로고 담당. -->
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collpase" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class ="icon-bar"></span> <!-- 오른쪽 위에 세줄짜리 메뉴표시 -->
					<span class ="icon-bar"></span>
					<span class ="icon-bar"></span>	
				</button>
				<!-- brand는 로고같은 것을 의미 -->
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
			</div>
			
			
			
			<div class="collpase navbar-collpase" id="#bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="main.jsp">메인</a></li> <!-- class="active" -> 현재 접속 페이지를 알려주는 표시.  -->
					<li><a href="bbs.jsp">게시판</a></li>
				</ul>
				
				<%
					if(sessionID == null) { //sessionID가 없다면(로그인이 안되어있다면 보여준다.)
				%>
						<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<!-- #은 아무대도 안간다는 뜻. -->
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria=haspopup="true"
								aria-expanded="false">접속하기<span class="caret"></span></a> <!-- caret = 하나의 아이콘 같은 것. -->
							
							<ul class="dropdown-menu">
								
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul>
						</li>
					</ul>
				
				
				
				<%
					} else { //로그인 되어있는 사람들에게만 보이는 부분.
				%>
						<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<!-- #은 아무대도 안간다는 뜻. -->
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria=haspopup="true"
								aria-expanded="false">회원관리<span class="caret"></span></a> <!-- caret = 하나의 아이콘 같은 것. -->
							
							<ul class="dropdown-menu">
								
								<li><a href="logoutAction.jsp">로그아웃</a></li>
								
							</ul>
						</li>
					</ul>
				
				
				
				<%
					}
				%>
				
				
			</div> 
		</nav>
		
		<div class="container">
			<div class="jumbotron"> <!-- 보통 소개하는 영역에 사용하는 bootStrap 클래스 -->
				<div class="container">
					<h1>웹 사이트 소개</h1>
					<p>JSP와 Mysql, BootStrap FramWork를 사용하여 간단한 로직으로 구성된 웹사이트를 만들어 보았습니다.</p>
					<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div id="myCarousel" class="carousel slide" data-ride="carousel"> <!--carousel은 사진첩 같은것. -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>
				
				<div class="carousel-inner">
					<div class = "item active">
						<img src="images/1.jpg">
					</div>
					<div class = "item">
						<img src="images/2.jpg">
					</div>
					<div class = "item">
						<img src="images/3.jpg">
					</div>
				</div>
				
				<a class = "left carousel-control" href="#myCarousel" data-slide="prev">
					<span class="glyphicon glyphicon-chevron-left"></span>
				</a>
				<a class = "right carousel-control" href="#myCarousel" data-slide="next">
					<span class="glyphicon glyphicon-chevron-right"></span>
				</a>
			</div>
		
		</div>
		
		
		<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- 애니메이션을 담당하게 될 자바스크립트 참조. -->
		<script src = "js/bootstrap.js"></script>
		
	</body> 
</html>