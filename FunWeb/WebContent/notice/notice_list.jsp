<%@page import="Notice.NoticeBean"%>
<%@page import="Notice.NoticeDAO"%>
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
		
		NoticeDAO nd = new NoticeDAO();
		
		int count = nd.getNoticeCount(); // 게시판 글 수
		int pageSize = 3; // 한 페이지에 보여줄 글 개수
		String pageNum = request.getParameter("pageNum");   // 현재 페이지 번호
		if(pageNum == null) { 
			pageNum = "1";
		}
		int currentPage=Integer.parseInt(pageNum); // 현재 페이지 번호
		int startRow = (currentPage-1)*pageSize + 1; // 시작하는 행번호
		int endRow = currentPage + pageSize - 1; // 끝나는 행번호
		
		List<NoticeBean> noticeList = null;
		if(count != 0){
			noticeList = nd.getNoticeList(startRow, pageSize); // paging	
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
				<li><a href="#">게시판</a></li>
				<li><a href="#">FAQ</a></li>
				<li><a href="#">뉴스</a></li>
				<li><a href="#">일정</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>게시판</h1>
			<table id="notice">
				<tr>
					<th class="tno">번호</th>
					<th class="ttitle">제목</th>
					<th class="twrite">작성자</th>
					<th class="tdate">작성일</th>
					<th class="tread">조회수</th>
				</tr>
				
				
				<%
				if(noticeList != null){
					for(int i = 0; i < noticeList.size(); i++){	// 리스트 
	 					NoticeBean nb = noticeList.get(i);  
	 			%>
				<tr>
					<td><%=nb.getNum() %></td>
					<td><a href="notice_content.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>"><%=nb.getTitle() %></a></td>
					<td><%=nb.getWriter() %></td>
					<td><%=nb.getDate() %></td>
					<td><%=nb.getReadcount() %></td>
				</tr>
				<%
					}
				}
				%>
				
			</table>
			<div id="table_search">
			<%
				if(id!=null){	%>
				<input type="button" value="글쓰기" class="btn" onclick="location.href='notice_write.jsp?pageNum=<%=pageNum%>'">
				<% }
			%>
				<form action="notice_search.jsp" method="post">
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
			%>			<a href="notice_list.jsp?pageNum=<%=startPage-pageBlock%>">[이전]</a><%
					}
					
					for(int i = startPage; i <= endPage; i++){
			%>			<a href="notice_list.jsp?pageNum=<%=i%>"><%=i %></a><%
					}	
					
					// [다음]
							
					if(endPage < pageCount){
			%>			<a href="notice_list.jsp?pageNum=<%=startPage+pageBlock%>">[다음]</a><%
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