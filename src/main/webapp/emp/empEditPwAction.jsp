<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====empEditPwAction.jsp=====");
	
	// 사번과 바꿀 비밀번호 호출
	int empNo = Integer.parseInt(request.getParameter("empNo"));
	String newEmpPw = request.getParameter("newEmpPw");
	String newEmpPw2 = request.getParameter("newEmpPw2");
	
	// 디버깅
	System.out.println("empNo : " + empNo);
	System.out.println("newEmpPw : " + newEmpPw);
	System.out.println("newEmpPw2 : " + newEmpPw2);
	
	// 바꿀비밀번호와 바꿀비밀번호 확인이 일치하는가 분기문
	if(newEmpPw.equals(newEmpPw2)){
		// 비밀번호 히스토리 조회 메서드
		// return : boolean (기존에 있던 비밀번호면 true, 기존에 없던 비밀번호면 false)
		boolean selectEmpPwHistory = EmpDAO.selectEmpPwHistory(empNo, newEmpPw);
		System.out.println("selectEmpPwHistory : " + selectEmpPwHistory);
		if(selectEmpPwHistory==true){
			System.out.println("사용했던 비밀번호");
			String msg = URLEncoder.encode("사용했던 비밀번호입니다. 다시 입력해주세요.", "UTF-8");
			response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?msg="+msg);
			return;
		}
		
		// 변경할 비밀번호를 히스토리에 insert
		// return : insert 성공시 1 
		int insertEmpPwHistory = EmpDAO.insertEmpPwHistory(empNo, newEmpPw);
		System.out.println("insertEmpPwHistory : " + insertEmpPwHistory);
		if(insertEmpPwHistory == 0){
			System.out.println("pwHistory 등록 실패");
			String msg = URLEncoder.encode("pwHistory 등록 실패. 다시 시도해주세요.", "UTF-8");
			response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?msg="+msg);
			return;
		}
		
		
		// 현재 관리자의 비밀번호 업데이트 메서드
		// return : update 성공시 1 
		int updateEmpPw = EmpDAO.updateEmpPw(empNo, newEmpPw);
		System.out.println("updateEmpPw : " + updateEmpPw);
		if(updateEmpPw == 1){
			System.out.println("비밀번호 업데이트 성공");
			String msg = URLEncoder.encode("비밀번호 변경 성공.", "UTF-8");
			response.sendRedirect("/BeeNb/emp/empOne.jsp?msg="+msg);
			return;
		}else{
			System.out.println("비밀번호 업데이트 실패");
			String msg = URLEncoder.encode("비밀번호 변경 실패. 다시 시도해 주세요.", "UTF-8");
			response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?msg="+msg);
			return;
		}
	}else{
		System.out.println("비밀번호 확인 불일치");
		String msg = URLEncoder.encode("비밀번호 확인 불일치. 다시 시도해 주세요.", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empEditPwForm.jsp?msg="+msg);
		return;
	}
	
%>