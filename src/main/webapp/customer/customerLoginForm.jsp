<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionNotNull.jsp" %>
<%
	
	System.out.println("=====customerLoginForm.jsp=====");

	
	String errMsg = request.getParameter("errMsg");
	String logoutMsg = request.getParameter("logoutMsg");
	String signMsg = request.getParameter("signMsg");
	String editMsg = request.getParameter("editMsg");
	// 디버깅  
	System.out.println("에러 메세지 : "+ errMsg);
	System.out.println("로그아웃 메세지 : "+ logoutMsg);
	System.out.println("회원가입 메시지 : "+ signMsg);
	System.out.println("회원정보 수정 메세지 : "+ editMsg);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	 <style>
          .link-container {
            display: flex;
            justify-content: center;
            gap: 20px; /* 링크들 사이의 간격 조정 */
            margin-top: 10px;
        }
        .link-container a {
            text-decoration: none;
            color: #ffc107; /* 텍스트 색상 */
            font-size: 15px; /* 폰트 크기 */
        }
        .link-container a:hover {
            color: #e0a800; /* 호버 시 더 진한 노란색 */
        }
    </style>
	
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<div class="row mt-5" style="height: 65vh;">
			<div class="col"></div>
			<div class="col-6 position-relative">
				<div class="position-absolute top-50 start-50 translate-middle w-100">
					<div class="row">
						<h1> 로그인 </h1>
						</div>
						<%
							// 로그인 실패시 메세지
							if(errMsg != null) {
						%>
							 <div class="alert alert-danger" role="alert">
								<%= errMsg %>
							</div>
						<% 	
							// 로그아웃 메세지 
							} else if (logoutMsg != null) {
						%>		
							<div class="alert alert-success" role="alert">
								<%= logoutMsg %>
							</div>
						<%	
							// 회원가입 메세지
							} else if (signMsg != null) {
						%>
							<div class="alert alert-success" role="alert">
								<%= signMsg %>
							</div>
						<%		
							// 비밀번호 변경 성공시 메세지
							} else if (editMsg != null) {
						%>
							<div class="alert alert-success" role="alert">
								<%= editMsg %>
							</div>
						<%		
							} else{
						%>	
							
						<%
							}
						%>	
			
					<form action="/BeeNb/customer/customerLoginAction.jsp" method="post">
						<div class="row mt-3">
							<div class="col-3">
								<label for="customerId" class="form-label">ID:</label>
							</div>
							<div class="col-6">
								<input type="text" name="customerId" class="w-100 form-control" name="customerId" id="customerId" required="required">
							</div>
							<div class="col">
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-3">
								<label for="customerPw" class="form-label">PW:</label>
							</div>
							<div class="col-6">
								<input type="password" class="w-100 form-control" name="customerPw" id="customerPw" required="required">
							</div>
							<div class="col">
									<button type="submit" class="btn btn-outline-warning">로그인</button>									
								</div>
							</div>
						<div class="row mt-3">
							<div class="col">
								<div class="link-container">									
									<a class="text-decoration-none" href="/BeeNb/emp/empLoginForm.jsp">관리자 로그인</a>
									<a class="text-decoration-none" href="/BeeNb/customer/customerSignUpForm.jsp">회원가입</a>
									<a class="text-decoration-none" href="/BeeNb/customer/customerFindIdForm.jsp">ID찾기</a>
									<a class="text-decoration-none" href="/BeeNb/customer/customerAuthForm.jsp">비밀번호 재설정</a>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col"></div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>				
	</div>
</body>
</html>