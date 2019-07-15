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
	
		String pageNum = request.getParameter("pageNum");
	
		NoticeBean nb = new NoticeBean();
		nb.setNum(Integer.parseInt(request.getParameter("num")));
		
		NoticeDAO nd = new NoticeDAO();
		
		nd.deleteNotice(nb);
		
		%>
		<script type="text/javascript">
			alert("게시글 삭제 완료.");
			location.href="notice_list.jsp?pageNum=<%=pageNum%>";
		</script>
</body>
</html>