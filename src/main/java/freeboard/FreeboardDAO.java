package freeboard;

import  java.sql.*;
import  javax.sql.*;
import  javax.naming.*;

import java.util.ArrayList;
import java.util.List;

public class FreeboardDAO {
	
	private static FreeboardDAO instance = new FreeboardDAO();
	
	public static FreeboardDAO getInstance() {
		return instance;
	}
	
	private FreeboardDAO() { }
	
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
			System.out.println("freeboard 테이블의 아이디, 패스워드 확인에 문제가 발생했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return result;
	}	
	
	public void insertFreeboard(FreeboardVO article) { //게시글 하나를 insert 한다.
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		
		try { 
			conn = getConnection();
			// num,조회수는 자동이므로 컬럼명 지정해줌
			//insert into board(writer, email, subject, passwd, reg_date, content) values ('홍길동', 'aaa@aaa.com', '제목1', '123','now()','내용1');
			String sql = "insert into freeboard(writer, subject, reg_date, content)";
			sql += "values(?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1, article.getWriter());			
			pstmt.setString(2, article.getSubject());	
			pstmt.setString(3, article.getContent());
			pstmt.executeUpdate(); // 4. sql query 실행됨
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블 삽입에 문제가 발생했습니다.");
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
				
				String sql = "select count(*) from freeboard;";
				pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
				rs = pstmt.executeQuery(); // 4. sql query 실행됨
				
				if(rs.next()){ //id가 맞는것이 있나 없나 판별함
					result = rs.getInt(1);
				}
				
			} catch (Exception e){ //오류날 때 
				e.printStackTrace();
				System.out.println("freeboard 테이블의 자료 수 검색을 실패했습니다.");
			} finally {
				// 5. 자원 해제
				if(rs != null) try{rs.close();} catch(SQLException se) {}
				if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
				if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
			}
			
			return result;
		}
	public List<FreeboardVO> getArticles(int start, int end){
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		List<FreeboardVO> alist = null;
		
		try {
			conn = getConnection();
			
			String sql = "select * from freeboard  order by num desc limit ?, ?;";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				alist = new ArrayList<FreeboardVO>(end);
				do {
					FreeboardVO article = new FreeboardVO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					alist.add(article);
					
					} while(rs.next());
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블의 자료 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return alist;
	}	
	
	public List<FreeboardVO> getArticles(int start, int end, String sword){
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		List<FreeboardVO> alist = null;
		
		try {
			conn = getConnection();
			
			String sql = "select * from freeboard where writer like ? order by num desc limit ?, ?;";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1, sword);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				alist = new ArrayList<FreeboardVO>(end);
				do {
					FreeboardVO article = new FreeboardVO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					alist.add(article);
					
					} while(rs.next());
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블의 자료 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return alist;
	}
	
	public List<FreeboardVO> getArticles(String id, int start, int end){
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		List<FreeboardVO> alist = null;
		
		try {
			conn = getConnection();
			
			String sql = "select * from freeboard where writer = ? order by num desc limit ?, ?;";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1, id);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				alist = new ArrayList<FreeboardVO>(end);
				do {
					FreeboardVO article = new FreeboardVO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					
					alist.add(article);
					
					} while(rs.next());
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블의 자료 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return alist;
	}	
	// 상세 글보기
	public FreeboardVO getArticle(int num){ //글번혼
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		FreeboardVO article = null;
		
		int result = 0;
		
		try {
			conn = getConnection();
			//조회수
			String sql = "update freeboard set readcount=readcount+1 where num=?"; 
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, num);
			pstmt.executeUpdate(); // 4. sql query 실행됨
			
			sql = "select * from freeboard where num=?";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				article = new FreeboardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블 상세 보기 레코드 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return article;
	}
	
	//수정을 위한 상세글
	public FreeboardVO getArticleUpdate(int num){ //글번혼
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		FreeboardVO article = null;
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select * from freeboard where num=?";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				article = new FreeboardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setSubject(rs.getString("subject"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setContent(rs.getString("content"));
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블 상세 보기 레코드 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return article;
	}
	
	public int updateFreeboard(FreeboardVO article) {
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체		
		int result = 0;
		
		try {
			conn = getConnection();
				
			String sql = "update freeboard set  content=?, subject=? where num=?"; 
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1,article.getContent());
			pstmt.setString(2,article.getSubject());
			pstmt.setInt(3, article.getNum());					
			pstmt.executeUpdate(); // 4. sql query 실행됨
					
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블의 글 수정에 문제가 발생했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return result;
	}	
	
	public int deleteFreeboard(int num) {
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체		
		int result = 0;
		
		try {
			conn = getConnection();
				
			String sql = "delete from reply where ref=?"; 
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, num);					
			pstmt.executeUpdate(); // 4. sql query 실행됨
			
			sql = "delete from freeboard where num=?"; 
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setInt(1, num);					
			pstmt.executeUpdate(); // 4. sql query 실행됨
				
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("freeboard 테이블의 글 삭제에 문제가 발생했습니다.");
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
			String sql = "select count(*) from freeboard where subject like ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1,sword);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("freeboard 테이블의 레코드 전체수 검색을 실패했습니다!");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public int getBoardCount(String id) {
		Connection conn  = null; //데이터베이스 연결 객체
		PreparedStatement pstmt = null; // query 실행할 객체
		ResultSet rs = null; //select문 실행 결과를 저장하는 객체
		
		int result = 0;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from freeboard where writer = ?";
			pstmt = conn.prepareStatement(sql); // 3. sql을 실행할기 위한 객체 생성하기
			pstmt.setString(1,id);
			rs = pstmt.executeQuery(); // 4. sql query 실행됨
			
			if(rs.next()){ //id가 맞는것이 있나 없나 판별함
				result = rs.getInt(1);
			}
			
		} catch (Exception e){ //오류날 때 
			e.printStackTrace();
			System.out.println("문의내역 테이블의 자료 수 검색을 실패했습니다.");
		} finally {
			// 5. 자원 해제
			if(rs != null) try{rs.close();} catch(SQLException se) {}
			if(pstmt != null) try{pstmt.close();} catch(SQLException se) {}
			if(conn != null) try{conn.close();} catch(SQLException se) {} //연결해제
		}
		
		return result;
	}	
	
