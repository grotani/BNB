<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.util.*" %>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("=====customerBookingList.jsp=====");
	String customerId = (String)(loginCustomer.get("customerId"));
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// customerBookingList 페이지의 currentPage 세션 값 설정
		session.setAttribute("customerBookingCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("customerBookingCurrentPage") != null) {
		currentPage = (int)session.getAttribute("customerBookingCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	// 페이지당 보여줄 customerBookingList 행의 개수
	// 기본 10개로 설정
	int rowPerPage = 10;

	//customerBookingList 전체 행의 개수
	int totalRow = BookingDAO.selectAfterBookingListCnt(customerId);
	// 디버깅
	System.out.println("totalRow : " + totalRow);
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - emp 테이블 전체 행을 페이지당 보여줄 emp 행의 개수로 나눈 값
	int lastPage = totalRow / rowPerPage;
	// 나머지가 생길 경우 남은 emp 행을 보여주기 위해 lastPage 에 +1하기
	if(totalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// 이용 전 리스트
	ArrayList<HashMap<String,Object>> beforeList = BookingDAO.selectBeforeList(customerId);
	// 이용 후 리스트 
	ArrayList<HashMap<String,Object>> afterList = BookingDAO.selectAfterList(customerId, startRow, rowPerPage);
	
	// 예약 취소 성공 메세지 
	String succMsg = request.getParameter("succMsg");
	//디버깅
	System.out.println("succMsg: "+ succMsg);
	// 예약 취소 실패 메세지
	String errMsg = request.getParameter("errMsg");
	// 디버깅
	System.out.println("errMsg : " + errMsg);
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<style>
        /* 버튼 스타일 */
        .btn {
            display: inline-block;
            padding: 3px 10px;
            border: none;
            border-radius: 3px;
            background-color: #ffc107; /* 노란색 */
            color: #000;
            text-align: center;
            text-decoration: none;
            font-size: 13px;
            cursor: pointer;
        }

       
    </style>
</head>
<body>
	<div class="container">
	<!-- 고객 네비게이션 바 -->
	<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<h1>이용 전 예약리스트</h1>
		<%
			// 예약 취소 성공시 메세지
			if(succMsg != null) {
		%>
			 <div class="alert alert-success" role="alert">
				<%= succMsg %>
			 </div>
		<%
			} else if(errMsg != null){
		%>		
			 <div class="alert alert-danger" role="alert">
				<%= errMsg %>
			 </div>
		<%		
			}
		%>
		<!-- 이용 전 예약 리스트 출력 -->
		<table class="table table-striped">
			<tr>
				<th>예약번호</th>
				<th>아이디</th>
				<th>숙소이름</th>
				<th>주소</th>
				<th>예약상태</th>
				<th>결제일자</th>
				<th>입실날짜</th>
				<th>퇴실날짜</th>
				<th>예약취소</th>
			</tr>
			<%
				for(HashMap<String,Object> m : beforeList){
			%>
				<tr>
					<td><%=(Integer)(m.get("bookingNo"))%></td>
					<td><%=(String)(m.get("customerId"))%></td>
					<td><%=(String)(m.get("roomName"))%></td>
					<td><%=(String)(m.get("roomAddress"))%></td>
					<td><%=(String)(m.get("bookingState"))%></td>
					<td><%=(String)(m.get("createDate"))%></td>
					<td><%=(String)(m.get("startRoomDate"))%></td>
					<td><%=(String)(m.get("endRoomDate"))%></td>
					<td>
						<a href = "/BeeNb/customer/customerCancelBookingAction.jsp?bookingNo=<%=m.get("bookingNo") %>" onclick="return confirm('예약을 취소하시겠습니까?')" class="btn">
							예약취소
						</a>
					</td>
				</tr>
			<%
				}				
			%>
		</table>
		<h1>이용 후 예약리스트</h1>
		<!-- 이용 후 예약 리스트 출력 -->
		<form>
			<table class="table table-striped">
				<tr>
					<th>예약번호</th>
					<th>아이디</th>
					<th>숙소이름</th>
					<th>주소</th>
					<th>예약상태</th>
					<th>결제일자</th>
					<th>입실날짜</th>
					<th>퇴실날짜</th>
					<th>리뷰</th>
					<th>신고</th>
				</tr>
				<%
					for(HashMap<String,Object> m : afterList){
				%>
						<tr>
							<td><%=(Integer)(m.get("bookingNo"))%></td>
							<td><%=(String)(m.get("customerId"))%></td>
							<td><%=(String)(m.get("roomName"))%></td>
							<td><%=(String)(m.get("roomAddress"))%></td>
							<td><%=(String)(m.get("bookingState"))%></td>
							<td><%=(String)(m.get("createDate"))%></td>
							<td><%=(String)(m.get("startRoomDate"))%></td>
							<td><%=(String)(m.get("endRoomDate"))%></td>
						  	<td>
	                           <%
	                               if(((String)m.get("bookingState")).equals("리뷰완료")) {
	                           %>
	                               		<button class="btn btn-disabled" disabled>리뷰 완료</button>
	                           <%
	                               } else {
	                           %>
	                               		<a href="/BeeNb/customer/customerAddReviewForm.jsp?bookingNo=<%=m.get("bookingNo") %>" class="btn">리뷰 쓰기</a>
	                           <%
	                               }
	                           %>
	                       </td>
							<td>
								<%
									// 신고내역 상태 확인 신고는 1건만 등록 가능함
									HashMap<String,Object> map = ComplainDAO.selectcomplainStateOne(customerId, Integer.parseInt(""+m.get("bookingNo")));
											System.out.println("map : " + map);
											if(map.get("complainState") != null){
												if(((String)map.get("complainState")).equals("접수")){
								%>				
													<button class="btn btn-disabled" disabled>접수</button>
													<%				
														} else if(((String)map.get("complainState")).equals("처리중")){
													%>			
															<button class="btn btn-disabled" disabled>처리중</button>
													<%
														} else if(((String)map.get("complainState")).equals("처리완료")) {
													%>				
															<button class="btn btn-disabled" disabled>처리완료</button>
													<%
														}
											} else{
												%>
													<a href = "/BeeNb/customer/customerComplainBookingForm.jsp?bookingNo=<%=m.get("bookingNo")%>" class="btn">신고하기</a>
												<% 
											}
												%>																								
							</td>
						</tr>
				<%
					}				
				%>
			</table>
			<!-- 페이징 버튼 -->
			<div>
				<nav>
					<ul class = "pagination">
						<%
							if(currentPage > 1){
						%>		
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=1">처음페이지</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%
							}else {
						%>		
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=1">처음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%
							}
							if(currentPage < lastPage){
						%>
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?lastPage=<%=lastPage%>">마지막페이지</a>
								</li>
						<%		
							}else{
						%>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?currentPage=<%=currentPage+1%>">다음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/customerBookingList.jsp?lastPage=<%=lastPage%>">마지막페이지</a>
								</li>
						<%		
							}
						%>
					</ul>
				</nav>
			</div>
		</form>
		
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>