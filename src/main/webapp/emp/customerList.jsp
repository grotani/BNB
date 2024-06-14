<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== customerList.jsp ==========");

	// grade 요청 값(기본값 : 0(게스트))
	String grade = "0";
	if(request.getParameter("grade") != null) {
		grade = request.getParameter("grade");
		// customerList 페이지의 grade 세션 값 설정
		session.setAttribute("customerListGrade", grade);
	}
	// grade값 세션변수에 저장한 grade값으로 변경
	if(session.getAttribute("customerListGrade") != null) {
		grade = (String)(session.getAttribute("customerListGrade"));	
	}
	// 디버깅
	System.out.println("grade : " + grade);
	
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// customerList 페이지의 currentPage 세션 값 설정
		session.setAttribute("customerListCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("customerListCurrentPage") != null) {
		currentPage = (int)session.getAttribute("customerListCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 customer 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("customerListRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("customerListRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("customerListRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// customer 테이블의 전체 행 개수
	int customerListTotalRow = CustomerDAO.selectCustomerListCnt();
	// 디버깅
	System.out.println("customerListTotalRow : " + customerListTotalRow);
	
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - customer 테이블 전체 행을 페이지당 보여줄 customer 행의 개수로 나눈 값
	int lastPage = customerListTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 customer 행을 보여주기 위해 lastPage 에 +1하기
	if(customerListTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	// customer grade(0 : 호스트, 1 : 호스트 & 게스트)별, 페이징을 포함한 customer 목록 리스트
	ArrayList<HashMap<String, Object>> customerList = CustomerDAO.selectCustomerList(grade, startRow, rowPerPage);
	// 디버깅
	System.out.println("customerList : " + customerList);
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
	
		<h1>회원 리스트</h1>
	
		<!-- grade 선택하기(0 : 호스트, 1 : 호스트 & 게스트) -->
		<ul class="nav nav-tabs">
			<%
				if(Integer.parseInt(grade) == 0) {
			%>
					<li class="nav-item" style="width: 50%; text-align: center;">
						<a class="nav-link active fs-5" href="/BeeNb/emp/customerList.jsp?grade=0">게스트</a>
					</li>
					<li class="nav-item" style="width: 50%; text-align: center;">
						<a class="nav-link text-secondary fs-5" href="/BeeNb/emp/customerList.jsp?grade=1">게스트 & 호스트</a>
					</li>
			<%
				} else {
			%>
					<li class="nav-item" style="width: 50%; text-align: center;">
						<a class="nav-link text-secondary fs-5" href="/BeeNb/emp/customerList.jsp?grade=0">게스트</a>
					</li>
					<li class="nav-item" style="width: 50%; text-align: center;">
						<a  class="nav-link active fs-5" href="/BeeNb/emp/customerList.jsp?grade=1">게스트 & 호스트</a>
					</li>
			<%
				}
			%>
		</ul>
		<br>
		<!-- rowPerPage 설정 -->
		<form action="/BeeNb/emp/customerList.jsp" method="post">
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
		
		<!-- 고객 리스트 출력 -->
		<table class="table table-hover">
			<tr>
				<th>ID</th>
				<th>E-MAIL</th>
				<th>이름</th>
				<th>생년월일</th>
			</tr>
			<%
				for(HashMap<String, Object> m : customerList) {
			%>
					<tr onclick="location.href='/BeeNb/emp/customerOne.jsp?customerId=<%=m.get("customerId")%>'" style="cursor: pointer;">
						<td>
							<%=m.get("customerId")%>
						</td>
						<td>
							<%=m.get("customerEmail")%>
						</td>
						<td>
							<%=m.get("customerName")%>
						</td>
						<td>
							<%=m.get("customerBirth")%>
						</td>
					</tr>
			<%
				}
			%>
		</table>
		
		<!-- 페이징 버튼 -->	
		<div>
			<nav>
		       <ul class="pagination" style="display: flex; justify-content: center;">
					<%
						if(currentPage > 1) {
					%>	
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/customerList.jsp?currentPage=1&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/customerList.jsp?currentPage=<%=currentPage-1%>&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">이전페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/customerList.jsp?currentPage=1&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">처음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/customerList.jsp?currentPage=1&grade=<%=grade%>">이전페이지</a>
							</li>
					<%		
						}
						if(currentPage < lastPage) {
					%>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/customerList.jsp?currentPage=<%=currentPage+1%>&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link text-dark" href="/BeeNb/emp/customerList.jsp?currentPage=<%=lastPage%>&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
							</li>
					<%		
						} else {
					%>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/customerList.jsp?currentPage=<%=lastPage%>&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
							</li>
							<li class="page-item">
								<a class="page-link disabled" href="/BeeNb/emp/customerList.jsp?currentPage=<%=lastPage%>&grade=<%=grade%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
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