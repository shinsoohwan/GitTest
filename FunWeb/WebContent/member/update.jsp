<%@page import="Member.MemberDAO"%>
<%@page import="Member.MemberBean"%>
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
	function check() { 
		if(document.fr.pass.value=="" || document.fr.oldpass.value=="") {
			alert("비밀번호는 필수정보입니다.");
			return false;
		} 
		if(document.fr.pass.value.length > 10){
			alert("비밀번호는 10자 이하만 사용가능합니다.");
			return false;
		}
		if(document.fr.pass.value!=document.fr.pass2.value){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		if(document.fr.name.value=="") {
			alert("이름은 필수정보입니다.");
			return false;
		}
		if(document.fr.id.value.length > 10){
			alert("이름은 10자 이하만 사용가능합니다.");
			return false;
		}
		if(document.fr.email.value=="") {
			alert("이름은 필수정보입니다.");
			return false;
		}
		if(document.fr.email.value.length > 30){
			alert("이름은 30자 이하만 사용가능합니다.");
			return false;
		}
		if(document.fr.email.value!=document.fr.email2.value){
			alert("E-Mail이 일치하지 않습니다.");
			return false;
		}
		return;
	}
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
</script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String id = (String) session.getAttribute("id"); // 세션
		
		if (id == null) {
			response.sendRedirect("../main/main.jsp");
		}
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		
		
	%>

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
			<h1>회원 정보 수정</h1>
			<form action="updatePro.jsp" id="join" name="fr" method="post" onsubmit="return check()">
				<fieldset>
					<legend>필수 입력 정보</legend>
					<label>아이디</label> <input type="text" name="id" value="<%=mb.getId() %>" class="id" readonly>
					<input type="button" value="아이디중복검사" class="dup"><br>
					<label>기존 비밀번호</label> <input type="password" name="oldpass"><br>
					<label>새 비밀번호</label> <input type="password" name="pass"><br>
					<label>새 비밀번호 확인</label> <input type="password" name="pass2"><br>
					<label>이름</label> <input type="text" name="name"><br>
					<label>E-Mail</label> <input type="email" name="email"><br>
					<label>E-Mail 확인</label> <input type="email" name="email2"><br>
				</fieldset>
				<fieldset>
					<legend>선택 입력 정보</legend>
					<label>우편번호</label><input type="text" id="zip">
					<input type="button" class="dup" value="우편번호 찾기" onclick="execDaumPostcode()"><br>
					<label>주소</label><input type="text" id="addr1" style="width:300px;"><br>
					<label>상세주소</label><input type="text" id="addr2" style="width:300px;"><br>
					<label>전화 번호</label> <input type="text" name="phone"><br>
					<label>휴대폰 번호</label> <input type="text" name="mobile"><br>
				</fieldset>
				<div class="clear">
				</div>
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