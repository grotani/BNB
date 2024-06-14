<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====rejectRoomAction.jsp=====");

	// 승인 할 roomNo 호출
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	
	// 숙소 반려 메서드 실행 후 디버깅
	int reject = RoomDAO.updateRoomStateReject(roomNo);
	System.out.println("reject");
	
	if(reject == 1){
		System.out.println("반려 완료");
		String msg = URLEncoder.encode("숙소 반려 완료", "UTF-8");
		response.sendRedirect("/BeeNb/emp/pendingRoomList.jsp?msg="+msg);
		return;
	}else{
		String msg = URLEncoder.encode("오류가 발생하였습니다. 다시 확인해 주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/pendingRoomList.jsp?msg="+msg);
		return;
	}
	
	
%>