	// 게시물 답변
	public void replyBoard(FreeboardVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();	
			String sql = "insert into freeboard(writer, subject, reg_date, content)";
			sql += "values(?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());			
			pstmt.setString(2, article.getSubject());	
			pstmt.setString(3, article.getContent());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) try{pstmt.close();} catch(Exception se) {}
			if(conn != null) try{conn.close();} catch(Exception se) {} //연결 해제
		}
	}
	   public int deleteMemberFreeboard(String id) {   
		      Connection conn = null;         // 데이터베이스 연결할 객체
		      PreparedStatement pstmt = null;   // query 실행 객체
		      ResultSet rs = null;         // select문 실행 결과를 저장하는 객체
		      
		      int result = 0;
		      
		      try {
		         conn = getConnection();
		                  
		         String sql = "delete from freeboard where writer=?;";   // 쿼리 구문
		         pstmt  = conn.prepareStatement(sql);
		         pstmt.setString(1, id);
		         pstmt.executeUpdate(); // 4. sql query 실행 -  개수 반환
		               
		      }catch(Exception e){
		         e.printStackTrace();
		         System.out.println("Freeboard 테이블의 글 삭제에 문제가 발생했습니다.");
		      }finally{   // 5. 자원 해제
		         if(rs != null) try{rs.close();}catch(SQLException se){}      // 예외 처리 해줘야함
		         if(pstmt != null) try{pstmt.close();}catch(SQLException se){}
		         if(conn != null) try{conn.close();}catch(SQLException se){}   //연결 해제
		      }
		      
		      return result;
		   }
}
	

