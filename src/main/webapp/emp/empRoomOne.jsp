<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("==========empRoomOne.jsp==========");

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
		// empRoomOne의 리뷰부분 currentPage 세션 값 설정
		session.setAttribute("empRoomOneCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("empRoomOneCurrentPage") != null) {
		currentPage = (int)session.getAttribute("empRoomOneCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 review 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("empRoomOneReviewRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("empRoomOneReviewRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("empRoomOneReviewRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// review 테이블의 전체 행 개수
	int empRoomOneReviewTotalRow = ReviewDAO.selectHostRoomReviewListCnt(roomNo);
	// 디버깅
	System.out.println("empRoomOneReviewTotalRow : " + empRoomOneReviewTotalRow);
	
	
	// 리뷰 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - review 테이블 전체 행을 페이지당 보여줄 review 행의 개수로 나눈 값
	int lastPage = empRoomOneReviewTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 review 행을 보여주기 위해 lastPage 에 + 1하기
	if(empRoomOneReviewTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	
	// 호스팅한 숙소의 상세정보
	HashMap<String, Object> empRoomOne = RoomDAO.selectHostRoomOne(roomNo);
	//디버깅
	System.out.println("empRoomOne : " + empRoomOne);
	
	
	// 호스팅한 숙소의 하루 가격 및 정보(가격, 예약 상태)리스트
	ArrayList<HashMap<String, Object>> oneDayPriceList = OneDayPriceDAO.selectOneDayPriceList(roomNo);
	// 디버깅
	System.out.println("oneDayPriceList : " + oneDayPriceList);
	
	
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
		
		
		<!-- 숙소 리뷰 -->
		<div>
			<hr>			
			<h2 style="display: inline-block;">리뷰</h2>
			<table class="table table-striped">
			<%
				for(HashMap<String, Object> m : reviewList) {
			%>
				<tr>
					<td>
						<%=m.get("customerId") %>		
					</td>
					<td>
							<%
								for(int i = 1; i <= (int)(m.get("rating")); i++) {
							%>
									&#127775;
							<%
								}
							%>
					</td>
					<td>
						<%=((String)(m.get("createDate"))).substring(0, 11)%>
					</td>
					<td>
						<%=m.get("reviewContent") %>
					</td>
				</tr>
			<%
				}
			%>
			</table>
				
			<!-- 숙소 리뷰 페이징 -->	
			<div>
				<nav>
					<ul class="pagination" style="display: flex; justify-content: center;">
						<%
							if(currentPage > 1) {
						%>	
								<li class="page-item text-dark"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">처음페이지</a></li>
								<li class="page-item text-dark"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage-1%>">이전페이지</a></li>
						<%		
							} else {
						%>
								<li class="page-item"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">처음페이지</a></li>
								<li class="page-item"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=1">이전페이지</a></li>
						<%		
							}
				
							if(currentPage < lastPage) {
						%>
								<li class="page-item text-dark"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=currentPage+1%>">다음페이지</a></li>
								<li class="page-item text-dark"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">마지막페이지</a></li>
						<%		
							} else {
						%>
								<li class="page-item"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">다음페이지</a></li>
								<li class="page-item"><a class="page-link" href="/BeeNb/emp/empRoomOne.jsp?roomNo=<%=roomNo%>&currentPage=<%=lastPage%>">마지막페이지</a></li>
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