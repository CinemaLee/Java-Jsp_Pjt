<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("UTF-8"); %>



<!DOCTYPE html>
<html>
	<head> 
		<meta charset="UTF-8">
		<title>Insert title here</title> 
	</head> 
	<body>
		<%
		
		//세션 설정. (로그인이 되어있다면 이 jsp로 들어올 일은 없을 것이다. 그러나 주소로 인한 접근 ex)/login.jsp와 같은.. 일 경우에는 접근 될 수도 있으니 이를 대비하여 적어주는 부분.)
		String sessionID = null;
		if(session.getAttribute("userSessionID") != null) {
			sessionID = (String)session.getAttribute("userSessionID");
		}
		if(sessionID != null) { //로그인페이지로 못들어가게 한다. // .
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 돼있습니다')");
			script.println("location.href = 'main.jsp'");  // 이전 페이지로 사용자를 돌림
			script.println("</script>");
		}
	
	//////////////////////////////////////////////////////////////////////////////////////////////
		
			String id = request.getParameter("userID");
			String pw = request.getParameter("userPassword");
			
			UserDAO userDAO = new UserDAO();
			int result = userDAO.Login(id, pw);
			
			if(result == 1) { //로그인 성공
				session.setAttribute("userSessionID", id); // 세션을 설정해줌.
				sessionID = (String)session.getAttribute("userSessionID"); //일단 세션 ID를 확보.
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 되었습니다.')");
				script.println("location.href = 'main.jsp' ");
				script.println("</script>");
				
			}
			else if(result == 0) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			else if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디 입니다.')");
				script.println("history.back()");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			else if(result == -2) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 오류가 발생했습니다.')");
				script.println("history.back()");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
		%>
	</body> 
</html>