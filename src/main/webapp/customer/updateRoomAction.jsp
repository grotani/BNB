<%@page import="beeNb.dao.RoomOptionDAO"%>
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
	System.out.println("=====updateRoomAction.jsp=====");
	System.out.println("loginCustomer : " + loginCustomer);

	/*
		room tbl
			roomName
			roomCategory
			roomTheme
			roomAddress
			roomContent
			operationStart
			operationEnd
			maxPeople
	*/
	String roomName = request.getParameter("roomName");
	String roomCategory = request.getParameter("roomCategory");
	String roomTheme = request.getParameter("roomTheme");
	String roomAddress = request.getParameter("roomAddress");
	String roomContent = request.getParameter("roomContent");
	String operationStart = request.getParameter("operationStart");
	String operationEnd = request.getParameter("operationEnd");
	String maxPeople = request.getParameter("maxPeople");
	String roomNo = request.getParameter("roomNo");
	
	System.out.println("roomName : " + roomName);
	System.out.println("roomCategory : " + roomCategory);
	System.out.println("roomTheme : " + roomTheme);
	System.out.println("roomAddress : " + roomAddress);
	System.out.println("roomContent : " + roomContent);
	System.out.println("operationStart : " + operationStart);
	System.out.println("operationEnd : " + operationEnd);
	System.out.println("maxPeople : " + maxPeople);
	System.out.println("roomNo : " + roomNo);
	
	HashMap<String, String> roomParamMap = new HashMap<>();

	roomParamMap.put("roomCategory", roomCategory);
	roomParamMap.put("roomName", roomName);
	roomParamMap.put("roomTheme", roomTheme);
	roomParamMap.put("roomAddress", roomAddress);
	roomParamMap.put("roomContent", roomContent);
	roomParamMap.put("operationStart", operationStart);
	roomParamMap.put("operationEnd", operationEnd);
	roomParamMap.put("maxPeople", maxPeople);
	roomParamMap.put("roomNo", roomNo);
	
	
	int row = RoomDAO.updateRoom(roomParamMap);
	if(row <= 0){
		String errMsg = URLEncoder.encode("숙소 데이터 수정 실패", "utf-8");
		response.sendRedirect("/BeeNb/customer/updateRoomForm.jsp?errMsg="+errMsg);
		System.out.println("숙소 데이터 수정 실패!!!");
		return;
	}
	

	/*
		room_option tbl
			wifi
			kitshenTools
			parking
			bed
			ott
			ev
	*/
	
	String wifi = request.getParameter("wifi");
	String kitshenTools = request.getParameter("kitshenTools");
	String parking = request.getParameter("parking");
	String bed = request.getParameter("bed");
	String ott = request.getParameter("ott");
	String ev = request.getParameter("ev");
	
	System.out.println("wifi : " + wifi);
	System.out.println("kitshenTools : " + kitshenTools);
	System.out.println("parking : " + parking);
	System.out.println("bed : " + bed);
	System.out.println("ott : " + ott);
	System.out.println("ev : " + ev);
	
	HashMap<String, String> roomOptionParamMap = new HashMap<>();
	roomOptionParamMap.put("wifi", wifi);
	roomOptionParamMap.put("kitshenTools", kitshenTools);
	roomOptionParamMap.put("parking", parking);
	roomOptionParamMap.put("bed", bed);
	roomOptionParamMap.put("ott", ott);
	roomOptionParamMap.put("ev", ev);
	roomOptionParamMap.put("roomNo", roomNo);

	

	row = RoomOptionDAO.updateRoomOption(roomOptionParamMap);
	
	
	if(row <= 0){
		System.out.println("숙소 옵션 데이터 수정 실패!!!");
		String errMsg = URLEncoder.encode("숙소 상세 옵션 데이터 수정 실패", "utf-8");
		response.sendRedirect("/BeeNb/customer/updateRoomForm.jsp?errMsg="+errMsg);
		return;					
	}
	response.sendRedirect("/BeeNb/customer/hostRoomList.jsp");
	
%>