package Gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Gallery.GalleryBean;

public class GalleryDAO {
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

	// 갤러리의 전체 글 수 리턴
	public int getGalleryCount() {
		int gallerycount = 0;
		try {
			con = getConnection();

			String sql = "select count(*) from gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				gallerycount = rs.getInt(1);
			}
		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return gallerycount;
	}

	// paging 처리하여 갤러리의 글 가져오기
	public List<GalleryBean> getGalleryList(int startRow, int pageSize) {
		List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
		try {
			con = getConnection();

			String sql = "select * from gallery order by num desc limit ?,?";// 최신자료글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				GalleryBean gb = new GalleryBean();
				gb.setNum(rs.getInt("num"));
				gb.setWriter(rs.getString("writer"));
				gb.setTitle(rs.getString("title"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getDate("date"));
				gb.setFile(rs.getString("file"));

				galleryList.add(gb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return galleryList;

	}

	// 검색하여 paging 처리하여 갤러리의 글 가져오기
	public List<GalleryBean> getGalleryList(int startRow, int pageSize, String search) {
		List<GalleryBean> galleryList = new ArrayList<GalleryBean>();
		try {
			con = getConnection();

			String sql = "select * from gallery where title like ? order by num desc limit ?,?";// 최신자료글 맨 위로
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, '%' + search + '%');
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				GalleryBean gb = new GalleryBean();
				gb.setNum(rs.getInt("num"));
				gb.setWriter(rs.getString("writer"));
				gb.setTitle(rs.getString("title"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getDate("date"));
				gb.setFile(rs.getString("file"));

				galleryList.add(gb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return galleryList;

	}

	// 갤러리의 글 번호를 받아 읽은 횟수 +1
	public void updateReadcount(int num) {
		int readcount = 0;
		try {
			con = getConnection();

			String sql = "select readcount from gallery where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); // 에서
			if (rs.next()) {
				readcount = rs.getInt(1) + 1;
			}
			// 읽은 횟수 +1 후 저장
			sql = "update gallery set readcount = ? where num = ? ";
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

	// 갤러리의 글 정보 리턴
	public GalleryBean getGallery(GalleryBean gb) {
		try {
			con = getConnection();

			String sql = "select * from gallery where num=?"; // 조회 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gb.getNum());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				gb.setWriter(rs.getString("writer"));
				gb.setTitle(rs.getString("title"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getDate("date"));
				gb.setFile(rs.getString("file"));
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return gb;
	}

	// 마지막 갤러리의 글 번호 리턴
	public int galleryNum() {
		int galleryNum = 0;
		try {
			con = getConnection();

			String sql = "select max(num) from gallery";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				galleryNum = rs.getInt(1);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			// closeDB(con, pstmt, rs);
		}

		return galleryNum;
	}

	// 갤러리의 글 작성 - insert
	public void insertGallery(GalleryBean gb) {
		try {
			con = getConnection();

			int galleryNum = galleryNum() + 1;
			
			String sql = "insert into gallery(num,writer,title,readcount,date,file) values(?,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, galleryNum);
			pstmt.setString(2, gb.getWriter());
			pstmt.setString(3, gb.getTitle());
			pstmt.setInt(4, 0); // 생성하는 글이므로 읽은 횟수 0
			pstmt.setString(5, gb.getFile());

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
	}

	// 갤러리의 글 수정 - update
	public void updateGallery(GalleryBean gb) {
		try {
			con = getConnection();

			String sql = "update gallery set title=?, file=? where num=?";// 수정 쿼리문
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, gb.getTitle());
			pstmt.setString(2, gb.getFile());
			pstmt.setInt(3, gb.getNum());

			pstmt.executeUpdate(); // 이름 수정

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
	}

	// 갤러리의 글 삭제 - delete
	public void deleteGallery(GalleryBean gb) {
		try {
			con = getConnection();

			String sql = "delete from gallery where num=?"; // 삭제 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gb.getNum());

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
