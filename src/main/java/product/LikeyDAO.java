package product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import reply.ReplyVO;


public class LikeyDAO {

		private static LikeyDAO instance = new LikeyDAO();
		private ArrayList<LikeyVO> listOfProducts = new ArrayList<LikeyVO>();
		public static LikeyDAO getInstance() {
			return instance;
		}
		
		private LikeyDAO() { }
		
		private Connection getConnection() {		
			try {
				InitialContext ic = new InitialContext(); // JNDI 서버 객체 생성 
				DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/project"); // connection 객체 찾기
				Connection conn = ds.getConnection(); // connection 객체를 할당 받음
				return conn;
			} catch(Exception e) {
				System.out.println("likey 데이터베이스 연결에 문제가 발생했습니다.");
				return null;
			}				

		}
		
		public void insertLikey(String id) {		
			Connection conn = null;
			PreparedStatement pstmt = null; // query 실행
			
			try {			
				conn = getConnection();
				
				String sql = "insert into likey(id, number, reg_date)";
				sql += "values (?, ?, now())";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				pstmt.setString(1, id);
			
				
				
				pstmt.executeUpdate(); //4. sql query 실행
				
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("likey 테이블에 새로운 레코드 추가에 실패했습니다.");
			} finally {
				//5. 자원 해제
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
		}
		
		public List<LikeyVO> getArticles(int start, int end) {
			Connection conn = null;
			PreparedStatement pstmt = null; // query 실행
			ResultSet rs = null;
			List<LikeyVO> articleList = null;
			//System.out.println(start + " - " + end);
			try {			
				conn = getConnection();			
				
				//select b.* 
				//from ( select rownum as rnum, a.*
				//	     from (select * from board order by num desc) a ) b
				//where b.rnum >= 1 and b.rnum <= 10;
				String sql = "select * from likey order by number desc limit ?, ?";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery(); //4. sql query 실행
				
				if(rs.next()) {
					articleList = new ArrayList<LikeyVO>();
					do {
						LikeyVO article = new LikeyVO();
						article.setNumber(rs.getInt("number"));
						article.setId(rs.getString("id"));
						article.setReg_date(rs.getTimestamp("reg_date"));
						
						articleList.add(article);
					} while(rs.next());				
				}
				
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("product 테이블에 새로운 레코드 추가를 실패했습니다.");
			} finally {
				//5. 자원 해제
				if(rs != null) try {rs.close();} catch(SQLException se) { }
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
			
			return articleList;
		}
	
		public List<ProductVO> getArticles(int start, int end, String id) {
			Connection conn = null;
			PreparedStatement pstmt = null; // query 실행
			ResultSet rs = null;
			List<ProductVO> articleList = null;
			//System.out.println(start + " - " + end);
			try {			
				conn = getConnection();			
	
				String sql = "select * from product where pnum in(select number from likey id =?)";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
				pstmt.setString(3, id);
				rs = pstmt.executeQuery(); //4. sql query 실행
				
				if(rs.next()) {
					articleList = new ArrayList<ProductVO>();
					do {
						ProductVO article = new ProductVO();
						article.setPnum(rs.getInt("pnum"));
						article.setPid(rs.getInt("pid"));
						article.setPtitle(rs.getString("ptitle"));	
						article.setPrice(rs.getInt("price"));
						article.setCalory(rs.getInt("calory"));
						article.setSugar(rs.getInt("sugar"));
						article.setCaffeine(rs.getInt("caffeine"));
						article.setPimage(rs.getString("pimage"));					
						article.setPcontent(rs.getString("pcontent"));
						
						articleList.add(article);
					} while(rs.next());				
				}
				
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("product 테이블에 새로운 레코드 추가를 실패했습니다.");
			} finally {
				//5. 자원 해제
				if(rs != null) try {rs.close();} catch(SQLException se) { }
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
			
			return articleList;
		}
		
		public int getArticleCount() {
			Connection conn = null;
			PreparedStatement pstmt = null; // query 실행
			ResultSet rs = null;
			int result = 0;
			
			try {			
				conn = getConnection();			
				
				String sql = "select count(*) from likey";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				rs = pstmt.executeQuery(); //4. sql query 실행
				
				if(rs.next()) {
					result = rs.getInt(1);				
				} 			
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("likey 테이블의 레코드 전체수 검색을 실패했습니다.");
			} finally {
				//5. 자원 해제
				if(rs != null) try {rs.close();} catch(SQLException se) { }
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
			
			return result;
		}
		
		public int getArticleCount(String id) {
			Connection conn = null;
			PreparedStatement pstmt = null; // query 실행
			ResultSet rs = null;
			int result = 0;
			
			try {			
				conn = getConnection();			
				
				String sql = "select count(*) from likey id=?";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				pstmt.setString(1, id);
				rs = pstmt.executeQuery(); //4. sql query 실행
				
				if(rs.next()) {
					result = rs.getInt(1);				
				} 			
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("likey 테이블의 레코드 전체수 검색을 실패했습니다.");
			} finally {
				//5. 자원 해제
				if(rs != null) try {rs.close();} catch(SQLException se) { }
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
			
			return result;
		}


		
		public int deleteLikey(int number) {
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체		
			int result = 0;
			
			try {			
				conn = getConnection();
				
				String sql = "delete from likey where number=?";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				pstmt.setInt(1, number);
				
				pstmt.executeUpdate(); //4. sql query 실행

			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("likey 테이블의 글 삭제를 실패했습니다.");
			} finally {
				//5. 자원 해제
				if(rs != null) try {rs.close();} catch(SQLException se) { }
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
			
			return result;
		}
}
