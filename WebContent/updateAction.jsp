<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('로그인을 하세요.');");
			script.print("location.href = 'login.jsp'");
			script.print("</script>");
		} 
		int bbsID = 0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0){
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('유효하지 않은 글입니다.');");
			script.print("location.href = 'bbs.jsp'");
			script.print("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.print("<script>");
			script.print("alert('권한이 없습니다.');");
			script.print("location.href = 'bbs.jsp'");
			script.print("</script>");
		} else {
			if(request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
				|| request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
				PrintWriter script = response.getWriter();
				script.print("<script>");
				script.print("alert('입력이 안 된 사항이 있습니다.');");
				script.print("history.back()");
				script.print("</script>");
			}else{
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.print("alert('글 수정에 실패했습니다.');");
					script.print("history.back()");
					script.println("</script>");
				}
				else{
					PrintWriter script = response.getWriter();
					script.print("<script>");
					script.print("location.href = 'bbs.jsp'");
					script.print("</script>");
				}
		}
		
	}
	
	%>
</body>
</html>