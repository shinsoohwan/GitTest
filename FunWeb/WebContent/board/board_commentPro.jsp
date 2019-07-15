<%@page import="comment.CommentBean"%>
<%@page import="comment.CommentDAO"%>
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
	
	String id = (String) session.getAttribute("id"); // 세션
	String name = (String) session.getAttribute("name");
	
	int conref = Integer.parseInt(request.getParameter("conref"));//게시글 번호
	String pageNum = request.getParameter("pageNum");// 페이지 번호
	if(pageNum == null) { 
		pageNum = "1";
	}
	String content = request.getParameter("content");
	if(content != null){
		content = content.replace("\r\n", "<br>");
	}
	
	CommentBean cb = new CommentBean();
	cb.setName(name);
	cb.setConref(conref);
	cb.setTabref("board");
	cb.setContent(content);
	
	CommentDAO cd = new CommentDAO();
	cd.insertComment(cb);
%>

	<script type="text/javascript">
		alert("댓글 달기 완료");
		location.href="board_content.jsp?num=<%=conref%>&pageNum=<%=pageNum%>";
	</script>
	
</body>
</html>