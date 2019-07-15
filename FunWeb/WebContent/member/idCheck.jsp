<%@page import="Member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function ok(){
		opener.document.fr.id.value = document.wfr.fid.value;
		window.close();
	}

</script>

</head>
<body>
	<%
		String fid = request.getParameter("fid");
	
		MemberDAO md = new MemberDAO();
		
		int check = md.idCheck(fid);
		
		if(check==1){	// fid 는 중복되는 id 존재
			out.println("이미 사용중인 아이디 입니다.");
		}else if(check==0){	// fid 는 중복되는 id 없음
			out.println("사용가능한 아이디 입니다.");
			%>
			<input type="button" value="아이디사용" onclick="ok()">
			<%
		}
	%>
	<form action="idCheck.jsp" name="wfr" method="post">
		아이디 : <input type="text" name="fid" value="<%=fid %>">
		<input type="submit" value="아이디중복확인">
	</form>
	
</body>
</html>