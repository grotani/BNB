<%@page import="java.util.HashMap"%>
<%@page import="beeNb.dao.EmpDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/emp/inc/empSessionNotNull.jsp" %>
<%
	System.out.println("=====empLoginAction.jsp=====");
	String empNo = request.getParameter("empNo");
	String empPw = request.getParameter("empPw");
	// 디버깅 코드
	System.out.println("empNo : " + empNo);
	System.out.println("empPw : " + empPw);
	
	loginEmp = EmpDAO.empLogin(empNo, empPw);
	String msg = "입력하신 정보를 재확인 해주세요.";
	System.out.println("loginEmp : " + loginEmp);
	if(loginEmp.isEmpty()){
		String errMsg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect("/BeeNb/emp/empLoginForm.jsp?errMsg="+errMsg);
		return;
	}else{
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/BeeNb/emp/empRoomList.jsp");
		return;
	}
%>