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
			String url = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC"; //내 컴퓨터의 주소. 3306포트에 접속 BBS 라는 db에 접속
			String ID = "root";
			String PW = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, ID, PW);
		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
		
		public String getDate() { //날짜를 불러오는 함수.
			
			String sql = "SELECT NOW()";//현재시각을 가져오는 sql문법
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1); //현재의 값을 그대로 반환.
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return "";
		}
		
		
		public int getNext() { //최신 bbsID+1 을 출력.
			
			String sql = "SELECT bbsID FROM BBS ORDER BY bbsId DESC";
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) { //가져온 데이터 위에 커서가 위치해 있고, 그 다음도 있다면 true. 없으면 false.
					return rs.getInt("bbsID") + 1;
				}
				return 1; //현재 쓴 글이 첫번째 글인 경우.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB 오류.
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
				
				return pstmt.executeUpdate(); //성공하면 0이상의 결과를 보냄.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB 오류.
		}
		
		public ArrayList<bbsDTO> getList(int pageNum) { // 현재페이지에 해당하는 글들은 전부 불러오는 함수.
			String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
			ArrayList<bbsDTO> list = new ArrayList<bbsDTO>(); // 표를 담을 수 있는 ArrayList.
			
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
		
		
		public boolean nextPage(int pageNum) { //다음페이지에 내용이 있는지 확인하는 함수.
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
		
		
		//하나의 글을 불러오는 함수.
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
			String sql = "UPDATE BBS SET bbsTitle = ? , bbsContent = ?  WHERE bbsID = ?"; //오타 및 문법 오류 주의!!! 진짜 스트레스 이빠이 받는다.
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsID);
				
				return pstmt.executeUpdate(); //성공하면 0이상의 결과를 보냄.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB 오류.
		}
		
		public int delete(int bbsID) {
			String sql = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; //글은 삭제되도 글 정보는 남는다.
			try {
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				
				
				return pstmt.executeUpdate(); //성공하면 0이상의 결과를 보냄.
				
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			} 
			return -1; //DB 오류.
		}
		
		
	
}
