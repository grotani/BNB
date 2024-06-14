package beeNb.dao;

import java.sql.*;
import java.util.*;

public class OneDayPriceDAO {
	// 설명 : 해당 숙소의 가격 조회(매 일마다 책정된 모든 금액)]
	// 호출 : hostRoomOne.jsp
	// return : ArrayList<HashMap<String, Object>> oneDayPriceList
	public static ArrayList<HashMap<String, Object>> selectOneDayPriceList(int roomNo) throws Exception{
		ArrayList<HashMap<String, Object>> oneDayPriceList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 roomNo를 조건으로 onedayPrice의 데이터 SELECT 
		String sql = "SELECT room_date AS roomDate, room_price AS roomPrice, room_state AS roomState, create_date AS createDate, update_date AS updateDate"
				+ " FROM oneday_price"
				+ " WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomDate", rs.getString("roomDate"));
			m.put("roomPrice", rs.getString("roomPrice"));
			m.put("roomState", rs.getString("roomState"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			oneDayPriceList.add(m);
		}
		
		conn.close();
		return oneDayPriceList;
	}
	
	// 설명 : 해당 숙소의 해당 날짜에 가격 등록
	// 호출 : addOneDayPriceAction.jsp
	// return : int (등록 성공시 등록 개수만큼, 실패시 0)
	public static int insertOneDayPrice(int roomNo, String[] roomDate, int roomPrice) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// oneday_price 테이블에 INSERT 쿼리
		String sql = "INSERT INTO oneday_price(room_no, room_date, room_price) VALUES(?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		// roomDate의 개수만큼 INSERT 쿼리 반복실행
		for(int i = 0; i < roomDate.length; i++) {
			stmt.setInt(1, roomNo);
			stmt.setString(2, roomDate[i]);
			stmt.setInt(3, roomPrice);
			// 실행된 쿼리 수 계산
			row += stmt.executeUpdate();
		}
		
		conn.close();
		return row;
	}
	
	// 설명 : 해당 숙소의 해당 날짜에 등록된 가격 삭제
	// 호출 : hostRoomOne.jsp
	// return : int (삭제시 1, 실패시 0)
	public static int deleteOneDayPrice(int roomNo, String roomDate) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// oneday_price 테이블에 DELETE쿼리
		String sql = "DELETE FROM oneday_price WHERE room_no = ? AND room_date = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		stmt.setString(2, roomDate);
		
		row = stmt.executeUpdate();		
		
		conn.close();
		return row;
	}
	
	// 설명 : 예약 취소 시 room_state 예약 가능 상태로 변경
	// 호출 : hostBookingDeleteAction.jsp
	// return : int
	public static int updateOneDayPriceState(int roomNo, ArrayList<String> roomDate) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 숙소의 해당 날짜의 roomState를 예약 가능으로 변경
		String sql = "UPDATE oneday_price SET room_state = '예약 가능' WHERE room_no = ? AND room_date = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// roomDate 개수만큼 반복문 실행
		for(int i = 0; i < roomDate.size(); i++) {
			stmt.setInt(1, roomNo);
			stmt.setString(2, roomDate.get(i));
			// 실행된 쿼리 수 계산
			row += stmt.executeUpdate();
		}
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
		
	}
	
	// 설명 : 예약하면 state도 바꿔주고 또 뭐더라
	// 호출 : roomBookingAction.jsp
	// return int
	public static int updateOneDayPrice(int roomNo, String[] roomDateArr) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE oneday_price SET room_state = '예약 완료' WHERE room_no = ? AND room_date = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		for(String roomDate : roomDateArr) {
			stmt.setInt(1, roomNo);
			stmt.setString(2, roomDate);
			// 실행된 쿼리 수 계산
			row += stmt.executeUpdate();
		}
		return row;
	}
	
	// 설명 : 예약(결제)시 최종 결제 금액 get
	// 호출 : roomBookingAction.jsp
	// return : int
	public static int selectTotalPrice(int roomNo, String[] roomDate) throws Exception {
		int totalPrice = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT room_price FROM oneday_price WHERE room_no = ? AND room_date = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = null;
		for(int i = 0; i < roomDate.length; i++) {
			stmt.setInt(1, roomNo);
			stmt.setString(2, roomDate[i]);
			rs = stmt.executeQuery();
			if(rs.next()) {
				totalPrice += rs.getInt("room_price");
			}
		}
		
		conn.close();
		return totalPrice;
	}
}
