<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.io.PrintWriter" %>
<html>
	<head> 
		<meta charset="UTF-8">
		<meta name = "viewport" content = "width=device-width" , initial-scale="1"> <!-- 반응형 웹에 사용되는 메타 테그. -->
		<link rel = "stylesheet" href = "css/bootstrap.css"> <!-- 디자인을 담당하는 css 참조. -->
		<link rel = "stylesheet" href = "css/custom.css">
		<title>JSP 게시판 웹 사이트</title> 
	</head> 
	<body>
	
	<% //세션 설정. (로그인이 되어있다면 이 jsp로 들어올 일은 없을 것이다. 그러나 주소로 인한 접근 ex)/login.jsp와 같은.. 일 경우에는 접근 될 수도 있으니 이를 대비하여 적어주는 부분.)
			String sessionID = null;
			if(session.getAttribute("userSessionID") != null) {
				sessionID = (String)session.getAttribute("userSessionID");
			}
			if(sessionID != null) { //회원가입페이지로 못들어가게 한다. // 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 돼있습니다')");
				script.println("location.href = 'main.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
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
					<li><a href="main.jsp">메인</a></li>
					<li><a href="bbs.jsp">게시판</a></li>
					
				</ul>
				
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<!-- #은 아무대도 안간다는 뜻. -->
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria=haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a> <!-- caret = 하나의 아이콘 같은 것. -->
						
						<ul class="dropdown-menu">
							<!-- active는 현재 선택됐다는 것. -->
							<li><a href="login.jsp">로그인</a></li>
							<li class="active"><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>
			</div> 
		</nav>
	
	
	
	
		
		<!-- 회원가입 양식 만들기. -->
		<div class ="container"> <!-- html. 클래스는 내가 정의 하는 것. -->
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top:20px;">
					<form method = "post" action="joinAction.jsp">
						<h3 style="text-align: center;">회원가입 화면</h3>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
						</div>
						<div class="form-group">
							<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
						</div> 
						<div class="form-group" style="text-align: center;">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary active">
									<input type="radio" name="userGender" autocomplete="off" value="남자" checked> 남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="userGender" autocomplete="off" value="여자" checked> 여자
								</label>
							</div>
							
						</div> 
						<div class="form-group">
							<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
						</div> 
						<input type="submit" class="btn btn-primary form-control" value="회원가입">
					</form>
				</div>	
			</div>
			<div class="col-lg-4"></div>
		</div>
		
		
		
		
		
		
		
		<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- 애니메이션을 담당하게 될 자바스크립트 참조. -->
		<script src = "js/bootstrap.js"></script>
		
	</body> 
</html>