package beeNb.dao;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBHelper {
	// 설명 : maria DB에 연결하기 위한 메서드
	// return : Connection 타입
	public static Connection getConnection() throws Exception {
		// maria DB 접근 클래스 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		// 디버깅 
		//System.out.println("db클래스 로딩 성공");
		
		// 로컬 PC의 Properties 파일 읽어오기
		/*FileReader fr = new FileReader("C:\\beeNb_properties\\beeNb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		
		String url = prop.getProperty("url");
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		*/
		Connection conn = DriverManager.getConnection("jdbc:mariadb://52.78.200.98:3306/bnb", "root" , "pink1212");
		// 디버깅
		//System.out.println("db접근 성공");
		
		return conn;
	}
	
	// getConnection 연결 test를 위한 main
	public static void main(String[] args) throws Exception {
		// DBHelper.getConnection()메서드 실행
		DBHelper.getConnection();
	}
}
