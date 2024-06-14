<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.ThemeDAO" %>
<%@ page import="beeNb.dao.RoomDAO" %>
<%@page import="java.net.URLEncoder"%>
<%
	System.out.println("=====deleteThemeAction.jsp=====");

	// roomTheme 호출
	String roomTheme = request.getParameter("roomTheme");
	// roomTheme 디버깅
	System.out.println("roomTheme : " + roomTheme);
	
	// 해당 테마를 사용하고있는 room이 있는지 조회
	// return : boolean (있으면 true, 없으면 false)
	boolean thereIsRoomTheme = RoomDAO.thereIsRoomTheme(roomTheme);
	System.out.println("thereIsRoomTheme : " + thereIsRoomTheme);
	if(thereIsRoomTheme==true){
		System.out.println("사용중인 테마");
		String msg = URLEncoder.encode("사용중인 테마입니다. 해당 숙소를 삭제한 후 시도해주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/themeList.jsp?msg="+msg);
		return;
	}
	
	// 테마 삭제하는 메서드
	int deleteTheme = ThemeDAO.deleteTheme(roomTheme);
	// 메서드 반환값 디버깅
	System.out.println("deleteTheme : " + deleteTheme);
	
	// 테마삭제 결과 분기문
	if(deleteTheme==1){
		System.out.println("테마삭제완료");
		response.sendRedirect("/BeeNb/emp/themeList.jsp");
		return;
	}else{
		System.out.println("테마삭제실패");
		String errMsg = URLEncoder.encode("테마삭제실패. 다시 확인하세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/themeList.jsp?delErrMsg="+errMsg);
		return;
	}
	
%>