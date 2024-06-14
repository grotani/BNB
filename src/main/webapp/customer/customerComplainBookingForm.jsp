<%@page import="beeNb.dao.ThemeDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<% 
	System.out.println("=====.jsp=====");	
	String actionUrl = "/BeeNb/customer/customerComplainBookingAction.jsp";
	String cancelUrl = "/BeeNb/customer/customerBookingList.jsp";
	
	int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
	System.out.println("bookingNo : " + bookingNo);
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<title>BeeBb</title>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<div class="row mt-5">
		<div class="col"></div>
		<div class="col-8">
			<div class="row mt-3">
				<h1>민원 등록하기</h1>
			</div>
			<form action="<%=actionUrl %>" method="post" enctype="multipart/form-data">

				
				
				<div class="row mt-3">
					<div class="col">
						<label for="complainType">숙소 카테고리</label>
					</div>
 					<div class="col-10">
						<select name="complainType" id="complainType">
							<option value="불친절">불친절</option>
							<option value="비위생적">비위생적</option>
							<option value="옵션 미일치">옵션 미일치</option>
						</select>
					</div>
				</div>
		
				<div class="row mt-3">
					<div class="col">
						<label for="complainContent">숙소 설명</label>
					</div>			
					<div class="col-10">
						<textarea name="complainContent" id="complainContent" rows="10" cols="50" required="required"></textarea>
					</div>
				</div>
				
				
			
				
				
				<div class="row mt-3">
					<div class="col">
						<input type="hidden" name="bookingNo" value="<%=bookingNo %>">
						<button type="submit">등록</button>
						<a href="<%=cancelUrl%>" class="text-decoration-none">취소</a>
					</div>
				</div>

			</form>
		</div>
		<div class="col"></div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>>