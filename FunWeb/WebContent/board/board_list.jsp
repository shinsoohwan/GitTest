<%@page import="java.util.ArrayList"%>
<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDAO"%>
<%@page import="java.util.List"%>
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
	
		String id = (String) session.getAttribute("id"); // 세션
		
		BoardDAO bd = new BoardDAO();
		
// 		List boardList = bd.getBoardList();   
		
		int count = bd.getBoardCount(); // 게시판 글 수
		int pageSize = 3; // 한 페이지에 보여줄 글 개수
		String pageNum = request.getParameter("pageNum");   // 현재 페이지 번호
		if(pageNum == null) { 
			pageNum = "1";
		}
		int currentPage=Integer.parseInt(pageNum); // 현재 페이지 번호
		int startRow = (currentPage-1)*pageSize + 1; // 시작하는 행번호
		int endRow = currentPage + pageSize - 1; // 끝나는 행번호
		
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		if(count != 0){
			boardList = bd.getBoardList(startRow, pageSize); // paging	
		}
	%>

	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

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

		<!-- 게시판 -->
		<article>
			<h1>자료실</h1>
			<table id="notice">
				<tr>
					<th class="tno">번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				
				
				<%
				if(boardList != null){
					for(int i = 0; i < boardList.size(); i++){	// 리스트 
	 					BoardBean bb = boardList.get(i);  
	 			%>
				<tr>
					<td><%=bb.getNum() %></td>
					<td><a href="board_content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getTitle() %></a></td>
					<td><%=bb.getWriter() %></td>
					<td><%=bb.getDate() %></td>
					<td><%=bb.getReadcount() %></td>
				</tr>
				<%
					}
				}
				%>
				
			</table>
			<div id="table_search">
			<%
				if(id!=null){	%>
				<input type="button" value="글쓰기" class="btn" onclick="location.href='board_fwrite.jsp?pageNum=<%=pageNum%>'">
				<% }
			%>
				<form action="board_search.jsp" method="post">
					<input type="text" name="search" class="input_box"> 
					<input type="submit" value="search" class="btn">
				</form>
			</div>
			<div class="clear"></div>
			<div id="page_control">
			<%
				if(count != 0){ 
					int pageCount = count/pageSize; // 전체 페이지 수
					if(count%pageSize > 0){
						pageCount += 1;
					}
		
					 // 화면에 나올 페이지 개수
					int pageBlock = 3;
					// 화면에 나올 시작 페이지 번호
					int startPage = ((currentPage - 1) / pageSize) * pageSize + 1;
					// 화면에 나올 끝 페이지 번호
					int endPage = startPage + pageBlock -1; 
					if(endPage > pageCount) endPage = pageCount;
					
					// [이전]
							
					if(startPage > pageBlock){
			%>			<a href="board_list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a><%
					}
					
					for(int i = startPage; i <= endPage; i++){
			%>			<a href="board_list.jsp?pageNum=<%=i%>"><%=i %></a><%
					}	
					
					// [다음]
							
					if(endPage < pageCount){
			%>			<a href="board_list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a><%
					}
				}
					
			%>
			</div>
			
			
			
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../include/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>