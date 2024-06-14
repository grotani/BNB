<%@page import="beeNb.dao.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("========== hostRoomList.jsp ==========");
	// 세션에서 customerId 가져오기
	String customerId = (String)(loginCustomer.get("customerId"));
	// 디버깅
	System.out.println("customerId : " + customerId);
	
	// 해당 호스트(로그인 되어있는 회원)의 호스팅한 숙소 목록 리스트
	ArrayList<HashMap<String, Object>> hostRoomList = RoomDAO.selectHostRoomList(customerId);
	// 디버깅
	System.out.println("hostRoomList : " + hostRoomList);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<style>
		.room-image {
			width: 100%; /* 너비를 카드에 맞춤 */
			height: 200px; /* 높이 설정 */
			object-fit: cover; /* 이미지 비율을 유지하면서 빈 공간 없이 채움 */
		}
	</style>
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		
		<h1>나의 숙소 목록</h1>
		
		<!-- 호스팅한 숙소 목록 출력 -->
		<div class="row row-cols-1 row-cols-md-3 g-4">
		<%
			for (HashMap<String, Object> m : hostRoomList) {
		%>
				<div class="col">
					<div class="card">
						<img src="/BeeNb/upload/<%=(String)(m.get("roomImg"))%>" class="card-img-top room-image" alt="...">
						<div class="card-body">
							<h5 class="card-title"><%=(String) (m.get("roomName"))%></h5>
							<p class="card-text">
								<b>숙소 타입 : </b><%=(String) (m.get("roomCategory"))%>
								<br>
								<b>위치 : </b><%=(String) (m.get("roomAddress"))%>
								<br>
								<b>승인 상태 : </b><%=(String) (m.get("approveState"))%>
								<br>
								<b>운용기간 : </b><%=m.get("operationStart") %> ~ <%=m.get("operationEnd") %> 
								<br><a class="btn btn-warning" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=m.get("roomNo")%>">상세 보기</a>
							</p>
						</div>
					</div>
				</div>
		<%		
			}
		%>
		</div>
		
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>