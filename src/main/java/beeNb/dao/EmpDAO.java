package beeNb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class EmpDAO {
	// 설명 : emp테이블의 전체 행 개수 구하는 메서드(emp 리스트 출력 시 페이징하기 위해)
	// 호출 : BeeNb/emp/empList.jsp
	// return : int (emp 테이블 행 개수)
	public static int selectEmpListCnt(String searchWord) throws Exception {
		// emp테이블의 전체 행 개수를 담을 변수
		int cnt = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// emp 테이블로부터 전체 행 COUNT하는 쿼리
		String sql = "SELECT COUNT(*) cnt FROM emp WHERE emp_name LIKE ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchWord + "%");
		ResultSet rs = stmt.executeQuery();
		
		// SELECT 결과가 있다면
		if(rs.next()) {
			// SELECT 결과 값 담기
			cnt = rs.getInt("cnt");
		}
		
		conn.close();
		return cnt;
	}
	
	// 설명 : emp테이블에서 전체 emp를 출력(페이징 포함, 이름 검색 포함)
	// 호출 : BeeNb/emp/empList.jsp
	// return : ArrayList<HashMap<String, Object>> (emp테이블에서 SELECT 조회 값)
	public static ArrayList<HashMap<String, Object>> selectEmpList(String searchWord, int startRow, int rowPerPage) throws Exception{
		// SELECT 결과 값을 담을 List
		ArrayList<HashMap<String, Object>> empList = new ArrayList<>();
		
		Connection conn = DBHelper.getConnection();
		
		// searchWord가 empName에 포함되는 데이터를 SELECT 조회(단 createDate로 정렬하고, LIMIT문에 해당하는 데이터만)
		String sql = "SELECT emp_no AS empNo, emp_name AS empName, emp_phone AS empPhone, emp_birth AS empBirth, create_date AS createDate"
				+ " FROM emp"
				+ " WHERE emp_name LIKE ?"
				+ " ORDER BY create_date DESC"
				+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		// ResultSet의 결과행 개수만큼 반복
		while(rs.next()) {
			// HashMap에 행의 컬럼 값을 하나씩 추가
			HashMap<String, Object> m = new HashMap<>();
			m.put("empNo", rs.getInt("empNo"));
			m.put("empName", rs.getString("empName"));
			m.put("empPhone", rs.getString("empPhone"));
			m.put("empBirth", rs.getString("empBirth"));
			m.put("createDate", rs.getString("createDate"));
			// empList에 값이 들어간 HashMap을 하나씩 추가
			empList.add(m);
		}
		
		conn.close();
		return empList;
	}
	
	// 설명 : emp 로그인, 비밀번호 확인용으로도 쓸 수 있음
	// 호출 : empLoginAction.jsp, empDropCheckPwAction.jsp
	// return : HashMap<String, Object>
	public static HashMap<String, Object> empLogin(String empNo, String empPw) throws Exception{
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT emp_no AS empNo, emp_name AS empName, emp_phone AS empPhone, emp_Birth AS empBirth "
				+ "FROM emp WHERE emp_no = ? AND emp_pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empNo);
		stmt.setString(2, empPw);
		ResultSet rs = stmt.executeQuery();
		HashMap<String, Object> loginEmp = new HashMap<>();
		if(rs.next()) {
			loginEmp.put("empNo", rs.getInt("empNo"));
			loginEmp.put("empName", rs.getString("empName"));
			loginEmp.put("empPhone", rs.getString("empPhone"));
			loginEmp.put("empBirth", rs.getString("empBirth"));
		}
		return loginEmp;
	}
	
	// 설명 : 관리자 등록하는 메서드
	// 호출 : BeeNb/emp/empRegistAction.jsp
	// return : int (성공시 1, 실패시 0)
	public static int insertEmp(String empName, String empPhone, String empBirth) throws Exception{
		// 쿼리 실행시 반환된 행의 개수를 담을 변수
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		// emp테이블에 emp를 등록하는 INSERT 쿼리
		String sql = "INSERT INTO emp(emp_name, emp_pw, emp_phone, emp_birth) VALUES(?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empName);
		stmt.setString(2, empBirth);
		stmt.setString(3, empPhone);
		stmt.setString(4, empBirth);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 설명 : emp등록시 epw_history에 pw를 등록하기위해 가장 최근 생성된 emp의 empNo를 가져오는 메서드
	// 호출 : BeeNb/emp/empRegistAction.jsp
	// return : int (emp의 empNo)
	public static int selectRecentRegistEmp(String empName, String empPhone, String empBirth) throws Exception{
		// SELECT된 empNo가 담길 변수
		int empNo = 0;
		
		Connection conn = DBHelper.getConnection();	
		String sql = "SELECT emp_no AS empNo"
				+ " FROM emp"
				+ " WHERE emp_name = ? AND emp_phone = ? AND emp_Birth = ?"
				+ " ORDER BY create_date DESC"
				+ " LIMIT 0,1";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empName);
		stmt.setString(2, empPhone);
		stmt.setString(3, empBirth);
		ResultSet rs = stmt.executeQuery();
		
		// 가장 최근 생성된 empNo가 있다면 empNo변수에 담기
		if(rs.next()) {
			empNo = rs.getInt("empNo");
		}
		
		conn.close();
		return empNo;
	}
	
	// 설명 : emp_pw_history에 pw INSERT하는 메서드
	// 호출 : BeeNb/emp/empRegistAction.jsp
	// return : int (성공시 1, 실패시 0)
	public static int insertEmpPwHistory(int empNo, String empPw) throws Exception{
		// 쿼리 실행시 반환된 행의 개수를 담을 변수
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		// emp_pw_history테이블에 pw를 입력하는 INSERT 쿼리
		String sql = "INSERT INTO emp_pw_history(emp_no, emp_pw) VALUES(?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		stmt.setString(2, empPw);
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// 설명 : 관리자 비밀번호 변경시 기존에 pwHistory에 있는 pw인지 조회
	// 호출 : BeeNb/emp/empEditPwAction.jsp
	// return : boolean (기존에 있던 비밀번호면 true, 기존에 없던 비밀번호면 false)
	public static boolean selectEmpPwHistory(int empNo, String newEmpPw)throws Exception{
		boolean result = false;
		
		Connection conn = DBHelper.getConnection();
		
		// pwHistory를 조회하는 쿼리
		String sql = "SELECT * FROM emp_pw_history WHERE emp_no = ? AND  emp_pw = ? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		stmt.setString(2, newEmpPw);
		
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
	
	// 설명 : 관리자 비밀번호를 새롭게 바꾼 비밀번호로 업데이트
	// 호출 : /BeeNb/emp/empEditPwAction.jsp
	// return : int (업데이트 성공시 1, 실패시 0)
	public static int updateEmpPw(int empNo, String empPw)throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		// 관리자 비밀번호를 업데이트하는 쿼리
		String sql="UPDATE emp SET emp_pw = ? WHERE emp_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empPw);
		stmt.setInt(2, empNo);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		row = stmt.executeUpdate();
		
		//자원반납
		conn.close();		
		return row;
	}
	
	// 설명 : emp 테이블에 사번과 본인 휴대폰 번호로 본인인증을 하는 메서드
	// 호출 : /emp/empResetPwAction.jsp
	// return : boolean(성공시 true, 실패시 false)
	public static boolean selectEmpOne(int empNo, String empPhone) throws Exception {
		boolean resultBool = false;
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT * FROM emp WHERE emp_no = ? AND emp_phone = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, empNo);
		stmt.setString(2, empPhone);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultBool = true;
		}
		return resultBool;
	}

	// 설명 : emp 테이블에 emp_pw를 사번으로 초기화하는 메서드
	// 호출 : /emp/empResetPwAction.jsp
	// return : int(성공시 1, 실패시 0)
	public static int empResetPw(int empNo) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE emp SET emp_pw = ? WHERE emp_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ""+empNo);
		stmt.setInt(2, empNo);
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	// 설명 : 관리자 탈퇴
	// 호출 : /emp/empDropCheckPwAction.jsp
	// return : int(삭제 성공시 1, 실패시 0)
	public static int deleteEmp(String empNo) throws Exception{
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		// emp 테이블 한 행 삭제하는 쿼리
		String sql="DELETE FROM emp WHERE emp_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empNo);
		
		// 쿼리 디버깅
		System.out.println("stmt : " + stmt);
		
		// 쿼리 실행
		row = stmt.executeUpdate();
		
		// 자원반납
		conn.close();
		return row;
	}
}
