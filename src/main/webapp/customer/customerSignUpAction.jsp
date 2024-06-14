<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.net.*" %>
<% System.out.println("=====customerSignUpAction.jsp====="); %>
<%	
	String customerId = request.getParameter("customerId");
	String customerPw = request.getParameter("customerPw");
	String customerEmail = request.getParameter("customerEmail");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerPhone = request.getParameter("customerPhone");
	String customerGender = request.getParameter("customerGender");
	
	
	 // 검증 로직 추가
    if (customerId == null || customerId.isEmpty()) {
    	String errMsg2 = URLEncoder.encode("아이디 중복확인 필요", "UTF-8");
        response.sendRedirect("/BeeNb/customer/customerSignUpForm.jsp?errMsg2="+errMsg2);
        return;
    }
	 
	// 디버깅코드
	System.out.println("customerId : " + customerId);
	System.out.println("customerPw : " + customerPw);
	System.out.println("customerEmail : " + customerEmail);
	System.out.println("customerName : " + customerName);
	System.out.println("customerBirth : " + customerBirth);
	System.out.println("customerPhone : " + customerPhone);
	System.out.println("customerGender : " + customerGender);
	
	// 전화번호 값 검증
    // 휴대전화 앞, 중간, 뒷 번호로 나눠서 각 변수에 담기
    String customerPhoneFirst = customerPhone.substring(0, customerPhone.indexOf("-"));
    String customerPhoneSecond = customerPhone.substring(customerPhone.indexOf("-") + 1, customerPhone.lastIndexOf("-"));
    String customerPhoneThird = customerPhone.substring(customerPhone.lastIndexOf("-") + 1);
   
   	// 디버깅
  	System.out.println("customerPhoneFirst : " + customerPhoneFirst);
    System.out.println("customerPhoneSecond : " + customerPhoneSecond);
    System.out.println("customerPhoneThird : " + customerPhoneThird);
   
    // 휴대폰 앞, 중간, 뒷 번호 자릿수 체크(앞 : 3, 중간 : 4, 뒤 : 4)
    if(customerPhoneFirst.length() != 3 || customerPhoneSecond.length() != 4 || customerPhoneThird.length() != 4) {
       String errMsgP = URLEncoder.encode("휴대폰 번호를 정확히 입력해주세요", "UTF-8");
       response.sendRedirect("/BeeNb/customer/customerSignUpForm.jsp?errMsgP=" + errMsgP);
       return;
    }
	
	// customer table에 정보 넣기
	int row = CustomerDAO.insertCustomer(customerId, customerPw, customerEmail, customerName, customerBirth, customerPhone,customerGender);
	// customer_pw_history에 비밀번호 넣기 
	int row2 = CustomerDAO.insertCustomerPwHistory(customerId, customerPw);
	
	if(row == 1 && row2 == 1){
		// 디버깅코드
		System.out.println("입력성공");
		String signMsg = URLEncoder.encode("회원가입성공입니다.","utf-8");
		response.sendRedirect("/BeeNb/customer/customerLoginForm.jsp?signMsg="+signMsg);
	}else{
		// 디버깅코드
		System.out.println("입력실패");
		String errMsg = URLEncoder.encode("회원가입실패입니다.","utf-8");
		response.sendRedirect("/BeeNb/customer/customerSignUpForm.jsp?errMsg="+errMsg);
	}
%>
%>