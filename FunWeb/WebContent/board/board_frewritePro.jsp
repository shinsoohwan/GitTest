<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
		String uploadPath = request.getRealPath("/upload"); // 업로드할 파일 경로
	
		int maxSize = 5 * 1024 * 1024; // 파일 크기 // 5MB
		MultipartRequest multi = new MultipartRequest(request, uploadPath, maxSize, "UTF-8", new DefaultFileRenamePolicy()); 
		
		String writer = (String) session.getAttribute("name");
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String file = multi.getFilesystemName("file");
		int re_ref = Integer.parseInt(request.getParameter("re_ref"));
		int re_lev = Integer.parseInt(request.getParameter("re_lev"));
		int re_seq = Integer.parseInt(request.getParameter("re_seq"));
		
		if(content != null){
			content = content.replace("\r\n", "<br>");
		}
		
		BoardBean bb = new BoardBean();
		
		bb.setWriter(writer);
		bb.setTitle(title);
		bb.setContent(content);
		bb.setFile(file);
		bb.setRe_ref(re_ref);
		bb.setRe_lev(re_lev);
		bb.setRe_seq(re_seq);
		
		BoardDAO bd = new BoardDAO();

		bd.reInsertBoard(bb);
		
		response.sendRedirect("board_list.jsp");
	%>
	
</body>
</html>