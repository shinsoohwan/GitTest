<%@page import="Gallery.GalleryDAO"%>
<%@page import="Gallery.GalleryBean"%>
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
	
		GalleryBean gb = new GalleryBean();
		gb.setNum(Integer.parseInt(request.getParameter("num")));
		
		GalleryDAO gd = new GalleryDAO();
		
		gd.deleteGallery(gb);
		
		%>
		<script type="text/javascript">
			alert("게시글 삭제 완료.");
			location.href="gallery_list.jsp?pageNum=<%=pageNum%>";
		</script>
</body>
</html>