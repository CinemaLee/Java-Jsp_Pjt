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
			
			int bbsID = 0;
			if(request.getParameter("bbsID") != null) {
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
			
			if (bbsID == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			
			bbsDTO bbs = new bbsDAO().Getbbs(bbsID);		
			
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
		
		<!-- 게시판 디자인 -->
		<div class="container">
			<div class="row">
			
				
				
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
								
							</tr>
						</thead>
						
						<tbody>
							<tr>
								
								<td style="width: 20%;">글 제목</td>
								<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
								
							</tr>
							<tr>
								
								<td>작성자</td>
								<td colspan="2"><%= bbs.getUserID() %></td>
								
							</tr>
							<tr>
								
								<td>작성일자</td>
								<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시" + bbs.getBbsDate().substring(14,16) + "분"  %></td>
								
							</tr>
							<tr>
								
								<td>내용</td>
								<!-- 특수문자 처리부분. 꼭 필요하다.  -->
								<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></td>
								
							</tr>
							
						</tbody>
					
					</table>
					
					<a href="bbs.jsp" class="btn btn-primary">목록</a>
					
					<%
						if(sessionID != null && sessionID.equals(bbs.getUserID())){ //글쓴이 본인만 수정가능하게.

					%>
					
						<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID %>" class="btn btn-primary">삭제</a>
					
					
					<%
						}
					%>
						
					
				
			</div>
		</div>
		<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- 애니메이션을 담당하게 될 자바스크립트 참조. -->
		<script src = "js/bootstrap.js"></script>
		
	</body> 
</html>