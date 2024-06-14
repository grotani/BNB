<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.ThemeDAO" %>
<%@ page import="java.net.URLEncoder"%>
<%
	System.out.println("=====addThemeAction.jsp=====");

	// roomTheme 호출
	String roomTheme = request.getParameter("roomTheme");
	// roomTheme 디버깅
	System.out.println("roomTheme : " + roomTheme);
	
	// 추가하려는 테마이름 중복조회
	boolean checkThemeName = ThemeDAO.checkThemeName(roomTheme);
	// 메서드 반환값 디버깅(이미 있는 테마이름 : true / 없는이름 : false)
	System.out.println("checkThemeName : " + checkThemeName);
	// 이미 있는 이름이면 themeList.jsp로 에러메세지 담아서 sendRedirect
	if(checkThemeName==true){
		System.out.println("이미 있는 테마이름");
		String errMsg = URLEncoder.encode("중복된 테마 이름입니다.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/themeList.jsp?errMsg="+errMsg);
		return;
	}
	
	// 테마추가 메서드
	int insertTheme = ThemeDAO.insertTheme(roomTheme);
	// 메서드 반환값 디버깅
	System.out.println("insertTheme : " + insertTheme);
	
	// 테마추가 결과 분기문
	if(insertTheme==1){
		System.out.println("테마추가완료");
		response.sendRedirect("/BeeNb/emp/themeList.jsp");
		return;
	}else{
		System.out.println("테마추가실패");
		String errMsg = URLEncoder.encode("테마추가실패. 다시 확인하세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/themeList.jsp?errMsg="+errMsg);
		return;
	}
%>