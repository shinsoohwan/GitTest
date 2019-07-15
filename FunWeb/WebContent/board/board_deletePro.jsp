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
		bb.setNum(Integer.parseInt(request.getParameter("num")));
		
		BoardDAO bd = new BoardDAO();
		
		bd.deleteBoard(bb);
		
		%>
		<script type="text/javascript">
			alert("게시글 삭제 완료.");
			location.href="board_list.jsp?pageNum=<%=pageNum%>";
		</script>
</body>
</html>