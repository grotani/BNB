<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====empLogoutAction.jsp=====");
	session.invalidate();	
	String logoutMsg = "정상적으로 로그아웃 되었습니다.";
	String errMsg = URLEncoder.encode(logoutMsg, "utf-8");
	response.sendRedirect("/BeeNb/emp/empLoginForm.jsp?logoutMsg="+errMsg);
%>