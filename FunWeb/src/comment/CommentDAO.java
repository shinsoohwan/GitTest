package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Notice.NoticeBean;

public class CommentDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DB 연결
	public Connection getConnection() throws Exception {
		// context.xml
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB"); // 위치/이름
		con = ds.getConnection();

		return con;

	}

	// 기억장소 정리 - select
	public void closeDB(Connection con, PreparedStatement pstmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException ex) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException ex) {
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException ex) {
			}
		}
	}
	
	
	public List<CommentBean> selectComment(String tabref) {
		List<CommentBean> commentList = new ArrayList<CommentBean>();
		try {
			con = getConnection();

			String sql = "select * from comment where tabref=? order by num desc";// 최신게시글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, tabref);
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				CommentBean cb = new CommentBean();
				cb.setNum(rs.getInt("num"));
				cb.setName(rs.getString("name"));
				cb.setContent(rs.getString("content"));
				cb.setDate(rs.getDate("date"));
				cb.setTabref(rs.getString("tabref"));
				cb.setConref(rs.getInt("conref"));
				
				commentList.add(cb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return commentList;
	}
	
	public void insertComment(CommentBean cb) {
		int number = 0;
		try {
			con = getConnection();
			pstmt = con.prepareStatement("select max(num) from comment");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1) + 1;
			}else {
				number = 1;
			}
			
			String sql = "insert into comment values(?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, cb.getName());
			pstmt.setString(3, cb.getContent());
			pstmt.setString(4, cb.getTabref());
			pstmt.setInt(5, cb.getConref());

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
		
		
		
	}
	
}
