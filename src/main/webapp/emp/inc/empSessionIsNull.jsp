<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%
	// 고객 로그인이 되어 있지 않을 때 로그인폼으로 이동
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	if(loginEmp == null) {
		response.sendRedirect("/BeeNb/emp/empLoginForm.jsp");
		return;
	}
%>