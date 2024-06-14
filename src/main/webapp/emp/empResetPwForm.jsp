<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/emp/inc/empSessionNotNull.jsp" %>
<%
	System.out.println("=====empResetPwForm.jsp=====");
	//디버깅 코드
	String errMsg = request.getParameter("errMsg");
	
	// form 태그 action 속성의 값
	String url = "/BeeNb/emp/empResetPwAction.jsp";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<title>관리자 비밀번호 초기화</title>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<script
	  src="https://code.jquery.com/jquery-3.7.1.min.js"
	  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
	  crossorigin="anonymous"></script>
	<script type="text/javascript">
		function resetConfirm(){
			// confirm(매개변수)
			// 매개변수 : 문자열
			// 반환타입 : boolean
			let cnfrm = confirm("초기화하시겠습니까?");
			if(cnfrm){
				$("#resetPwForm").submit();
			}
		}
	</script>
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		<div class="row mt-5" style="height: 65vh;">
			<div class="col"></div>
			<div class="col-6 position-relative">
				<div class="position-absolute top-50 start-50 translate-middle w-100">
					<div class="row">
						<h1>관리자 비밀번호 초기화</h1>
					</div>
					<%
						// 로그인 실패시 메세지
						if(errMsg != null) {
					%>
						 <div class="alert alert-danger" role="alert">
							<%= errMsg %>
						</div>
					<%	
						}
					%>
					<form action="<%=url %>" id="resetPwForm" method="post">
						<div class="row mt-3">
							<div class="col-3">
								<label for="empNo" class="form-label">사번</label>
							</div>
							<div class="col-6">
								<input type="text" class="w-100 form-control" name="empNo" id="empNo" required="required">
							</div>
							<div class="col">
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-3">
								<label for="empPhone" class="form-label">휴대폰 번호</label>
							</div>
							<div class="col-6">
								<input type="tel" class="w-100 form-control" name="empPhone" id="empPhone" required="required">
							</div>
							<div class="col">
								<button type="button" class="btn btn-outline-warning" onclick="resetConfirm()">초기화</button>									
							</div>
						</div>
						<div class="row mt-3">
							<div class="col">
								<div class="d-flex justify-content-center">
									<a class="text-decoration-none me-3" href="/BeeNb/emp/empLoginForm.jsp">뒤로가기</a>
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