<%@page import="beeNb.dao.EmpDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== empRegistAction.jsp ==========");
	// 요청 값
	String empName = request.getParameter("empName");
	String empPhone = request.getParameter("empPhone");
	String empBirth = request.getParameter("empBirth").replace("-", "");
	
	// 디버깅
	System.out.println("empName : " + empName);
	System.out.println("empPhone : " + empPhone);
	System.out.println("empBirth : " + empBirth);

	// 전화번호 값 검증
	// 휴대전화 앞, 중간, 뒷 번호로 나눠서 각 변수에 담기
	String empPhoneFirst = empPhone.substring(0, empPhone.indexOf("-"));
	String empPhoneSecond = empPhone.substring(empPhone.indexOf("-") + 1, empPhone.lastIndexOf("-"));
	String empPhoneThird = empPhone.substring(empPhone.lastIndexOf("-") + 1);
	
	// 디버깅
	System.out.println("empPhoneFirst : " + empPhoneFirst);
	System.out.println("empPhoneSecond : " + empPhoneSecond);
	System.out.println("empPhoneThird : " + empPhoneThird);
	
	// 휴대폰 앞, 중간, 뒷 번호 자릿수 체크(앞 : 3, 중간 : 4, 뒤 : 4)
	if(empPhoneFirst.length() != 3 || empPhoneSecond.length() != 4 || empPhoneThird.length() != 4) {
		String errMsg = URLEncoder.encode("휴대폰 번호를 정확히 입력해주세요", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empRegistForm.jsp?errMsg=" + errMsg);
		return;
	}
	
	// emp 등록 메서드 실행
	// emp 등록 INSERT쿼리 실행시 결과 행 개수
	int empRow = EmpDAO.insertEmp(empName, empPhone, empBirth);
	
	// emp 등록 INSERT 실패인 경우
	if(empRow == 0) {
		String errMsg = URLEncoder.encode("관리자 정보를 다시 입력해주세요", "UTF-8");
		response.sendRedirect("/BeeNb/emp/empRegistForm.jsp?errMsg=" + errMsg);
		return;
	}
	
	// emp 등록 시 emp_pw_history에 pw(empBirth) INSERT하기
	// 위의 요청값인 empName, empPhone, empBirth로 가장 최근에 생성된 emp의 empNo값
	int empNo = EmpDAO.selectRecentRegistEmp(empName, empPhone, empBirth);
	// 디버깅
	System.out.println("empNo : " + empNo);
	
	// emp_pw_history에 pw(empBirth)값 INSERT하기
	int epwHistoryRow = EmpDAO.insertEmpPwHistory(empNo, empBirth);
	// 디버깅
	System.out.println("epwHistoryRow : " + epwHistoryRow);
	
	// emp 등록 성공 시 empList.jsp로 redirect
	String msg = URLEncoder.encode("관리자가 등록되었습니다", "UTF-8");
	response.sendRedirect("/BeeNb/emp/empList.jsp?msg=" + msg);
%>