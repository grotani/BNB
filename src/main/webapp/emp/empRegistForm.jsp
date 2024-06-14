<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== empRegistForm.jsp ==========");
	// err메시지 요청 값
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 등록</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<style>
        .container {
            height: 100vh; /* 전체 화면 높이를 부모 컨테이너에 설정 */
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1;
            height: 65%; /* 높이를 65%로 설정 */
        }
    </style>	
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 관리자 등록 폼 -->
		<div class="main-content">
			<h1>관리자 등록</h1>
			<!-- err 메시지 출력 -->
			<%
				if(errMsg != null) {
			%>
					<div class="alert alert-danger" role="alert">
						<%= errMsg%>
					</div>
			<%
				}
			%>
			
			<!-- 뒤로 가기(/BeeNb/emp/customerList.jsp로 이동) -->
			<div style="display: grid; justify-content: end;">
				<a class="btn-close" href="/BeeNb/emp/empList.jsp"></a>
			</div>
			
			<!-- 관리자 정보 입력 폼 -->
		 	<div class="position-absolute top-50 start-50 translate-middle" style="width: 400px;">
				<form action="/BeeNb/emp/empRegistAction.jsp" method="post">
					<div>
						<label>이름</label>
						<input class="form-control" type="text" name="empName" required="required">
					</div>
					
					<div>
						<label>휴대전화</label>
						<input class="form-control" type="tel" name="empPhone" required="required" placeholder="예시) 010-1234-5678">
					</div>
					
					<div>
						<label>생년월일</label>
						<input class="form-control" type="date" name="empBirth" required="required" >
						<br>
					</div>
					
					<button class="btn btn-warning w-100" type="submit">등록하기</button>
				</form>
			</div>
			
		</div>
				
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>