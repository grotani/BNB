<%@page import="beeNb.dao.ComplainDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	System.out.println("=====updateVocStateAction.jsp=====");
	int complainNo = Integer.parseInt(request.getParameter("complainNo"));
	String complainState = request.getParameter("complainState");
	String complainAnswer = request.getParameter("complainAnswer");
	
	// 디버깅 코드
	System.out.println("complainNo : " + complainNo);
	System.out.println("complainState : " + complainState);
	if(complainAnswer != null){
		System.out.println("complainAnswer : " + complainAnswer);
	}
	int row = 0;
	if(complainState.equals("접수")){
		System.out.println("113");
		row = ComplainDAO.updateVoc(complainNo, "처리중", "");
	}else if(complainState.equals("처리중")){
		System.out.println("113");
		row = ComplainDAO.updateVoc(complainNo, "처리완료", complainAnswer);		
	}
	
	String msg = "입력하신 정보를 재확인 해주세요.";
	if(row == 0){
		String errMsg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect("/BeeNb/emp/vocOne.jsp?errMsg="+errMsg+"&complainNo="+complainNo);
		return;
	}
	response.sendRedirect("/BeeNb/emp/vocList.jsp");
%>