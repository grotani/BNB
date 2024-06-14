package beeNb.dao;

import java.sql.*;
import java.util.*;

public class BookingListDAO {
	
	// 설명 : 숙소삭제를 위해 예약목록을 있는지 조회.
	// booking_state가 '전'인 것만 조회
	// 호출 : empRoomDeleteAction.jsp, customerRoomDeleteAction.jsp
	// return :
	public static int selectBookingList(int roomNo) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql ="SELECT * FROM booking WHERE booking_state = '전' AND room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		System.out.println("stmt : " + stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = 1;
		}
		
		return row;
	}
	
	// 설명 : 해당 bookingNo의 예약 일자 리스트를 가져오는 메서드
	// 호출 : /customer/hostBookingDeleteAction.jsp
	// return : ArrayList<String> (roomDate list)
	public static ArrayList<HashMap<String, Object>> selectRoomDateListOfBookingNo(int bookingNo) throws Exception{
		ArrayList<HashMap<String, Object>> roomDateListOfBookingNo = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 bookingNo의 예약일자(roomDate) SELECT
		String sql = "SELECT room_date AS roomDate, room_no AS roomNo"
				+ " FROM booking_list"
				+ " WHERE booking_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomNo", rs.getInt("roomNo"));
			m.put("roomDate", rs.getString("roomDate"));
			roomDateListOfBookingNo.add(m);
		}
		
		conn.close();
		return roomDateListOfBookingNo;
	}
	
	// 설명 : 예약시 해당 bookingNo에 대한 값(해당 roomNo, roomDate) booking_list에 INSERT
	// 호출 : roomBookingAction.jsp
	// return : int
	public static int insertBookingList(int roomNo, int bookingNo, String[] roomDate) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO booking_list(booking_no, room_no, room_date) VALUES(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// roomDate 개수만큼 반복문 실행
		for(int i = 0; i < roomDate.length; i++) {
			stmt.setInt(1, bookingNo);
			stmt.setInt(2, roomNo);
			stmt.setString(3, roomDate[i]);
			// 실행된 쿼리 수 계산
			row += stmt.executeUpdate();
		}
		
		conn.close();
		return row;
	}
	
	// 설명 : 해당 bookingNo의 퇴실일 구하기
	// 호출 : hostBookingList.jsp
	// return : String
	public static String selectEndDate(int bookingNo) throws Exception{
		String endDate = "";
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT MAX(room_date) endDate FROM booking_list WHERE booking_no = ? GROUP BY booking_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endDate = rs.getString("endDate");
		}
		
		conn.close();
		return endDate;
				
		
	}
	
	// 설명 : 해당 bookingNo의 입실일 구하기
	// 호출 : hostBookingList.jsp
	// return : String
	public static String selectStartDate(int bookingNo) throws Exception{
		String startDate = "";
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT MIN(room_date) startDate FROM booking_list WHERE booking_no = ? GROUP BY booking_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			startDate = rs.getString("startDate");
		}
		
		conn.close();
		return startDate;
				
		
	}
}
