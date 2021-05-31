<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate();
	//session.removeAttribute("userType");
	response.sendRedirect("main.jsp");
%>