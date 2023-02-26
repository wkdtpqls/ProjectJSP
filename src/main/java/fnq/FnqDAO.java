package fnq;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import fnq.FnqVO;

public class FnqDAO {
		
		private static FnqDAO instance = new FnqDAO();
		private ArrayList<FnqVO> listOfProducts = new ArrayList<FnqVO>();
		public static FnqDAO getInstance() {
			return instance;
		}
		
		private FnqDAO() { }
		
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
			
		
		public void insertFnq(FnqVO article) { //게시글 하나를 insert 한다.
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			
			try { 
				conn = getConnection();
				// num,조회수는 자동이므로 컬럼명 지정해줌
				//insert into board(writer, email, subject, passwd, reg_date, content) values ('홍길동', 'aaa@aaa.com', '제목1', '123','now()','내용1');
				String sql = "insert into fnq(question, answer)";
				sql += "values(?, ?)";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기		
				pstmt.setString(1, article.getQuestion());	
				pstmt.setString(2, article.getAnswer());
				pstmt.executeUpdate(); // 4. sql query 실행됨
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블 삽입에 문제가 발생했습니다.");
			} finally {
				// 5. 자원 해제
				if(pstmt != null) try{pstmt.close();} catch(Exception se) {}
				if(conn != null) try{conn.close();} catch(Exception se) {} //연결 해제
			}
		}
		
		public int getArticleCount() {
				Connection conn  = null; //데이터베이스 연결 객체
				PreparedStatement pstmt = null; // query 실행할 객체
				ResultSet rs = null; //select문 실행 결과를 저장하는 객체
				
				int result = 0;
				
				try {
					conn = getConnection();
					
					String sql = "select count(*) from fnq;";
					pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
					rs = pstmt.executeQuery(); // 4. sql query 실행됨
					
					if(rs.next()){ //id가 맞는것이 있나 없나 판별함
						result = rs.getInt(1);
					}
					
				} catch (Exception e){ //오류날 때 
					e.printStackTrace();
					System.out.println("fnq 테이블의 자료 수 검색을 실패했습니다.");
				} finally {
					// 5. 자원 해제
					if(rs != null) try{rs.close();} catch(SQLException se) {}
					if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
					if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
				}
				
				return result;
			}
		public List<FnqVO> getArticles(int start, int end){
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체
			List<FnqVO> alist = null;
			
			try {
				conn = getConnection();
				
				String sql = "select * from fnq order by num desc limit ?, ?;";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery(); // 4. sql query 실행됨
				
				if(rs.next()){ //id가 맞는것이 있나 없나 판별함
					alist = new ArrayList<FnqVO>(end);
					do {
						FnqVO article = new FnqVO();
						article.setNum(rs.getInt("num"));
						article.setQuestion(rs.getString("question"));
						article.setAnswer(rs.getString("answer"));
						
						alist.add(article);
						
						} while(rs.next());
				}
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블의 자료 검색을 실패했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return alist;
		}	
		
		public List<FnqVO> getArticles(int start, int end, String sword){
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체
			List<FnqVO> alist = null;
			
			try {
				conn = getConnection();
				
				String sql = "select * from fnq where question like ? order by num desc limit ?, ?;";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setString(1, sword);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery(); // 4. sql query 실행됨
				
				if(rs.next()){ //id가 맞는것이 있나 없나 판별함
					alist = new ArrayList<FnqVO>(end);
					do {
						FnqVO article = new FnqVO();
						article.setNum(rs.getInt("num"));
						article.setQuestion(rs.getString("question"));
						article.setAnswer(rs.getString("answer"));
						
						alist.add(article);
						
						} while(rs.next());
				}
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블의 자료 검색을 실패했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return alist;
		}
		
		
		// 상세 글보기
		public FnqVO getArticle(int num){ //글번혼
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체
			FnqVO article = null;
			
			int result = 0;
			
			try {
				conn = getConnection();
				
				String sql = "select * from fnq where num=?";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery(); // 4. sql query 실행됨
				
				
				if(rs.next()){ //id가 맞는것이 있나 없나 판별함
					article = new FnqVO();
					article.setNum(rs.getInt("num"));
					article.setQuestion(rs.getString("question"));
					article.setAnswer(rs.getString("answer"));
				}
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블 상세 보기 레코드 검색을 실패했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return article;
		}
		
		//수정을 위한 상세글
		public FnqVO getArticleUpdate(int num){ //글번혼
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체
			FnqVO article = null;
			
			int result = 0;
			
			try {
				conn = getConnection();
				
				String sql = "select * from fnq where num=?";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery(); // 4. sql query 실행됨
				
				
				if(rs.next()){ //id가 맞는것이 있나 없나 판별함
					article = new FnqVO();
					article.setNum(rs.getInt("num"));
					article.setQuestion(rs.getString("question"));
					article.setAnswer(rs.getString("answer"));
				}
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블 상세 보기 레코드 검색을 실패했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return article;
		}
		
		public int updateFnq(FnqVO article) {
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체		
			int result = 0;
			
			try {
				conn = getConnection();
					
				String sql = "update fnq set question=?, answer=? where num=?"; 
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setString(1,article.getQuestion());
				pstmt.setString(2,article.getAnswer());
				pstmt.setInt(3, article.getNum());					
				pstmt.executeUpdate(); // 4. sql query 실행됨
						
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블의 글 수정에 문제가 발생했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return result;
		}	
		
		public int deleteFnq(int num) {
			Connection conn  = null; //데이터베이스 연결 객체
			PreparedStatement pstmt = null; // query 실행할 객체
			ResultSet rs = null; //select문 실행 결과를 저장하는 객체		
			int result = 0;
			
			try {
				conn = getConnection();
				
				String sql = "delete from fnq where num=?"; 
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				pstmt.setInt(1, num);					
				pstmt.executeUpdate(); // 4. sql query 실행됨
					
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("fnq 테이블의 글 삭제에 문제가 발생했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return result;
		}
		
		public int getArticleCount(String sword) {
			Connection conn = null;
			PreparedStatement pstmt = null; // query 실행
			ResultSet rs = null;
			int result = 0;
							
			try {			
				conn = getConnection();			
				//select count(*) from book where btitle like '%자료%';
				String sql = "select count(*) from fnq where question like ?";
				pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
				pstmt.setString(1,sword);
				rs = pstmt.executeQuery(); //4. sql query 실행
				
				if(rs.next()) {
					result = rs.getInt(1);				
				} 			
			} catch(Exception e) {
				e.printStackTrace();
				System.out.println("fnq 테이블의 레코드 전체수 검색을 실패했습니다!");
			} finally {
				//5. 자원 해제
				if(rs != null) try {rs.close();} catch(SQLException se) { }
				if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
				if(conn != null) try {conn.close();} catch(SQLException se) { }
			}
			
			return result;
		}
		
}
