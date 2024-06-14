<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 회원가입 실패시 오류 메시지
	String errMsg = request.getParameter("errMsg");

	// 아이디 중복확인 오류 메시지
	String errMsg2 = request.getParameter("errMsg2");
	
	// 전화번호 입력 오류 메시지
	String errMsgP = request.getParameter("errMsgP");
	if(errMsgP == null){
		errMsgP = "";
	}
	String customerId = request.getParameter("customerId");
	if(customerId == null){
		customerId = "";
	}
	String check = request.getParameter("check");
	if(check == null){
		check = "";
	}
	String msg = "";
	if(check.equals("T")){
		msg = "가입이 가능한 아이디입니다.";
	} else if(check.equals("F")){
		msg = "이미 존재하는 아이디입니다.";
	}
	
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
		<div class="card mx-auto mt-5" style="max-width: 600px;">
            <div class="card-body">
                <h1 class="card-title text-center">회원가입</h1>
                <!-- 아이디 회원가입 오류 메시지 -->
                 <% if (errMsg != null) { %>
                    <div class="alert alert-danger" role="alert"><%= errMsg %></div>
                <% } %>
                <!-- 아이디 중복확인 오류 메시지 -->
                <% if (errMsg2 != null) { %>
                    <div class="alert alert-danger" role="alert"><%= errMsg2 %></div>
                <% } %>
                <form method="post" action="/BeeNb/customer/customerCheckIdAction.jsp" class="mb-4">
                    <div class="form-group">
                        <!-- 중복 확인 메시지 -->
                        <%
                        	if(msg != null && !msg.equals("")) {
                        %>
                        		<div class="alert alert-warning" role="alert"><%= msg %></div>
                        <%
                        	}
                        %>
                        
                        <label for="customerId">아이디</label>
                        <div class="input-group">
                            <input type="text" id="customerId" name="customerId" class="form-control" required="required" value="<%= customerId %>">
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-warning">중복확인</button>
                            </div>
                        </div>
                    </div>
                </form>
                <!-- 회원가입 폼 -->
                <form method="post" action="/BeeNb/customer/customerSignUpAction.jsp">
                    <!-- 아이디 필드 -->
                    <div class="form-group">
                        <%
                            if(check.equals("T")) { // check가 T면 아이디를 readonly로 받기 
                        %>
                            <input type="text" name="customerId" value="<%= customerId %>" readonly="readonly" hidden="hidden">
                        <%
                            } else { // check가 F면 아이디가 입력되지 않게
                        %>
                            <input type="text" name="customerId" hidden="hidden">
                        <%
                            }
                        %>
                    </div>
                    <!-- 비밀번호 필드 -->
                    <div class="form-group">
                        <label for="customerPw">비밀번호</label>
                        <input type="password" id="customerPw" name="customerPw" class="form-control" required>
                    </div>
                    <!-- 이메일 필드 -->
                    <div class="form-group">
                        <label for="customerEmail">이메일</label>
                        <input type="email" id="customerEmail" name="customerEmail" class="form-control" required>
                    </div>
                    <!-- 이름 필드 -->
                    <div class="form-group">
                        <label for="customerName">이름</label>
                        <input type="text" id="customerName" name="customerName" class="form-control" required>
                    </div>
                    <!-- 생년월일 필드 -->
                    <div class="form-group">
                        <label for="customerBirth">생년월일</label>
                        <input type="date" id="customerBirth" name="customerBirth" class="form-control" required>
                    </div>
                    <!-- 전화번호 필드 -->
                    <div class="form-group">
                        <label for="customerPhone">전화번호</label>
                        <input type="tel" id="customerPhone" name="customerPhone" class="form-control" placeholder="010-1234-7890" required>
                        <!-- 전화번호 에러 메시지 -->
                        <%
                            if(errMsgP != null) {
                        %>
                            <div class="text-danger"><%= errMsgP %></div>
                        <%
                            }
                        %>
                    </div>
                    <!-- 성별 필드 -->
                    <div class="form-group">
                        <label>성별</label><br>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="genderF" name="customerGender" value="F" class="form-check-input">
                            <label for="genderF" class="form-check-label">여자</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input type="radio" id="genderM" name="customerGender" value="M" class="form-check-input">
                            <label for="genderM" class="form-check-label">남자</label>
                        </div>
                    </div>
                     <!-- 가입하기 버튼 -->
                    <button type="submit" class="btn btn-warning w-100">가입하기</button>
                </form>
            </div>
        </div>
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>