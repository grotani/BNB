<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp"%>
<%
	System.out.println("=====empDropCheckPwForm.jsp=====");

	// 메시지 호출
	String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 탈퇴 비밀번호 확인</title>
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
			<h1>비밀번호확인</h1>
			<form method="post" action="/BeeNb/emp/empDropCheckPwAction.jsp">
				<input type="hidden" value="<%= loginEmp.get("empNo") %>" name="empNo">
				<table>
					<tr>
						<td>
							현재 비밀번호 확인 : &nbsp;
						</td>
						<td>
							<input type="password" class="form-control" name="empPw">
						</td>
						<td>
							&nbsp;&nbsp;<button type="submit" class="btn btn-warning">수정</button>
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
			</form>
		</div>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
</body>
</html>