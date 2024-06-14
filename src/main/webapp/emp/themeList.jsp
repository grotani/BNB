<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beeNb.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("=====themeList.jsp=====");

	// 테마리스트 메서드 호출
	ArrayList<String> selectThemeList = ThemeDAO.selectThemeList();
	
    // 테마 추가 에러메세지 호출
    String msg = request.getParameter("msg");
    
    // 테마 추가 에러메세지 호출
    String errMsg = request.getParameter("errMsg");
    
    // 테마 삭제 에러메세지 호출
    String delErrMsg = request.getParameter("delErrMsg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>테마 리스트</title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="/BeeNb/img/beeFavicon.ico">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>
		
		<!-- 메인작업 -->
		<h1>테마 리스트</h1>
		<%
			if(msg != null){
		%>
				<%=msg %>
		<%		
			}
		%>
		<table class="table">
			<tr>
				<th>테마</th>
			</tr>
			<%
				for(String m : selectThemeList){
			%>
					<tr>
						<td>
							<%= m %>
							<a href="/BeeNb/emp/deleteThemeAction.jsp?roomTheme=<%= m %>" class="text-decoration-none text-danger">&#128473;</a>
						    <%
			                    if(delErrMsg != null){
			                %>
			                        <%=delErrMsg %>
			                <%
			                    }
			                %>
						</td>
					</tr>
			<%
				}
			%>			
		</table>
		
		<!-- 테마 추가 버튼 -->
		<form method="post" action="/BeeNb/emp/addThemeAction.jsp">
			<table>
				<tr>
					<td>
						<div class="row g-3 align-items-center">
							<div class="col-auto">
								<input type="text" class="form-control" name="roomTheme">
							</div>
						</div>
					</td>
					<td>
						&nbsp;<button type="submit" class="btn btn-warning">추가</button>
					</td>
					<td>
					    <%
		                    if(errMsg != null){
		                %>
		                        <%=errMsg %>
		                <%
		                    }
		                %>
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>