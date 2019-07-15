<%@page import="mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="Member.MemberBean"%>
<%@page import="Member.MemberDAO"%>
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
	
		String id = (String) session.getAttribute("id"); // 세션
		
		String from = "derstsa00@naver.com"; // 보내는 사람 = 관리자(고정)
		String to = request.getParameter("Email");	// 받는사람
		String subject = request.getParameter("title");		// 제목
		String content = request.getParameter("content");	// 내용
		
		// 정보를 담을 객체
		Properties p = new Properties();	
		// 네이버 smtp
		p.put("mail.smtp.host", "smtp.naver.com");	
		
		// smtp 서버에 접속하기 위한 정보들
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		
		
		Authenticator auth = new SMTPAuthenticator();
	    Session ses = Session.getInstance(p, auth);
	     
	    ses.setDebug(true);
	     
	    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
	    msg.setSubject(subject); // 제목
	     
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr); // 보내는 사람
	     
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
	     
		if(content != null){
			content = content.replace("\r\n", "<br>");
		}
	    
	    msg.setContent(content, "text/html;charset=UTF-8"); // 내용과 인코딩
	     
	    Transport.send(msg); // 전송

		
		 

		response.sendRedirect("../main/main.jsp");
	%>
	
</body>
</html>