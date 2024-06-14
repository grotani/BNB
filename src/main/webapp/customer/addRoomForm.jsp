<%@page import="beeNb.dao.ThemeDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<% 
	System.out.println("=====addRoomForm.jsp=====");	
	String actionUrl = "/BeeNb/customer/addRoomAction.jsp";
	String cancelUrl = "/BeeNb/customer/customerRoomList.jsp";
	ArrayList<String> themeList = ThemeDAO.selectThemeList();
	
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
				<h1>숙소 등록하기</h1>
			</div>
			<form action="<%=actionUrl %>" method="post" enctype="multipart/form-data">
				<div class="row mt-3">
					<div class="col">
						<label for="roomName">숙소명</label>
					</div>
					<div class="col-10">
						<input type="text" name="roomName" id="roomName" required="required">
					</div>
				</div>
				
				
				
				<div class="row mt-3">
					<div class="col">
						<label for="roomCategory">숙소 카테고리</label>
					</div>
 					<div class="col-10">
						<select name="roomCategory" id="roomCategory">
							<option value="펜션">펜션</option>
							<option value="호텔">호텔</option>
							<option value="리조트">리조트</option>
							<option value="카라반">카라반</option>
							<option value="글램핑">글램핑</option>
							<option value="한옥">한옥</option>
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
											<%=theme %>&nbsp;<input type="radio" value="<%=theme %>" name="roomTheme" checked="checked">&nbsp;&nbsp;&nbsp; 
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
						<input type="text" name="roomAddress" id="roomAddress" required="required">
					</div>
				</div>
				
				<div class="row mt-3">
					<div class="col">
						<label for="roomContent">숙소 설명</label>
					</div>			
					<div class="col-10">
						<textarea name="roomContent" id="roomContent" rows="10" cols="50" required="required"></textarea>
					</div>
				</div>
				
				
				<div class="row mt-3">
					<div class="col">
						<label for="operationStart">숙소 운용 기간</label>
					</div>
					<div class="col-10">
						<input type="date" id="operationStart" name="operationStart" required="required">
						<span>~</span>
						<input type="date" id="operationEnd" name="operationEnd" required="required">
					</div>
				</div>
				
				
				<div class="row mt-3">
					<div class="col">
						<label for="maxPeople">최대 수용 인원</label>						
					</div>
					<div class="col-10">
						<input type="number" name="maxPeople" id="maxPeople" required="required">
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
									<input type="radio" id="wifi1" name="wifi" checked="checked" value="0">
								</td>
								<td>
									<label for="wifi2">없음</label>
								</td>
								<td>
									<input type="radio" id="wifi2" name="wifi" value="1">
								</td>
								<td>
									<label>주방도구</label>	
								</td>
								<td>
									<label for="kt1">제공</label>
								</td>
								<td>
									<input type="radio" id="kt1" name="kitshenTools" checked="checked" value="0">
								</td>
								<td>
									<label for="kt2">없음</label>
								</td>
								<td>
									<input type="radio" id="kt2" name="kitshenTools" value="1">								
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
									<input type="radio" id="parking1" name="parking" checked="checked" value="0">
								</td>
								<td>
									<label for="parking2">불가</label>
								</td>
								<td>
									<input type="radio" id="parking2" name="parking" value="1">
								</td>

								<td>
									<label for="bed">침대 개수</label>
								</td>
								<td colspan="4">
									<input class="w-25" type="number" id="bed" name="bed" value="" required="required">
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
									<input type="radio" id="ott1" name="ott" checked="checked" value="0">
								</td>
								<td>
									<label for="ott2">없음</label>
								</td>
								<td>
									<input type="radio" id="ott2" name="ott" value="1">
								</td>
								<td>
									<label>엘리베이터</label>
								</td>
								<td>
									<label for="ev1">제공</label>	
								</td>
								<td>
									<input type="radio" id="ev1" name="ev" checked="checked" value="0">
								</td>
								<td>
									<label for="ev2">없음</label>	
								</td>
								<td>
									<input type="radio" id="ev2" name="ev" value="1">
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				
				<div class="row mt-3">
					<div class="col">
						<label>파일첨부</label>
					</div>
					<div class="col-10">
						<input type="file" multiple name="file" >					
					</div>
				</div>
				
				
				
				<div class="row mt-3">
					<div class="col">
						<button type="submit">등록</button>
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