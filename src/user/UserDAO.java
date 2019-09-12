package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	//jsp���� DB�� ������ �� �ʿ��� Ŭ������, �� ��ɵ��� ��� ���� Ŭ����.
	private Connection con;
	
	
	public UserDAO() {
		
		try {
			String url = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; //�� ��ǻ���� �ּ�. 3306��Ʈ�� ���� BBS ��� db�� ����
			String ID = "root";
			String PW = "root";
			Class.forName("com.mysql.cj.jdbc.Driver"); // DB�� �޸𸮿� �ε�.
			con = DriverManager.getConnection(url, ID, PW); //jsp�� DB�� ����.
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public int Login(String id, String pw) { 
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT userPassword FROM USER WHERE userID = ?"; //sql injection ���� ��ŷ����� ����ϱ� ���� ���.
		try {
			pstmt = con.prepareStatement(sql); // �ڹٿ��� ������ ���۽��� �� �� �ִ� ��ü ����.
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); // ���� ����. DB���� ���� �ڷḦ ���� �ö��� executeQuery() ���. ResultSet�� ����ش�.
			if(rs.next()) {
				if(rs.getString("userPassword").equals(pw)) {
					return 1;//�α��� ����.
				}
				else
					return 0; //��й�ȣ ����ġ
			}
			return -1; // ���̵� ����.
			
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
		return -2; //�����ͺ��̽� ����
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
			
			
			return pstmt.executeUpdate(); // DB�� INSERT �� ���� executeUpdate() ���. �����ϸ� 1�� ���!
			
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
		return -1; //ȸ������ ����.
	}
	
	
	
	

}
