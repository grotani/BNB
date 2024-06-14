package beeNb.dao;

import java.sql.*;
import java.util.*;

public class RevenueDAO {
	// 설명 : revenue_status테이블의 전체 행 개수 구하는 메서드(revenue_status 리스트 출력 시 페이징하기 위해)
	// 호출 : BeeNb/emp/revenueList.jsp
	// return : int (revenue_status 테이블 행 개수)
	public static int selectRevenueListCnt() throws Exception {
		int cnt = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT COUNT(*) cnt FROM revenue_status";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		
		conn.close();
		return cnt;
		
	}
	
	// 설명 : revenue_status테이블에서 전체 revenue_status를 출력(페이징 포함)
	// 호출 : BeeNb/emp/revenueList.jsp
	// return : ArrayList<HashMap<String, Object>> (revenue_status테이블에서 SELECT 조회 값)
	public static ArrayList<HashMap<String, Object>> selectRevenueList() throws Exception {
		ArrayList<HashMap<String, Object>> revenueList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT booking_no AS bookingNo, revenue, create_date AS createDate FROM revenue_status ORDER BY createDate DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("bookingNo", rs.getInt("bookingNo"));
			m.put("revenue", rs.getInt("revenue"));
			m.put("createDate", rs.getString("createDate"));
			revenueList.add(m);
		}
		
		conn.close();
		return revenueList;
		
	}
	
	// 설명 : 전체 수익 계산 메서드
	// 호출 : /emp/revenueList.jsp
	// return : int(수익)
	public static int selectTotalRevenue() throws Exception {
		int totalRevenue = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT SUM(revenue) AS total_revenue FROM revenue_status;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			totalRevenue = rs.getInt("total_revenue");
		}
		
		conn.close();
		return totalRevenue;
		
	}
	
	// 설명 : 예약(결제)시 최종 금액 revenue테이블에 INSERT
	// 호출 : roomBookingAction.jsp
	// return : int
	public static int insertRevenue(int bookingNo, int revenue) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO revenue_status(booking_no, revenue) VALUES(?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, bookingNo);
		stmt.setInt(2, revenue);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
}
