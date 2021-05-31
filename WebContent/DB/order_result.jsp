<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>연암 부동산</title>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="mycss.css" rel="stylesheet">
<link href="../mycss.css" rel="stylesheet">
</head>

<body>

	<% 
	String isInfoPage = request.getParameter("page");
	if(isInfoPage != null){
		if(isInfoPage.equals("info")){
	
	%>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
			<div class="container">
				<jsp:include page="./layout/top.jsp" flush="false" />
			</div>
		</nav>
	
	<%
		}
	}
	%>
	<%
		try {
		if (session.getAttribute("userType").toString() == "매도자") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('매도자는 매수할 수 없습니다.')");
			script.println("history.back();");
			script.println("</script>");
			if (true)
		return; // 왜인지 이거 안넣으면 중단이 안됨;;
		}
	} catch (Exception e) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.')");
		script.println("history.back();");
		script.println("</script>");

		if (true)
			return;
	}
	%>
	<h1 style="text-align: center;">${ userName }님의 매물 주문 목록</h1>
	<%
	request.setCharacterEncoding("utf-8");
	Connection con = null;
	String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
	String userid = "leekm";
	String pwd = "12121212";
	String query = "";
	Statement stmt = null;
	ResultSet rs = null;
	Integer getParam1 = (Integer)request.getAttribute("type"); 
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

	//query = "select * from 주문 where 매수자이름=" + "'" + name + "'"; /* SQL 문 */
	String userID = (String) session.getAttribute("userID");
	query = "select 주문번호, 매수자_이름, 매도자_이름, 매물_등록번호, 주문일자 from 주문, 매수자, 매도자 where 주문.매도자id = 매도자.id and 주문.매수자id = 매수자.id and 매수자.id = "
			+ "'" + userID + "'" + " order by 주문번호";
	try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
		List<Integer> row1 = new ArrayList<Integer>();
		List<String> row2 = new ArrayList<String>();
		List<String> row3 = new ArrayList<String>();
		List<Integer> row4 = new ArrayList<Integer>();
		List<String> row5 = new ArrayList<String>();
		while (rs.next()) {
			row1.add(rs.getInt(1));
			row2.add(rs.getString(2));
			row3.add(rs.getString(3));
			row4.add(rs.getInt(4));
			row5.add(rs.getString(5));
		}
	%>
	<form method="post" action="delete_order.jsp">
	<table class="type1">
		<tr>
			<th scope="cols">주문번호</th>
			<th scope="cols">매수자이름</th>
			<th scope="cols">매도자이름</th>
			<th scope="cols">매물등록번호</th>
			<th scope="cols">주문일자</th>
			<%
				if(getParam1 != null){
					out.print("<th scope='cols'>주문취소</th>");
				}
			%>
		</tr>
		<%
			for (int i = 0; i < row1.size(); i++) {
			out.print("<tr>");
			out.print("<td style='text-align:center;'>" + row1.get(i) + "</td>");
			out.print("<td style='text-align:center;'>" + row2.get(i) + "</td>");
			out.print("<td style='text-align:center;'>" + row3.get(i) + "</td>");
			out.print("<td style='text-align:center;'>" + row4.get(i) + "</td>");
			out.print("<td style='text-align:center;'>" + row5.get(i) + "</td>");
			if(getParam1 != null){
				out.print("<td><input type='submit' value='주문취소' name='data" + row1.get(i) + "' class='btn btn-primary'></td>");
			}
			out.print("</tr>");
		}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		%>
	</table>
	</form>
	<script src="vendor/jquery/jquery.slim.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>