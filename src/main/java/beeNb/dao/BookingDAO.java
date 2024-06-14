package beeNb.dao;

import java.sql.*;
import java.util.*;

public class BookingDAO {
	// 설명 : 고객의 사용 전 예약 리스트 
	// 호출 : /customer/customerBookingList.jsp
	// return : ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectBeforeList(String customerId) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT a.booking_no bookingNo, a.customer_id customerId, r.room_name roomName, "
				+ "r.room_address roomAddress, a.booking_state bookingState, a.create_date createDate, a.startRoomDate, a.endRoomDate "
				+ "FROM (SELECT b.room_no, b.booking_no, b.booking_state, b.customer_id, b.create_date, "
				+ "MIN(bl.room_date) startRoomDate, MAX(bl.room_date) endRoomDate "
				+ "FROM booking b INNER JOIN booking_list bl "
				+ "ON b.booking_no = bl.booking_no "
				+ "WHERE b.booking_state IN ('전') AND b.customer_id = ? "
				+ "GROUP BY b.booking_no, b.booking_state, b.customer_id, b.room_no) a INNER JOIN room r "
				+ "ON a.room_no = r.room_no "
				+ "ORDER BY bookingNo asc ";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		
		//디버깅 코드
		System.out.println("stmt : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("bookingNo",rs.getInt("bookingNo"));
			m.put("customerId",rs.getString("customerId"));
			m.put("roomName",rs.getString("roomName"));
			m.put("roomAddress",rs.getString("roomAddress"));
			m.put("bookingState",rs.getString("bookingState"));
			m.put("createDate",rs.getString("createDate"));
			m.put("startRoomDate",rs.getString("startRoomDate"));
			m.put("endRoomDate",rs.getString("endRoomDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	// 설명 : 고객의 사용 후 예약 리스트 
	// 호출 : /customer/customerBookingList.jsp
	// return : ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectAfterList(String customerId, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT a.booking_no bookingNo, a.customer_id customerId, r.room_name roomName, "
				+ "r.room_address roomAddress, a.booking_state bookingState, a.create_date createDate, a.startRoomDate, a.endRoomDate "
				+ "FROM (SELECT b.room_no, b.booking_no, b.booking_state, b.customer_id, b.create_date, "
				+ "MIN(bl.room_date) startRoomDate, MAX(bl.room_date) endRoomDate "
				+ "FROM booking b INNER JOIN booking_list bl "
				+ "ON b.booking_no = bl.booking_no "
				+ "WHERE b.booking_state IN ('후','리뷰완료') AND b.customer_id = ? "
				+ "GROUP BY b.booking_no, b.booking_state, b.customer_id, b.room_no) a INNER JOIN room r "
				+ "ON a.room_no = r.room_no "
				+ "ORDER BY bookingNo asc "
				+ "LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		//디버깅 코드
		System.out.println("stmt : " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("bookingNo",rs.getInt("bookingNo"));
			m.put("customerId",rs.getString("customerId"));
			m.put("roomName",rs.getString("roomName"));
			m.put("roomAddress",rs.getString("roomAddress"));
			m.put("bookingState",rs.getString("bookingState"));
			m.put("createDate",rs.getString("createDate"));
			m.put("startRoomDate",rs.getString("startRoomDate"));
			m.put("endRoomDate",rs.getString("endRoomDate"));
			list.add(m);
		}
		
		conn.close();
		return list;
	}
	// 설명 : 고객의 사용 후 예약 리스트 행의 총 개수
	// 호출 : /customer/customerBookingList.jsp
	// return : int
	public static int selectAfterBookingListCnt(String customerId) throws Exception {
		int total = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT COUNT(*) cnt "
				+ "FROM(SELECT b.room_no, b.booking_no, b.booking_state, b.customer_id, b.create_date, "
				+ "MIN(bl.room_date) startRoomDate, MAX(bl.room_date) endRoomDate "
				+ "FROM booking b INNER JOIN booking_list bl "
				+ "ON b.booking_no = bl.booking_no "
				+ "WHERE b.booking_state IN ('후','리뷰완료') AND b.customer_id = ? "
				+ "GROUP BY b.booking_no, b.booking_state, b.customer_id, b.room_no) a INNER JOIN room r "
				+ "ON a.room_no = r.room_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		//디버깅 코드
		System.out.println("stmt: " + stmt);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			total = rs.getInt("cnt");
		}
		
		conn.close();
		return total;
	}
	// 설명 : 고객이 이용 전 예약 취소 기능
	// 호출 : /customer/customerBookingList.jsp
	// return : int
	public static int deleteBooking(int bookingNo, String customerId) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE booking, booking_list "
				+ "FROM booking "
				+ "INNER JOIN booking_list ON booking.booking_no = booking_list.booking_no "
				+ "WHERE booking.customer_id = ? "
				+ "AND booking.booking_state = '전' "
				+ "AND booking.booking_no = ? "
				+ "AND DATEDIFF(booking_list.room_date, CURDATE()) > 3";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		stmt.setInt(2, bookingNo);
		
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
	
		conn.close();
		return row;
	}
	
