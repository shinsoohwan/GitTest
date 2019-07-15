<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function check(){
		if(document.fr.id.value=="") {
			alert("ID는 필수정보입니다.");
			return false;
		} 
		if(document.fr.id.value.length > 10){
			alert("ID는 10자 이하만 입력가능합니다.");
			return false;
		}
		if(document.fr.pass.value=="") {
			alert("Password는 필수정보입니다.");
			return false;
		} 
		if(document.fr.pass.value.length > 10){
			alert("Password는 10자 이하만 입력가능합니다.");
			return false;
		}
		return;
	}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../include/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">회원가입</a></li>
				<li><a href="#">개인정보 정책</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
			<h1>로그인</h1>
			<form action="loginPro.jsp" id="join" name="fr" method="post" onsubmit="return check()">
				<fieldset>
					<label>아이디</label> <input type="text" name="id"><br>
					<label>비밀번호</label> <input type="password" name="pass"><br>
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="확인" class="submit"> 
					<input type="reset" value="다시입력" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../include/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>