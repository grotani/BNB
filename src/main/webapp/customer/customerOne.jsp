<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%

	System.out.println("=====customerOne.jsp=====");
	
	String customerId = (String)(loginCustomer.get("customerId"));
	// 고객정보수정 성공 메세지 
	String succMsg = request.getParameter("succMsg");
	//디버깅
	System.out.println("고객ID :" + customerId);
	
	
	HashMap<String, String> customerOne = CustomerDAO.selectCustomerOne(customerId);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
	<h1>회원정보</h1>
	<%
		// 고객정보 수정 성공 메세지 
		if(succMsg != null) {
	%>
		<div class="alert alert-success" role="alert">
				<%= succMsg %>
		</div>
	<%		
		}
	%>
		<div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <ul class="list-group list-group-flush">						
							<li class="list-group-item">이름 : <%=(String)(customerOne.get("customerName")) %></li>
							<li class="list-group-item">아이디 : <%=(String)(customerOne.get("customerId")) %></li>
							<li class="list-group-item">이메일 : <%=(String)(customerOne.get("customerEmail")) %> </li>
							<li class="list-group-item">생년월일 : <%=(String)(customerOne.get("customerBirth")) %></li>
							<li class="list-group-item">성별 : <%=(String)(customerOne.get("customerGender")) %></li>
							<li class="list-group-item">휴대폰 번호 : <%=(String)(customerOne.get("customerPhone")) %></li>
							<li class="list-group-item">회원가입일 : <%=(String)(customerOne.get("createDate")) %></li>
							<li class="list-group-item">회원정보 수정일 : <%=(String)(customerOne.get("updateDate")) %></li>								
						</ul>
			</div>
		</div>
	</div>
	<div class="mt-3">
		<a href="/BeeNb/customer/customerCheckPwForm.jsp">정보수정</a>
		<a href="/BeeNb/customer/customerDropCheckPwForm.jsp">회원탈퇴</a>
	</div>
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>