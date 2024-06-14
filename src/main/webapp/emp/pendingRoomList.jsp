<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====pendingRoomList.jsp=====");

	// 메시지 호출
	String msg = request.getParameter("msg");
	
	// 미승인 숙소 리스트 메서드(미승인이란 : 미승인+재승인)
	ArrayList<HashMap<String, Object>> selectPendingRoomList = RoomDAO.selectPendingRoomList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>숙소심사</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="/BeeNb/img/beeFavicon.ico">
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
		
		<!-- 메인작업 -->
		<div class="main-content">
			<h1>숙소심사</h1>
			<%
				if(msg != null){
			%>
					<%=msg %>
			<%
				}
			%>
			<table class="table">
				<tr>
					<th>숙소번호</th>
					<th>호스트ID</th>
					<th>숙소이름</th>
					<th>현재상태</th>
					<th>상세보기</th>
				</tr>
				
					<%
						for (HashMap<String, Object> m : selectPendingRoomList) {
					%>
							<tr>
								<td><%=(Integer) (m.get("roomNo"))%></td>
								<td><%=(String) (m.get("customerId"))%></td>
								<td><%=(String) (m.get("roomName"))%></td>
								<td><%=(String) (m.get("approveState"))%></td>
								<td><a href="/BeeNb/emp/pendingRoomOne.jsp?roomNo=<%=(Integer) (m.get("roomNo"))%>" class="btn btn-warning">상세보기</a></td>
								
							</tr>
					<%
						}
					%>
			</table>
		</div>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
</body>
</html>