package comment;

import java.sql.Date;

public class CommentBean {
	private int num;	// 코멘트 고유 번호
	private String name;	// 작성자 이름
	private String content;	// 코멘트 내용
	private Date date;	// 작성 날짜
	private String tabref;	// 판의 종류 ( notice, board, gallery)
	private int conref;	// 코멘트 달린 게시글 번호
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getTabref() {
		return tabref;
	}
	public void setTabref(String tabref) {
		this.tabref = tabref;
	}
	public int getConref() {
		return conref;
	}
	public void setConref(int conref) {
		this.conref = conref;
	}
	
	
	
}
