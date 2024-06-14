package beeNb.dao;

import java.sql.*;
import java.util.*;

public class ComplainDAO {
	// 설명 : complainlist 보여주기
	// 호출 : customerComplainList.jsp
	// return : ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String, Object>> selectComplainList(String customerId) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT  b.booking_no bookingNo, c.complain_no complainNo, c.complain_type complainType, "
				+ "c.complain_content complainContent, c.complain_state complainState, c.complain_answer complainAnswer, "
				+ "c.create_date createDate, c.update_date updateDate " + "FROM complain c INNER JOIN booking b "
				+ "ON c.booking_no = b.booking_no " + "WHERE b.customer_id = ? " + "ORDER BY b.create_date";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		// 디버깅코드
		System.out.println("stmt:" + stmt);

		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("bookingNo", rs.getInt("bookingNo"));
			m.put("complainNo", rs.getInt("complainNo"));
			m.put("complainType", rs.getString("complainType"));
			m.put("complainContent", rs.getString("complainContent"));
			m.put("complainState", rs.getString("complainState"));
			m.put("complainAnswer", rs.getString("complainAnswer"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			list.add(m);
		}

		conn.close();
		return list;
	}

	// 설명 : complain 상세보기
	// 호출 : customerComplainOne.jsp
	// return : <HashMap<String,Object>>
	public static HashMap<String, Object> selectComplainOne(String complainNo) throws Exception {
		HashMap<String, Object> map = null;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT  b.booking_no bookingNo, c.complain_no complainNo, c.complain_type complainType, "
				+ "c.complain_content complainContent, c.complain_state complainState, c.complain_answer complainAnswer, "
				+ "c.create_date createDate, c.update_date updateDate FROM complain c INNER JOIN booking b "
				+ "ON c.booking_no = b.booking_no " + "WHERE c.complain_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, complainNo);
		// 디버깅코드
		System.out.println("stmt:" + stmt);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			map = new HashMap<String, Object>();
			map.put("complainNo", rs.getInt("complainNo"));
			map.put("bookingNo", rs.getInt("bookingNo"));
			map.put("complainType", rs.getString("complainType"));
			map.put("complainState", rs.getString("complainState"));
			map.put("complainAnswer", rs.getString("complainAnswer"));
			map.put("createDate", rs.getString("createDate"));
			map.put("updateDate", rs.getString("updateDate"));
		}

