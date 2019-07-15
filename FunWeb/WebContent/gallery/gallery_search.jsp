<%@page import="Gallery.GalleryBean"%>
<%@page import="Gallery.GalleryDAO"%>
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
		
		String search = request.getParameter("search");
		if(search == null) { 
			search = "";
		}
		
		GalleryDAO gd = new GalleryDAO();
		
// 		List GalleryList = gd.getGalleryList();   
		
		int count = gd.getGalleryCount(); // 게시판 글 수
		int pageSize = 6; // 한 페이지에 보여줄 글 개수 (3 * 2)
		String pageNum = request.getParameter("pageNum");   // 현재 페이지 번호
		if(pageNum == null) { 
			pageNum = "1";
		}
		int currentPage=Integer.parseInt(pageNum); // 현재 페이지 번호
		int startRow = (currentPage-1)*pageSize + 1; // 시작하는 행번호
		int endRow = currentPage + pageSize - 1; // 끝나는 행번호
		
		List<GalleryBean> galleryList = null;
		if(count != 0){
			galleryList = gd.getGalleryList(startRow, pageSize, search); // paging	
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
				<li><a href="#">갤러리</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
			<h1>갤러리</h1>
				<table id="notice">
				<%
				int gX = 3;	// 한줄에 보여줄 개수
// 				int gY = 2;	// pageSize / gX
				
				int tdNum = galleryList.size();
				
				if(galleryList != null){
					for(int i = 0; i <(galleryList.size() - 1)/gX+1; i++){	 
	 					
	 				%>
					<tr>
					<%
	 					for(int j = 0; j < gX; j++){
						GalleryBean gb = galleryList.get(gX*i+j);  
					%>
					<td>
						<a href="gallery_content.jsp?num=<%=gb.getNum()%>&pageNum=<%=pageNum%>" style="float:left"><br>
							<img src="../upload/<%= gb.getFile()%>" width="100" height="100"><br>
							<%=gb.getTitle() %>
						</a>
					</td>
					<%
							if(--tdNum == 0){
								break;
							}
	 					}
					%>
					</tr>
				<%
					}
				}
				%>
			</table>
			
			<div id="table_search">
			<%
				if(id!=null){	%>
				<input type="button" value="글쓰기" class="btn" onclick="location.href='gallery_fwrite.jsp?pageNum=<%=pageNum%>'">
				<% }
			%>
				<form action="gallery_search.jsp" method="post">
					<input type="text" name="search" class="input_box" value="<%=search%>"> 
					<input type="button" value="search" class="btn">
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
			%>			<a href="gallery_search.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>">[이전]</a><%
					}
					
					for(int i = startPage; i <= endPage; i++){
			%>			<a href="gallery_search.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i %></a><%
					}	
					
					// [다음]
							
					if(endPage < pageCount){
			%>			<a href="gallery_search.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">[다음]</a>
			
			
			<%
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