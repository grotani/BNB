<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerLogoutAction.jsp=====");
	// 세션초기화 
	session.invalidate();

	String logoutMsg = URLEncoder.encode("정상적으로 로그아웃 되었습니다.","utf-8");
	response.sendRedirect("/BeeNb/customer/customerLoginForm.jsp?logoutMsg="+logoutMsg);
%>