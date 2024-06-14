package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class RoomDAO {
	// 설명 : room테이블에서 전체 room을 출력
	// 호출 : /emp/roomList.jsp, /customer/roomList.jsp
	// return : ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectRoomList(String theme) throws Exception {
		// SELECT 결과 값을 담을 List
		ArrayList<HashMap<String, Object>> RoomList = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
	    String sql = "SELECT r.room_no, r.customer_id, r.room_name, r.room_address, r.max_people, max(img.room_img) AS mimg"
                + " FROM room AS r"
                + " INNER JOIN room_img AS img"
                + " ON r.room_no = img.room_no";
	    // 테마가 있을 때만 sql에 추가해준다.
	    if (theme != null && !theme.isEmpty()) {
	        sql += " WHERE r.room_theme = ?";
	    }
	    // 무조건 추가된다.
	    sql += " GROUP BY img.room_no";

		PreparedStatement stmt = conn.prepareStatement(sql);
		// 테마가 있을 때만 ?에 param을 넣어준다.
	    if (theme != null && !theme.isEmpty()) {
	        stmt.setString(1, theme);
	    }
		ResultSet rs = stmt.executeQuery();
		System.out.println(stmt);
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("roomNo",rs.getInt("r.room_no"));
			m.put("customerId",rs.getString("r.customer_id"));
			m.put("roomName",rs.getString("r.room_name"));
			m.put("roomAddress",rs.getString("r.room_address"));
			m.put("maxPeople",rs.getInt("r.max_people"));
			m.put("roomImg",rs.getString("mimg"));
			RoomList.add(m);
		}
		
		conn.close();
		return RoomList;
	}

	
	// 설명 : 호스트가 호스팅한 숙소 목록 출력
	// 호출 : /customer/hostRoomList.jsp
	// return : ArrayList<HashMap<String, Object>> hostRoomList
	public static ArrayList<HashMap<String, Object>> selectHostRoomList(String customerId) throws Exception {
		// 해당 호스트의 숙소 목록을 담는 리스트
		ArrayList<HashMap<String, Object>> hostRoomList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// 해당 호스트의 아이디(customerId)에 해당하는 room 테이블의 room SELECT하는 쿼리
		String sql = "SELECT r.room_no AS roomNo, r.room_name AS roomName, r.room_address AS roomAddress, r.operation_start AS operationStart,"
				+ " r.operation_end AS operationEnd, r.room_category AS roomCategory, r.approve_state AS approveState, img.room_img AS roomImg"
				+ " FROM room AS r INNER JOIN room_img AS img"
				+ " ON r.room_no = img.room_no"
				+ " WHERE customer_id = ?"
				+ " GROUP BY r.room_no"
				+ " ORDER BY r.room_no DESC;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomNo", rs.getInt("roomNo"));
			m.put("roomName", rs.getString("roomName"));
			m.put("roomAddress", rs.getString("roomAddress"));
			m.put("approveState", rs.getString("approveState"));
			m.put("operationStart", rs.getString("operationStart"));
			m.put("operationEnd", rs.getString("operationEnd"));
			m.put("roomCategory", rs.getString("roomCategory"));
			m.put("roomImg", rs.getString("roomImg"));
			hostRoomList.add(m);
		}
		
		conn.close();
		return hostRoomList;
	}
	
	// 설명 : 호스트의 호스팅한 숙소 1개에 대한 상세 정보 조회
	// 호출 : /customer/hostRoomOne.jsp
	// return : HashMap<String, Object> hostRoomOne
	public static HashMap<String, Object> selectHostRoomOne(int roomNo) throws Exception{
		HashMap<String, Object> hostRoomOne = new HashMap<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT r.room_no AS roomNo, r.customer_id AS customerId, r.room_name AS roomName, r.room_theme AS roomTheme, r.room_address AS roomAddress,"
				+ " r.operation_start AS operationStart, r.operation_end AS operationEnd, r.max_people AS maxPeople, r.room_content AS roomContent,"
				+ " r.room_category AS roomCategory, r.approve_state AS approveState, r.create_date AS createDate, r.update_date AS updateDate, img.room_img AS roomImg"
				+ " FROM room AS r INNER JOIN room_img AS img"
				+ " ON r.room_no = img.room_no"
				+ " WHERE r.room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			hostRoomOne.put("roomNo", rs.getInt("roomNo"));
			hostRoomOne.put("customerId", rs.getString("customerId"));
			hostRoomOne.put("roomName", rs.getString("roomName"));
			hostRoomOne.put("roomTheme", rs.getString("roomTheme"));
			hostRoomOne.put("roomAddress", rs.getString("roomAddress"));
			hostRoomOne.put("operationStart", rs.getString("operationStart"));
			hostRoomOne.put("operationEnd", rs.getString("operationEnd"));
			hostRoomOne.put("maxPeople", rs.getInt("maxPeople"));
			hostRoomOne.put("roomContent", rs.getString("roomContent"));
			hostRoomOne.put("roomCategory", rs.getString("roomCategory"));
			hostRoomOne.put("approveState", rs.getString("approveState"));
			hostRoomOne.put("createDate", rs.getString("createDate"));
			hostRoomOne.put("updateDate", rs.getString("updateDate"));
			hostRoomOne.put("roomImg", rs.getString("roomImg"));
		}
		
		conn.close();
		return hostRoomOne;
	}
	
	// 설명 : 숙소 삭제
	// 호출 : empRoomDeleteAction.jsp, customerDeleteAction.jsp
	// return int
	public static int deleteRoom(int roomNo) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql="DELETE FROM room WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		return row;
	}
	
	// 설명 : 숙소 등록
	// 호출 : addRoomAction.jsp
	// return int
	public static int insertRoom(HashMap<String, Object> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "room ("
				+ "room_no"
				+ ", customer_id"
				+ ", room_name"
				+ ", room_theme"
				+ ", room_address"
				+ ", operation_start"
				+ ", operation_end"
				+ ", max_people"
				+ ", room_content"
				+ ", room_category"
				+ ", approve_state) VALUES "
				+ "(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, '미승인')";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ""+map.get("customerId"));
		stmt.setString(2, ""+map.get("roomName"));
		stmt.setString(3, ""+map.get("roomTheme"));
		stmt.setString(4, ""+map.get("roomAddress"));
		stmt.setString(5, ""+map.get("operationStart"));
		stmt.setString(6, ""+map.get("operationEnd"));
		stmt.setInt(7, Integer.parseInt(""+map.get("maxPeople")));
		stmt.setString(8, ""+map.get("roomContent"));
		stmt.setString(9, ""+map.get("roomCategory"));
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	// 설명 : 숙소 찾기 by ID
	// 호출 : addRoomAction.jsp
	// return int
	public static int selectRoomById(String customerId) throws Exception {
		int roomNo = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT room_no FROM room WHERE customer_id = ? ORDER BY room_no DESC LIMIT 0, 1";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			roomNo = rs.getInt("room_no");
		}
		return roomNo;
	}
	// 설명 : 숙소 등록
	// 호출 : addRoomAction.jsp
	// return int
	public static int insertRoomOption(HashMap<String, Object> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "room_option ("
				+ "room_no"
				+ ", wifi"
				+ ", kitchen_tools"
				+ ", parking"
				+ ", bed"
				+ ", ott"
				+ ", ev) VALUES "
				+ "(?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, Integer.parseInt(""+map.get("roomNo")));
		stmt.setString(2, ""+map.get("wifi"));
		stmt.setString(3, ""+map.get("kitshenTools"));
		stmt.setString(4, ""+map.get("parking"));
		stmt.setString(5, ""+map.get("bed"));
		stmt.setString(6, ""+map.get("ott"));
		stmt.setString(7, ""+map.get("ev"));
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// 설명 : room중에서 state가 미승인, 재승인 목록 불러오기
	// 호출 : pendingRoomList.jsp
	// return ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> selectPendingRoomList() throws Exception {
		ArrayList<HashMap<String, Object>> selectPendingRoomList = new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT room_no AS roomNo, customer_id AS customerId,"
				+ " room_name AS roomName, approve_state AS approveState"
				+ " FROM room"
				+ " WHERE approve_state = '미승인' OR"
				+ " approve_state = '재승인'";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("roomNo",rs.getInt("roomNo"));
			m.put("customerId",rs.getString("customerId"));
			m.put("roomName",rs.getString("roomName"));
			m.put("approveState",rs.getString("approveState"));
			selectPendingRoomList.add(m);
		}
		
		conn.close();
		return selectPendingRoomList;
	}
	
	// 설명 : 해당 roomNo의 approve_state를 '승인'으로 업데이트
	// 호출 : approveRoomAction.jsp
	// return : int
	public static int updateRoomStateApprove(int roomNo) throws Exception{
		int ApproveResult = 0;
		Connection conn = DBHelper.getConnection();
		
		// 쿼리
		String sql = "UPDATE room SET approve_state = '승인' WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		
		// 완성 쿼리 디버깅
		System.out.println("stmt: " + stmt);
		
		// 쿼리 실행
		ApproveResult = stmt.executeUpdate();
				
		// 자원반납
		conn.close();		
		return ApproveResult;
	}

	
	// 설명 : 해당 roomNo의 approve_state를 '반려'으로 업데이트
	// 호출 : rejectRoomAction.jsp
	// return : int
	public static int updateRoomStateReject(int roomNo) throws Exception{
		int rejectResult = 0;
		Connection conn = DBHelper.getConnection();
		
		// 쿼리
		String sql = "UPDATE room SET approve_state = '반려' WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		
		// 완성 쿼리 디버깅
		System.out.println("stmt: " + stmt);
		
		// 쿼리 실행
		rejectResult = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		
		return rejectResult;
	}
	
	// 설명 : 숙소 상세 정보를 등록
	// 호출 : updateRoomForm.jsp
	// return HashMap<String, String>
	public static HashMap<String, String> selectRoomOne(int roomNo) throws Exception{
		HashMap<String, String> resultMap = new HashMap<>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT "
				+ "	r.room_no AS roomNo "
				+ "    , r.room_name AS roomName "
				+ "    , r.room_theme AS roomTheme "
				+ "    , r.room_address AS roomAddress "
				+ "    , r.operation_start AS operationStart "
				+ "    , r.operation_end AS operationEnd "
				+ "    , r.max_people AS maxPeople "
				+ "    , r.room_content AS roomContent "
				+ "    , r.room_category AS roomCategory "
				+ "    , r.approve_state AS approveState "
				+ "    , r.create_date AS createDate "
				+ "    , r.update_date AS updateDate "
				+ "    , o.bed bed"
				+ "    , o.ev ev"
				+ "    , o.kitchen_tools kitchenTools"
				+ "    , o.ott ott"
				+ "    , o.parking parking"
				+ "    , o.wifi wifi"
				+ " FROM  "
				+ "	room AS r INNER JOIN room_option AS o "
				+ "	ON r.room_no = o.room_no "
				+ "WHERE r.room_no = ?";  
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap.put("roomNo", rs.getString("roomNo"));
			resultMap.put("roomName", rs.getString("roomName"));
			resultMap.put("roomTheme", rs.getString("roomTheme"));
			resultMap.put("roomAddress", rs.getString("roomAddress"));
			resultMap.put("operationStart", rs.getString("operationStart"));
			resultMap.put("operationEnd", rs.getString("operationEnd"));
			resultMap.put("maxPeople", rs.getString("maxPeople"));
			resultMap.put("roomContent", rs.getString("roomContent"));
			resultMap.put("roomCategory", rs.getString("roomCategory"));
			resultMap.put("approveState", rs.getString("approveState"));
			resultMap.put("bed", rs.getString("bed"));
			resultMap.put("ev", rs.getString("ev"));
			resultMap.put("kitchenTools", rs.getString("kitchenTools"));
			resultMap.put("ott", rs.getString("ott"));
			resultMap.put("parking", rs.getString("parking"));
			resultMap.put("wifi", rs.getString("wifi"));	
		}
		return resultMap;
	}
		
	// 설명 : 숙소 상세 정보를 수정
	// 호출 : updateRoomForm.jsp
	// return HashMap<String, String>
	public static int updateRoom(HashMap<String, String> map) throws Exception {
		
		System.out.println("map : " + map);
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE room "
				+ "SET "
				+ "room_name = ? "
				+ ", room_category = ? "
				+ ", room_theme = ? "
				+ ", room_address = ? "
				+ ", room_content = ? "
				+ ", operation_start = ? "
				+ ", operation_end = ? "
				+ ", max_people = ? "
				+ "WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, map.get("roomName"));
		stmt.setString(2, map.get("roomCategory"));
		stmt.setString(3, map.get("roomTheme"));
		stmt.setString(4, map.get("roomAddress"));
		stmt.setString(5, map.get("roomContent"));
		stmt.setString(6, map.get("operationStart"));
		stmt.setString(7, map.get("operationEnd"));
		stmt.setString(8, map.get("maxPeople"));
		stmt.setInt(9, Integer.parseInt(map.get("roomNo")));
		row = stmt.executeUpdate();	
		return row;
	}	
	// 설명 : 고객(호스트) 탈퇴 전 등록한 숙소가 있는지 확인
    // 호출 : /customer/customerDropCheckPwForm.jsp
    // 리턴값 : boolean (false 숙소가 존재, true면 숙소가 미존재)
	public static boolean selectRoomListDrop(String customerId) throws Exception {
	    boolean result = true;
	    Connection conn = DBHelper.getConnection();

	    String sql = "SELECT * "
	          + "FROM customer c INNER JOIN room r "
	          + "ON c.customer_id = r.customer_id "
	          + "WHERE c.customer_id = ? ";

	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, customerId);

	    // 디버깅코드
	    System.out.println("stmt :" + stmt);

	    ResultSet rs = stmt.executeQuery();

	    if(rs.next()) {
	       result = false;
	    }

	    conn.close();
	    return result;
	 }
	
	// 설명 : room 중에 해당 테마를 가지고 있는 room이 있는지 확인
	// 호출 : /emp/deleteThemeAction.jsp
	// 리턴값 : boolean (false면 없음, true면 있음)
	public static boolean thereIsRoomTheme(String roomTheme) throws Exception {
		boolean result = false;
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT room_no FROM room WHERE room_theme = ?";
		
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, roomTheme);
	    
	    // 디버깅코드
	    System.out.println("stmt :" + stmt);

	    ResultSet rs = stmt.executeQuery();

	    if(rs.next()) {
	       result = true;
	    }
	    
	    conn.close();
		return result;
	}
	
	// 설명 : 검색 결과출력
	// 호출 : empRoomList.jsp, customerRoomList.jsp
	// return : ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> searchRoomList(String searchAddress, 
			String searchStartDate, String searchEndDate, int searchMaxPeople, String theme) throws Exception {
		ArrayList<HashMap<String, Object>> searchRoomList = new ArrayList<HashMap<String, Object>>();
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// <검색 메서드>
		// (시작날-마지막날)+1을 하면 며칠 묵을 것인지 계산됨
		// 검색 지정한 날을 기준으로 에약가능한 onedayPrice를 count한 결과와 (시작날-마지막날)+1과 값이 같으면
		// 검색 지정한 날짜로 예약가능한 room임
		// + 지역검색 조건
		// + 최대인원보다 같거나 큰 room이 나오는 조건
		// + 해당 room_no인 img(img는 대표사진 한장만 나오게 max를 줌(대표사진을 따로 정해야함)
		// 을 만족하는 쿼리임.
		String sql = "SELECT r.room_no, max(ri.room_img), r.room_name, r.customer_id, r.room_address, r.max_people"
				+ " FROM room r ,"
				+ "	(SELECT op.room_no AS rno,COUNT(*) AS cnt"
				+ "	FROM oneday_price op"
				+ " WHERE op.room_state = '예약 가능'"
				+ " AND op.room_date BETWEEN ? AND ?"
				+ " GROUP BY op.room_no) T , room_img ri"
				+ " WHERE T.cnt >= DATEDIFF(?, ?)+1"
				+ " AND T.rno = r.room_no AND room_address LIKE ? AND max_people >= ?"
				+ " AND r.room_no=ri.room_no";
	    // theme 값이 있는 경우 조건 추가
	    if (theme != null && !theme.isEmpty()) {
	        sql += " AND r.room_theme = ?";
	    }
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setString(1, searchStartDate);
	    stmt.setString(2, searchEndDate);
	    stmt.setString(3, searchEndDate);
	    stmt.setString(4, searchStartDate);
	    stmt.setString(5, "%" + searchAddress + "%");
	    stmt.setInt(6, searchMaxPeople);
	    // theme 값이 있는 경우에만 설정
	    if (theme != null && !theme.isEmpty()) {
	        stmt.setString(7, theme);
	    }
	    ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("roomNo", rs.getInt("r.room_no"));
			m.put("roomImg", rs.getString("max(ri.room_img)"));
			m.put("roomName", rs.getString("r.room_name"));
			m.put("customerId", rs.getString("r.customer_id"));
			m.put("roomAddress", rs.getString("r.room_address"));
			m.put("maxPeople", rs.getInt("r.max_people"));
			searchRoomList.add(m);
		}
	    
	    conn.close();
		return searchRoomList;
	}
	
	// 설명 : 검색+필터 결과출력
	// 호출 : empRoomList.jsp, customerRoomList.jsp
	// return : ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> searchRoomFilterList(String searchAddress, String searchStartDate, 
			String searchEndDate, int searchMaxPeople, String lowPrice, String highPrice, String room_category, String wifi, 
			String kitchen_tools, String parking, int bed, String ott, String ev, String theme) throws Exception {
	    ArrayList<HashMap<String, Object>> searchRoomFilterList = new ArrayList<>();

		// DB연결
		Connection conn = DBHelper.getConnection();
		
        String sql = "SELECT r.room_no, MAX(ri.room_img) as room_img, r.room_name, r.customer_id, r.room_address, r.max_people"
        		+ " FROM room r"
        		+ " JOIN ("
        		+ "    SELECT op.room_no, COUNT(*) AS cnt"
        		+ "    FROM oneday_price op"
        		+ "    WHERE op.room_state = '예약 가능'"
        		+ "    AND op.room_date BETWEEN ? AND ?"
        		+ "    GROUP BY op.room_no"
        		+ " ) T ON T.room_no = r.room_no"
        		+ " JOIN room_img ri ON r.room_no = ri.room_no"
        		+ " JOIN room_option ro ON r.room_no = ro.room_no"
        		+ " WHERE T.cnt >= DATEDIFF(?, ?) + 1"
        		+ " AND r.room_address LIKE ?"
        		+ " AND r.max_people >= ?"
        		+ " AND EXISTS ("
        		+ "    SELECT 1"
        		+ "    FROM oneday_price op"
        		+ "    WHERE op.room_no = r.room_no"
        		+ "    AND op.room_price BETWEEN ? AND ?"
        		+ " )"
        		+ " AND r.room_category = ?"
        		+ " AND ro.wifi = ?"
        		+ " AND ro.kitchen_tools = ?"
        		+ " AND ro.parking = ?"
        		+ " AND ro.bed = ?"
        		+ " AND ro.ott = ?"
        		+ " AND ro.ev = ?";
        		
        		 
        	    // theme 값이 있는 경우 조건 추가
        	    if (theme != null && !theme.isEmpty()) {
        	        sql += " AND r.room_theme = ?";
        	    }
        	    
        	    sql += " GROUP BY r.room_no, r.room_name, r.customer_id, r.room_address, r.max_people";
        		

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, searchStartDate);
        stmt.setString(2, searchEndDate);
        stmt.setString(3, searchEndDate);
        stmt.setString(4, searchStartDate);
        stmt.setString(5, "%" + searchAddress + "%");
        stmt.setInt(6, searchMaxPeople);
        stmt.setString(7, lowPrice);
        stmt.setString(8, highPrice);
        stmt.setString(9, room_category);
        stmt.setString(10, wifi);
        stmt.setString(11, kitchen_tools);
        stmt.setString(12, parking);
        stmt.setInt(13, bed);
        stmt.setString(14, ott);
        stmt.setString(15, ev);
        
        // theme 값이 있는 경우에만 설정
        if (theme != null && !theme.isEmpty()) {
            stmt.setString(16, theme);
        }

        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            HashMap<String, Object> m = new HashMap<>();
            m.put("roomNo", rs.getInt("r.room_no"));
            m.put("roomImg", rs.getString("room_img"));
            m.put("roomName", rs.getString("r.room_name"));
            m.put("customerId", rs.getString("r.customer_id"));
            m.put("roomAddress", rs.getString("r.room_address"));
            m.put("maxPeople", rs.getInt("r.max_people"));
            searchRoomFilterList.add(m);
        }

        conn.close();

	    return searchRoomFilterList;
	}
	
	// 설명 : 필터 결과출력
	// 호출 : empRoomList.jsp, customerRoomList.jsp
	// return : ArrayList<HashMap<String, Object>>
	public static ArrayList<HashMap<String, Object>> roomFilterList(String lowPrice, String highPrice, String room_category, String wifi, 
			String kitchen_tools, String parking, int bed, String ott, String ev, String theme) throws Exception {
		ArrayList<HashMap<String, Object>> roomFilterList = new ArrayList<HashMap<String, Object>>();
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		String sql="SELECT r.room_no, r.customer_id, r.room_name, r.room_address, r.max_people, max(img.room_img) AS mri"
				+ " FROM room AS r"
				+ "	JOIN room_img AS img ON r.room_no =  img.room_no"
				+ "	JOIN room_option AS ro ON r.room_no = ro.room_no"
				+ "	JOIN oneday_price AS op ON r.room_no = op.room_no"
				+ " WHERE"
				+ "	op.room_price BETWEEN ? AND ?"
				+ "	AND r.room_category = ?"
				+ "	AND ro.wifi = ?"
				+ "	AND ro.kitchen_tools = ?"
				+ "	AND ro.parking = ?"
				+ "	AND ro.bed = ?"
				+ "	AND ro.ott = ?"
				+ "	AND ro.ev = ?";
		
	    // theme 값이 있는 경우 조건 추가
	    if (theme != null && !theme.isEmpty()) {
	        sql += " AND r.room_theme = ?";
	    }

	    sql += " GROUP BY img.room_no";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, lowPrice);
		stmt.setString(2, highPrice);
		stmt.setString(3, room_category);
		stmt.setString(4, wifi);
		stmt.setString(5, kitchen_tools);
		stmt.setString(6, parking);
		stmt.setInt(7, bed);
		stmt.setString(8, ott);
		stmt.setString(9, ev);
		
	    // theme 값이 있는 경우에만 설정
	    if (theme != null && !theme.isEmpty()) {
	        stmt.setString(10, theme);
	    }
		
		ResultSet rs = stmt.executeQuery();
		 
	    while (rs.next()) {
	        HashMap<String, Object> m = new HashMap<>();
	        m.put("roomNo", rs.getInt("r.room_no"));
	        m.put("roomImg", rs.getString("mri"));
	        m.put("roomName", rs.getString("r.room_name"));
	        m.put("customerId", rs.getString("r.customer_id"));
	        m.put("roomAddress", rs.getString("r.room_address"));
	        m.put("maxPeople", rs.getInt("r.max_people"));
	        roomFilterList.add(m);
	        System.out.println(m);
	    }

	    conn.close();
	        
		return roomFilterList;
	}
	
}