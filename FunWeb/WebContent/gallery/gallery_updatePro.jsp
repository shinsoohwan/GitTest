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
		GalleryDAO gd = new GalleryDAO();
		
		gb.setNum(Integer.parseInt(request.getParameter("num")));
		String writer = (String) session.getAttribute("name");
		gb.setTitle(request.getParameter("title"));
		gb.setFile(request.getParameter("file"));
			
		gd.updateGallery(gb);
	%>
	<script type="text/javascript">
		alert("갤러리글 수정 완료.");
		location.href="gallery_content.jsp?num=<%=gb.getNum()%>&pageNum=<%=pageNum%>";
	</script>
	
</body>
</html>