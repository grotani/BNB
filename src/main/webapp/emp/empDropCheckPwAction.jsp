<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="beeNb.dao.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====empDropCheckPwAction.jsp=====");

	// 사번, 비밀번호 호출
	String empNo = request.getParameter("empNo");
	String empPw = request.getParameter("empPw");
	
	// 디버깅
	System.out.println("empNo : " + empNo);
	System.out.println("empPw : " + empPw);
	
	// 비밀번호 일치하는 지 확인
	// 로그인 메서드랑 같음
	HashMap<String, Object> checkPw = EmpDAO.empLogin(empNo, empPw);
	System.out.println("checkPw : " + checkPw);
	
	// 로그인 메서드를 썼다. 로그인 메서드는 세션에 여러 값을 넣기위해 HashMap타입으로 반환한다.
	// 이 값이 null인지 아닌지로 비밀번호 확인을 대체하겠다.
	if(checkPw!=null){ // 성공
		int deleteEmp = EmpDAO.deleteEmp(empNo);
		if(deleteEmp==1){
			System.out.println("관리자 탈퇴완료");
			session.invalidate();
			response.sendRedirect("/BeeNb/emp/empLoginForm.jsp");
			return;
		}else{
			System.out.println("관리자 탈퇴실패");
			String msg = URLEncoder.encode("관리자 탈퇴실패. 다시 확인하세요.", "UTF-8");
			response.sendRedirect("/BeeNb/emp/empDropCheckPwForm.jsp?msg="+msg);
			return;
		}
	}else{
		System.out.println("관리자 탈퇴실패");
		String msg = URLEncoder.encode("관리자 탈퇴실패. 다시 확인하세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empDropCheckPwForm.jsp?msg="+msg);
		return;
	}
%>