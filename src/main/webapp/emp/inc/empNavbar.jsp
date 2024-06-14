<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="beeNb.dao.*" %>
<%
	// 세션 값 불러오기
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	System.out.println("loginEmp : " + loginEmp);
	
	// 테마리스트 메서드 호출
	ArrayList<String> selectThemeList = ThemeDAO.selectThemeList();
%>
<link rel="icon" href="/BeeNb/img/beeFavicon.ico">
<nav class="navbar navbar-expand-lg bg-white sticky-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="/BeeNb/emp/empRoomList.jsp">
   	    <img src="/BeeNb/img/bee.png" class="h-100 d-inline-block" style="width: 30px; height: 25px;">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/BeeNb/emp/empRoomList.jsp">BeeNb</a>
        </li>
    	<!-- <%
			for(String m : selectThemeList){
		%>
        <li class="nav-item">
          <a class="nav-link" href="/BeeNb/emp/empRoomList.jsp?&theme=<%= m %>"><%= m %></a>
        </li>
		<%
			}
		%> -->
      </ul>
      <div class="d-flex" role="search">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
              <a class="nav-link active" aria-current="page" href="/BeeNb/emp/empRoomList.jsp">당신의 공간을 비앤비 하세요</a>
	        </li>
	      </ul>
        <li class="navbar-nav me-auto mb-2 mb-lg-0 nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            메뉴
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/BeeNb/emp/empOne.jsp"> 
            <%
            	if(loginEmp != null){
            %>
            		<%= loginEmp.get("empName") %> 님
            <%
            	}else{
            %>
            		<a href="/BeeNb/emp/empLoginForm.jsp" class="dropdown-item">로그인하세요.</a>
            <%    		
            	}
            %>
            </a></li>
            <hr>
            <li><a class="dropdown-item" href="/BeeNb/emp/empList.jsp">관리자리스트</a></li>
            <li><a class="dropdown-item" href="/BeeNb/emp/revenueList.jsp">수익현황리스트</a></li>
            <li><a class="dropdown-item" href="/BeeNb/emp/customerList.jsp">회원리스트</a></li>
            <li><a class="dropdown-item" href="/BeeNb/emp/pendingRoomList.jsp">숙소심사</a></li>
            <li><a class="dropdown-item" href="/BeeNb/emp/themeList.jsp">테마관리</a></li>
            <li><a class="dropdown-item" href="/BeeNb/emp/vocList.jsp">VOC관리</a></li>
            <%
            	if(loginEmp!=null){
            %>
		            <hr>
		            <li><a class="dropdown-item" href="/BeeNb/emp/empLogoutAction.jsp">로그아웃</a></li>
            <%		
            	}
            %>
          </ul>
        </li>
      </div>
    </div>
  </div>
</nav>