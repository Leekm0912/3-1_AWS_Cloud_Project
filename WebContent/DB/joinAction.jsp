<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->

<%
	request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>연암 부동산</title>

</head>

<body>

	<%
	request.setCharacterEncoding("utf-8");
	pageContext.setAttribute("userID", request.getParameter("userID"));
	
	pageContext.setAttribute("userName", request.getParameter("userName"));
	pageContext.setAttribute("userPhone", request.getParameter("userPhone"));
	pageContext.setAttribute("userType", request.getParameter("userType"));
	pageContext.setAttribute("email", request.getParameter("email"));
	
	// 비밀번호 암호화. key=30
	String enpw = request.getParameter("userPassword");
	char [] enpw_char = enpw.toCharArray();
	/*for(int i=0; i<enpw_char.length;i++){
		int temp = (int)enpw_char[i];
		temp -= 30;
		enpw_char[i] = (char)temp;
	}*/
	enpw = new String(enpw_char);
	pageContext.setAttribute("userPassword", enpw);
	PreparedStatement ppst = null;
	Connection con = null;
	String query = "";
	String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
	String userid = "leekm";
	String pwd = "12121212";

	try { /* 드라이버를 찾는 과정 */
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//System.out.println("드라이버 로드 성공");
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}

	try { /* 데이터베이스를 연결하는 과정 */
		//System.out.println("데이터베이스 연결 준비 ...");
		con = DriverManager.getConnection(url, userid, pwd);
		//System.out.println("데이터베이스 연결 성공");
	} catch (SQLException e) {
		e.printStackTrace();
	}

	String userType = (String)pageContext.getAttribute("userType");
	if (userType.equals("매수자")) {
		query = "insert into 매수자 values(?,?,?,?,?)";
	} else if (userType.equals("매도자")) {
		query = "insert into 매도자 values(?,?,?,?,?)";
	}

	try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
		ppst = null;
		ppst = con.prepareStatement(query); // PreparedStatement 객체 생성(쿼리 생성)
		ppst.setString(3, (String) pageContext.getAttribute("userName"));
		ppst.setString(1, (String) pageContext.getAttribute("userID"));
		ppst.setString(2, (String) pageContext.getAttribute("userPassword"));
		ppst.setString(4, (String) pageContext.getAttribute("userPhone"));
		ppst.setString(5, (String) pageContext.getAttribute("email"));
		ppst.executeUpdate(); // 쿼리(sql) 실행
	} catch (SQLException e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('잘못됐거나 중복된 입력값 입니다(DB 오류).')");

		script.println("history.back()");

		script.println("</script>");
		return;

	}

	con.close();
	response.sendRedirect("login.jsp");
	%>



</body>

</body>

</html>