	// 설명 : 호스트가 호스팅한 숙소의 예약을 조회하는 페이지(hostBookingList.jsp)의 페이징 기능을 위한 전체 행 개수 구하기
	// 호출 : hostBookingList.jsp
	// return : int(해당 숙소의 예약 개수)
	public static int selectHostBookingListCnt(String customerId, String roomName) throws Exception{
		int cnt = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 숙소의 예약 개수 SELECT
		String sql = "SELECT COUNT(*) AS cnt"
				+ " FROM booking b"
				+ " INNER JOIN room r"
				+ " ON b.room_no = r.room_no"
				+ " WHERE r.customer_id = ?";
		
		// roomName에 따른 분기 발생으로 인해 stmt 먼저 생성
		PreparedStatement stmt = null;
		
		// 예약리스트 전체 조회시
		if(roomName.equals("all")) {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
		} else {
			// roomName이 있는 경우(select박스로 숙소별로 예약 리스트 조회시)
			sql = sql + " AND r.room_name = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setString(2, roomName);
		}
		
		ResultSet rs = stmt.executeQuery();
		
		// 해당 숙소의 예약(booking)이 있다면
		if(rs.next()) {
			// 예약 개수 cnt에 담기
			cnt = rs.getInt("cnt");
		}
		
		conn.close();
		return cnt;
	}
	
	// 설명 : 호스트가 호스팅한 숙소의 예약을 조회
	// 호출 : hostBookingList.jsp
	// return : int(해당 숙소의 예약 개수)
	public static ArrayList<HashMap<String, Object>> selectHostBookingList(String customerId, String roomName, int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> hostBookingList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 숙소의 예약 목록 SELECT
		String sql = "SELECT b.booking_no AS bookingNo, b.customer_id AS customerId, c.customer_name AS customerName, b.booking_state AS bookingState,"
				+ " b.use_people AS usePeople, b.create_date AS createDate, b.update_date AS updateDate, r.room_name AS roomName "
				+ " FROM booking b"
				+ " INNER JOIN room r"
				+ " ON b.room_no = r.room_no"
				+ " INNER JOIN customer c"
				+ " ON b.customer_id = c.customer_id"
				+ " WHERE r.customer_id = ?";
		
		// roomName에 따른 분기 발생으로 인해 stmt 먼저 생성
		PreparedStatement stmt = null;
		
		// 예약리스트 전체 조회시
		if(roomName.equals("all")) {
			sql = sql + " ORDER BY b.create_date DESC, bookingNo DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
		} else {
			// roomName이 있는 경우(select박스로 숙소별로 예약 리스트 조회시)
			sql = sql + " AND r.room_name = ?"
					+ " ORDER BY b.create_date DESC, bookingNo DESC"
					+ "	LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerId);
			stmt.setString(2, roomName);
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
			
		}
		
		
		ResultSet rs = stmt.executeQuery();
		
		// 해당 숙소의 목록 list에 담기
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("bookingNo", rs.getInt("bookingNo"));
			m.put("roomName", rs.getString("roomName"));
			m.put("customerId", rs.getString("customerId"));
			m.put("customerName", rs.getString("customerName"));
			m.put("bookingState", rs.getString("bookingState"));
			m.put("usePeople", rs.getInt("usePeople"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			hostBookingList.add(m);
		}
		
		conn.close();
		return hostBookingList;
	}
	// 설명 : 고객(게스트) 탈퇴 전 이용 전 예약 내역이 있는지 확인
	// 호출 : /customer/customerDropCheckPwForm.jsp
	// 리턴값 : boolean (false면 예약내역 존재, true면 예약내역 미존재)
	public static boolean selectBeforeBookingById(String customerId) throws Exception {
		boolean result  = true;
	
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT * "
				+ "FROM customer c INNER JOIN booking b "
				+ "ON c.customer_id = b.customer_id "
				+ "WHERE c.customer_id = ? AND b.booking_state = '전'";
						
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		// 디버깅코드
		System.out.println("stmt :" + stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = false;
		}
		
		conn.close();
		return result;
	}
	
	// 설명 : 호스트가 고객의 에약을 취소하는 기능
	// 호출 : /customer/hostBookingList.jsp
	// return : int
	public static int deleteBookingByHost(int bookingNo) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "DELETE booking"
				+ " FROM booking"
				+ " WHERE booking_no = ? AND booking_state = '전'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);
		
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
	
		conn.close();
		return row;
	}
	
	// 설명 : 리뷰 쓰면 이용 완료하는 거
	// 호출 : /customer/customerAddReviewAction
	// return int
	public static int updateBookingState(int bookingNo) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE booking SET booking_state = '리뷰완료' WHERE booking_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// 설명 : 그...예약 등록
	// 호출 : roomBookingAction.jsp
	// return int
	/* 
	 */
	public static int insertBooking(String customerId, int usePeople, int roomNo) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO booking (customer_id, booking_state, use_people, create_date, update_date, room_no) VALUES (?, '전', ?, now(), now(), ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);		
		stmt.setInt(2, usePeople);		
		stmt.setInt(3, roomNo);		
		row = stmt.executeUpdate();
		conn.close();
		
		return row;
	}
	
	// 설명 : 호스트가 (고객의 이용이 끝났을 때)이용완료 버튼을 눌러서 bookingState를 변경해주는 메서드
	// 호출 : /customer/hostBookingUpdateAction.jsp
	// return : int
	public static int updateBookingState(int bookingNo, String state) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		// 해당 booking_no의 state를 변경(ex. 이용 후)
		String sql = "UPDATE booking SET booking_state = ? WHERE booking_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, state);
		stmt.setInt(2, bookingNo);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	}
	
	// 설명 : 예약시 booking_list에 INSERT하기 위해 bookingNo 가져오는 메서드
	// 호출 : roomBookingAction.jsp
	// return : int
	public static int selectBookingNo(String customerId, int roomNo) throws Exception{
		int bookingNo = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT booking_no bookingNo FROM booking WHERE customer_id = ? AND room_no = ? ORDER BY create_date DESC LIMIT 0,1";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setInt(2, roomNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) { 
			bookingNo = rs.getInt("bookingNo");
		}
		
		conn.close();
		return bookingNo;
	}
}
