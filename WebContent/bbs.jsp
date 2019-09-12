<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.bbsDAO" %>
<%@ page import="bbs.bbsDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<meta name = "viewport" content = "width=device-width" , initial-scale="1"> <!-- 반응형 웹에 사용되는 메타 테그. -->
		<link rel = "stylesheet" href = "css/bootstrap.css"> <!-- 디자인을 담당하는 css 참조. -->
		<link rel = "stylesheet" href = "css/custom.css">
		<title>JSP 게시판 웹 사이트</title>
		<style type="text/css">
			a, a:hover {
				color : #000000;
				text-decoration: none;
			
			}
		</style>
	</head> 
	<body>
	
		<%
			String sessionID = null;
			if(session.getAttribute("userSessionID") != null) {
				sessionID = (String)session.getAttribute("userSessionID");
			}
			
			int pageNum = 1; //페이지 기본설정. 1페이지
			if(request.getParameter("pageNum") != null) { //pageNum이 어디서 넘어 왔다면
				pageNum = Integer.parseInt(request.getParameter("pageNum")); // 정수형으로 바꿔주어 저장.
			}
			
			///////////////////////////////////////////////////////////////
		
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
						<tr> <!-- 한 행. -->
							<th style="background-color: #eeeeee; text-align: center;">번호</th> <!-- th: 한 행의 한 요소. -->
							<th style="background-color: #eeeeee; text-align: center;">제목</th>
							<th style="background-color: #eeeeee; text-align: center;">작성자</th>
							<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						</tr>
					</thead>
					
					<tbody>
						<%
							bbsDAO bbsdao = new bbsDAO();
							ArrayList<bbsDTO> list = bbsdao.getList(pageNum); //현재 페이지번호를 받아서 리스트화.
							for(int i=0; i<list.size(); i++) {
						
						%>
						
						<!-- 게시판 내용 구현 -->
						<tr>
							<td><%= list.get(i).getBbsID() %></td>
							<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a></td>
							<td><%= list.get(i).getUserID() %></td>
							<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분"  %></td>
						</tr>
						
						
						<%
							}
						%>
						
					</tbody>
					
				</table>
				
				<%
					//페이지 <다음, 이전> 버튼 구현.
					if(pageNum != 1) {
						
					
				%>
					<a href="bbs.jsp?pageNum=<%=pageNum - 1 %>" class="btn btn-success btn-arraw-left">이전</a> <!-- 페이지 번호를 넘겨줌. -->
				<%
					} if(bbsdao.nextPage(pageNum + 1)) {
				%>
					<a href="bbs.jsp?pageNum=<%=pageNum + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
				<%
					}
				%>
				
				<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			
			</div>
		</div>
		<script src = "http://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- 애니메이션을 담당하게 될 자바스크립트 참조. -->
		<script src = "js/bootstrap.js"></script>
		
	</body> 
</html>