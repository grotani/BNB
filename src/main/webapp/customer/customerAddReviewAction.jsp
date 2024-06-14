<%@page import="beeNb.dao.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="beeNb.dao.ReviewDAO"%>
<%@page import="beeNb.dao.ComplainDAO"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="beeNb.dao.RoomImgDAO"%>
<%@page import="beeNb.dao.RoomDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Collection"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<%
	System.out.println("=====.jsp=====");

	int bookingNo = Integer.parseInt(request.getParameter("bookingNo"));
	String rating = request.getParameter("rating");
	String reviewContent = request.getParameter("reviewContent");

	System.out.println("bookingNo : " + bookingNo);
	System.out.println("rating : " + rating);
	System.out.println("reviewContent : " + reviewContent);

	HashMap<String, Object> paramMap = new HashMap<>();

	paramMap.put("bookingNo", bookingNo);
	paramMap.put("rating", rating);
	paramMap.put("reviewContent", reviewContent);

	int row = ReviewDAO.insertReview(paramMap);

	if(row <= 0){
		String errMsg = URLEncoder.encode("리뷰 등록 실패", "utf-8");
		response.sendRedirect("/BeeNb/customer/customerAddReviewForm.jsp?errMsg="+errMsg);
		System.out.println("리뷰 등록 실패!!!");
		return;
	}else{
		row = BookingDAO.updateBookingState(bookingNo);
	}
	response.sendRedirect("/BeeNb/customer/customerBookingList.jsp");
	
%>