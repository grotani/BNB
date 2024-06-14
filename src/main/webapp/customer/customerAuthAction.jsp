<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>

<%
	System.out.println("=====customerAuthAction.jsp=====");

	String customerId = request.getParameter("customerId");
	String customerName = request.getParameter("customerName");
	String customerPhone = request.getParameter("customerPhone");
	
	// 디버깅코드
	System.out.println("customerId :" + customerId);
	System.out.println("customerName :" + customerName);
	System.out.println("customerPhone :" + customerPhone);
	
	// 본인인증 유무 확인하기
	boolean result = CustomerDAO.selectCustomerAuth(customerId, customerName, customerPhone);
	
	if(result == true){//true면 본인인증 성공
		// 디버깅코드
		System.out.println("본인인증 성공");
		String authMsg = URLEncoder.encode("본인인증 성공입니다.", "utf-8");	
		response.sendRedirect("/BeeNb/customer/customerEditPwForm.jsp?customerId="+customerId+"&authMsg="+authMsg);
	}else{ // false면 본인인증 실패
		// 디버깅코드
		System.out.println("본인인증 실패");
		String errMsg = URLEncoder.encode("본인인증 실패입니다.", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerAuthForm.jsp?errMsg="+errMsg);
	}
%>