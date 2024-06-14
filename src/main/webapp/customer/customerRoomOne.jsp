<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
	System.out.println("loginCustomer : " + loginCustomer);
%>
<%
	System.out.println("==========customerRoomOne.jsp==========");

	// roomNo 요청 값
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	// 디버깅
	System.out.println("roomNo : " + roomNo);
	
	// currentPage 요청 값(리뷰 페이징을 위해)
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(리뷰 페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// customerRoomOne의 리뷰부분 currentPage 세션 값 설정
		session.setAttribute("customerRoomOneCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("customerRoomOneCurrentPage") != null) {
		currentPage = (int)session.getAttribute("customerRoomOneCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 review 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("customerRoomOneReviewRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("customerRoomOneReviewRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("customerRoomOneReviewRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// review 테이블의 전체 행 개수
	int customerRoomOneReviewTotalRow = ReviewDAO.selectHostRoomReviewListCnt(roomNo);
	// 디버깅
	System.out.println("customerRoomOneReviewTotalRow : " + customerRoomOneReviewTotalRow);
	
	
	// 리뷰 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - review 테이블 전체 행을 페이지당 보여줄 review 행의 개수로 나눈 값
	int lastPage = customerRoomOneReviewTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 review 행을 보여주기 위해 lastPage 에 + 1하기
	if(customerRoomOneReviewTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// 이미지 목록 정보
	ArrayList<String> roomImgList = RoomImgDAO.selectRoomImgList(roomNo);
	// 호스팅한 숙소의 상세정보
	HashMap<String, Object> customerRoomOne = RoomDAO.selectHostRoomOne(roomNo);
	//디버깅
	System.out.println("customerRoomOne : " + customerRoomOne);
	
	
	// 호스팅한 숙소의 하루 가격 및 정보(가격, 예약 상태)리스트
	ArrayList<HashMap<String, Object>> oneDayPriceList = OneDayPriceDAO.selectOneDayPriceList(roomNo);
	// 디버깅
	System.out.println("oneDayPriceList : " + oneDayPriceList);
	
	
	// 호스팅한 숙소의 리뷰 리스트
	ArrayList<HashMap<String, Object>> reviewList = ReviewDAO.selectHostRoomReviewList(roomNo, startRow, rowPerPage);
	// 디버깅
	System.out.println("reviewList : " + reviewList);
%>
<%
	// 달력 구현
	// 페이지의 달력 년도와 월 요청값
	String targetYear = request.getParameter("targetYear");
	String targetMonth = request.getParameter("targetMonth");
	// 디버깅
	System.out.println("targetYear : " + targetYear);
	System.out.println("targetMonth : " + targetMonth);
	
	// 캘린더 객체 생성
	Calendar target = Calendar.getInstance();
	
	// 년도, 월의 요청값이 있을 경우 Calendar객체의 Year, Month를 요청값으로 변경
	if(targetYear != null && targetMonth != null) {
		target.set(Calendar.YEAR, Integer.parseInt(targetYear));
		target.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	
	// 달력 1일 시작 전 공백 개수 구하기 -> 1일의 요일이 필요 -> target의 날짜를 1일로 변경
	target.set(Calendar.DATE, 1);
	int firstDayNum = target.get(Calendar.DAY_OF_WEEK);	//1일의 요일 (일 : 1 / 월 : 2 / ... / 토 : 7)
	// 디버깅
	System.out.println("firstDayNum : " + firstDayNum);
	
	
	// 페이지에 출력할 달력 년 월 변수
	int calendarYear = target.get(Calendar.YEAR);
	int calendarMonth = target.get(Calendar.MONTH);
	// 디버깅
	System.out.println("calendarYear : " + calendarYear);
	System.out.println("calendarMonth : " + calendarMonth);
	
	int firstDayBeforeBlank = firstDayNum - 1;	// 1일 시작 전 공백 개수 Ex) 1일이 일요일 -> 0개 / 1일이 월요일 -> 1개 / .... / 1일이 토요일 -> 6개
	int lastDay = target.getActualMaximum(Calendar.DATE);	// target달의 마지막 날짜 반환
	// 디버깅
	System.out.println("firstDayBeforeBlank : " + firstDayBeforeBlank);
	System.out.println("lastDay : " + lastDay);
	
	// 달력 칸의 개수
	int calendarTotalDiv = 42;	
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
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<div class="row mt-5">
			<div class="col"></div>
			<div class="col-10">
				<div class="row mt-5">
					<div class="col">
											
						<!-- 숙소 이미지 -->
<%-- 						<div>
							<img alt="..." src="/BeeNb/upload/<%=customerRoomOne.get("roomImg") %>"  width="100%">
						</div> --%>
						<div id="carouselExample" class="carousel slide">
						  <div class="carousel-inner">
							<% 
								if(!roomImgList.isEmpty()){ 
									int index=0;
									for(String s : roomImgList){		
							%>						  	
									    <div class="carousel-item <%=(index == 0) ? "active" : "" %> ">
									      	<img src="/BeeNb/upload/<%=s %>" class="d-block" style="height: 300px;" alt="...">
									    </div>
							<% 		
										index = index + 1;
									}
									
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
						<hr>
						<h1><%=customerRoomOne.get("roomName") %></h1>	
						<!-- 숙소 상세정보 출력 -->
						<div>
						<!-- 나머지 상세정보 -->
						<div>
							<div>
								<b>숙소 이름</b>
								<%=customerRoomOne.get("roomName") %>
							</div>
							
							<div>
								<b>숙소 타입</b>
								<%=customerRoomOne.get("roomCategory") %>
							</div>
							
							<div>
								<b>테마</b>
								<%=customerRoomOne.get("roomTheme") %>
							</div>
							
							<div>
								<b>위치</b>
								<%=customerRoomOne.get("roomAddress") %>
							</div>
							
							<div>
								<b>운용 기간</b>
								<%=customerRoomOne.get("operationStart") %> ~ <%=customerRoomOne.get("operationEnd") %>
							</div>
							
							<div>
								<b>최대 수용 인원</b>
								<%=customerRoomOne.get("maxPeople") %>
							</div>
							
							<div>
								<b>설명</b>
								<%=customerRoomOne.get("roomContent") %>
							</div>
							
<%-- 							<div>
								<b>승인 상태</b>
								<%=customerRoomOne.get("approveState") %>
							</div>
							
							<div>
								<b>숙소 등록일</b>
								<%=customerRoomOne.get("createDate") %>
							</div>
							
							<div>
								<b>숙소 수정일</b>
								<%=customerRoomOne.get("updateDate") %>
							</div> --%>
						</div>
					</div>
					</div>
					<div class="col-3 small">
						<!-- 숙소 예약일 표시 및 가격 등록 버튼-->
						<div>
							
							<div class="row">
								<div class="col">
									<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo %>&targetYear=<%=calendarYear%>&targetMonth=<%=calendarMonth - 1%>">
										이전 달
									</a>
								</div>
								
								<div class="col">
									<%=calendarYear%>년 <%=calendarMonth + 1%>월
								</div>
								
								<div class="col">
									<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo %>&targetYear=<%=calendarYear%>&targetMonth=<%=calendarMonth + 1%>">
										다음 달
									</a>
								</div>
							</div>
						</div>
						<!-- 달력 -->
						<form action="/BeeNb/customer/roomBookingAction.jsp" method="post">
							<div>
								<!-- 요일 -->
								<table class="table">
									<thead>
										<tr>
											<th>일</th>
											<th>월</th>
											<th>화</th>
											<th>수</th>
											<th>목</th>
											<th>금</th>
											<th>토</th>
										</tr>
									</thead>
									<tbody>
										<tr>
										<%
											for(int i = 1; i <= calendarTotalDiv; i ++) {
												// 공백 숫자를 뺀 실제 달력에 표시되야하는 날짜
												int realDay = i - firstDayBeforeBlank;
										%>
												<td>
										<%
												// realDay가 실제 달력의 날짜 안에 있어야만 달력에 출력
												if((realDay >= 1) && (i -firstDayBeforeBlank <= lastDay)) {
										%>
													<%=realDay %>
										<%
													// 리스트의 요소들 중 요금이 책정된 날짜가 있다면 페이지에 출력
													for(HashMap<String, Object> m : oneDayPriceList) {
														int oneDayPriceYear = Integer.parseInt((((String)(m.get("roomDate"))).substring(0, 4)));
														int oneDayPriceMonth = Integer.parseInt((((String)(m.get("roomDate"))).substring(5, 7)));
														int oneDayPriceDay = Integer.parseInt((((String)(m.get("roomDate"))).substring(8, 10)));
														if(calendarYear == oneDayPriceYear && (calendarMonth + 1) == oneDayPriceMonth && (realDay) == oneDayPriceDay) {
										%>
															<%-- <br>예약 상태 : <b><%=m.get("roomState")%></b>
															<br>등록 가격 : <b><%=String.format("%,d", Integer.parseInt((String)m.get("roomPrice")))%>원</b> --%>
										<%
															if(((String)m.get("roomState")).equals("예약 가능")) {
										%>
															<br><input type="checkbox" name="roomDate" value="<%=m.get("roomDate") %>">
										<%
															}
														}
													}
										%>
												</td>
										<%
												}
												// 한줄에 칸이 7개가 되면 행을 닫기
												if(i % 7 == 0) {
										%>
													</tr>
										<%
												}
											}
										%>
									</tbody>
								</table>
							</div>
							<%if(loginCustomer != null){ %>
							<div>
								인원&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;
								<input type="number" class="form-control w-75" style="display: inline-block;" id="usePeople" name="usePeople"><br>
								<input type="hidden" id="roomNo" name="roomNo" value="<%=customerRoomOne.get("roomNo") %>">
							</div>
								<div class="mt-3 d-flex flex-row-reverse">
									<input type="submit" class=" btn btn-outline-warning btn-width-beenb mx-2" value="예약하기">
								</div>
							<% } %>
						</form>
					</div>
				</div>
			</div>
			<div class="col"></div>		
		</div>
		
		
		
		

		<!-- 숙소 리뷰 -->
		<div>
			<hr>
			<h2 style="display: inline-block;">리뷰</h2>
			<%
				for(HashMap<String, Object> m : reviewList) {
			%>
					<div>
						<div>
							<%=m.get("customerId") %>
						</div>
						<div>
							<%
								for(int i = 1; i <= (int)(m.get("rating")); i++) {
							%>
									&#127775;
							<%
								}
							%>
						</div>
						<div>
							<%=((String)(m.get("createDate"))).substring(0, 11)%>
						</div>
						<div><%=m.get("reviewContent") %></div>
					</div>	
					<hr>
			<%
				}
			%>
				
			<!-- 숙소 리뷰 페이징 -->	
			<div>
							<nav>
		        	<ul class="pagination" style="display: flex; justify-content: center;">
		        	
				<%
					if(currentPage > 1) {
				%>	
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1" class="mx-1">처음페이지</a>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage-1%>"  class="mx-1">이전페이지</a>
				<%		
					} else {
				%>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1" class="mx-1">처음페이지</a>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1" class="mx-1">이전페이지</a>
				<%		
					}
		
					if(currentPage < lastPage) {
				%>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage+1%>" class="mx-1">다음페이지</a>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>" class="mx-1">마지막페이지</a>
				<%		
					} else {
				%>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>" class="mx-1">다음페이지</a>
						<a href="/BeeNb/customer/customerRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>" class="mx-1">마지막페이지</a>
				<%
					}
				%>
				</ul>
		        	</nav>
			</div>
		</div>
		
		<!-- 푸터 -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>