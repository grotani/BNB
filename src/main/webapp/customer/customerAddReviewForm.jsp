<%@page import="beeNb.dao.ThemeDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<% 
	System.out.println("=====.jsp=====");	
	String actionUrl = "/BeeNb/customer/customerAddReviewAction.jsp";
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
				<h1>리뷰 등록하기</h1>
			</div>
			<form action="<%=actionUrl %>" method="post" enctype="multipart/form-data">

				
				
				<div class="row mt-3">
					<div class="col">
						<label for="rating">별점</label>
					</div>
 					<div class="col-10">
						<select name="rating" id="rating">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
					</div>
				</div>
		
				<div class="row mt-3">
					<div class="col">
						<label for="reviewContent">리뷰 설명</label>
					</div>			
					<div class="col-10">
						<textarea name="reviewContent" id="reviewContent" rows="10" cols="50" required="required"></textarea>
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