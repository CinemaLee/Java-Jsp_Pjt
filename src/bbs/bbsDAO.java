package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class bbsDAO {
	private Connection con;
	//private PreparedStatement pstmt;
	private ResultSet rs;
	
	public bbsDAO() {
		try {
			String url = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; //�� ��ǻ���� �ּ�. 3306��Ʈ�� ���� BBS ��� db�� ����
			String ID = "root";
			String PW = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, ID, PW);
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
		
		public String getDate() { //��¥�� �ҷ����� �Լ�.
			
			String sql = "SELECT NOW()";//����ð��� �������� sql����
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1); //������ ���� �״�� ��ȯ.
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return "";
		}
		
		
		public int getNext() { //�ֽ� bbsID+1 �� ���.
			
			String sql = "SELECT bbsID FROM BBS ORDER BY bbsId DESC";
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) { //������ ������ ���� Ŀ���� ��ġ�� �ְ�, �� ������ �ִٸ� true. ������ false.
					return rs.getInt("bbsID") + 1;
				}
				return 1; //���� �� ���� ù��° ���� ���.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB ����.
		}
		
		public int write(String bbsTitle, String userID, String bbsContent) { 
			
			String sql = "INSERT INTO BBS VALUES(?,?,?,?,?,?)";
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, bbsTitle);
				pstmt.setString(3, userID);
				pstmt.setString(4, getDate());
				pstmt.setString(5, bbsContent);
				pstmt.setInt(6, 1);
				
				return pstmt.executeUpdate(); //�����ϸ� 0�̻��� ����� ����.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB ����.
		}
		
		public ArrayList<bbsDTO> getList(int pageNum) { // ������������ �ش��ϴ� �۵��� ���� �ҷ����� �Լ�.
			String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
			ArrayList<bbsDTO> list = new ArrayList<bbsDTO>(); // ǥ�� ���� �� �ִ� ArrayList.
			
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNum-1) * 10);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					bbsDTO bt = new bbsDTO();
					
					bt.setBbsID(rs.getInt(1));
					bt.setBbsTitle(rs.getString(2));
					bt.setUserID(rs.getString(3));
					bt.setBbsDate(rs.getString(4));
					bt.setBbsContent(rs.getString(5));
					bt.setBbsAvailable(rs.getInt(6));
					
					list.add(bt);
				}
				
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return list;
		}
		
		
		public boolean nextPage(int pageNum) { //������������ ������ �ִ��� Ȯ���ϴ� �Լ�.
			String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
			
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNum-1) * 10);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					return true;
				}
				
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return false;
		}
		
		
		//�ϳ��� ���� �ҷ����� �Լ�.
		public bbsDTO Getbbs(int bbsID) {
			String sql = "SELECT * FROM BBS WHERE bbsID = ?";
			
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					bbsDTO bt = new bbsDTO();
					
					bt.setBbsID(rs.getInt(1));
					bt.setBbsTitle(rs.getString(2));
					bt.setUserID(rs.getString(3));
					bt.setBbsDate(rs.getString(4));
					bt.setBbsContent(rs.getString(5));
					bt.setBbsAvailable(rs.getInt(6));
					
					return bt;
				}
				
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return null;
		}
		
		
		public int update(int bbsID, String bbsTitle, String bbsContent) {
			String sql = "UPDATE BBS SET bbsTitle = ? , bbsContent = ?  WHERE bbsID = ?"; //��Ÿ �� ���� ���� ����!!! ��¥ ��Ʈ���� �̺��� �޴´�.
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsID);
				
				return pstmt.executeUpdate(); //�����ϸ� 0�̻��� ����� ����.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB ����.
		}
		
		public int delete(int bbsID) {
			String sql = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //���� �����ǵ� �� ������ ���´�.
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				
				
				return pstmt.executeUpdate(); //�����ϸ� 0�̻��� ����� ����.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB ����.
		}
		
		
	
}