		conn.close();
		return map;
	}

	// 설명 : complain 상세보기
	// 호출 : customerComplainOne.jsp
	// return : <HashMap<String,String>>
	public static HashMap<String, String> selectVocOne(String complainNo) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT  c.complain_no complainNo, c.complain_type complainType,"
				+ "c.complain_content complainContent, c.complain_state complainState, c.complain_answer complainAnswer, "
				+ "c.create_date createDate, c.update_date updateDate FROM complain c " 
				+ "WHERE c.complain_no = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, complainNo);
		// 디버깅코드
		System.out.println("stmt:" + stmt);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			map.put("complainNo", rs.getString("complainNo"));
			map.put("complainType", rs.getString("complainType"));
			map.put("complainContent", rs.getString("complainContent"));
			map.put("complainState", rs.getString("complainState"));
			map.put("complainAnswer", rs.getString("complainAnswer"));
			map.put("createDate", rs.getString("createDate"));
			map.put("updateDate", rs.getString("updateDate"));
		}
		conn.close();
		return map;
	}

	// 설명 : complainList 개수
	// 호출 : empComplainList.jsp
	// return : ArrayList<HashMap<String,Object>>
	public static int selectEmpComplainListCnt(String complainState) throws Exception {
		int cnt = 0;

		Connection conn = DBHelper.getConnection();
		String sql = "SELECT " + "count(*) cnt " + "FROM complain c " + "WHERE 1=1 ";

		// complainState에 따른 분기 발생으로 인해 stmt 먼저 생성
		PreparedStatement stmt = null;

		// 예약리스트 전체 조회시
		if (complainState.equals("all")) {
			stmt = conn.prepareStatement(sql);
		} else {
			// complainState이 있는 경우(select박스로 숙소별로 예약 리스트 조회시)
			sql = sql + " AND c.complain_state = ? ";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, complainState);
		}

		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			cnt = rs.getInt("cnt");
		}

		conn.close();
		return cnt;
	}

	// 설명 : vocList 조회
	// 호출 : vocList.jsp
	// return : ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectVOCList(String complainState, int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> vocList = new ArrayList<>();

		Connection conn = DBHelper.getConnection();

		String sql = "SELECT " + "c.complain_no complainNo, " + "c.complain_type complainType, "
				+ "c.complain_content complainContent, " + "c.complain_state complainState, "
				+ "c.complain_answer complainAnswer, " + "c.create_date createDate, " + "c.update_date updateDate "
				+ "FROM complain c " + "WHERE 1=1 ";

		// complain_state에 따른 분기 발생으로 인해 stmt 먼저 생성
		PreparedStatement stmt = null;

		if (complainState.equals("all")) {
			sql = sql + " ORDER BY c.create_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		} else {
			// complain_state이 있는 경우
			sql = sql + " AND c.complain_state = ?" + " ORDER BY c.create_date DESC" + "	LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, complainState);
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);

		}

		ResultSet rs = stmt.executeQuery();

		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("complainNo", rs.getInt("complainNo"));
			m.put("complainType", rs.getString("complainType"));
			m.put("complainContent", rs.getString("complainContent"));
			m.put("complainState", rs.getString("complainState"));
			m.put("complainAnswer", rs.getString("complainAnswer"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			vocList.add(m);
		}

		conn.close();
		return vocList;
	}

	// 설명 : 민원 상태 업데이트
	// 호출 : /BeeNb/emp/updateVocState.jsp
	// return : int (업데이트 성공시 1)
	public static int updateVoc(int complainNo, String complainState, String complainAnswer) throws Exception {
		System.out.println("11");
		int row = 0;
		Connection conn = DBHelper.getConnection();

		String sql = "";
		PreparedStatement stmt = null;
		if (complainState.equals("처리중")) {
			sql = "UPDATE complain SET complain_state = ? WHERE complain_no = ?";
			System.out.println("11");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, complainState);
			stmt.setInt(2, complainNo);
		} else if (complainState.equals("처리완료")) {
			System.out.println("22");
			sql = "UPDATE complain SET complain_state = ?, complain_answer = ? WHERE complain_no = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, complainState);
			stmt.setString(2, complainAnswer);
			stmt.setInt(3, complainNo);
		}
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		row = stmt.executeUpdate();
		// 자원반납
		conn.close();
		return row;
	}

	// 설명 : 리뷰 등록
	// 호출 : customerComplainBookingAction.jsp
	// return int
	public static int insertComplain(HashMap<String, Object> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO " + "Complain (" + "complain_no" + ", complain_type" + ", complain_content"
				+ ", complain_state" + ", complain_answer" + ", create_date" + ", update_date" + ", booking_no"
				+ ") VALUES " + "(null, ?, ?, '접수', null, now(), now(), ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "" + map.get("complainType"));
		stmt.setString(2, "" + map.get("complainContent"));
		stmt.setString(3, "" + map.get("bookingNo"));
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	
	// 설명 : 신고내역 상태 가져오기
	// 호출 : customerBookingList.jsp
	// return : HashMap()
	public static HashMap<String,Object> selectcomplainStateOne (String customerId, int bookingNo) throws Exception{
		HashMap<String, Object> m = new HashMap<String,Object>();
		Connection conn = DBHelper.getConnection();
		String sql="SELECT cp.complain_state complainState, b.booking_no bookingNo"
				+ " FROM booking b LEFT JOIN complain cp"
				+ " ON b.booking_no = cp.booking_no"
				+ " WHERE b.customer_id = ? AND cp.booking_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		stmt.setInt(2,bookingNo);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			m.put("complainState", rs.getString("complainState"));
			m.put("bookingNo", rs.getInt("bookingNo"));
		}
		conn.close();
		return m;
		
	}
}
