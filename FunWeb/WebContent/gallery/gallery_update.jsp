<%@page import="Gallery.GalleryDAO"%>
<%@page import="Gallery.GalleryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function chk_file_type(obj) {
	var file_kind = obj.value.lastIndexOf('.');
	var file_name = obj.value.substring(file_kind+1,obj.length);
	var file_type = file_name.toLowerCase();

 	var check_file_type = new Array();​

 	check_file_type=['jpg','gif','png','jpeg','bmp'];

 	if(check_file_type.indexOf(file_type)==-1){
  		alert('이미지 파일만 선택할 수 있습니다.');
  		var parent_Obj=obj.parentNode
  		var node=parent_Obj.replaceChild(obj.cloneNode(true),obj);
 		return false;
 	}
}
</script>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		GalleryBean gb = new GalleryBean();
		gb.setNum(num);
	
		GalleryDAO gd = new GalleryDAO();
		gb = gd.getGallery(gb);
		
	
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
<li><a href="#">갤러리</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>갤러리</h1>
	<form action="gallery_updatePro.jsp?pageNum=<%=pageNum%>" method="post" name="fr">
		<input type="hidden" name="num" value="<%=num %>">
		<table border="1">
			<tr><td>제목</td><td><input type="text" name="subject" value="<%=gb.getTitle() %>"></td></tr>
			<tr>
				<td>사진파일</td>
				<td><input type="file" name="file" accept="image/jpeg,image/gif,image/png" onchange="chk_file_type(this)"></td>
			</tr>
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