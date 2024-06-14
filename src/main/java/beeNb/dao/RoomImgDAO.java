package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class RoomImgDAO {
	// 설명 : 숙소 옵션 등록
	// 호출 : addRoomAction.jsp
	// return int
	public static int insertRoomImg(ArrayList<HashMap<String, Object>> imgList) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO "
				+ "room_img ("
				+ "room_img"
				+ ", room_no) VALUES "
				+ "(?, ?)";
		for(HashMap<String, Object> imgMap : imgList) {
			System.out.println("imgMap : " + imgMap);
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ""+imgMap.get("filename"));
			stmt.setInt(2, Integer.parseInt(""+imgMap.get("roomNo")));
			row = stmt.executeUpdate();
		}
		conn.close();
		return row;
	}

	// 설명 : 숙소 이미지 리스트 가져오기
	// 호출 : /customer/hostRoomOne.jsp
	// return : ArrayList<String> 숙소 이미지 리스트
	public static ArrayList<String> selectRoomImgList(int roomNo) throws Exception{
		ArrayList<String> roomImgList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT room_img AS roomImg FROM room_img WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, roomNo);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			roomImgList.add(rs.getString("roomImg"));
		}
		
		conn.close();
		return roomImgList;
	}
}
