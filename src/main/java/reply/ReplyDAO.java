package reply;

import  java.sql.*;
import  javax.sql.*;
import  javax.naming.*;

import java.util.ArrayList;
import java.util.List;

public class ReplyDAO {
	
	private static ReplyDAO instance = new ReplyDAO();
	
	public static ReplyDAO getInstance() {
		return instance;
	}
	
	private ReplyDAO() { }
	
	private Connection getConnection() {
		try {
			InitialContext ic = new InitialContext(); //JNDI 서버 객체 생성
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/project");
			Connection conn = ds.getConnection(); //connection  객체를 할당 받음
			return conn;
		} catch(Exception e) {
			System.out.println("데이터베이스 연결에 문제가 발생했습니다.");
			return null;
		}
	}
		
	public int userCheck(String id, String passwd) {
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		
		int result = -1;
		
		try {
			conn = getConnection();
			
			String sql = "select id, passwd from member where id =?";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				String rid = rs.getString("id"); //테이블의 컬럼명으로
				String rpasswd = rs.getString("passwd");
				if(id.equals(rid) && passwd.equals(rpasswd)){
					result = 1; // 인증 성공
				}else{
					result = 0; // 패스워드 틀림
				}
			}else{
				result = -1; // 해당 아이디 없음
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("member 테이블의 아이디, 패스워드 확인에 문제가 발생했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return result;
	}	
	
	public void insertReply(ReplyVO article) { //게시글 하나를 insert 한다.
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		
		try { 
			conn = getConnection();
			
			String sql = "insert into reply(rwriter, reply, rreg_date, ref)";
			sql += "values(?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1, article.getRwriter());			
			pstmt.setString(2, article.getReply());	
			pstmt.setInt(3, article.getRef());
			pstmt.executeUpdate(); // 4. sql query 실행됨
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("reply 테이블 삽입에 문제가 발생했습니다.");
		} finally {
			// 5. 자원 해제
			if(pstmt != null) try{pstmt.close();} catch(Exception se) {}
			if(conn != null) try{conn.close();} catch(Exception se) {} //연결 해제
		}
	}
	

	
	public int getArticleCount(int ref) {
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체
			
			int result = 0;
			
			try {
				conn = getConnection();
				
				String sql = "select count(*) from reply where ref=?";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setInt(1, ref);
				rs = pstmt.executeQuery(); // 4. sql query 실행됨
				
				if(rs.next()){ //id가 맞는것이 있나 없나 판별함
					result = rs.getInt(1);
				}
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("reply 테이블의 자료 수 검색을 실패했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return result;
		}	
	
	public List<ReplyVO> getArticles(int ref){
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		List<ReplyVO> alist = null;
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select * from reply where ref=? order by rnum;";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, ref);
			
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				alist = new ArrayList<ReplyVO>();
				do {
					ReplyVO article = new ReplyVO();
					article.setRnum(rs.getInt("rnum"));
					article.setRwriter(rs.getString("rwriter"));
					article.setReply(rs.getString("reply"));
					article.setRreg_date(rs.getTimestamp("rreg_date"));
					article.setRef(rs.getInt("ref"));
					
					alist.add(article);
					
					} while(rs.next());
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("reply 테이블의 자료 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return alist;
	}
	
	public int deleteReply(int rnum) { 
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체		
		int result = 0;
		
		try {
			conn = getConnection();
				
			String sql = "delete from reply where rnum=?"; 
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, rnum);					
			pstmt.executeUpdate(); // 4. sql query 실행됨
				
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("reply 테이블의 글 삭제에 문제가 발생했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return result;
	}
}
	

