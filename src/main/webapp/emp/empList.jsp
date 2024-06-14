<%@page import="java.util.*"%>
<%@page import="beeNb.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== empList.jsp ==========");
	
	// 이름으로 emp를 검색하기위해 searchWord 요청값(SELECT에서 LIKE 절에 사용하기 위해)
	String searchWord = "";
    if(request.getParameter("searchWord") != null) {
    	searchWord = request.getParameter("searchWord");
    	// empList 페이지의 searchWord 세션 값 설정
		session.setAttribute("empListSearchWord", searchWord);
    }
 	// currentPage값 세션변수에 저장한 currentPage값으로 변경
 	if(session.getAttribute("empListSearchWord") != null) {
 		searchWord = (String)session.getAttribute("empListSearchWord");	
 	}
	// 디버깅
	System.out.println("searchWord : " + searchWord);
	
	
	// 현재 페이지 구하기
	// 처음 실행시 1페이지로 설정
	int currentPage = 1;
	// currentPage 요청 값이 있을 경우(페이지 이동 시) 요청 값으로 변경
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// empList 페이지의 currentPage 세션 값 설정
		session.setAttribute("empListCurrentPage", currentPage);
	}
	// currentPage값 세션변수에 저장한 currentPage값으로 변경
	if(session.getAttribute("empListCurrentPage") != null) {
		currentPage = (int)session.getAttribute("empListCurrentPage");	
	}
	// 디버깅
	System.out.println("currentPage : " + currentPage);
	
	
	// 페이지당 보여줄 emp 행의 개수
	// 기본 30개로 설정
	int rowPerPage = 30;
	// rowPerPage 요청 값이 있을 경우(select박스로 선택했을 때) 요청 값으로 변경
	if(request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		session.setAttribute("empListRowPerPage", rowPerPage);
	}
	// rowPerPage값 세션변수에 저장한 rowPerPage값으로 변경
	if(session.getAttribute("empListRowPerPage") != null) {
		rowPerPage = (int)session.getAttribute("empListRowPerPage");
	}
	// 디버깅
	System.out.println("rowPerPage : " + rowPerPage);
	
	
	// emp 테이블의 전체 행 개수
	int empListTotalRow = EmpDAO.selectEmpListCnt(searchWord);
	// 디버깅
	System.out.println("empListTotalRow : " + empListTotalRow);
	
	
	// 페이지당 시작할 row
	int startRow = (currentPage - 1) * rowPerPage;
	// 디버깅
	System.out.println("startRow : " + startRow);
	
	
	// 마지막 페이지 구하기 - emp 테이블 전체 행을 페이지당 보여줄 emp 행의 개수로 나눈 값
	int lastPage = empListTotalRow / rowPerPage;
	// 나머지가 생길 경우 남은 emp 행을 보여주기 위해 lastPage 에 +1하기
	if(empListTotalRow % rowPerPage != 0) {
		lastPage += 1;
	}
	// 디버깅
	System.out.println("lastPage : " + lastPage);
	
	
	// emp 이름 검색, 페이징을 포함한 emp 목록 리스트
	ArrayList<HashMap<String, Object>> empList = EmpDAO.selectEmpList(searchWord, startRow, rowPerPage);
	// 디버깅
	System.out.println("empList : " + empList);
%>
<%
	//msg 요청 값
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 목록</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<h1>관리자 리스트</h1>
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
		
		<!-- rowPerPage 설정 -->
		<form action="/BeeNb/emp/empList.jsp" method="post">
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
				
				<!-- 관리자 등록 -->
				<div class="col-auto ms-auto">	
					<a class="btn btn-warning" href="/BeeNb/emp/empRegistForm.jsp">관리자 등록</a>
				</div>
			</div>
		</form>
		
		<!-- 관리자 리스트 출력 -->
		<table class="table">
			<tr>
				<th>사번</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>생년월일</th>
				<th>등록일</th>
			</tr>
			<%
				for(HashMap<String, Object> m : empList) {
			%>
					<tr>
						<td><%=m.get("empNo")%></td>
						<td><%=m.get("empName")%></td>
						<td><%=m.get("empPhone")%></td>
						<td><%=m.get("empBirth")%></td>
						<td><%=m.get("createDate")%></td>
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
	                    if (currentPage > 1) {
		            %>
	                        <li class="page-item">
	                            <a class="page-link text-dark" href="/BeeNb/emp/empList.jsp?currentPage=1&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">처음페이지</a>
	                        </li>
	                        <li class="page-item">
	                            <a class="page-link text-dark" href="/BeeNb/emp/empList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">이전페이지</a>
	                        </li>
		            <%
	                    } else {
		            %>
	                        <li class="page-item disabled">
	                            <a class="page-link" href="/BeeNb/emp/empList.jsp?currentPage=1&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">처음페이지</a>
	                        </li>
	                        <li class="page-item disabled">
	                            <a class="page-link" href="/BeeNb/emp/empList.jsp?currentPage=1&searchWord=<%=searchWord%>">이전페이지</a>
	                        </li>
		            <%
		                    }
	                    if (currentPage < lastPage) {
		            %>
	                        <li class="page-item">
	                            <a class="page-link text-dark" href="/BeeNb/emp/empList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
	                        </li>
	                        <li class="page-item">
	                            <a class="page-link text-dark" href="/BeeNb/emp/empList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
	                        </li>
		            <%
	                    } else {
		            %>
	                        <li class="page-item disabled">
	                            <a class="page-link" href="/BeeNb/emp/empList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">다음페이지</a>
	                        </li>
	                        <li class="page-item disabled">
	                            <a class="page-link" href="/BeeNb/emp/empList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>&rowPerPage=<%=rowPerPage%>">마지막페이지</a>
	                        </li>
		            <%
	                    }
		            %>
		        </ul>
		    </nav>
		</div>
		
		<!-- 관리자 이름 검색 -->
		<form action="/BeeNb/emp/empList.jsp" method="post">
			<div class="row justify-content-center">
			 	<div class="col-4">
			 		<input class="form-control" type="text" name="searchWord" placeholder="사원 이름으로 찾기" style="width: 100%;">
			 	</div>
			 	
			 	<div class="col-auto ps-0">
					<button class="btn btn-warning" type="submit">검색</button>
				</div>
			</div>
		</form>
		

		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>