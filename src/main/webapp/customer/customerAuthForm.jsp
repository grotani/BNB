<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerAuthForm.jsp=====");
	// 본인인증 오류 메시지
	String errMsg = request.getParameter("errMsg");
	System.out.println("errMsg : "+ errMsg);
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
                <h1 class="card-title text-center">본인인증</h1>
                <% if (errMsg != null) { %>
                    <div class="alert alert-danger" role="alert"><%= errMsg %></div>
                <% } %>
                <form method="post" action="/BeeNb/customer/customerAuthAction.jsp">
                    <div class="mb-3">
                        <label for="customerId" class="form-label">아이디:</label>
                        <input type="text" class="form-control" id="customerId" name="customerId" required>
                    </div>
                    <div class="mb-3">
                        <label for="customerName" class="form-label">이름:</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" required>
                    </div>
                    <div class="mb-3">
                        <label for="customerPhone" class="form-label">전화번호:</label>
                        <input type="text" class="form-control" id="customerPhone" name="customerPhone" placeholder="010-0000-0000" required>
                    </div>
                    <button type="submit" class="btn btn-warning w-100">확인하기</button>
                </form>
            </div>
        </div>
			<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>