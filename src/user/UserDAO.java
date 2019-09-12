package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	//jsp에서 DB로 접근할 때 필요한 클래스로, 그 기능들을 모아 놓은 클래스.
	private Connection con;
	
	
	public UserDAO() {
		
		try {
			String url = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; //내 컴퓨터의 주소. 3306포트에 접속 BBS 라는 db에 접속
			String ID = "root";
			String PW = "root";
			Class.forName("com.mysql.cj.jdbc.Driver"); // DB를 메모리에 로드.
			con = DriverManager.getConnection(url, ID, PW); //jsp와 DB를 연결.
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public int Login(String id, String pw) { 
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT userPassword FROM USER WHERE userID = ?"; //sql injection 같은 해킹기법을 방어하기 위한 방법.
		try {
			pstmt = con.prepareStatement(sql); // 자바에서 쿼리를 전송시켜 줄 수 있는 객체 생성.
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); // 쿼리 전송. DB에서 무언가 자료를 가져 올때는 executeQuery() 사용. ResultSet에 담아준다.
			if(rs.next()) {
				if(rs.getString("userPassword").equals(pw)) {
					return 1;//로그인 성공.
				}
				else
					return 0; //비밀번호 불일치
			}
			return -1; // 아이디가 없음.
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return -2; //데이터베이스 오류
	}
	
	
	
	public int join(UserDTO user) {
		
		PreparedStatement pstmt = null;
		
			
		
		String sql = "INSERT INTO USER VALUES(?, ?, ? ,? ,?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			
			return pstmt.executeUpdate(); // DB로 INSERT 할 때는 executeUpdate() 사용. 성공하면 1을 출력!
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				
			} catch (Exception e2) {
				// TODO: handle exception
				e2.printStackTrace();
			}
		}
		return -1; //회원가입 실패.
	}
	
	
	
	

}
