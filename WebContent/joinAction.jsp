<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>

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
			if(session.getAttribute("userSessionID") != null ){
				sessionID = (String)session.getAttribute("userSessionID");
			}
			if(sessionID != null) { 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 돼있습니다')");
				script.println("location.href = 'main.jsp'");  
				script.println("</script>");
			}
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			String userID = (String)request.getParameter("userID");
			String userPassword = (String)request.getParameter("userPassword");
			String userName = (String)request.getParameter("userName");
			String userGender = (String)request.getParameter("userGender");
			String userEmail = (String)request.getParameter("userEmail");
			
			if( userID.equals("") || userPassword.equals("") || userName.equals("") || userGender.equals("")|| userEmail.equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			} else {
				UserDAO userDAO = new UserDAO();
				int result = userDAO.join(new UserDTO(userID,userPassword,userName,userGender,userEmail));
				
				
				if(result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디 입니다.')");
					script.println("history.back()");  // 이전 페이지로 사용자를 돌림
					script.println("</script>");
				}
				else {
					session.setAttribute("userSessionID", userID);
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원가입 되었습니다!')");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");
				}
			}
			
			
		%>
	</body> 
</html>