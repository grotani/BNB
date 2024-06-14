<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<%
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println("=====customerCheckIdAction.jsp=====");
	System.out.println("customerId: " + customerId);
	
	boolean result = CustomerDAO.customerCheckId(customerId);

	
	if(result == true){ // 아이디 사용 가능
		System.out.println("사용가능");
		// check가 T면 사용가능 
		response.sendRedirect("/BeeNb/customer/customerSignUpForm.jsp?customerId="+customerId+"&check=T");
	}else{ // 아이디 사용 불가
		System.out.println("사용불가");
		// check가 F면 사용불가
		response.sendRedirect("/BeeNb/customer/customerSignUpForm.jsp?customerId="+customerId+"&check=F");
	}
%>