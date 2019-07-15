package Board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Board.BoardBean;

public class BoardDAO {
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

	// 게시판의 전체 글 수 리턴
	public int getBoardCount() {
		int boardcount = 0;
		try {
			con = getConnection();

			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				boardcount = rs.getInt(1);
			}
		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return boardcount;
	}

	// paging 처리하여 게시판의 글 가져오기
	public List<BoardBean> getBoardList(int startRow, int pageSize) {
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		try {
			con = getConnection();

			String sql = "select * from board order by num desc limit ?,?";// 최신자료글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setTitle(rs.getString("title"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));

				boardList.add(bb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return boardList;

	}

	// 검색하여 paging 처리하여 게시판의 글 가져오기
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
		List<BoardBean> boardList = new ArrayList<BoardBean>();
		try {
			con = getConnection();

			String sql = "select * from board where title like ? order by num desc limit ?,?";// 최신자료글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, '%' + search + '%');
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setWriter(rs.getString("writer"));
				bb.setTitle(rs.getString("title"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));

				boardList.add(bb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return boardList;

	}

	// 자료글 번호를 받아 읽은 횟수 +1
	public void updateReadcount(int num) {
		int readcount = 0;
		try {
			con = getConnection();

			String sql = "select readcount from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); // 에서
			if (rs.next()) {
				readcount = rs.getInt(1) + 1;
			}
			// 읽은 횟수 +1 후 저장
			sql = "update board set readcount = ? where num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, readcount);
			pstmt.setInt(2, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
	}

	// 자료글 정보 리턴
	public BoardBean getBoard(BoardBean bb) {
		try {
			con = getConnection();

			String sql = "select * from board where num=?"; // 조회 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				bb.setWriter(rs.getString("writer"));
				bb.setTitle(rs.getString("title"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				bb.setFile(rs.getString("file"));
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);

		}
		return bb;
	}

	// 마지막 자료글 번호 리턴
	public int boardNum() {
		int boardNum = 0;
		try {
			con = getConnection();

			String sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				boardNum = rs.getInt(1);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			// closeDB(con, pstmt, rs);
		}

		return boardNum;
	}

	// 자료글 작성 - insert
	public void insertBoard(BoardBean bb) {
		try {
			con = getConnection();

			int boardNum = boardNum() + 1;
			
			String sql = "insert into board(num,writer,title,content,readcount,date,file) values(?,?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, boardNum);
			pstmt.setString(2, bb.getWriter());
			pstmt.setString(3, bb.getTitle());
			pstmt.setString(4, bb.getContent());
			pstmt.setInt(5, 0); // 생성하는 글이므로 읽은 횟수 0
			pstmt.setString(6, bb.getFile());

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
	}

	// 자료글 수정 - update
	public void updateBoard(BoardBean bb) {
		try {
			con = getConnection();

			String sql = "update board set title=?, content=?, file=? where num=?";// 수정 쿼리문
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, bb.getTitle());
			pstmt.setString(2, bb.getContent());
			pstmt.setString(3, bb.getFile());
			pstmt.setInt(4, bb.getNum());

			pstmt.executeUpdate(); // 이름 수정

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
	}

	// 자료글 삭제 - delete
	public void deleteBoard(BoardBean bb) {
		try {
			con = getConnection();

			String sql = "delete from board where num=?"; // 삭제 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
	}

}
