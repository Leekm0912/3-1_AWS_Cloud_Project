<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.stream.Stream"%>
<%@ page import="java.util.Collection.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String query = "";

request.setCharacterEncoding("utf-8");
Connection con = null;
String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
String userid = "leekm";
String pwd = "12121212";

String num = "";
Enumeration<String> temp = request.getParameterNames();
Iterator<String> i = temp.asIterator();
while(i.hasNext()){
	String name = i.next();
	num = name.split("data")[1];
	System.out.println(num);
	if(!num.equals("")){
		break;
	}
}

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

query = "delete from 주문 where 주문번호 = ?";
try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
	PreparedStatement ppst = null;
	ppst = con.prepareStatement(query); // PreparedStatement 객체 생성(쿼리 생성)
	ppst.setInt(1,Integer.parseInt(num));
	ppst.executeUpdate(); // 쿼리(sql) 실행
} catch (SQLException e) {
	PrintWriter script = response.getWriter();
	e.printStackTrace();
	script.println("<script>");
	script.println("alert('잘못된 사용입니다(DB오류)')");
	script.println("history.back()");
	script.println("</script>");

	if (true) return;
}
PrintWriter script = response.getWriter();
script.println("<script>");
script.println("alert('취소 완료!')");
script.println("</script>");
con.close();
response.sendRedirect("mypage.jsp");
%>

