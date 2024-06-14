<%@page import="java.net.URLEncoder"%>
<%@page import="beeNb.dao.OneDayPriceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println("========== deleteOneDayPriceAction.jsp ==========");

	// 요청 값
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	String roomDate = request.getParameter("roomDate");
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	System.out.println("roomDate : " + roomDate);
	
	
	// 해당 숙소의 해당 날짜에 등록된 가격 삭제
	int deleteOneDayPriceRow = OneDayPriceDAO.deleteOneDayPrice(roomNo, roomDate);
	System.out.println("deleteOneDayPriceRow : " + deleteOneDayPriceRow);
	
	// 삭제 실패
	if(deleteOneDayPriceRow == 0) {
		String errMsg = URLEncoder.encode("가격 삭제에 실패했습니다", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostRoomOne.jsp?roomNo=" + roomNo + "&errMsg=" + errMsg);
		return;
	}
	
	String msg = URLEncoder.encode(roomDate + "일의 가격이 삭제되었습니다.", "UTF-8");
	response.sendRedirect("/BeeNb/customer/hostRoomOne.jsp?roomNo=" + roomNo + "&msg=" + msg);
%>