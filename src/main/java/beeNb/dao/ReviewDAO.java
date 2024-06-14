package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class ReviewDAO {
	// 설명 : 해당 숙소의 리뷰 개수 조회(페이징 하기 위해서)
	// 호출 : hostRoomOne.jsp
	// return : int (리뷰 개수)
	public static int selectHostRoomReviewListCnt(int roomNo) throws Exception{
		// 해당 숙소의 리뷰 개수
		int cnt = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// 리뷰 조회(review 테이블, booking 테이블, room 테이블 총 3개 테이블을 JOIN)
		String sql = "SELECT COUNT(*) AS cnt"
				+ " FROM review r"
				+ " INNER JOIN booking b"
				+ " ON r.booking_no = b.booking_no"
				+ " INNER JOIN room hr"
				+ " ON b.room_no = hr.room_no";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		
		conn.close();
		return cnt;
	}
	
	// 설명 : 해당 숙소의 리뷰 조회
	// 호출 : hostRoomOne.jsp
	// return : int (리뷰 개수)
	public static ArrayList<HashMap<String, Object>> selectHostRoomReviewList(int roomNo, int startRow, int rowPerPage) throws Exception{
		// 해당 숙소 리뷰 목록
		ArrayList<HashMap<String, Object>> reviewList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 리뷰 조회(review 테이블, booking 테이블, room 테이블 총 3개 테이블을 JOIN)
		String sql = "SELECT r.booking_no AS bookingNo, r.rating AS rating, r.review_content AS reviewContent, r.create_date AS createDate, b.customer_id AS customerId"
				+ " FROM review r"
				+ " INNER JOIN booking b"
				+ " ON r.booking_no = b.booking_no"
				+ " INNER JOIN room hr"
				+ " ON b.room_no = hr.room_no"
				+ " WHERE hr.room_no = ?"
				+ " ORDER BY createDate DESC"
				+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("bookingNo", rs.getInt("bookingNo"));
			m.put("rating", rs.getInt("rating"));
			m.put("reviewContent", rs.getString("reviewContent"));
			m.put("createDate", rs.getString("createDate"));
			m.put("customerId", rs.getString("customerId"));
			reviewList.add(m);
		}
		
		conn.close();
		return reviewList;
	}
	
	
	// 설명 : 리뷰 등록
	// 호출 : .jsp
	// return int
	public static int insertReview(HashMap<String, Object> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "Review ("
				+ "booking_no"
				+ ", rating"
				+ ", review_content"
				+ ", create_date"
				+ ") VALUES "
				+ "(?, ?, ?, now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ""+map.get("bookingNo"));
		stmt.setString(2, ""+map.get("rating"));
		stmt.setString(3, ""+map.get("reviewContent"));
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	
}
