<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("=====customerFindIdForm.jsp=====");
	
	// ID찾기 실패시 에러메세지 
	String errMsg = request.getParameter("errMsg");
	// 디버깅
	System.out.println("에러메세지 :" + errMsg);
	
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
				<h1 class="card-title text-center">ID찾기</h1>
				<%
					if(errMsg != null) {
				%>
					<div class="alert alert-danger" role="alert">
						<%= errMsg %>
					</div>	
				<%	
					}
				%>
				<form action="/BeeNb/customer/customerFindIdAction.jsp" method="post">
					<div class="mb-3">
						<label for="customerName" class="form-label">이름: </label>
                        <input type="text" class="form-control" id="customerName" name="customerName" required>
                    </div>
                    <div class="mb-3">
						<label for="customerEmail" class="form-label">이메일: </label>
                        <input type="text" class="form-control" id="customerEmail" name="customerEmail" required>
                    </div>
					<button type="submit" class="btn btn-warning w-100">ID찾기</button>
				</form>
			</div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
	
</body>
</html>