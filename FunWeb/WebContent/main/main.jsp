<%@page import="Gallery.GalleryBean"%>
<%@page import="Gallery.GalleryDAO"%>
<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
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
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더파일들어가는 곳 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더파일들어가는 곳 -->
		<!-- 메인이미지 들어가는곳 -->
		<div class="clear"></div>
		<div id="main_img">
			<img src="../img/웅비관1.jpg" width="971" height="282">
		</div>
		<!-- 메인이미지 들어가는곳 -->
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<article id="front">
			
			<div>
				<%	
				GalleryDAO gd = new GalleryDAO();
				int count = gd.getGalleryCount(); // 갤러리 글 수
				List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
				if(count != 0){
					galleryList = gd.getGalleryList(1, 3, ""); // paging	
				}
				
				if(galleryList != null){
					for(int i = 0; i < galleryList.size(); i++){	// 리스트 
						GalleryBean gb = galleryList.get(i);  
				%>
				<div id="hosting">
					<div class="contxt">
						<a href="../gallery/gallery_content.jsp?num=<%=gb.getNum()%>" style="float:left"><br>
							<img src="../upload/<%= gb.getFile()%>" width="100" height="100"><br>
							<h3><%=gb.getTitle() %></h3>
							<p><%=gb.getDate() %></p>
						</a>
					</div>
				</div>
						
				<%
					}
				}
				%>
				
				<div class="clear">
			</div>
			<div id="news_notice">
				<h3>
					<span class="orange">자료실</span>
				</h3>
				<table>
				<%
				BoardDAO bd = new BoardDAO();
				count = bd.getBoardCount(); // 게시판 글 수
				List<BoardBean> boardList = new ArrayList<BoardBean>();
				if(count != 0){
					boardList = bd.getBoardList(1, 5, ""); // paging	
				}
				
				if(boardList != null){
					for(int i = 0; i < boardList.size(); i++){	// 리스트 
						BoardBean bb = boardList.get(i);  
					%>
					<tr>
						<td class="contxt"><a href="../board/board_content.jsp?num=<%=bb.getNum()%>"><%=bb.getTitle() %></a></td>
						<td><%=bb.getDate() %></td>
					</tr>
							
					<%
					}
				}
				%>
				</table>
			</div>
			
			<div id="news_notice">
				<h3 class="brown">게시판</h3>
				<table>
				<%
				NoticeDAO nd = new NoticeDAO();
				count = nd.getNoticeCount(); // 게시판 글 수
				List<NoticeBean> noticeList = new ArrayList<NoticeBean>();
				if(count != 0){
					noticeList = nd.getNoticeList(1, 5, ""); // paging	
				}
				
				if(noticeList != null){
					for(int i = 0; i < noticeList.size(); i++){	// 리스트 
	 					NoticeBean nb = noticeList.get(i);  
					%>
					<tr>
						<td class="contxt"><a href="../notice/notice_content.jsp?num=<%=nb.getNum()%>"><%=nb.getTitle() %></a></td>
						<td><%=nb.getDate() %></td>
					</tr>
							
					<%
					}
				}
				%>
					
				
				</table>
			</div>
		</article>
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../include/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>