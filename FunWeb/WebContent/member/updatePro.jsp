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

		MemberBean mb = new MemberBean();
		MemberDAO md = new MemberDAO();

		mb.setId(request.getParameter("id"));
		mb.setPass(request.getParameter("oldpass"));

		int check = md.userCheck(mb);
		
		if(check == 1){ // 비밀번호가 일치할 경우 정보 수정
			mb.setPass(request.getParameter("pass"));
			mb.setName(request.getParameter("name"));
			mb.setEmail(request.getParameter("email"));
			mb.setZip(request.getParameter("zip"));
			mb.setAddr1(request.getParameter("addr1"));
			mb.setAddr2(request.getParameter("addr2"));
			mb.setPhone(request.getParameter("phone"));
			mb.setMobile(request.getParameter("mobile"));
			
			
			md.updateMember(mb);
			
			session.setAttribute("name", mb.getName());
			response.sendRedirect("../main/main.jsp");

		}
		else{	// 비밀번호 틀림
			%>
			<script type="text/javascript">
				alert("패스워드 틀림.");
				history.back();
			</script>
			<%	
		}
	%>

</body>
</html>