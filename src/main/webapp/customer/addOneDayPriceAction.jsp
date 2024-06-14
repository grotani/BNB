<%@page import="beeNb.dao.OneDayPriceDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("========== addOneDayPriceAction.jsp ==========");
	// 요청 값(roomNo, roomDate[], roomPrice)
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	// 날짜 선택 안 했을 경우
	if(request.getParameterValues("roomDate") == null) {
		String errMsg = URLEncoder.encode("가격을 등록할 날짜를 선택해주세요", "UTF-8");
		response.sendRedirect("/BeeNb/customer/addOneDayPriceForm.jsp?roomNo=" + roomNo + "&errMsg=" + errMsg);
		return;
	}
	String[] roomDate = request.getParameterValues("roomDate");
	int roomPrice = Integer.parseInt(request.getParameter("roomPrice"));
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	for(String s : roomDate) {
		System.out.println("roomDate : " + s);
	}
	System.out.println("roomPrice : " + roomPrice);
	
	// 해당 날짜에 가격 등록(ondDayPrice DB에 INSERT)
	int insertOneDayPriceRow = OneDayPriceDAO.insertOneDayPrice(roomNo, roomDate, roomPrice);
	System.out.println("insertOneDatePriceRow : " + insertOneDayPriceRow);
	
	if(insertOneDayPriceRow == 0) {
		// 등록 실패
		String errMsg = URLEncoder.encode("가격 등록에 실패했습니다. 다시 등록해주세요", "UTF-8");
		response.sendRedirect("/BeeNb/customer/addOneDayPriceForm.jsp?roomNo=" + roomNo + "&errMsg=" + errMsg);
		return;
	}
	// 등록 성공
	String msg = URLEncoder.encode("가격이 등록되었습니다.", "UTF-8");
	response.sendRedirect("/BeeNb/customer/hostRoomOne.jsp?roomNo=" + roomNo+ "&msg=" + msg);
%>