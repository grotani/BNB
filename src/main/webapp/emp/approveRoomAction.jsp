<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====approveRoomAction.jsp=====");
	
	// 승인 할 roomNo, customerId 호출
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	String customerId = request.getParameter("customerId");
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	System.out.println("customerId : " + customerId);
	
	// 숙소 승인 메서드 실행 후 디버깅
	int approve = RoomDAO.updateRoomStateApprove(roomNo);
	System.out.println("approve : " + approve);
	
	// 성공 실패 분기문
	if(approve == 1){ // 업데이트 성공시
		System.out.println("승인 업데이트 성공");
	
		// 상신한 customer의 grade를 조회 후 디버깅
		int checkCustomerGrade = CustomerDAO.checkCustomerGrade(customerId);
		System.out.println("checkCustomerGrade : " + checkCustomerGrade);
							
		// 조회 결과 0이면(게스트등급이면) 1로 업데이트(호스트등급부여)
		if(checkCustomerGrade == 0){
			int updateGrade = CustomerDAO.updateCustomerGrade(customerId);
			System.out.println("호스트 등급 부여 되었으면 1 :" + updateGrade);
			String msg = URLEncoder.encode("숙소 승인 완료, 호스트 권한 부여 완료", "UTF-8");
			response.sendRedirect("/BeeNb/emp/pendingRoomList.jsp?msg="+msg);
			return;
		}
		
		//
		String msg = URLEncoder.encode("숙소 승인 완료", "UTF-8");
		response.sendRedirect("/BeeNb/emp/pendingRoomList.jsp?msg="+msg);
		return;
	}else{
		String msg = URLEncoder.encode("오류가 발생하였습니다. 다시 확인해 주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/pendingRoomList.jsp?msg="+msg);
		return;
	}
%>