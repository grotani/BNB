<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>


<%
	System.out.println("=====customerDropAction.jsp=====");
	String customerId = request.getParameter("customerId");
	
	//디버깅
	System.out.println("customerId : " + customerId);

	
	// 회원탈퇴시 회원정보 삭제 
	int row = CustomerDAO.deleteCustomer(customerId);
	System.out.println("회원정보삭제: "+row);
	// 회원탈퇴시 회원의 비밀번호이력 삭제
	int row2 = CustomerDAO.deleteCustomerPwHistory(customerId);
	System.out.println("비밀번호 이력삭제: "+row2);
	
	if(row == 1 && row2 == 0) {
		//디버깅코드
		System.out.println("탈퇴성공");
		String dropMsg=URLEncoder.encode("탈퇴완료되었습니다 언제든지 저희를 다시 이용해주세요", "UTF-8");
		response.sendRedirect("/BeeNb/customer/customerRoomList.jsp");
		// 세션초기화 
		session.invalidate();
	} else {
		//디버깅코드
		System.out.println("탈퇴실패");
		String dropErrMsg=URLEncoder.encode("탈퇴실패하셨습니다. 정말로 탈퇴 하시겠습니까?", "UTF-8");
		response.sendRedirect("/BeeNb/customer/customerDropCheckPwForm.jsp?dropErrMsg="+dropErrMsg);		
	}		
	
%>