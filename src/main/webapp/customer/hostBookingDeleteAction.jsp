<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beeNb.dao.OneDayPriceDAO"%>
<%@page import="beeNb.dao.BookingListDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="beeNb.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("========== hostBookingDeleteAction.jsp ==========");

	// 요청 값(bookingNo)
	int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
	// 디버깅
	System.out.println("bookingNo : " + bookingNo);
	
	// 해당 bookingNo의 roomNo, roomDate(예약 일자) list
	ArrayList<HashMap<String, Object>> roomNoAndDateList = BookingListDAO.selectRoomDateListOfBookingNo(bookingNo);
	
	// bookingNo에 대한 roomNo는 모두 같으므로 첫번째 인덱스의 roomNo를 가져오기
	int roomNo = (int)(roomNoAndDateList.get(0).get("roomNo"));
	// bookingNo에 대한 roomDate를 담을 
	ArrayList<String> roomDateList = new ArrayList<>();
	
	// 각각의 roomDate를 리스트에 담기
	for(HashMap<String, Object> m : roomNoAndDateList) {
		roomDateList.add((String)(m.get("roomDate")));
	}
	
	// 예약 취소 쿼리 실행 전 oneday_price테이블의 roomState를 예약 가능으로 변경
	int updateOneDayPriceRow = OneDayPriceDAO.updateOneDayPriceState(roomNo, roomDateList);
	
	// roomState 변경 실패
	if(updateOneDayPriceRow == 0) {
		String errMsg = URLEncoder.encode("예약 취소가 실패했습니다", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostBookingList.jsp?errMsg=" + errMsg);
		return;
	}
	
	// roomState 변경 성공
	// 고객의 예약 취소
	int deleteBookinByHostRow = BookingDAO.deleteBookingByHost(bookingNo);
	// 디버깅
	System.out.println("deleteBookinByHostRow : " + deleteBookinByHostRow);
	
	// 예약 취소 실패
	if(deleteBookinByHostRow == 0) {
		String errMsg = URLEncoder.encode("예약 취소가 실패했습니다", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostBookingList.jsp?errMsg=" + errMsg);
		return;
	}
	// 예약 취소 성공
	String msg = URLEncoder.encode("예약번호 " + bookingNo + "의 예약이 취소되었습니다.", "UTF-8");
	response.sendRedirect("/BeeNb/customer/hostBookingList.jsp?msg=" + msg);
		
%>