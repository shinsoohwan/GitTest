<%@page import="Board.BoardDAO"%>
<%@page import="Board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		BoardBean bb = new BoardBean();
		bb.setNum(num);
	
		BoardDAO bd = new BoardDAO();
		bb = bd.getBoard(bb);
		
	
	%>
	<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../include/top.jsp"/>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
	<ul>
		<li><a href="#">자료실</a></li>
		<li><a href="#">기숙사칙</a></li>
		<li><a href="#">식단표</a></li>
		<li><a href="#">확인서</a></li>
	</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>자료실</h1>
	<form action="board_updatePro.jsp?pageNum=<%=pageNum%>" method="post" name="fr">
		<input type="hidden" name="num" value="<%=num %>">
		<table border="1">
			<tr><td>제목</td><td><input type="text" name="subject" value="<%=bb.getTitle() %>"></td></tr>
			<tr><td>첨부파일</td><td><input type="file" name="file" value="<%=bb.getFile()%>"></td></tr>
			<tr><td>본문</td><td><textarea name="content" rows="10" cols="20"><%=bb.getContent() %></textarea></td></tr>	
			<tr><td colspan="2"><input type="submit" value="수정하기"></td></tr>
		</table>
	</form>
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../include/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>