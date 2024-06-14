<%@page import="beeNb.dao.ComplainDAO"%>
<%@page import="beeNb.dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/emp/inc/empSessionIsNull.jsp" %>
<%
	System.out.println("========== vocOne.jsp ==========");


	String complainNo = request.getParameter("complainNo");
	String errMsg = request.getParameter("errMsg");
	// 디버깅
	System.out.println("complainNo : " + complainNo);
	
	HashMap<String, String> complainOne = ComplainDAO.selectVocOne(complainNo);
	// 디버깅
	System.out.println("complainOne : " + complainOne);
	
	String actionUrl = "/BeeNb/emp/updateVocStateAction.jsp";
	String cancelUrl = "/BeeNb/emp/vocList.jsp";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
	<link href="/BeeNb/css/common.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/emp/inc/empNavbar.jsp"></jsp:include>

		<div class="row mt-5" style="height: 65%;">
			<div class="col"></div>
			<div class="col-8">
				<div class="row mt-3">
					<h1>민원 상세내용</h1>
				</div>
				<form action="<%=actionUrl %>" method="post" enctype="multipart/form-data">
					<div class="row mt-3">
						<div class="col">
							<label for="complainType">민원 유형</label>
						</div>
						<div class="col-10">
							<%=complainOne.get("complainType") %>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<label for="complainState">민원 상태</label>
						</div>
						<div class="col-10">
							<%=complainOne.get("complainState") %>
						</div>
					</div>
					
					<div class="row mt-3">
						<div class="col">
							<label for=complainContent>민원 내용</label>
						</div>
						<div class="col-10" style="border">
							<textarea class="form-control" id="exampleFormControlTextarea1" rows="15" style="resize: none;" readonly="readonly"><%=complainOne.get("complainContent") %>	
							</textarea>
						</div>
					</div>
					
					
					<%if(complainOne.get("complainState").equals("처리중") ) { %>
						<div class="row mt-3">
							<div class="col">
								<label for="complainAnswer">민원 답변</label>
							</div>
							<div class="col-10">
								<textarea name="complainAnswer" id="complainAnswer" rows="10" cols="50" required="required"></textarea>
							</div>
						</div>
					<% } %>
					
					<%if(complainOne.get("complainState").equals("처리완료") ) { %>
						<div class="row mt-3">
							<div class="col">
								<label for="complainAnswer">민원 답변</label>
							</div>
							<div class="col-10">
								<%=complainOne.get("complainAnswer") %>
							</div>
						</div>
					<% } %>
					
					
					<div class="row mt-3">
						<div class="col d-flex justify-content-center">
							<input type="hidden" name="complainNo" value="<%=complainNo%>">
							<input type="hidden" name="complainState" value="<%=complainOne.get("complainState")%>">
							<%if(complainOne.get("complainState").equals("접수") ) { %>
								<button type="submit" class="btn btn-outline-warning btn-width-beenb mx-2">접수</button>
							<% } %>
							<%if(complainOne.get("complainState").equals("처리중") ) { %>
								<button type="submit" class="btn btn-outline-warning btn-width-beenb mx-2">완료</button>
							<% } %>
							<a href="<%=cancelUrl%>" class="text-decoration-none btn btn-outline-dark btn-width-beenb mx-2">돌아가기</a>
						</div>
					</div>
	
				</form>
			</div>
			<div class="col"></div>
		</div>
		<!-- 푸터  -->
		<jsp:include page="/inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>