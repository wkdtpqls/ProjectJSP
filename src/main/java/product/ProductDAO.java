package product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import product.ProductVO;

public class ProductDAO {

	private static ProductDAO instance = new ProductDAO();
	private ArrayList<ProductVO> listOfProducts = new ArrayList<ProductVO>();
	public static ProductDAO getInstance() {
		return instance;
	}
	
	private ProductDAO() { }
	
	private Connection getConnection() {		
		try {
			InitialContext ic = new InitialContext(); // JNDI 서버 객체 생성 
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/project"); // connection 객체 찾기
			Connection conn = ds.getConnection(); // connection 객체를 할당 받음
			return conn;
		} catch(Exception e) {
			System.out.println("product 데이터베이스 연결에 문제가 발생했습니다.");
			return null;
		}				
	}
	
	public void insertProduct(ProductVO article) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		
		try {			
			conn = getConnection();
			
			String sql = "insert into product(pnum, pid, ptitle, price, calory, sugar, caffeine, pimage, pcontent)";
			sql += "values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, article.getPnum());
			pstmt.setInt(2, article.getPid());
			pstmt.setString(3, article.getPtitle());
			pstmt.setInt(4, article.getPrice());
			pstmt.setInt(5, article.getCalory());
			pstmt.setInt(6, article.getSugar());
			pstmt.setInt(7, article.getCaffeine());
			pstmt.setString(8, article.getPimage());
			pstmt.setString(9, article.getPcontent());
			
			pstmt.executeUpdate(); //4. sql query 실행
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 테이블에 새로운 레코드 추가에 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
	}
	
	public List<ProductVO> getArticles(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<ProductVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			//select b.* 
			//from ( select rownum as rnum, a.*
			//	     from (select * from board order by num desc) a ) b
			//where b.rnum >= 1 and b.rnum <= 10;
			String sql = "select * from product order by pnum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
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
	
	//카테고리 리스트
	public List<ProductVO> getArticles(int pid, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<ProductVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			//select b.* 
			//from ( select rownum as rnum, a.*
			//	     from (select * from board order by num desc) a ) b
			//where b.rnum >= 1 and b.rnum <= 10;
			String sql = "select * from product where pid=? order by pnum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, pid);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
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
	
	//전체 메뉴 검색
	public List<ProductVO> getArticles(int start, int end, String sword) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<ProductVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			//select b.* 
			//from ( select rownum as rnum, a.*
			//	     from (select * from board order by num desc) a ) b
			//where b.rnum >= 1 and b.rnum <= 10;
			String sql = "select * from product where ptitle like ? order by pnum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, sword);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, end);
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
	
	//카테고리 메뉴 검색
	public List<ProductVO> getArticles(int start, int end, String sword, int pid) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<ProductVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			//select b.* 
			//from ( select rownum as rnum, a.*
			//	     from (select * from board order by num desc) a ) b
			//where b.rnum >= 1 and b.rnum <= 10;
			String sql = "select * from product where ptitle like ? and pid = ? order by pnum desc limit ?, ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, sword);
			pstmt.setInt(2, pid);
			pstmt.setInt(3, start-1);
			pstmt.setInt(4, end);
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
			
			String sql = "select count(*) from product";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 테이블의 레코드 전체수 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public int getCategoryCount(int pid) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
		
		try {			
			conn = getConnection();			
			
			String sql = "select count(*) from product where pid =?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, pid);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 테이블의 레코드 전체수 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public ProductVO getArticle(int pnum) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		ProductVO article = null;
		
		try {			
			conn = getConnection();	
			
			String sql = "select * from product where pnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				article = new ProductVO();
				article.setPnum(rs.getInt("pnum"));
				article.setPid(rs.getInt("pid"));
				article.setPtitle(rs.getString("ptitle"));	
				article.setPrice(rs.getInt("price"));
				article.setCalory(rs.getInt("calory"));
				article.setSugar(rs.getInt("sugar"));
				article.setCaffeine(rs.getInt("caffeine"));
				article.setPimage(rs.getString("pimage"));					
				article.setPcontent(rs.getString("pcontent"));		
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 테이블에 상세보기의 레코드 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return article;
	}	



	
	public void updateProduct(ProductVO article) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		
		try {			
			conn = getConnection();
			
			String sql = "update product set pid=?, ptitle=?,price=?, calory=?, sugar=?, caffeine=?, pcontent=?, pimage=? where pnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			
			pstmt.setInt(1, article.getPid());
			pstmt.setString(2, article.getPtitle());
			pstmt.setInt(3, article.getPrice());
			pstmt.setInt(4, article.getCalory());
			pstmt.setInt(5, article.getSugar());
			pstmt.setInt(6, article.getCaffeine());
			pstmt.setString(7, article.getPcontent());
			pstmt.setString(8, article.getPimage());
			pstmt.setInt(9, article.getPnum());
			
			pstmt.executeUpdate(); //4. sql query 실행

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 테이블의 글 수정을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}

	}
	
	public void deleteProduct(int pnum) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		
		try {			
			conn = getConnection();

			String sql = "delete from product where pnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, pnum);
			
			pstmt.executeUpdate(); //4. sql query 실행

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 테이블의 글 삭제를 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}

	}	
	
	
	public int getArticleCount(String sword) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
						
		try {			
			conn = getConnection();			
			//select count(*) from book where btitle like '%자료%';
			String sql = "select count(*) from product where ptitle like ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1,sword);
			
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 검색을 실패했습니다");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public int getArticleCount(String sword, int pid) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
						
		try {			
			conn = getConnection();			
			//select count(*) from book where btitle like '%자료%';
			String sql = "select count(*) from product where ptitle like ? and pid = ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1,sword);
			pstmt.setInt(2,pid);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("product 검색을 실패했습니다");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
}
