package beeNb.dao;

import java.sql.*;
import java.util.*;

public class CustomerDAO {
	// 설명 : 고객의 회원가입 메서드
	// 호출 : /customer/customerSignUpAction.jsp
	// return : int row
	public static int insertCustomer(String customerId, String customerPw,
									String customerEmail, String customerName,
									String customerBirth, String customerPhone, String customerGender) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO customer(customer_id, customer_pw, customer_email, customer_name,"
				+ " customer_birth, customer_phone, customer_gender, customer_grade, create_date, update_date) "
				+ " VALUES(?, ?, ?, ?, ?, ?, ?, '0', NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		stmt.setString(3, customerEmail);
		stmt.setString(4, customerName);
		stmt.setString(5, customerBirth);
		stmt.setString(6, customerPhone);
		stmt.setString(7, customerGender);
		// 디버깅
		System.out.println("stmt : " + stmt);
		row = stmt.executeUpdate();

		
		conn.close();
		return row;
		
	}
	
	// 설명 : 고객이 회원가입시 pw_history에 들어가는 메소드
	// 호출 : /customer/customerSignUpAction.jsp
	// return : int row
	public static int insertCustomerPwHistory(String customerId, String customerPw) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO customer_pw_history(customer_pw, customer_id, create_date)"
				+ " VALUES(?, ?, NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerPw);
		stmt.setString(2, customerId);
		// 디버깅
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 설명 : 고객 로그인 Action
    // 호출 : /customer/customerLoginAction.jsp
    // return : HashMap(Id,Pw)
    public static HashMap<String, String> loginCustomer (String customerId, String customerPw)
          throws Exception {
       HashMap<String, String > map = null;
       Connection conn = DBHelper.getConnection();
       String sql = "SELECT * FROM customer WHERE customer_id =? AND customer_pw =?";
       PreparedStatement stmt = conn.prepareStatement(sql);
       stmt.setString(1, customerId);
       stmt.setString(2, customerPw);
       // 디버깅
       System.out.println("stmt :" + stmt);
       
       ResultSet rs = stmt.executeQuery();
       if(rs.next()) {
          map = new HashMap<String, String>();
          map.put("customerId", rs.getString("customer_id"));
          map.put("customerEmail", rs.getString("customer_email"));
          map.put("customerName", rs.getString("customer_name"));
          map.put("customerBirth", rs.getString("customer_birth"));
          map.put("customerPhone", rs.getString("customer_phone"));
          map.put("customerGender", rs.getString("customer_gender"));
          
       }
       conn.close();
       return map;
       
    }
    
	// 설명 : 고객 회원가입시 아이디 중복 확인 
	// 호출 : /customer/customerCheckId.jsp
	// return : boolean (사용가능하면 true, 불가능하면 false)
	public static boolean customerCheckId(String customerId) throws Exception {
	 	boolean result = false;
	 	Connection conn = DBHelper.getConnection();
	 	String sql = "SELECT customer_id FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		// 디버깅
		System.out.println("stmt :" + stmt);
	 	ResultSet rs = stmt.executeQuery();
	 	
	 	if(!rs.next()) {
	 		result = true;
	 	}
	 	conn.close();
	 	return result;
	
	}
	 
	// 설명 : 비밀번호 재설정시 본인인증    
	// 호출 : /customer/customerAuthAction.jsp
	// return : boolean(일치하면 true, 불일치하면 false)
	public static boolean selectCustomerAuth (String customerId, String customerName, String customerPhone)throws Exception {
	    boolean result = false; 
	    Connection conn = DBHelper.getConnection();
	    String sql = "SELECT customer_id, customer_name, customer_phone FROM customer WHERE customer_id = ? AND customer_name = ? And customer_phone = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerName);
		stmt.setString(3, customerPhone);
		// 디버깅
		System.out.println("stmt :" + stmt);
		   
	    ResultSet rs = stmt.executeQuery();
	    if(rs.next()) {
	    	result = true;
	    	
	    }
	 	System.out.println("result :" + result);
	 	conn.close();
	 	return result; 
	}
  
	// 설명 : 회원 ID 찾기
	// 호출 : /customer/customerFindIdAction.jsp
	// return : String(일치하면 회원ID, 불일치하면 공백)
	public static String customerCheckId(String customerName, String customerEmail) throws Exception {
		String result = "";
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT customer_id customerId FROM customer WHERE customer_name =? AND customer_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerName);
		stmt.setString(2,customerEmail);
		
