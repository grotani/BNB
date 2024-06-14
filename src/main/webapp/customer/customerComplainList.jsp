<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "beeNb.dao.*" %>
<%@ page import = "java.util.*" %>

<%
	System.out.println("=====customerComplainList.jsp=====");
	String customerId = (String)(loginCustomer.get("customerId"));
	
	ArrayList<HashMap<String,Object>> complainList = ComplainDAO.selectComplainList(customerId);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	 <style>
        /* 버튼 스타일 */
        .btn {
            display: inline-block;
            padding: 3px 10px;
            border: none;
            border-radius: 3px;
            background-color: #ffc107; /* 노란색 */
            color: #000;
            text-align: center;
            text-decoration: none;
            font-size: 13px;
            cursor: pointer;
        }

        /* 버튼 호버 효과 */
        .btn:hover {
            background-color: #ffca28; /* 밝은 노란색 */
        }
    </style>
</head>
<body>
	<div class="container">
	<!-- 고객 네비게이션 바 -->
	<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<h1>신고 내역</h1>
		<table class="table table-striped">
			<tr>
				<td>예약번호</td>
				<td>신고번호</td>
				<td>신고유형</td>
				<td>신고내용</td>
				<td>진행상태</td>				
				<td>신고일자</td>
				<td>처리일자</td>
				<td>답변</td>
			</tr>
			<%
				for(HashMap<String,Object> m : complainList){
				String complainState = (String)(m.get("complainState"));
			%>
				<tr>
					<td><%=(Integer)(m.get("bookingNo"))%>      </td>
					<td><%=(Integer)(m.get("complainNo"))%>     </td>					
					<td><%=(String)(m.get("complainType"))%>    </td>
					<td><%=(String)(m.get("complainContent"))%> </td>
					<td><%=(String)(m.get("complainState"))%>   </td>
					<td><%=(String)(m.get("createDate"))%>      </td>
					<td>
						<%
							if(m.get("updateDate") != null){
						%>
							<%=(String)(m.get("updateDate"))%>  
						<%	
							}
						%>
					    </td>
					<td>
						<% if(complainState.equals("처리완료")) { %>
	                  	 	 <a href="/BeeNb/customer/customerComplainOne.jsp?complainNo=<%=(Integer)(m.get("complainNo")) %>" class="btn">답변 보기</a>
		                <% } else { %>
		                    <!-- 처리완료가 아닌 경우에는 아무것도 표시하지 않음 -->
		                <% } %>						
					</td>
				</tr>
			<%		
				}
			
			%>
		</table>
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>