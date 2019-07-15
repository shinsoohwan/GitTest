package Board;

import java.sql.Date;

public class BoardBean {

	private int num;
	private String writer;
	private String title;
	private String content;
	private int readcount;
	private Date date;
	private String file;
	private int re_ref;
	private int re_lev;
	private int re_seq;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public int getRe_ref() {
		return re_ref;
	}

	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}

	public int getRe_lev() {
		return re_lev;
	}

	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}

	public int getRe_seq() {
		return re_seq;
	}

	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}

	
}
