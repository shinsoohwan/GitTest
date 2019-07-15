<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
		String uploadPath = request.getRealPath("/upload"); // 업로드할 파일 경로
	
		System.out.println("업로드폴더경로" + uploadPath);
		
		int maxSize = 5 * 1024 * 1024; // 파일 크기 // 5MB
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy()); 
		
		String writer = (String) session.getAttribute("name");
		String title = multi.getParameter("title");
		String file = multi.getFilesystemName("file");
		
		GalleryBean gb = new GalleryBean();
		
		gb.setWriter(writer);
		gb.setTitle(title);
		gb.setFile(file);
		
		GalleryDAO gd = new GalleryDAO();

		gd.insertGallery(gb);
		
		response.sendRedirect("gallery_list.jsp");
	%>
	
</body>
</html>