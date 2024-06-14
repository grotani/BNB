package beeNb.dao;

import java.sql.*;
import java.util.*;

public class ThemeDAO {
	// 테마리스트를 출력하는 메서드
	// 호출 : /emp/themeList.jsp, /emp/inc/empNavbar.jsp, /customer/inc/customerNavbar.jsp
	// return : ArrayList<String>
	public static ArrayList<String> selectThemeList() throws Exception{
		ArrayList<String> themeList = new ArrayList<String>();
		
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		// 테마리스트를 출력하는 쿼리
		String sql = "SELECT room_theme FROM room_theme";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		// 반복문 돌려서 모든 행의 값을 theme에 add함.
		while(rs.next()) {
			String theme = rs.getString("room_theme");
			themeList.add(theme);
		}
		
		// 자원반납
		conn.close();
		return themeList;
	}
	
	// 테마를 추가하는 메서드
	// 호출 : /emp/addThemeAction.jsp
	// return : int (성공 : 1 / 실패 : 0)
	public static int insertTheme(String roomTheme) throws Exception{
		int row = 0;

		// DB연결		
		Connection conn = DBHelper.getConnection();
		
		// 테마를 추가하는 쿼리
		String sql = "INSERT INTO room_theme (room_theme) VALUES (?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, roomTheme);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		return row;
	}
	
	// 테마 추가시 중복확인 메서드
	// 호출 : /emp/addThemeAction.jsp
	// return : boolean (이미 있는 테마이름 : true / 없는이름 : false)
	public static boolean checkThemeName(String roomTheme) throws Exception{
		boolean result = false;
		
		// DB연결		
		Connection conn = DBHelper.getConnection();
		
		// 테마 추가시 중복확인 메서드
		String sql = "SELECT room_theme FROM room_theme WHERE room_theme = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, roomTheme);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
	 		result = true;
	 	}
		
		// 자원반납
		conn.close();
		return result;
	}
	
	// 테마 삭제 메서드
	// 호출 : /emp/deleteThemeAction.jsp
	// return : int(삭제완료 : 1, 실패 : 0)
	public static int deleteTheme(String roomTheme) throws Exception{
		int deleteTheme = 0;
		Connection conn = DBHelper.getConnection();
		
		// 테마 삭제 쿼리
		String sql = "DELETE FROM room_theme WHERE room_theme = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, roomTheme);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		deleteTheme = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		return deleteTheme;
	}
}
