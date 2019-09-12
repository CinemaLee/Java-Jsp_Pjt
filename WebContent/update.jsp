<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.bbsDAO" %>
<%@ page import="bbs.bbsDTO" %>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<meta name = "viewport" content = "width=device-width" , initial-scale="1"> <!-- 반응형 웹에 사용되는 메타 테그. -->
		<link rel = "stylesheet" href = "css/bootstrap.css"> <!-- 디자인을 담당하는 css 참조. -->
		<link rel = "stylesheet" href = "css/custom.css">
		<title>JSP 게시판 웹 사이트</title> 
	</head> 
	<body>
	
		<%
			String sessionID = null;
			if(session.getAttribute("userSessionID") != null) {
				sessionID = (String)session.getAttribute("userSessionID");
			}
			
			if(sessionID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요.')");
				script.println("location.href = 'login.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			
			int bbsID=0;
			if(request.getParameter("bbsID") != null) {
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
			if(bbsID==0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글 입니다.')");
				script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			
			bbsDTO bbsdto = new bbsDAO().Getbbs(bbsID);
			if(!sessionID.equals(bbsdto.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
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
					<li><a href="main.jsp">메인</a></li> <!-- class="active" -> 현재 접속 페이지를 알려주는 표시.  -->
					<li class="active"><a href="bbs.jsp">게시판</a></li>
				</ul>
				
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
				
				
				
				
			</div> 
		</nav>
		
		<!-- 게시판 디자인 -->
		<div class="container">
			<div class="row">
			
				<form action="updateAction.jsp?bbsID=<%= bbsID %>" method="post">
				
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>
								
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbsdto.getBbsTitle() %>"></td>
								
							</tr>
							<tr>
								<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;" ><%= bbsdto.getBbsContent() %></textarea></td>
							</tr>
						</tbody>
					
					</table>
					<input type="submit" class="btn btn-primary pull-right" value="글수정"> 	
					
				</form>
			</div>
		</div>
		<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- 애니메이션을 담당하게 될 자바스크립트 참조. -->
		<script src = "js/bootstrap.js"></script>
		
	</body> 
</html>