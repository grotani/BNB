<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("=====customerUpdateForm.jsp=====");
	//로그인 인증 
	String customerId = (String)(loginCustomer.get("customerId"));
	String customerName = (String)(loginCustomer.get("customerName"));
	String customerPw = request.getParameter("customerPw");
	String customerPhone = (String)(loginCustomer.get("customerPhone"));
	String customerEmail =(String)(loginCustomer.get("customerEmail"));
	
	
	// 에러메세지
	String errMsg = request.getParameter("errMsg");
	String usedPwMsg = request.getParameter("usedPwMsg");
	String msg = request.getParameter("msg");
	
	// 디버깅코드
	System.out.println("customerId :"+ customerId);
	System.out.println("customerName :"+ customerName);
	System.out.println("customerPw :"+ customerPw);
	System.out.println("customerPhone :"+ customerPhone);
	System.out.println("customerEmail :"+ customerEmail);
	
	
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
		<div class="card mx-auto" style="max-width: 600px;">
            <div class="card-body">
				<h1 class="card-title text-center">개인정보 수정</h1>
				<%
					// 비밀번호 변경시 기존 사용 비번으로 변경불가
					if(usedPwMsg != null) {
				%>
					<div class="alert alert-danger" role="alert">
						<%= usedPwMsg %>
					</div>
				<%	
					// 고객 정보변경 실패시 에러 메세지 
					}else if(errMsg != null){
				%>
					<div class="alert alert-danger" role="alert">
						<%= errMsg %>
					</div>
				<% 		
					// 변경 비밀번호 불일치시 에러 메세지
					} else if(msg != null){
				%>
					<div class="alert alert-danger" role="alert">
						<%= msg %>
					</div>
				<%
					}
				%>	
				<form method = "post" action = "/BeeNb/customer/customerUpdateAction.jsp">
					<div class="mb-3">
                        <label for="customerId" class="form-label">아이디: </label>
                        <input type="hidden" class="form-control" id="customerId" name="customerId" value="<%=customerId%>" required><%=customerId%>
                   	</div>
                   	<div class="mb-3">
                        <label for="customerEmail" class="form-label">이메일: </label>
                        <input type="email" class="form-control" id="customerEmail" name="customerEmail"  value="<%=customerEmail%>" required>
                   	</div>
                   	<div class="mb-3">
                        <label for="customerName" class="form-label">이름: </label>
                        <input type="hidden" class="form-control" id="customerName" name="customerName" value="<%=customerName%>" required><%=customerName%>
                   	</div>
                   	<div class="mb-3">
                        <input type="hidden" class="form-control" name="customerPw" value="<%=customerPw%>">
                   	</div>
                   	<div class="mb-3">
                        <label for="customerPhone" class="form-label">전화번호: </label>
                        <input type="text" class="form-control" id="customerPhone" name="customerPhone" value="<%=customerPhone%>" required>
                   	</div>
                   	<div class="mb-3">
                        <label for="newCustomerPw" class="form-label">새 비밀번호: </label>
                        <input type="password" class="form-control" id="newCustomerPw" name="newCustomerPw">
                   	</div>
                   	<div class="mb-3">
                        <label for="newCustomerPwCheck" class="form-label">새 비밀번호 확인: </label>
                        <input type="password" class="form-control" id="newCustomerPwCheck" name="newCustomerPwCheck">
                   	</div>
					<button type="submit" class="btn btn-warning w-100" >수정하기</button>
				</form>	
			</div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
	
</body>
</html>