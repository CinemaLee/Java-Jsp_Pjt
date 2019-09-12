<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDAO" %>
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
		String title = request.getParameter("bbsTitle");
		String content = request.getParameter("bbsContent");
			String sessionID = null;
			if(session.getAttribute("userSessionID") != null ){ //SessionID가 이미 있다면. 로그인 중이라면.
				sessionID = (String)session.getAttribute("userSessionID");
			}
			if(sessionID == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 해야 글쓰기가 가능합니다.')");
				script.println("location.href = 'login.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			else{
				if(title == null || content == null) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안된 사항이 있습니다.')");
					script.println("history.back()");  // 이전 페이지로 사용자를 돌림
					script.println("</script>");
				}else{
					bbsDAO bbsdao = new bbsDAO();
					int result = bbsdao.write(title, sessionID, content);
					if(result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");  // 이전 페이지로 사용자를 돌림
						script.println("</script>");
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
						script.println("</script>");
					}
				}
				
				
				
				
			}
			
			
		%>
	</body> 
</html>