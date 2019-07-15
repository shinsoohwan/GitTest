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
		NoticeDAO nd = new NoticeDAO();
		
		nb.setNum(Integer.parseInt(request.getParameter("num")));
		

		nb.setWriter(request.getParameter("writer"));
		nb.setTitle(request.getParameter("title"));
		nb.setContent(request.getParameter("content"));
			
		nd.updateNotice(nb);
	%>
	<script type="text/javascript">
		alert("게시글 수정 완료.");
		location.href="notice_content.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>";
	</script>
	
</body>
</html>