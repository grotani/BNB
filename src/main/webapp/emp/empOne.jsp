<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====empOne.jsp=====");

	// 비밀번호 변경 성공 Msg
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 상세보기</title>
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
			<h1>개인정보확인</h1>
			<table class="table">
				<tr>
					<th>사번</th>
					<th>이름</th>
					<th>전화번호</th>
					<th>생년월일</th>
					<th>비밀번호수정</th>
					<th>탈퇴</th>
					<th>비고</th>
				</tr>
				<tr>
					<td><%= loginEmp.get("empNo") %></td>
					<td><%= loginEmp.get("empName") %></td>
					<td><%= loginEmp.get("empPhone") %></td>
					<td><%= loginEmp.get("empBirth") %></td>
					<td>
						<a href="/BeeNb/emp/empEditPwForm.jsp" class="btn btn-warning">수정</a>
					</td>
					<td>
						<a href="/BeeNb/emp/empDropCheckPwForm.jsp" class="btn btn-warning">탈퇴</a>
					</td>
					<td>
						<%
		                    if(msg != null){
		                %>
		                        &nbsp;<%=msg %>
		                <%
		                    }
		                %>
					</td>
				</tr>
			</table>
		</div>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>