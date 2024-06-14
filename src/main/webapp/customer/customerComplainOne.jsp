<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/customer/inc/customerSessionIsNull.jsp" %>
<%@ page import = "beeNb.dao.*" %>
<%
	System.out.println("=====customerComplainOne.jsp=====");

	String complainNo = request.getParameter("complainNo");
	System.out.println(complainNo);
	
	HashMap<String, Object> complainOne = ComplainDAO.selectComplainOne(complainNo);
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
	<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
	<h1>신고 상세내역</h1>	
 	<div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"> 예약번호 : <%= complainOne.get("bookingNo") %></li>
                        <li class="list-group-item"> 신고번호 : <%= complainOne.get("complainNo") %></li>
                        <li class="list-group-item"> 신고유형: <%= complainOne.get("complainType") %></li>                                
                        <li class="list-group-item"> 진행상태: <%= complainOne.get("complainState") %></li>
                        <li class="list-group-item"> 답변: <%= complainOne.get("complainAnswer") %></li>
                        <li class="list-group-item"> 신고일자: <%= complainOne.get("createDate") %></li>
                        <li class="list-group-item"> 처리일자: <%= complainOne.get("updateDate") %></li>
                    </ul>          								
				</div>
			</div>
		</div>	
	</div>	
	<!-- 푸터  -->
	<jsp:include page="/inc/footer.jsp"></jsp:include>	
	</div>
</body>
</html>