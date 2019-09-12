<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDAO" %>
<%@ page import="bbs.bbsDTO" %>
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
			String sessionID = null;
			if(session.getAttribute("userSessionID") != null ){ //SessionID가 이미 있다면. 로그인 중이라면.
				sessionID = (String)session.getAttribute("userSessionID"); 
			}
			
			if(sessionID == null) { //로그인을 안했다면
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 해야 글쓰기가 가능합니다.')");
				script.println("location.href = 'login.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			
			int bbsID=0;
			if(request.getParameter("bbsID") != null) { //update.jsp 에서 넘어온 bbsID
				bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
			
			if(bbsID==0) { //글이 존재하지 않는 상태.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글 입니다.')");
				script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			
			//글 쓴 본인이 맞는지 확인하는 작업.
			bbsDTO bbsdto = new bbsDAO().Getbbs(bbsID);
			if(!sessionID.equals(bbsdto.getUserID())){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('권한이 없습니다.')");
				script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
				script.println("</script>");
			}
			
			else{ //빈칸이 하나라도 있다면? // update.jsp에서 넘어온 bbsTitle, bbsContent
				if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null || request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("") ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안된 사항이 있습니다.')");
					script.println("history.back()");  // 이전 페이지로 사용자를 돌림
					script.println("</script>");
				}else{
					//조건을 다 만족해서 글을 수정하는 부분.
					bbsDAO bbsdao = new bbsDAO();
					int result = bbsdao.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
					if(result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
						script.println("history.back()");  // 이전 페이지로 사용자를 돌림
						script.println("</script>");
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('수정하였습니다.')");
						script.println("location.href = 'bbs.jsp'");  // 이전 페이지로 사용자를 돌림
						script.println("</script>");
					}
				}
				
				
				
				
			}
			
			
		%>
	</body> 
</html>