		// 디버깅
		System.out.println("customerCheckId stmt :" + stmt);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = rs.getString("customerId");
		}	
		conn.close();
		return result;
	}
	  
	// 설명 : 고객 비밀번호 변경시 이전 비밀번호와 일치되는지 확인
	// 호출 : /customer/customerEditPwAction.jsp, customerUpdateAction.jsp
	// return : boolean(기존에 있던 비밀번호면 true, 없으면 false)
	public static boolean selectCustomerPwHistory(String customerId, String newCustomerPw) throws Exception {
		boolean result = false;
		Connection conn = DBHelper.getConnection();
		String sql;
		if(newCustomerPw != null && !newCustomerPw.isEmpty()) {
			sql = "SELECT customer_pw FROM customer_pw_history WHERE customer_id =? AND customer_pw = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1,customerId);
			stmt.setString(2,newCustomerPw);
		    // 디버깅
		    System.out.println("stmt :" + stmt);
			ResultSet rs = stmt.executeQuery();
		  
		    if(rs.next()) {
				result = true;
			}
		}else {
			result = false;
		}
	    conn.close();
	    return result;
	    
	}
	  
	// 설명 : 고객 테이블에서 비밀번호 변경
	// 호출 : /customer/customerEditPwAction.jsp
	// return : int
	public static int updateCustomerPw(String newCustomerPw, String customerId) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE customer SET customer_pw = ?, update_date = now() WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newCustomerPw);
		stmt.setString(2, customerId);
		// 디버깅
		System.out.println("stmt: " + stmt);
		row = stmt.executeUpdate();
		  
		conn.close();
		 return row;
	}
  
	// 설명 : 고객 비밀번호 변경시 비밀번호 이력테이블에 변경비밀번호 추가
	// 호출 : /customer/customerEditPwAction.jsp, /customer/customerUpdateAction.jsp
	// return : int
	public static int insertCustomerNewPwHistory(String newCustomerPw, String customerId) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql;
		if(newCustomerPw != null && !newCustomerPw.isEmpty()) {
			sql = "INSERT INTO customer_pw_history(customer_pw, customer_id, create_date) VALUES (?, ?, NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, newCustomerPw);
			stmt.setString(2, customerId);
			// 디버깅
			System.out.println("stmt: " + stmt);
			row = stmt.executeUpdate();
		} else {
			row = 1;
		}
  
		conn.close();
		return row;
	}
  
	// 설명 : 고객(customer)정보 상세보기 & 정보수정
	// 호출 : customerOne.jsp / customerUpdateForm.jsp
	// return : HashMap
	public static HashMap<String, String> selectCustomerOne (String customerId) throws Exception {
		HashMap<String, String> m  = null;	
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT customer_id customerId, customer_email customerEmail, customer_name customerName, customer_birth customerBirth, "
			+ " customer_phone customerPhone, customer_gender customerGender, customer_grade customerGrade, create_date createDate, update_date updateDate FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1,customerId);
		// 디버깅
		System.out.println("stmt :" + stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			m = new HashMap<String,String>();
			m.put("customerId", rs.getString("customerId"));
			m.put("customerEmail", rs.getString("customerEmail"));
			m.put("customerName", rs.getString("customerName"));
			m.put("customerBirth", rs.getString("customerBirth"));
			m.put("customerPhone", rs.getString("customerPhone"));
			m.put("customerGender", rs.getString("customerGender"));
			m.put("customerGrade", rs.getString("customerGrade"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
		}
		
		conn.close();
		return m;
	} 
  
	// 설명 : customer테이블의 전체 행 개수 구하는 메서드(customer 리스트 출력 시 페이징하기 위해)
	// 호출 : /emp/customerList.jsp
	// return : int (customer 테이블 행 개수)
	public static int selectCustomerListCnt() throws Exception {
		// customer테이블의 전체 행 개수를 담을 변수
		int cnt = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// customer 테이블로부터 전체 행 COUNT하는 쿼리
		String sql = "SELECT COUNT(*) cnt FROM customer";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// SELECT 결과가 있다면
		if(rs.next()) {
			// SELECT 결과 값 담기
			cnt = rs.getInt("cnt");
		}
			
		conn.close();
		return cnt;
	}
		
	// 설명 : customer테이블에서 전체 customer를 출력(페이징 포함, grade 선택)
	// 호출 : /emp/customerList.jsp
	// return : ArrayList<HashMap<String, Object>> (customer테이블에서 SELECT 조회 값)
	public static ArrayList<HashMap<String, Object>> selectCustomerList(String grade, int startRow, int rowPerPage) throws Exception{
		// SELECT 결과 값을 담을 List
		ArrayList<HashMap<String, Object>> customerList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// grade를 조건으로 customer SELECT 조회(단 createDate로 정렬하고, LIMIT문에 해당하는 데이터만)
		String sql = "SELECT customer_id AS customerId, customer_email AS customerEmail, customer_name AS customerName,"
				+ " customer_birth AS customerBirth, customer_phone AS customerPhone, customer_gender AS customerGender,"
				+ " customer_grade AS customerGrade, create_date AS createDate, update_date AS updateDate"
				+ " FROM customer"
				+ " WHERE customer_grade = ?"
				+ " ORDER BY create_date DESC"
				+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, grade);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// ResultSet의 결과행 개수만큼 반복
		while(rs.next()) {
			// HashMap에 행의 컬럼 값을 하나씩 추가
			HashMap<String, Object> m = new HashMap<>();
			m.put("customerId", rs.getString("customerId"));
			m.put("customerEmail", rs.getString("customerEmail"));
			m.put("customerName", rs.getString("customerName"));
			m.put("customerBirth", rs.getString("customerBirth"));
			m.put("customerPhone", rs.getString("customerPhone"));
			m.put("customerGender", rs.getString("customerGender"));
			m.put("customerGrade", rs.getString("customerGrade"));
			m.put("createDate", rs.getString("createDate"));
			m.put("updateDate", rs.getString("updateDate"));
			// customerList에 값이 들어간 HashMap을 하나씩 추가
			customerList.add(m);
			}
		
		conn.close();
		return customerList;
	}
	
	// 설명 : 회원정보 수정시 비밀번호 확인
	// 호출 : customerCheckPwAction.jsp
	// return : boolean (일치하면 true , 불일치시 false)
	public static boolean selectCustomerPw(String customerId, String customerPw) throws Exception {
		boolean result = false;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT customer_pw AS customerPw FROM customer WHERE customer_id = ? And customer_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		stmt.setString(2, customerPw);
		//디버깅코드
		System.out.println("stmt: "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = true;
		}
		
		conn.close();
		return result;
	}
	// 설명 : 회원정보 수정
	// 호출 : customerUpdateAction.jsp
	// return : int 
	public static int updateCustomer(String customerEmail, String customerPhone,
									String newCustomerPw, String customerId) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql;
		PreparedStatement stmt;
		if(newCustomerPw != null && newCustomerPw != "") {
			sql = "UPDATE customer SET customer_pw = ?, customer_email = ?, customer_phone = ?, update_date=NOW()"
					+ " WHERE customer_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newCustomerPw);
			stmt.setString(2, customerEmail);
			stmt.setString(3, customerPhone);
			stmt.setString(4, customerId);
		} else {
			sql = "UPDATE customer SET customer_email = ?, customer_phone = ?, update_date=NOW()"
					+ " WHERE customer_id = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, customerEmail);
			stmt.setString(2, customerPhone);
			stmt.setString(3, customerId);
		}

		// 디버깅코드
		System.out.println("stmt :" + stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	// 설명 : 숙소 심사 상신한 customer가 호스티인지 아닌지 출력(0: 게스트, 1: 호스트)
	// 호출 : approveRoomAction.jsp
	// return : int
	public static int checkCustomerGrade(String customerId)throws Exception {
		int customerGrade = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT customer_grade FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		
		// 디버깅코드
		System.out.println("stmt :" + stmt);
		
		// 리턴값에 출력된 grade값을 대입
	    ResultSet rs = stmt.executeQuery();
	    if (rs.next()) {
	        customerGrade = rs.getInt("customer_grade");
	    }
		
	    // 자원반납
	    conn.close();
		return customerGrade;
	}
	
	// 설명 : customer의 grade를 1로 업데이트(호스트권한부여)
	// 호출 : approveRoomAction.jsp
	// return : int
	public static int updateCustomerGrade(String customerId) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		// 쿼리
		String sql = "UPDATE customer SET customer_grade = '1' WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		
		// 완성 쿼리 디버깅
		System.out.println("stmt: " + stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
				
		// 자원반납
		conn.close();		
		return row;
	}
	
	// 설명 : 회원탈퇴시 customer 정보 삭제
	// 호출 : customerDropAction.jsp
	// return : int
	public static int deleteCustomer(String customerId) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql ="DELETE FROM customer WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		// 디버깅
		System.out.println("stmt :"+ stmt);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// 설명 : 회원탈퇴시 customer_pw_history 정보 삭제
	// 호출 : customerDropAction.jsp
	// return : int
	public static int deleteCustomerPwHistory(String customerId) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql ="DELETE FROM customer_pw_history WHERE customer_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		// 디버깅
		System.out.println("stmt :"+ stmt);
		
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
}
