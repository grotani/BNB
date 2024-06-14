<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<%
	System.out.println("=====customerEditPwAction.jsp=====");

	String customerId = request.getParameter("customerId");
	String newCustomerPw = request.getParameter("newCustomerPw");
	String newCustomerPwCheck = request.getParameter("newCustomerPwCheck");
	
	// 디버깅 코드
	System.out.println("customerId: " + customerId);
	System.out.println("newCustomerPw: " + newCustomerPw);
	System.out.println("newCustomerPwCheck: " + newCustomerPwCheck);
	
	// 비밀번호 변경시 이력에 없는지 확인
	boolean result = CustomerDAO.selectCustomerPwHistory(customerId, newCustomerPw);
	if(result == true){
		System.out.println("비밀번호 중복");
		String errMsg = URLEncoder.encode("사용했던 비밀번호입니다. 다시입력해주세요.","utf-8");
		response.sendRedirect("/BeeNb/customer/customerEditPwForm.jsp?errMsg="+errMsg+"&customerId="+customerId);
		return;
	}
	
	// customer table에 새로운 pw 업데이트
	int row = CustomerDAO.updateCustomerPw(newCustomerPw, customerId);
	// customer_pw_history에 새로운 pw 입력 
	int row2 = CustomerDAO.insertCustomerNewPwHistory(newCustomerPw, customerId);

	if(row == 1 && row2 == 1){
		// 디버깅 코드
		System.out.println("변경 성공");
		String editMsg = URLEncoder.encode("변경성공입니다.","utf-8");
		response.sendRedirect("/BeeNb/customer/customerLoginForm.jsp?editMsg="+editMsg);
	} else{
		// 디버깅 코드
		System.out.println("변경 실패");
		String errMsg = URLEncoder.encode("변경실패입니다.","utf-8");
		response.sendRedirect("/BeeNb/customer/customerEditPwForm.jsp?errMsg="+errMsg+"&customerId="+customerId);
	}

%>