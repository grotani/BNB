<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("=====customerCheckPwForm.jsp=====");
	// 로그인 인증 
	String customerId = (String)(loginCustomer.get("customerId"));
	//디버깅
	System.out.println("고객ID :" + customerId);
	
	String errMsg = request.getParameter("errMsg");
		

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
				<h1 class="card-title text-center">정보수정시 비밀번호 확인</h1>
				<%
					if(errMsg != null){
				%>
					<div class="alert alert-danger" role="alert">
						<%=errMsg%>
					</div>	
				<%	
					}
				%>
				<form method="post" action="/BeeNb/customer/customerCheckPwAction.jsp">
                    <div class="mb-3">
                        <label for="customerPw" class="form-label">비밀번호를 입력하세요</label>
                        <input type="password" class="form-control" id="customerPw" name="customerPw" required>
                    </div>
					<button type="submit" class="btn btn-warning w-100">확인하기</button>
				</form>
			</div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>	
</body>
</html>