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
	<div id="wrap">
		<!-- 헤더가 들어가는 곳 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더가 들어가는 곳 -->

		<!-- 본문 들어가는 곳 -->
		<!-- 서브페이지 메인이미지 -->
		<div id="sub_img"></div>
		<!-- 서브페이지 메인이미지 -->
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
		<!-- 내용 -->
		<article>
			<h1>게시판</h1>
			<form action="notice_writePro.jsp" method="post" name="fr">
				<table border="1">
					<tr><td>제목</td><td><input type="text" name="title"></td></tr>
					<tr><td>본문</td><td><textarea name="content" rows="10" cols="20"></textarea></td></tr>
					<tr><td colspan="2"><input type="submit" value="글쓰기"></td></tr>
				</table>
			</form>
		</article>
		<!-- 내용 -->
		<!-- 본문 들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../include/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>

