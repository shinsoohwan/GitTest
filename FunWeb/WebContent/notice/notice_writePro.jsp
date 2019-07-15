<%@page import="Notice.NoticeDAO"%>
<%@page import="Notice.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
		String writer = (String)session.getAttribute("name");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		if(content != null){
			content = content.replace("\r\n", "<br>");
		}
		
		NoticeBean nb = new NoticeBean();
		
		nb.setWriter(writer);
		nb.setTitle(title);
		nb.setContent(content);
		
		NoticeDAO nd = new NoticeDAO();

		nd.insertNotice(nb);
		
		response.sendRedirect("notice_list.jsp");
	%>
	
</body>
</html>