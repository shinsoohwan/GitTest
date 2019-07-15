<%@page import="Member.MemberDAO"%>
<%@page import="Member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
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
		mb.setPass(request.getParameter("pass"));
		mb.setName(request.getParameter("name"));
		mb.setReg_date(new Timestamp(System.currentTimeMillis()));
		mb.setEmail(request.getParameter("email"));
		mb.setZip(request.getParameter("zip"));
		mb.setAddr1(request.getParameter("addr1"));
		mb.setAddr2(request.getParameter("addr2"));
		mb.setPhone(request.getParameter("phone"));
		mb.setMobile(request.getParameter("mobile"));
		
		md.insertMember(mb);
	
	%>
	
	<script type="text/javascript">
		alert("회원 가입 완료.");
		location.href="login.jsp";
	</script>

</body>
</html>