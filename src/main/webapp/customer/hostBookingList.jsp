<%@page import="beeNb.dao.BookingListDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beeNb.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("========== hostBookingList.jsp ==========");
	
	// 고객 ID(호스트) 가져오기(session)
	String customerId = (String)loginCustomer.get("customerId");
	System.out.println("customerId : " + customerId);
	
	// roomName 요청값
	String roomName = "all";
	// roomName 요청 값이 있을 경우
	if(request.getParameter("roomName") != null) {
		roomName = request.getParameter("roomName");
	}
	
	System.out.println("roomName : " + roomName);
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// hostBookingList 페이지의 currentPage 세션 값 설정
		session.setAttribute("hostBookingListCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("hostBookingListCurrentPage") != null) {
		currentPage = (int)session.getAttribute("hostBookingListCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 hostBookingList 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("hostBookingListRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("hostBookingListRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("hostBookingListRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// (해당 호스트의)booking 테이블의 전체 행 개수
	int hostBookingListTotalRow = BookingDAO.selectHostBookingListCnt(customerId, roomName);
	// 디버깅
	System.out.println("hostBookingListTotalRow : " + hostBookingListTotalRow);
	
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - (해당 호스트의)booking 테이블 전체 행을 페이지당 보여줄 (해당 호스트의)booking 행의 개수로 나눈 값
	int lastPage = hostBookingListTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 (해당 호스트의)booking 행을 보여주기 위해 lastPage 에 + 1하기
	if(hostBookingListTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	
	// 해당 호스트의 호스팅한 숙소들의 예약 목록
	ArrayList<HashMap<String, Object>> hostBookingList = BookingDAO.selectHostBookingList(customerId, roomName, startRow, rowPerPage);
	// 디버깅
	System.out.println("hostBookingList : " + hostBookingList);
	
	
	// 호스트의 숙소 별로 예약을 보기위해 호스팅한 숙소 list 가져오기
	ArrayList<HashMap<String, Object>> hostRoomList = RoomDAO.selectHostRoomList(customerId);
	System.out.println("hostRoomList : " + hostRoomList);
%>
<%
	// msg 요청 값
	String msg = request.getParameter("msg");
	// err메시지 요청 값
	String errMsg = request.getParameter("errMsg");
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
		
		<h1>예약 관리</h1>
		<!-- msg 출력 -->
		<%
			if(msg != null) {
		%>
				<div class="alert alert-success" role="alert">
					<%= msg%>
				</div>
		<%
			}
		%>
		<!-- errMsg 출력 -->
		<%
			if(errMsg != null) {
		%>
				<div class="alert alert-success" role="alert">
					<%= errMsg%>
				</div>
		<%
			}
		%>
		<!-- 숙소 별 select -->
		<form action="/BeeNb/customer/hostBookingList.jsp" method="post">
			<div class="row">
				<div class="col-auto">
					<select class="form-select" name="rowPerPage" style="width: 100%;">
						<%
							for(int i = 10; i <= 50; i = i + 20) {
								if(rowPerPage == i) {
						%>
									<option value="<%=i%>" selected="selected"><%=i%>개씩</option>
						<%
								} else {
						%>
									<option value="<%=i%>"><%=i%>개씩</option>
						<%
								}
							}
						%>
					</select>
				</div>
				<div class="col-auto ps-0">
					<button class="btn btn-warning" type="submit">보기</button>
				</div>
			</div>
		</form>
		
		<!-- 예약 리스트 -->
		<table class="table">
			<thead>
				<tr>
					<th>예약 번호</th>
					<th>숙소</th>
					<th>고객 ID</th>
					<th>고객 이름</th>
					<th>예약 상태</th>
					<th>예약 인원</th>
					<th>입실일</th>
					<th>퇴실일</th>
					<th>예약일</th>
					<th>예약 상태 변경일</th>
					<th>예약 취소</th>
					<th>체크아웃</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(HashMap<String, Object> m : hostBookingList) {
				%>
						<tr>
							<td><%=m.get("bookingNo") %></td>
							<td><%=m.get("roomName") %></td>
							<td><%=m.get("customerId") %></td>
							<td><%=m.get("customerName") %></td>
							<td><%=m.get("bookingState") %></td>
							<td><%=m.get("usePeople") %></td>
							<td><%=BookingListDAO.selectStartDate((int)m.get("bookingNo"))%></td>
							<td><%=BookingListDAO.selectEndDate((int)m.get("bookingNo"))%></td>
							<td><%=m.get("createDate") %></td>
							<td><%=m.get("updateDate") %></td>
							<%
								if(m.get("bookingState").equals("전")) {
							%>
									<td>
										<a class="btn btn-warning" href="/BeeNb/customer/hostBookingDeleteAction.jsp?bookingNo=<%=m.get("bookingNo")%>">에약 취소</a>
									</td>
									
							<%
								} else {
							%>
									<td></td>
							<%
								}
							
								// 퇴실날짜가 오늘이거나 오늘 이전일 경우만 이용 완료 가능
								SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
							    Date today = new Date();
							    String todayStr = dateFormat.format(today);  
							    Date todayDate = dateFormat.parse(todayStr);
		
							    String endDateStr = BookingListDAO.selectEndDate((int)m.get("bookingNo"));
							    Date endDate = dateFormat.parse(endDateStr);

								if(!todayDate.before(endDate) && m.get("bookingState").equals("전")) {
							%>
									<td>
										<a class="btn btn-warning" href="/BeeNb/customer/hostBookingUpdateAction.jsp?bookingNo=<%=m.get("bookingNo")%>">이용 완료</a>
									</td>
							<%
								} else {
							%>
									<td></td>
							<%
								}
							%>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<!-- 페이징 버튼 -->	
		<div>
			<nav>
		        <ul class="pagination" style="display: flex; justify-content: center;">
					<%
						if(currentPage > 1) {
					%>	
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/customer/hostBookingList.jsp?roomName=<%=roomName%>&currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/customer/hostBookingList.jsp?roomName=<%=roomName%>&currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/customer/hostBookingList.jsp?roomName=<%=roomName%>&currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/customer/hostBookingList.jsp?roomName=<%=roomName%>&currentPage=1">이전페이지</a>
							</li>
					<%		
						}
						if(currentPage < lastPage) {
					%>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/customer/hostBookingList.jsp?roomName=<%=roomName%>&currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/customer/hostBookingList.jsp?roomName=<%=roomName%>&currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/customer/hostBookingList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/customer/hostBookingList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
							</li>
					<%
						}
					%>
				</ul>
		    </nav>
		</div>
		
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>