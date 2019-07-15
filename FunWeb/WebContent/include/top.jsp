<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
	<%
		String id = (String)session.getAttribute("id");
		String name = (String)session.getAttribute("name");
			
		if(id == null){// 로그인 전(로그인, 회원가입)
	%>
		<div id="login"> 
			<a href="../member/login.jsp">로그인</a> | 
			<a href="../member/join.jsp">회원가입</a>
		</div>
	<%
		} else {  // 로그인 후 (로그아웃, 회원정보수정)
	%>
		<div id="login"> 
			<%=name %>님 
			<a href="../member/logout.jsp">로그아웃</a> | 
			<a href="../member/update.jsp">회원정보수정</a><br>
		</div>
	<%
	
		} 
	%>
		<div class="clear"></div>
		<!-- 로고들어가는 곳 -->
		<div id="logo">
			<a href="../main/main.jsp"><img src="../img/logo.png" width="265" height="62" alt="logo"></a>
		</div>
		<!-- 로고들어가는 곳 -->
		<nav id="top_menu">
			<ul>
				<li><a href="../main/main.jsp">홈</a></li>
				<li><a href="../notice/notice_list.jsp">게시판</a></li>
				<li><a href="../board/board_list.jsp">자료실</a></li>
				<li><a href="../gallery/gallery_list.jsp">갤러리</a></li>
				<li><a href="../map/map.jsp">찾아오는길</a></li>
				<% 
				if(id != null){	
					if(id.equals("admin")){
						%>
							<li><a href="../mail/mail_write.jsp">메일보내기</a></li>
						<%
					}
				}
				%>
			</ul>
		</nav>
	</header>
</body>
</html>