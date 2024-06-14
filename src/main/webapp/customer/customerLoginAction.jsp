<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>

<%
	System.out.println("=====customerLoginAction.jsp=====");
	// 로그인 인증분기 
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/BeeNb/customer/customerRoomList.jsp");
		return;
	}
%>
<%
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	// 디버깅
	System.out.println("로그인 ID :" + customerId);
	System.out.println("로그인 Pw :" + customerPw);
	
	
	HashMap<String, String> loginCustomer = CustomerDAO.loginCustomer(customerId, customerPw);
	if(loginCustomer == null) {
		// 디버깅
		System.out.println("customer 로그인실패");
		String errMsg = URLEncoder.encode("입력하신 정보를 재확인 해주세요", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerLoginForm.jsp?errMsg="+errMsg);
	} else {
		// 디버깅
		System.out.println("customer 로그인 성공");
		session.setAttribute("loginCustomer", loginCustomer);
		response.sendRedirect("/BeeNb/customer/customerRoomList.jsp");
	}
	
%>