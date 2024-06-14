<%@page import="java.net.URLEncoder"%>
<%@page import="beeNb.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("========== hostBookingUpdateAction.jsp ==========");
	// bookingNo 요청값
	int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
	// 디버깅
	System.out.println("bookingNo : " + bookingNo);
	
	// bookingState(ENUM : '전', '후', '리뷰완료')의 상태를 '후'로 변경
	String state = "후";
	int updateBookingStateRow = BookingDAO.updateBookingState(bookingNo, state);
	
	// 디버깅
	System.out.println("updateBookingStateRow : " + updateBookingStateRow);
	// 상태 변경 실패
	if(updateBookingStateRow == 0) {
		String errMsg = URLEncoder.encode("상태 변경에 실패했습니다", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostBookingList.jsp?errMsg=" + errMsg);
		return;
	}
	// 상태 변경 성공
	String msg = URLEncoder.encode("예약번호 " + bookingNo + "번이 체크아웃 되었습니다.", "UTF-8");
	response.sendRedirect("/BeeNb/customer/hostBookingList.jsp?msg=" + msg);

%>