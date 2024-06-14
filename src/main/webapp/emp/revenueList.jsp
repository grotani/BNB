<%@page import="java.util.ArrayList"%>
<%@page import="beeNb.dao.RevenueDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== revenueList.jsp ==========");
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// revenueList 페이지의 currentPage 세션 값 설정
		session.setAttribute("revenueListCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("revenueListCurrentPage") != null) {
		currentPage = (int)session.getAttribute("revenueListCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 revenueList 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("revenueListRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("revenueListRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("revenueListRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// revenue_status 테이블의 전체 행 개수
	int revenueListTotalRow = RevenueDAO.selectRevenueListCnt();
	// 디버깅
	System.out.println("revenueListTotalRow : " + revenueListTotalRow);
	
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - revenue_status 테이블 전체 행을 페이지당 보여줄 revenue_status 행의 개수로 나눈 값
	int lastPage = revenueListTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 revenue_status 행을 보여주기 위해 lastPage 에 + 1하기
	if(revenueListTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// 수익 현황 리스트
	ArrayList<HashMap<String, Object>> revenueList = RevenueDAO.selectRevenueList();
	// 디버깅
	System.out.println("revenueList : " + revenueList);
	
	// 전체 수익
	int totalRevenue = RevenueDAO.selectTotalRevenue();
	// 디버깅
	System.out.println("totalRevenue : " + totalRevenue);
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
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<h1>수익현황</h1>
		
		<!-- rowPerPage 설정 -->
		<form action="/BeeNb/emp/revenueList.jsp" method="post">
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
		
		<!-- 수익 리스트 출력 -->
		<table class="table">
			<tr>
				<th>예약번호</th>
				<th>수익</th>
				<th>예약일(결제일)</th>
			</tr>
			<%
				for(HashMap<String, Object> m : revenueList) {
			%>
					<tr>
						<td><%=m.get("bookingNo") %></td>
						<td><%=String.format("%,d", m.get("revenue"))%>원</td>
						<td><%=m.get("createDate") %></td>
					</tr>
			<%
				}
			%>
			
			<tr class="table-warning">
				<th>총 수익</th>
				<td><%=String.format("%,d", totalRevenue)%>원</td>
				<td></td>
			</tr>
		</table>
		
		<!-- 페이징 버튼 -->	
		<div>
			<nav>
		        <ul class="pagination" style="display: flex; justify-content: center;">
					<%
						if(currentPage > 1) {
					%>	
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/revenueList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/revenueList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">이전페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/revenueList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/revenueList.jsp?currentPage=1">이전페이지</a>
							</li>
					<%		
						}
						if(currentPage < lastPage) {
					%>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/revenueList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/revenueList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/revenueList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/revenueList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
							</li>
					<%
						}
					%>
				</ul>
		    </nav>
		</div>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>