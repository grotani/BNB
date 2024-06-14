<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>
<%@page import="java.net.*"%>


<%

	System.out.println("=====customerFindIdAction.jsp=====");
	
	String customerName = request.getParameter("customerName");
	String customerEmail = request.getParameter("customerEmail");
	// 디버깅
	System.out.println("고객이름 :" + customerName);
	System.out.println("고객이메일 :" + customerEmail);
	
	
	String result = CustomerDAO.customerCheckId(customerName, customerEmail);
	
	if(result == "") {
		// 디버깅코드
		System.out.println("ID찾기 실패");
		String errMsg = URLEncoder.encode("입력하신 정보를 재확인 해주세요", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerFindIdForm.jsp?errMsg="+errMsg);
	} else {
		// 디버깅코드
		System.out.println("ID찾기 성공");
		response.sendRedirect("/BeeNb/customer/customerResultIdOne.jsp?result="+result);
		
	}

%>
