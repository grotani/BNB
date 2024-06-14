<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "java.net.*" %>

<%
	System.out.println("=====customerCheckPwAction.jsp=====");
	String customerPw = request.getParameter("customerPw");
	String customerId = (String)(loginCustomer.get("customerId"));
	// 디버깅코드
	System.out.println("customerPw: "+customerPw);
	System.out.println("customerId: "+customerId);
	
	// 정보수정시 비밀번호 확인
	boolean result = CustomerDAO.selectCustomerPw(customerId, customerPw);
	
	if(result == true){
		System.out.println("일치");
		response.sendRedirect("/BeeNb/customer/customerUpdateForm.jsp?customerPw="+customerPw);
	} else{
		System.out.println("불일치");
		String errMsg = URLEncoder.encode("비밀번호 불일치 다시 입력해주세요", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerCheckPwForm.jsp?errMsg="+errMsg);
	}
	
%>