<%@page import="beeNb.dao.ThemeDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<% 
	System.out.println("=====updateRoomForm.jsp=====");	
	String actionUrl = "/BeeNb/customer/updateRoomAction.jsp";
	String cancelUrl = "/BeeNb/customer/hostRoomList.jsp";
	ArrayList<String> themeList = ThemeDAO.selectThemeList();
	
	int roomNo = Integer.parseInt(request.getParameter("roomNo"));
	String errMsg = request.getParameter("errMsg");
	
	
	HashMap<String, String> oneMap = RoomDAO.selectRoomOne(roomNo);
	
	System.out.println("OneMap : " + oneMap);
	
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/inc/bootstrapCDN.jsp"></jsp:include>
	<title>BeeBb</title>
	<link href="/BeeNb/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container">
		<!-- 관리자 네비게이션 바 -->
		<jsp:include page="/customer/inc/customerNavbar.jsp"></jsp:include>
		<div class="row mt-5">
		<div class="col"></div>
		<div class="col-8">
			<div class="row mt-3">
				<h1>숙소 수정하기</h1>
			</div>
			<form action="<%=actionUrl %>" method="post" enctype="multipart/form-data">
				<div class="row mt-3">
					<div class="col">
						<label for="roomName">숙소명</label>
					</div>
					<div class="col-10">
						<input type="text" name="roomName" id="roomName" required="required" value="<%=oneMap.get("roomName") %>">
					</div>
				</div>
				<div class="row mt-3">
					<div class="col">
						<label for="roomCategory">숙소 카테고리</label>
					</div>
 					<div class="col-10">
						<select name="roomCategory" id="roomCategory">
							<option value="펜션" <%=oneMap.get("roomCategory").equals("펜션") ? "selected" : "" %>>펜션</option>
							<option value="호텔" <%=oneMap.get("roomCategory").equals("호텔") ? "selected" : "" %>>호텔</option>
							<option value="리조트" <%=oneMap.get("roomCategory").equals("리조트") ? "selected" : "" %>>리조트</option>
							<option value="카라반" <%=oneMap.get("roomCategory").equals("카라반") ? "selected" : "" %>>카라반</option>
							<option value="글램핑" <%=oneMap.get("roomCategory").equals("글램핑") ? "selected" : "" %>>글램핑</option>
							<option value="한옥" <%=oneMap.get("roomCategory").equals("한옥") ? "selected" : "" %>>한옥</option>
						</select>
					</div>
				</div>
				
				
				
				<div class="row mt-3">
					<div class="col">
						<label>숙소 테마</label>
					</div>
					<div class="col-10">
						<table>
							<tr>	
								<%
									int index = 0;
									for(String theme : themeList){ 
										if(index%4 == 0){
								%>
											</tr><tr>
								<%
										}
								%>
										<td>
											<%=theme %>&nbsp;<input type="radio" value="<%=theme %>" name="roomTheme" 
											
											<%=oneMap.get("roomTheme").equals(theme) ? "checked" : "" %>
											>&nbsp;&nbsp;&nbsp; 
										</td>
								<% 		index = index + 1;
									}
								%>
							</tr>
						</table>
					</div>
				</div>
				
				
				<div class="row mt-3">
					<div class="col">
						<label for="roomAddress">숙소 주소</label>
					</div>			
					<div class="col-10">
						<input type="text" name="roomAddress" id="roomAddress" required="required" value="<%=oneMap.get("roomAddress")%>">
					</div>
				</div>
				
				<div class="row mt-3">
					<div class="col">
						<label for="roomContent">숙소 설명</label>
					</div>			
					<div class="col-10">
						<textarea name="roomContent" id="roomContent" rows="10" cols="50" required="required"><%=oneMap.get("roomContent")%></textarea>
					</div>
				</div>
				
				
				<div class="row mt-3">
					<div class="col">
						<label for="operationStart">숙소 운용 기간</label>
					</div>
					<div class="col-10">
						<input type="date" id="operationStart" name="operationStart" required="required" value="<%=oneMap.get("operationStart")%>">
						<span>~</span>
						<input type="date" id="operationEnd" name="operationEnd" required="required" value="<%=oneMap.get("operationEnd")%>">
					</div>
				</div>
				
				
				<div class="row mt-3">
					<div class="col">
						<label for="maxPeople">최대 수용 인원</label>						
					</div>
					<div class="col-10">
						<input type="number" name="maxPeople" id="maxPeople" required="required" value="<%=oneMap.get("maxPeople")%>">
					</div>
				</div>	
				
				
				
				<div class="row mt-3">
					<div class="col">
						<label>숙소 상세 정보</label>
					</div>
					<div class="col-10">
						<table>
							<colgroup>
								<col width="18%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								
								<col width="18%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
							
							</colgroup>
							<tr>

								<td>
									<label>WIFI</label>	
								</td>
								<td>
									<label for="wifi1">제공</label>								
								</td>
								<td>
									<input type="radio" id="wifi1" name="wifi" <%=oneMap.get("wifi").equals("0") ? "checked" : "" %> value="0">
								</td>
								<td>
									<label for="wifi2">없음</label>
								</td>
								<td>
									<input type="radio" id="wifi2" name="wifi" <%=oneMap.get("wifi").equals("1") ? "checked" : "" %> value="1">
								</td>
								<td>
									<label>주방도구</label>	
								</td>
								<td>
									<label for="kt1">제공</label>
								</td>
								<td>
									<input type="radio" id="kt1" name="kitshenTools" <%=oneMap.get("kitchenTools").equals("0") ? "checked" : "" %> value="0">
								</td>
								<td>
									<label for="kt2">없음</label>
								</td>
								<td>
									<input type="radio" id="kt2" name="kitshenTools" <%=oneMap.get("kitchenTools").equals("1") ? "checked" : "" %> value="1">								
								</td>
							</tr>
							<tr>
								<td>
									<label>Parking</label>
								</td>
								<td>
									<label for="parking1">가능</label>
								</td>
								<td>
									<input type="radio" id="parking1" name="parking" checked="checked" <%=oneMap.get("parking").equals("0") ? "checked" : "" %> value="0">
								</td>
								<td>
									<label for="parking2">불가</label>
								</td>
								<td>
									<input type="radio" id="parking2" name="parking" <%=oneMap.get("parking").equals("1") ? "checked" : "" %> value="1">
								</td>

								<td>
									<label for="bed">침대 개수</label>
								</td>
								<td colspan="4">
									<input class="w-25" type="number" id="bed" name="bed" value="<%=oneMap.get("bed") %>" required="required">
								</td>
							</tr>
							<tr>
								<td>
									<label>OTT 여부</label>
								</td>
								<td>
									<label for="ott1">제공</label>
								</td>
								<td>
									<input type="radio" id="ott1" name="ott" <%=oneMap.get("ott").equals("0") ? "checked" : "" %> value="0">
								</td>
								<td>
									<label for="ott2">없음</label>
								</td>
								<td>
									<input type="radio" id="ott2" name="ott" <%=oneMap.get("ott").equals("1") ? "checked" : "" %>  value="1">
								</td>
								<td>
									<label>엘리베이터</label>
								</td>
								<td>
									<label for="ev1">제공</label>	
								</td>
								<td>
									<input type="radio" id="ev1" name="ev" <%=oneMap.get("ev").equals("0") ? "checked" : "" %> value="0">
								</td>
								<td>
									<label for="ev2">없음</label>	
								</td>
								<td>
									<input type="radio" id="ev2" name="ev" <%=oneMap.get("ev").equals("1") ? "checked" : "" %> value="1">
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				
				<!-- <div class="row mt-3">
					<div class="col">
						<label>파일첨부</label>
					</div>
					<div class="col-10">
						<input type="file" multiple name="file" >					
					</div>
				</div>
				 -->
				
				
				<div class="row mt-3">
					<div class="col">
						<input type="hidden" name="roomNo" value="<%=roomNo %>">
						<button type="submit">수정</button>
						<a href="<%=cancelUrl%>" class="text-decoration-none">취소</a>
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