package Notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class NoticeDAO {
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

	// 기억장소 정리
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
	public int getNoticeCount() {
		int noticecount = 0;
		try {
			con = getConnection();

			String sql = "select count(*) from notice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticecount = rs.getInt(1);
			}
		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return noticecount;
	}

	// paging 처리하여 게시판의 글 가져오기
	public List<NoticeBean> getNoticeList(int startRow, int pageSize) {
		List<NoticeBean> noticeList = new ArrayList<NoticeBean>();
		try {
			con = getConnection();

			String sql = "select * from notice order by num desc limit ?,?";// 최신게시글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeBean nb = new NoticeBean();
				nb.setNum(rs.getInt("num"));
				nb.setWriter(rs.getString("writer"));
				nb.setTitle(rs.getString("title"));
				nb.setReadcount(rs.getInt("readcount"));
				nb.setDate(rs.getDate("date"));

				noticeList.add(nb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return noticeList;

	}

	// 검색할때 paging 처리하여 게시판의 글 가져오기
	public List<NoticeBean> getNoticeList(int startRow, int pageSize, String search) {
		List<NoticeBean> noticeList = new ArrayList<NoticeBean>();
		try {
			con = getConnection();

			String sql = "select * from notice where title like ? order by num desc limit ?,?";// 최신게시글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, '%' + search + '%');
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				NoticeBean nb = new NoticeBean();
				nb.setNum(rs.getInt("num"));
				nb.setWriter(rs.getString("writer"));
				nb.setTitle(rs.getString("title"));
				nb.setReadcount(rs.getInt("readcount"));
				nb.setDate(rs.getDate("date"));

				noticeList.add(nb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return noticeList;

	}

	// 게시글 번호를 받아 읽은 횟수 +1
	public void updateReadcount(int num) {
		int readcount = 0;
		try {
			con = getConnection();

			String sql = "select readcount from notice where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); // 에서
			if (rs.next()) {
				readcount = rs.getInt(1) + 1;
			}
			// 읽은 횟수 +1 후 저장
			sql = "update notice set readcount = ? where num = ? ";
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

	// 게시글 정보 리턴 - select
	public NoticeBean getNotice(NoticeBean nb) {
		try {
			con = getConnection();

			String sql = "select * from notice where num=?"; // 조회 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nb.getNum());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nb.setWriter(rs.getString("writer"));
				nb.setTitle(rs.getString("title"));
				nb.setContent(rs.getString("content"));
				nb.setReadcount(rs.getInt("readcount"));
				nb.setDate(rs.getDate("date"));
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);

		}
		return nb;
	}

	// 마지막 게시글 번호 리턴
	public int noticeNum() {
		int noticeNum = 0;
		try {
			con = getConnection();

			String sql = "select max(num) from notice";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				noticeNum = rs.getInt(1);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			// closeDB(con, pstmt, rs);
		}

		return noticeNum;
	}

	// 게시글 작성 - insert
	public void insertNotice(NoticeBean nb) {
		try {
			con = getConnection();

			int noticeNum = noticeNum() + 1;
			
			String sql = "insert into notice(num, writer, title, content, readcount, date) values(?, ?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, noticeNum);
			pstmt.setString(2, nb.getWriter());
			pstmt.setString(3, nb.getTitle());
			pstmt.setString(4, nb.getContent());
			pstmt.setInt(5, 0);

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
	}

	// 게시글 수정 - update
	public void updateNotice(NoticeBean nb) {
		try {
			con = getConnection();

			String sql = "update notice set title=?, content=? where num=?";// 수정 쿼리문
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, nb.getTitle());
			pstmt.setString(2, nb.getContent());
			pstmt.setInt(3, nb.getNum());

			pstmt.executeUpdate(); // 이름 수정

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
	}

	// 게시글 삭제 - delete
	public void deleteNotice(NoticeBean nb) {
		try {
			con = getConnection();

			String sql = "delete from notice where num=?"; // 삭제 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, nb.getNum());

			pstmt.executeUpdate(); // 이름 삭제

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
	}

}
