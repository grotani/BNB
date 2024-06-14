<%@page import="beeNb.dao.ComplainDAO"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="beeNb.dao.RoomImgDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<%
	System.out.println("=====customerComplainBookingAction.jsp=====");

	String bookingNo = request.getParameter("bookingNo");
	String complainType = request.getParameter("complainType");
	String complainContent = request.getParameter("complainContent");

	System.out.println("bookingNo : " + bookingNo);
	System.out.println("complainType : " + complainType);
	System.out.println("complainContent : " + complainContent);

	HashMap<String, Object> paramMap = new HashMap<>();

	paramMap.put("bookingNo", bookingNo);
	paramMap.put("complainType", complainType);
	paramMap.put("complainContent", complainContent);

	
	int row = ComplainDAO.insertComplain(paramMap);

	if(row <= 0){
		String errMsg = URLEncoder.encode("민원 등록 실패", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerBookingForm.jsp?errMsg="+errMsg);
		System.out.println("민원 등록 실패!!!");
		return;
	}
	response.sendRedirect("/BeeNb/customer/customerBookingList.jsp");
	
%>