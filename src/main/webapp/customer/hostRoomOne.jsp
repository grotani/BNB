<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%
	System.out.println("========== hostRoomOne.jsp ==========");

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
		// hostRoomOne의 리뷰부분 currentPage 세션 값 설정
		session.setAttribute("hostRoomCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("hostRoomCurrentPage") != null) {
		currentPage = (int)session.getAttribute("hostRoomCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 review 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("hostRoomReviewRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("hostRoomReviewRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("hostRoomReviewRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// review 테이블의 전체 행 개수
	int hostRoomReviewTotalRow = ReviewDAO.selectHostRoomReviewListCnt(roomNo);
	// 디버깅
	System.out.println("hostRoomReviewTotalRow : " + hostRoomReviewTotalRow);
	
	
	// 리뷰 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - review 테이블 전체 행을 페이지당 보여줄 review 행의 개수로 나눈 값
	int lastPage = hostRoomReviewTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 review 행을 보여주기 위해 lastPage 에 + 1하기
	if(hostRoomReviewTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// 호스팅한 숙소의 이미지리스트
	ArrayList<String> roomImgList = RoomImgDAO.selectRoomImgList(roomNo);
	//디버깅
	System.out.println("roomImgList : " + roomImgList);
	
	// 호스팅한 숙소의 상세정보
	HashMap<String, Object> hostRoomOne = RoomDAO.selectHostRoomOne(roomNo);
	//디버깅
	System.out.println("hostRoomOne : " + hostRoomOne);
	
	
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
<%
	// msg 요청 값
	String msg = request.getParameter("msg");

	// errMsg 요청 값
	String errMsg = request.getParameter("errMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function deleteConfirm(event) {
	        event.preventDefault(); // 기본 동작 막기
	        let cnfrm = confirm("숙소를 삭제하시겠습니까?");
	        if (cnfrm) {
	            // 확인을 누르면 페이지 이동
	            window.location.href = event.currentTarget.href;
	        }
	        // 취소를 누르면 아무 것도 하지 않음 (그대로 현재 페이지에 머무름)
	    }
	</script>
</head>
<body>
	<div class="container">
		<!-- 고객 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		
		<h1><%=hostRoomOne.get("roomName") %></h1>
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
				<div class="alert alert-danger" role="alert">
					<%= errMsg%>
				</div>
		<%
			}
		%>
		<div style="text-align: right;">
			<!-- 숙소 삭제버튼 -->
			<a class="btn btn-warning" href="/BeeNb/customer/customerRoomDeleteAction.jsp?roomNo=<%=roomNo%>" onclick="deleteConfirm(event)">숙소 삭제</a>
			
			<!-- 숙소 수정버튼 -->
			<a class="btn btn-warning" href="/BeeNb/customer/updateRoomForm.jsp?roomNo=<%=roomNo%>">숙소 수정</a>
		</div>
		
		<!-- 숙소 상세정보 출력 -->
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
						<td><%=hostRoomOne.get("roomName") %></td>
					</tr>
					<tr>
						<th>숙소 타입</th>
						<td><%=hostRoomOne.get("roomCategory") %></td>
					</tr>
					<tr>
						<th>테마</th>
						<td><%=hostRoomOne.get("roomTheme") %></td>
					</tr>
					<tr>
						<th>위치</th>
						<td><%=hostRoomOne.get("roomAddress") %></td>
					</tr>
					<tr>
						<th>운용 기간</th>
						<td><%=hostRoomOne.get("operationStart") %> ~ <%=hostRoomOne.get("operationEnd") %></td>
					</tr>
					<tr>
						<th>최대 수용 인원</th>
						<td><%=hostRoomOne.get("maxPeople") %></td>
					</tr>
					<tr>
						<th>승인 상태</th>
						<td><%=hostRoomOne.get("approveState") %></td>
					</tr>
					<tr>
						<th>숙소 등록일</th>
						<td><%=hostRoomOne.get("createDate") %></td>
					</tr>
					<tr>
						<th>숙소 수정일</th>
						<td><%=hostRoomOne.get("updateDate") %></td>
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
					<%=hostRoomOne.get("roomContent") %>
				</td>
			</tr>
		</table>

		<!-- 숙소 예약일 표시 및 가격 등록 버튼-->
		<div>
			<hr>
			<%
				if(hostRoomOne.get("approveState").equals("승인")) {
			%>
					<a class="btn btn-warning" href="/BeeNb/customer/addOneDayPriceForm.jsp?roomNo=<%=roomNo%>">가격 등록</a>
			<%
				} else {
			%>
					<a class="btn btn-warning disabled" href="/BeeNb/customer/addOneDayPriceForm.jsp?roomNo=<%=roomNo%>">가격 등록</a>
			<%
				}
			%>
			
			<div class="row" style="text-align: center; justify-content: center;">
				<div class="col-auto">
					<a class="text-decoration-none fs-5 text-dark" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo %>&targetYear=<%=calendarYear%>&targetMonth=<%=calendarMonth - 1%>">
						이전 달
					</a>
				</div>
				
				<div class="col-4">
					<h1><%=calendarYear%>년 <%=calendarMonth + 1%>월</h1>
				</div>
				
				<div class="col-auto">
					<a class="text-decoration-none fs-5 text-dark" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo %>&targetYear=<%=calendarYear%>&targetMonth=<%=calendarMonth + 1%>">
						다음 달
					</a>
				</div>
			</div>
		</div>
		<!-- 달력 -->
		<div>
			<!-- 요일 -->
			<table class="table">
				<thead>
					<tr style="text-align: center;">
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
							<td style="width: 200px; height: 130px;">
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
										<br>예약 상태 : <b><%=m.get("roomState")%></b>
										<br>등록 가격 : <b><%=String.format("%,d", Integer.parseInt((String)m.get("roomPrice")))%>원</b>
					<%
										if(((String)m.get("roomState")).equals("예약 가능")) {
					%>
										<br><a class="text-decoration-none" href="/BeeNb/customer/deleteOneDayPriceAction.jsp?roomNo=<%=roomNo%>&roomDate=<%=m.get("roomDate")%>">가격 삭제</a>
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
		
		<!-- 숙소 리뷰 -->
		<div>
			<hr>
			<h2 style="display: inline-block;">리뷰</h2>
			<%
				// 리뷰가 없을 때
				if(reviewList.isEmpty()) {
			%>
					<br>
						<h4 style="text-align: center;">리뷰가 없어요 :(</h4>
					<br>
			<%
				}
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
								<li class="page-item">
									<a class="page-link text-dark" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">처음페이지</a>
								</li>
								<li class="page-item">
									<a class="page-link text-dark" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage-1%>">이전페이지</a>
								</li>
						<%		
							} else {
						%>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">처음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">이전페이지</a>
								</li>
						<%		
							}
				
							if(currentPage < lastPage) {
						%>
								<li class="page-item">
									<a class="page-link text-dark" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage+1%>">다음페이지</a>
								</li>
								<li class="page-item">
									<a class="page-link text-dark" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">마지막페이지</a>
								</li>
						<%		
							} else {
						%>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">다음페이지</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link" href="/BeeNb/customer/hostRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">마지막페이지</a>
								</li>
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