<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>
<%@ page import="java.net.URLEncoder"%>
<%
	System.out.println("=====deleteHostRoomAction.jsp=====");
	
	// roomNo호출 후 디버깅
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	System.out.println("roomNo : " + roomNo);
	
	// 이용전인 예약목록이 있는지 확인 후 디버깅
	int bookingExist = BookingListDAO.selectBookingList(roomNo);
	System.out.println("예약목록이 있으면 1, 없으면 0 : " + bookingExist);
	
	if(bookingExist==1){ // 예약목록이 있으면 에러메세지와 함께 리스트 페이지로...(수정예정)
		System.out.println("예약목록이 존재함");
		String errMsg = URLEncoder.encode("예약목록이 존재합니다.", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostRoomOne.jsp?roomNo="+roomNo+"&errMsg="+errMsg);
		return;
	}
	
	// 이용전 예약목록이 없을 때 비로소
	// room 삭제 메서드 실행
	// delete cascade를 어디어디에 줄까 생각중.
	int deleteRoom = RoomDAO.deleteRoom(roomNo);
	System.out.println("deleteRoom : " + deleteRoom);
	
	if(deleteRoom==1){
		System.out.println("숙소 삭제 완료");
		String msg = URLEncoder.encode("숙소삭제완료.", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostRoomList.jsp?msg="+msg);
		return;
	}else{
		System.out.println("숙소 삭제 실패");
		String errMsg = URLEncoder.encode("숙소삭제실패.", "UTF-8");
		response.sendRedirect("/BeeNb/customer/hostRoomOne.jsp?roomNo="+roomNo+"&errMsg="+errMsg);
		return;
	}
%>