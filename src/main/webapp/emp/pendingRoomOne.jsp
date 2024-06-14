<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("==========pendingRoomOne.jsp==========");

	// roomNo 요청 값
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	
	
	// 호스팅한 숙소의 상세정보
	HashMap<String, Object> empRoomOne = RoomDAO.selectHostRoomOne(roomNo);
	//디버깅
	System.out.println("empRoomOne : " + empRoomOne);
	
	
	// 호스팅한 숙소의 하루 가격 및 정보(가격, 예약 상태)리스트
	ArrayList<HashMap<String, Object>> oneDayPriceList = OneDayPriceDAO.selectOneDayPriceList(roomNo);
	// 디버깅
	System.out.println("oneDayPriceList : " + oneDayPriceList);
	
	int startRow = 1;
	int rowPerPage = 1;
	// 호스팅한 숙소의 리뷰 리스트
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.selectHostRoomReviewList(roomNo, startRow, rowPerPage);
	// 디버깅
	System.out.println("reviewList : " + reviewList);
	
	// 호스팅한 숙소의 이미지리스트
	ArrayList<String> roomImgList = RoomImgDAO.selectRoomImgList(roomNo);
	//디버깅
	System.out.println("roomImgList : " + roomImgList);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="/BeeNb/img/beeFavicon.ico">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 숙소 이름 -->
		<h1><%=empRoomOne.get("roomName") %></h1>
		
		<div style="display: flex; jusify-content: space-between;">
			<div class="w-50">
				<!-- 숙소 이미지 캐러셀 -->
				<div id="carouselExample" class="carousel slide">
				  <div class="carousel-inner">
		  				<%
							for(String roomImg : roomImgList) {
						%>
							    <div class="carousel-item active">
							      <img src="/BeeNb/upload/<%=roomImg %>" class="d-block w-100" alt="..." style="height: 365px;">
							    </div>
						<%
							}
						%>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
			</div>
			<div class="w-50">
				<!-- 숙소 상세정보 출력 -->
				<table class="table table-striped">
					<tr>
						<th>숙소 이름</th>
						<td><%=empRoomOne.get("roomName") %></td>
					</tr>
					<tr>
						<th>숙소 타입</th>
						<td><%=empRoomOne.get("roomCategory") %></td>
					</tr>
					<tr>
						<th>테마</th>
						<td><%=empRoomOne.get("roomTheme") %></td>
					</tr>
					<tr>
						<th>위치</th>
						<td><%=empRoomOne.get("roomAddress") %></td>
					</tr>
					<tr>
						<th>운용 기간</th>
						<td><%=empRoomOne.get("operationStart") %> ~ <%=empRoomOne.get("operationEnd") %></td>
					</tr>
					<tr>
						<th>최대 수용 인원</th>
						<td><%=empRoomOne.get("maxPeople") %></td>
					</tr>
					<tr>
						<th>승인 상태</th>
						<td><%=empRoomOne.get("approveState") %></td>
					</tr>
					<tr>
						<th>숙소 등록일</th>
						<td><%=empRoomOne.get("createDate") %></td>
					</tr>
					<tr>
						<th>숙소 수정일</th>
						<td><%=empRoomOne.get("updateDate") %></td>
					</tr>
				</table>
			</div>
		</div>
		
		<table class="table table-striped">
			<tr>
				<th>숙소 상세 내용</th>
			</tr>
			<tr>
				<td>
					<%=empRoomOne.get("roomContent") %>
				</td>
			</tr>
		</table>
		
		<hr>
		
		<div>
			<a href="/BeeNb/emp/approveRoomAction.jsp?roomNo=<%=roomNo %>&customerId=<%=empRoomOne.get("customerId") %>" class="btn btn-warning">승인</a>	
			<a href="/BeeNb/emp/rejectRoomAction.jsp?roomNo=<%=roomNo %>&customerId=<%=empRoomOne.get("customerId") %>" class="btn btn-warning">반려</a>
		</div>

		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>