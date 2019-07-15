<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
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
	
		BoardBean bb = new BoardBean();
		BoardDAO bd = new BoardDAO();
		
		bb.setNum(Integer.parseInt(request.getParameter("num")));
		String writer = (String) session.getAttribute("name");
		bb.setTitle(request.getParameter("title"));
		bb.setContent(request.getParameter("content"));
		bb.setFile(request.getParameter("file"));
			
		bd.updateBoard(bb);
	%>
	<script type="text/javascript">
		alert("게시글 수정 완료.");
		location.href="board_content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>";
	</script>
	
</body>
</html>