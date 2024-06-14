<%@page import="java.net.URLEncoder"%>
<%@page import="beeNb.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/emp/inc/empSessionNotNull.jsp" %>
<% 
	System.out.println("=====empResetPwAction.jsp=====");
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String empPhone = request.getParameter("empPhone");
	// 디버깅 코드
	System.out.println("empNo : " + empNo);
	System.out.println("empPhone : " + empPhone);
	
	boolean resultBool = EmpDAO.selectEmpOne(empNo, empPhone);
	String msg = "입력하신 정보를 재확인 해주세요.";
	if(resultBool == false){
		String errMsg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect("/BeeNb/emp/empResetPwForm.jsp?errMsg="+errMsg);
		return;
	}
	
	int row = EmpDAO.empResetPw(empNo);
	msg = "초기화 에러. 관리자에게 문의바랍니다.";
	if(row == 0){
		String errMsg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect("/BeeNb/emp/empLoginForm.jsp?errMsg="+errMsg);
		return;
	}else{
		response.sendRedirect("/BeeNb/emp/empLoginForm.jsp");
		return;
	}
%>