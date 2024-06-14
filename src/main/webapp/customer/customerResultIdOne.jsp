<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>

<%
	System.out.println("=====customerResultIdOne.jsp=====");
	String result = request.getParameter("result");
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<style>
		 .link-container a {
	        text-decoration: none;
	        color: #ffc107; /* 텍스트 색상 */
	        font-size: 15px; /* 폰트 크기 */
        }
         .card {
            margin-top: 50px; /* 높이를 조정하여 중간으로 이동 */
            max-width: 600px;
        }
	</style>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>			
		<div class="card mx-auto" style="max-width: 600px;">
            <div class="card-body">
				<h1 class="card-title text-center">ID확인</h1>
					<div class="mb-3">
                        아이디 : <%=result %>
                    </div>
                    <div class="row mt-3">
						<div class="col">
		                    <div class="link-container">
								<a class="text-decoration-none" href="/BeeNb/customer/customerLoginForm.jsp">로그인하러가기</a>
								<a class="text-decoration-none" href="/BeeNb/customer/customerAuthForm.jsp">비밀번호변경</a>			
							</div>
						</div>
					</div>
			</div>
		</div>
			
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>		
</body>
</html>