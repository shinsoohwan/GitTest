<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Notice.NoticeDAO"%>
<%@page import="Notice.NoticeBean"%>
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
		String name = (String) session.getAttribute("name");
		
		int num = Integer.parseInt(request.getParameter("num"));//게시글 번호
		String pageNum = request.getParameter("pageNum");// 페이지 번호
		if(pageNum == null) { 
			pageNum = "1";
		}
		
		NoticeBean nb = new NoticeBean();
		nb.setNum(num);
	
		NoticeDAO nd = new NoticeDAO();
		
		nd.updateReadcount(num);// 조회수 증가
		
		nb = nd.getNotice(nb);	// 게시글 읽어오기
		
		String content = nb.getContent();
		if(content!=null){
			//	\r\n => <br>
			content.replace("\r\n", "<br>");
			nb.setContent(content);
		}
		
		CommentDAO cd = new CommentDAO();
		
		List<CommentBean> commentList = new ArrayList<CommentBean>();
		commentList = cd.selectComment("notice");
		
		
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
	<table border="2" align="center" width="600px">
		<tr>
			<td>글번호</td><td><%= nb.getNum()%></td>
			<td>조회수</td><td><%= nb.getReadcount()%></td>
		</tr>
		<tr>
			<td>작성자</td><td><%= nb.getWriter()%></td>
			<td>작성일</td><td><%= nb.getDate()%></td>
		</tr>
		<tr>
			<td>제목</td><td colspan="3"><%= nb.getTitle()%></td>
		</tr>
		<tr>
			<td>내용</td><td colspan="3"><%= nb.getContent()%></td>
		</tr>
		<tr>
			<td colspan="4">

		<!--세션 id 검사해서 작성자일때만 수정, 삭제 보이게 만들기 -->
		<%
		if(id!=null){
			if(name.equals(nb.getWriter())){
			%>
				<input type="button"  value="글수정" onclick="location.href='notice_update.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>'">
				<input type="button" value="글삭제" onclick="location.href='notice_deletePro.jsp?num=<%=nb.getNum()%>&pageNum=<%=pageNum%>'">
			
			<%
			}
		}
		%>
				<input type="button" value="글목록" onclick="location.href='notice_list.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
	
	<form action="notice_commentPro.jsp" method="post" name="fr">
		<input type="hidden" name="conref" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table border="2" align="center" width="600px">
			<tr><td colspan="3" align="center">Comment</td></tr>
			<tr>
				<td align="center" width="100">ID</td><td colspan="2" align="center">Content</td>
			</tr>
			<tr>
				<%
					if(id!=null){	
				%>
			
				<td align="center"><%= name%></td>
				<td colspan="2">
					<textarea name="content" cols="50" rows="3"></textarea>
					<input type="submit" name="resister" value="댓글쓰기">
				</td>
				
				<% 
					}else{
				%>
				<td colspan="3" align="center">
					<textarea name="content" cols="80" rows="3">로그인 이후 코멘트 작성을 하실 수 있습니다.</textarea>
				</td>
				<%
					}
				%>
			</tr>		
			<%
				for(int i = 0; i < commentList.size(); i++){
					CommentBean cb = commentList.get(i);
					
					if(nb.getNum() == cb.getConref()){
						%>
						<tr>
							<td><%=cb.getName() %></td>
							<td><%=cb.getContent() %></td>
							<td><%=cb.getDate() %></td>
						</tr>
						<%
					}
				}
			%>
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