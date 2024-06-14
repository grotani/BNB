<%@page import="beeNb.dao.ComplainDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beeNb.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== vocList.jsp ==========");
	
	
	String complainState = "all";
	if(request.getParameter("complainState") != null) {
		complainState = request.getParameter("complainState");
	}
	
	System.out.println("complainState : " + complainState);
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// hostBookingList 페이지의 currentPage 세션 값 설정
		session.setAttribute("vocListCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("vocListCurrentPage") != null) {
		currentPage = (int)session.getAttribute("vocListCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 hostBookingList 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("vocListRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("vocListRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("vocListRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// (해당 호스트의)booking 테이블의 전체 행 개수
	int vocListTotalRow = ComplainDAO.selectEmpComplainListCnt(complainState);
	// 디버깅
	System.out.println("vocListTotalRow : " + vocListTotalRow);
	
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - (해당 호스트의)booking 테이블 전체 행을 페이지당 보여줄 (해당 호스트의)booking 행의 개수로 나눈 값
	int lastPage = vocListTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 (해당 호스트의)booking 행을 보여주기 위해 lastPage 에 + 1하기
	if(vocListTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	
	ArrayList<HashMap<String, Object>> vocList = ComplainDAO.selectVOCList(complainState, startRow, rowPerPage);
	// 디버깅
	System.out.println("vocList : " + vocList);
	
	
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
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<h1>고객 신고 관리</h1>
		
		<!-- 숙소 별 select -->
 		<form action="/BeeNb/emp/vocList.jsp" method="post">
			<select name="complainState">
				<option value="all">전체</option>	
				<option value="접수" <%=(complainState.equals("접수")) ? "selected" : "" %>>접수</option>	
				<option value="처리중" <%=(complainState.equals("처리중")) ? "selected" : "" %>>처리중</option>	
				<option value="처리완료" <%=(complainState.equals("접수완료")) ? "selected" : "" %>>처리완료</option>	
			</select>
			<button type="submit">보기</button>
		</form>
		
		<!-- 예약 리스트 -->
		<table class="table">
			<colgroup>
				<col style="width: 10%">
				<col style="width: 25%">
				<col style="width: 25%">
				<col style="width: *">
			</colgroup>
			<thead>
				<tr>
					<th>신고 번호</th>
					<th>신고 유형</th>
					<th>신고일</th>
					<th>신고 상태</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(HashMap<String, Object> m : vocList) {
				%>
						<tr>
							<td>
								<a href="/BeeNb/emp/vocOne.jsp?complainNo=<%=m.get("complainNo")%>" class="text-decoration-none">
									<%=m.get("complainNo") %>
								</a>
							</td>
							<td><%=m.get("complainType")%></td>
							<td><%=m.get("createDate")%></td>
							<td><%=m.get("complainState")%></td>
						</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<!-- 페이징 버튼 -->	
		<div>
			<nav>
		        <ul class="pagination">
					<%
						if(currentPage > 1) {
					%>	
							<li class="page-item">
								<a class="page-link" href="/BeeNb/emp/vocList.jsp?complainState=<%=complainState%>&currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="/BeeNb/emp/vocList.jsp?complainState=<%=complainState%>&currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/vocList.jsp?complainState=<%=complainState%>&currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/vocList.jsp?complainState=<%=complainState%>&currentPage=1">이전페이지</a>
							</li>
					<%		
						}
						if(currentPage < lastPage) {
					%>
							<li class="page-item">
								<a class="page-link" href="/BeeNb/emp/vocList.jsp?complainState=<%=complainState%>&currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="/BeeNb/emp/vocList.jsp?complainState=<%=complainState%>&currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/vocList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/vocList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
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