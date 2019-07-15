<%@page import="Member.MemberDAO"%>
<%@page import="Member.MemberBean"%>
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

		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
			
		MemberBean mb = new MemberBean();
		
		mb.setId(id);
		mb.setPass(pass);
		
		MemberDAO md = new MemberDAO();
		
		int check = md.userCheck(mb);
		
		if(check == 1){ // 로그인 성공
			session.setAttribute("id", id);
			session.setAttribute("name", mb.getName());
			response.sendRedirect("../main/main.jsp");
		}else if(check == 0){ // pass 불일치
			%>
			<script type="text/javascript">
				alert("잘못된 비밀번호입니다.");
				history.back();
			</script>
			<%
		}else if(check == -1){ // id 없음
			%>
			<script type="text/javascript">
				alert("존재하지 않는 아이디입니다.");
				history.back();
			</script>
			<%
		}

	%>
</body>
</html>