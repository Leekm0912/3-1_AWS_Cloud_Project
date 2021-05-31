<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String type = request.getParameter("type");
	if(type.equals("sell")){
%>
		<jsp:forward page="../add_order.jsp"/>
<%
	}else if(type.equals("update")){
		String num = "";
		Enumeration<String> temp = request.getParameterNames();
		Iterator<String> i = temp.asIterator();
		while(i.hasNext()){
			String name = i.next();
			if(name.contains("data")){
				num = name.split("data")[1];
				System.out.println(num);
				if(!num.equals("")){
					break;
				}
			}
		}
		request.setAttribute("num", num);
%>
		<jsp:forward page="../delete_data.jsp"/>
<%
	}
%>