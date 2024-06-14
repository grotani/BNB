<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>

<%
	System.out.println("=====customerDropCheckPwAction.jsp=====");
	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	//디버깅
	System.out.println("customerId :" + customerId);
	System.out.println("customerPw :" + customerPw);
	
	boolean result = CustomerDAO.selectCustomerPw(customerId, customerPw);
	if(result == true) {
		//디버깅
		System.out.println("일치성공");
		response.sendRedirect("/BeeNb/customer/customerDropAction.jsp?customerId="+customerId);
	} else {
		//디버깅
		System.out.println("불일치");
		String errMsg=URLEncoder.encode("ID 또는 비밀번호 불일치", "UTF-8");
		response.sendRedirect("/BeeNb/customer/customerDropCheckPwForm.jsp?customerId="+customerId+"&errMsg="+errMsg);
	}
	
	
%>
