<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="db.UserDAO"%>
<%@ page import="db.User"%>
<!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
%>



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용-->

<jsp:useBean id="user" class="db.User" scope="page" />

<jsp:setProperty name="user" property="userID" param="userID"/>

<jsp:setProperty name="user" property="userType" param="userType"/>



<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>연암 부동산</title>

</head>

<body>

	<%
	User result = null;
	UserDAO userDAO = new UserDAO(); //인스턴스생성
	String isKakao = request.getParameter("type");
	String email = request.getParameter("email");
	
	if(isKakao != null){
		if(isKakao.contains("kakao")){
			String kakaoName = request.getParameter("id");
			String kakaoId = request.getParameter("pw");
			System.out.println("카카오톡 로그인 : " + kakaoName + kakaoId + isKakao);
			result = userDAO.login(kakaoName, kakaoId, isKakao, email);
			session.setAttribute("userName", result.getUserName());
			session.setAttribute("userID",kakaoName);
			session.setAttribute("userPassword",kakaoId);
			session.setAttribute("isKakao","true");
			session.setAttribute("email", result.getEmail());
		}
	}else{
		result = userDAO.login(user.getUserID(), request.getParameter("userPassword"), user.getUserType(), email);
		session.setAttribute("userName", result.getUserName());
		session.setAttribute("userID",request.getParameter("userID"));
		session.setAttribute("userPassword",request.getParameter("userPassword"));
		session.setAttribute("isKakao","false");
		session.setAttribute("email", result.getEmail());
	}
	
	
	//로그인 성공
	if (result.getUserType() == "매수자" || result.getUserType() == "매도자") {

		PrintWriter script = response.getWriter();
		if(result.getUserType() == "매수자") {
			session.setAttribute("userType", "매수자");
		}
		else if(result.getUserType() == "매도자") {
			session.setAttribute("userType", "매도자");
		}
		response.sendRedirect("main.jsp");
		

	}

	//로그인 실패

	else if (result.getUserType() == "0") {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('비밀번호가 틀립니다.')");

		script.println("history.back()");

		script.println("</script>");

	}

	//아이디 없음

	else if (result.getUserType() == "-1") {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('존재하지 않는 아이디 입니다.')");

		script.println("history.back()");

		script.println("</script>");

	}

	//DB오류

	else if (result.getUserType() == "-2") {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('DB오류가 발생했습니다.')");

		script.println("history.back()");

		script.println("</script>");

	}
	%>



</body>

</body>

</html>
