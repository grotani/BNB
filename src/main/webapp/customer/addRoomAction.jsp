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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 사용자 인증 코드 -->
<%@ include file="/customer/inc/customerSessionIsNull.jsp"%>
<%
	System.out.println("=====addRoomAction.jsp=====");
	System.out.println("loginCustomer : " + loginCustomer);
	String customerId = ""+loginCustomer.get("customerId");
	System.out.println("customerId : " + customerId);
	
	/*
		room tbl
			roomName
			roomCategory
			roomTheme
			roomAddress
			roomContent
			operationStart
			operationEnd
			maxPeople
	*/
	String roomName = request.getParameter("roomName");
	String roomCategory = request.getParameter("roomCategory");
	String roomTheme = request.getParameter("roomTheme");
	String roomAddress = request.getParameter("roomAddress");
	String roomContent = request.getParameter("roomContent");
	String operationStart = request.getParameter("operationStart");
	String operationEnd = request.getParameter("operationEnd");
	String maxPeople = request.getParameter("maxPeople");
	
	System.out.println("roomName : " + roomName);
	System.out.println("roomCategory : " + roomCategory);
	System.out.println("roomTheme : " + roomTheme);
	System.out.println("roomAddress : " + roomAddress);
	System.out.println("roomContent : " + roomContent);
	System.out.println("operationStart : " + operationStart);
	System.out.println("operationEnd : " + operationEnd);
	System.out.println("maxPeople : " + maxPeople);
	
	HashMap<String, Object> roomParamMap = new HashMap<>();

	roomParamMap.put("roomCategory", roomCategory);
	roomParamMap.put("roomName", roomName);
	roomParamMap.put("roomTheme", roomTheme);
	roomParamMap.put("roomAddress", roomAddress);
	roomParamMap.put("roomContent", roomContent);
	roomParamMap.put("operationStart", operationStart);
	roomParamMap.put("operationEnd", operationEnd);
	roomParamMap.put("maxPeople", maxPeople);
	roomParamMap.put("customerId", customerId);
	
	
	int row = RoomDAO.insertRoom(roomParamMap);
	int roomNo = 0;
	if(row > 0){
		//room 데이터를 추가한 이후
		roomNo = RoomDAO.selectRoomById(customerId);
		System.out.println("roomNo : " + roomNo);
	}else{
		String errMsg = URLEncoder.encode("숙소 데이터 등록 실패", "utf-8");
		response.sendRedirect("/BeeNb/emp/addRoomForm.jsp?errMsg="+errMsg);
		System.out.println("숙소 데이터 등록 실패!!!");
		return;
	}
	

	/*
		room_option tbl
			wifi
			kitshenTools
			parking
			bed
			ott
			ev
	*/
	
	String wifi = request.getParameter("wifi");
	String kitshenTools = request.getParameter("kitshenTools");
	String parking = request.getParameter("parking");
	String bed = request.getParameter("bed");
	String ott = request.getParameter("ott");
	String ev = request.getParameter("ev");
	
	System.out.println("wifi : " + wifi);
	System.out.println("kitshenTools : " + kitshenTools);
	System.out.println("parking : " + parking);
	System.out.println("bed : " + bed);
	System.out.println("ott : " + ott);
	System.out.println("ev : " + ev);
	
	HashMap<String, Object> roomOptionParamMap = new HashMap<>();
	roomOptionParamMap.put("wifi", wifi);
	roomOptionParamMap.put("kitshenTools", kitshenTools);
	roomOptionParamMap.put("parking", parking);
	roomOptionParamMap.put("bed", bed);
	roomOptionParamMap.put("ott", ott);
	roomOptionParamMap.put("ev", ev);
	roomOptionParamMap.put("roomNo", roomNo);
	
	
	if(roomNo != 0){
		//room_no를 얻은 이후
		row = RoomDAO.insertRoomOption(roomOptionParamMap);
		if(row == 0){
			System.out.println("숙소 옵션 데이터 등록 실패!!!");
			String errMsg = URLEncoder.encode("숙소 상세 옵션 데이터 등록 실패", "utf-8");
			response.sendRedirect("/BeeNb/emp/addRoomForm.jsp?errMsg="+errMsg);
			return;					
		}
	}else {
		System.out.println("숙소 데이터 아이디값으로 조회되지 않음!!!");
		String errMsg = URLEncoder.encode("숙소 상세 옵션 데이터 등록 실패", "utf-8");
		response.sendRedirect("/BeeNb/emp/addRoomForm.jsp?errMsg="+errMsg);
		return;		
	}

	// 이미지 파일 파라미터 파싱
	Collection<Part> parts = request.getParts();
	ArrayList<HashMap<String, Object>> imgList = new ArrayList<>();
	for(Part part : parts){
		HashMap<String, Object> m = new HashMap<>();
		if(part.getName().equals("file")){
			String getName = part.getName();
	 		String oriName = part.getSubmittedFileName();
			int dotIdx = oriName.lastIndexOf(".");
			String exe = oriName.substring(dotIdx);
			UUID uuid = UUID.randomUUID();
			String filename = uuid.toString().replace("-", "");
			filename = filename + exe;

			System.out.println("getName : " + getName);
			System.out.println("oriName : " + oriName);
			System.out.println("dotIdx : " + dotIdx);
			System.out.println("exe : " + exe);
			System.out.println("uuid : " + uuid);
			System.out.println("filename : " + filename);
			
			m.put("filename", filename);
			m.put("roomNo", roomNo);
			m.put("part", part);
			imgList.add(m);
		};
	}
	System.out.println("imgList : " + imgList);
	if(!imgList.isEmpty()){
		RoomImgDAO.insertRoomImg(imgList);
		for(HashMap<String, Object> m : imgList){
			Part part = (Part)m.get("part");
			InputStream inputStream = part.getInputStream(); // part객체안에 파일(바이너리)을 메모로리 불러 옴
			String filePath = request.getServletContext().getRealPath("upload");
			File f = new File(filePath, ""+m.get("filename"));
			OutputStream outputStream = Files.newOutputStream(f.toPath()); // os + file
			inputStream.transferTo(outputStream);	
			outputStream.close();
			inputStream.close();
		}
	}
	response.sendRedirect("/BeeNb/customer/hostRoomList.jsp");
	
%>