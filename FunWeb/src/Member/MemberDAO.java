package Member;

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

public class MemberDAO {
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

	// ID, pass 검사 - 로그인, 회원정보 수정
	public int userCheck(MemberBean mb) {
		try {
			con = getConnection();

			String sql = "select id, pass, name from member where id=?"; // 로그인 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());

			rs = pstmt.executeQuery();

			if (rs.next()) { // 아이디 존재
				if (rs.getString("pass").equals(mb.getPass())) { // pass 일치
					mb.setName(rs.getString("name"));
					return 1;
				} else // pass 불일치
					return 0;
			} else // 아이디 없음
				return -1;

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
		return -2;
	}

	// ID 회원정보 리턴 - select
	public MemberBean getMember(MemberBean mb) {
		try {
			con = getConnection();

			String sql = "select * from member where id=?"; // 조회 쿼리문
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setEmail(rs.getString("email"));
				mb.setZip(rs.getString("zip"));
				mb.setAddr1(rs.getString("addr1"));
				mb.setAddr2(rs.getString("addr2"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
		return mb;
	}

	// 회원가입 - insert
	public void insertMember(MemberBean mb) {
		try {
			con = getConnection();

			String sql = "insert into member(id,pass,name,reg_date,email,zip,addr1,addr2,phone,mobile) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getReg_date());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getZip());
			pstmt.setString(7, mb.getAddr1());
			pstmt.setString(8, mb.getAddr2());
			pstmt.setString(9, mb.getPhone());
			pstmt.setString(10, mb.getMobile());

			pstmt.executeUpdate();

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
	}

	// 회원정보수정 - update
	public void updateMember(MemberBean mb) {
		try {
			con = getConnection();

			String sql = "update member set pass=?, name=?, email=?, zip=?, addr1=?, addr2=?, phone=?, mobile=? where id=?"; // 수정 쿼리문
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, mb.getPass());
			pstmt.setString(2, mb.getName());
			pstmt.setString(3, mb.getEmail());
			pstmt.setString(4, mb.getZip());
			pstmt.setString(5, mb.getAddr1());
			pstmt.setString(6, mb.getAddr2());
			pstmt.setString(7, mb.getPhone());
			pstmt.setString(8, mb.getMobile());
			pstmt.setString(9, mb.getId());

			pstmt.executeUpdate(); // 이름 수정

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}
	}

	public int idCheck(String fid) {
		try {
			con = getConnection();

			String sql = "select id from member";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) { // 모든 아이디 검사
				if (fid.equals(rs.getString("id"))) { // id 일치하면
					return 1; // fid 는 중복되는 id 존재
				}
			}
			return 0; // fid 는 중복되는 id 없음

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳

			e.printStackTrace();
		} finally {
			closeDB(con, pstmt, rs);
		}

		return -1;
	}

	// ----------------이메일 보내기-------------

	// 이름과 이메일 가져오기
	public List<MemberBean> getMemberList() {
		List<MemberBean> memberList = new ArrayList<MemberBean>();
		try {
			con = getConnection();

			String sql = "select name, email from member order by name";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setName(rs.getString("name"));
				mb.setEmail(rs.getString("email"));

				memberList.add(mb);
			}

		} catch (Exception e) {
			// 예외,에러가 발생하면 처리하는 곳
			e.printStackTrace();
		} finally {
			// 예외발생 상관없이 처리되는 문장
			closeDB(con, pstmt, rs);
		}
		return memberList;

	}

}
