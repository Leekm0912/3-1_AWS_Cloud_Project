<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("utf-8");
String userType = (String) session.getAttribute("userType");
String userID = (String) session.getAttribute("userID");

String nowPW = request.getParameter("now_password");
String changePW1 = request.getParameter("change_password1");
String changePW2 = request.getParameter("change_password2");

String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
String userid = "leekm";
String pwd = "12121212";
String query = "";
Statement stmt = null;
ResultSet rs = null;
PreparedStatement ppst = null;
Connection con = null;

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

if (userType.equals("매수자")) {
	query = "select pw from 매수자 where id = " + "'" + userID + "'";
} else if (userType.equals("매도자")) {
	query = "select pw from 매도자 where id = " + "'" + userID + "'";
}

String getPW = "";

try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
	stmt = con.createStatement();
	rs = stmt.executeQuery(query);
	while(rs.next()){
		getPW = rs.getString(1);
	}
	char [] temp = getPW.toCharArray();
	
	for(int i=0; i<temp.length;i++){
		int temp2 = (int)temp[i];
		temp2 += 30;
		temp[i] = (char)temp2;
	}
	getPW =  new String(temp);
	System.out.println(getPW);
	if (nowPW.equals(getPW)) {
		if(!changePW1.equals(changePW2)){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			
			script.println("alert('비밀번호가 일치하지 않습니다.')");
		
			script.println("history.back()");
		
			script.println("</script>");
			return;
		}
		

		temp = changePW1.toCharArray();
			
		for(int i=0; i<temp.length;i++){
			int temp2 = (int)temp[i];
			temp2 -= 30;
			temp[i] = (char)temp2;
		}
		changePW1 =  new String(temp);
		
		if (userType.equals("매수자")) {
			query = "update 매수자 set pw = ? where id = ?";
		} else if (userType.equals("매도자")) {
			query = "update 매도자 set pw = ? where id = ?";
			//query = "update 매도자 set pw = ? where id = "+ "'" + userID + "'";
		}
		
		try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
			ppst = null;
			ppst = con.prepareStatement(query); // PreparedStatement 객체 생성(쿼리 생성)
			ppst.setString(1, changePW1);
			ppst.setString(2, userID);
			ppst.executeUpdate(); // 쿼리(sql) 실행
		} catch (SQLException e) {
			e.printStackTrace();
			PrintWriter script = response.getWriter();
		
			script.println("<script>");
		
			script.println("alert('잘못된 입력값 입니다(DB 오류).')");
		
			script.println("history.back()");
		
			script.println("</script>");
			return;

		}
	}
	else{
		PrintWriter script = response.getWriter();
		
		script.println("<script>");
		
		script.println("alert('현재 비밀번호가 다릅니다.')");
	
		script.println("history.back()");
	
		script.println("</script>");
		return;
	}
} catch (Exception e) {
	e.printStackTrace();
}
PrintWriter script = response.getWriter();
script.println("<script>");

script.println("alert('비밀번호 변경이 완료되었습니다.')");

script.println("history.back()");

script.println("</script>");
con.close();
//response.sendRedirect("mypage.jsp");
%>
