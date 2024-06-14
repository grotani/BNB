<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerEditPwForm.jsp=====");
	String customerId = request.getParameter("customerId");
	String errMsg = request.getParameter("errMsg");
	String authMsg = request.getParameter("authMsg");
	
	// 디버깅 코드
	System.out.println("customerId :" + customerId);
	System.out.println("errMsg :" + errMsg);
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
				<h1 class="card-title text-center"> 비밀번호 변경 </h1>
				<%
					// 비밀번호 변경 실패 시 메세지
					if(errMsg != null) {
				%>
					 <div class="alert alert-danger" role="alert">
						<%= errMsg %>
					</div>
				<% 	
					// 본인인증 성공 메세지
					} else if (authMsg != null) {
				%>		
					<div class="alert alert-success" role="alert">
						<%= authMsg %>
					</div>
				<%	
					}
				%>
					<form method = "post" action = "/BeeNb/customer/customerEditPwAction.jsp">
						<div class="mb-3">
	                        <label for="customerId" class="form-label">아이디: </label>
	                        <input type="text" class="form-control" id="customerId" name="customerId" value="<%=customerId %>" required readonly="readonly">
                    	</div>
                    	<div class="mb-3">
	                        <label for="newCustomerPw" class="form-label">새 비밀번호: </label>
	                        <input type="password" class="form-control" id="newCustomerPw" name="newCustomerPw" required>
                    	</div>
                    	<div class="mb-3">
	                        <label for="newCustomerPwCheck" class="form-label">확인 비밀번호:  </label>
	                        <input type="password" class="form-control" id="newCustomerPwCheck" name="newCustomerPwCheck" required>
                    	</div>
						<button type="submit" class="btn btn-warning w-100">변경하기</button>
					</form>
				</div>
			</div>
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>