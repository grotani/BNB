<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "java.util.*" %>

<%
	System.out.println("=====customerCancelBookingAction.jsp=====");
	int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
	String customerId = (String)(loginCustomer.get("customerId"));
	
	//디버깅 코드
	System.out.println("bookingNo:" + bookingNo);
	System.out.println("customerId:" + customerId);
	
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
		
	// roomState 변경 성공
	
	// 예약 취소 기능
	int row = BookingDAO.deleteBooking(bookingNo, customerId);
	
	if(row == 1){
		//디버깅 코드
		System.out.println("취소성공");
		String succMsg = URLEncoder.encode("예약취소 완료되었습니다.", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerBookingList.jsp?succMsg="+succMsg+"&customerId="+customerId);
	} else{
		//디버깅 코드
		System.out.println("취소실패");
		String errMsg = URLEncoder.encode("이용일 3일전 취소 불가합니다.", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerBookingList.jsp?errMsg="+errMsg+"&customerId="+customerId);
	}
%>