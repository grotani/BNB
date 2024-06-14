package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;

public class RoomOptionDAO {
	public static int updateRoomOption(HashMap<String, String> map) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE room_option "
				+ "SET "
				+ "wifi = ? "
				+ ", kitchen_tools = ? "
				+ ", parking = ? "
				+ ", bed = ? "
				+ ", ott = ? "
				+ ", ev = ? "
				+ "WHERE room_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, map.get("wifi"));
		stmt.setString(2, map.get("kitshenTools"));
		stmt.setString(3, map.get("parking"));
		stmt.setString(4, map.get("bed"));
		stmt.setString(5, map.get("ott"));
		stmt.setString(6, map.get("ev"));
		stmt.setInt(7, Integer.parseInt(map.get("roomNo")));
		row = stmt.executeUpdate();	
		return row;
	}
}
