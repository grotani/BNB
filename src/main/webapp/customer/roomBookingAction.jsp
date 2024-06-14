<%@page import="beeNb.dao.RevenueDAO"%>
<%@page import="beeNb.dao.BookingListDAO"%>
<%@page import="beeNb.dao.BookingDAO"%>
<%@page import="beeNb.dao.OneDayPriceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<%
	System.out.println("==========roomBookingAction.jsp==========");

	String customerId = ""+loginCustomer.get("customerId");
	int roomNo =  Integer.parseInt(request.getParameter("roomNo"));
	int usePeople = Integer.parseInt(request.getParameter("usePeople"));
	String roomDate[] = request.getParameterValues("roomDate");
	
	System.out.println("roomNo : " + roomNo);
	System.out.println("usePeople : " + usePeople);
	System.out.println("roomDate.length : " + roomDate.length);
	for(String dateItem : roomDate){
		System.out.println("roomDate : " + dateItem);
	}
	
	int row = OneDayPriceDAO.updateOneDayPrice(roomNo, roomDate);
	if(row != roomDate.length){
		System.out.println("날짜별 가격 정보 변경 오류!");
		return;
	}
	
	row = BookingDAO.insertBooking(customerId, usePeople, roomNo);
	if(row <= 0){
		System.out.println("부킹 정보 등록 오류!");
		return;		
	}
	int bookingNo = BookingDAO.selectBookingNo(customerId, roomNo);
	row = BookingListDAO.insertBookingList(roomNo, bookingNo, roomDate);
	int revenue = OneDayPriceDAO.selectTotalPrice(roomNo, roomDate);
	row = RevenueDAO.insertRevenue(bookingNo, revenue);
	response.sendRedirect("/BeeNb/customer/customerBookingList.jsp");

%>