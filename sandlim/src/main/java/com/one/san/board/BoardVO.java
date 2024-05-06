package com.one.san.board;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	
	private int b_num;
	private String b_sort;
	private String b_cat;
	private String b_title;
	private String b_nick;
	private Date b_date;
	private String b_content;
	private String b_file;
	private String b_status;
	private String b_cnt;
	private String b_rev;
	
	//마이바티스를 사용하기 위해 필요한 멤버필드
	private String searchCondition;
	private String searchKeyword;
	//업로드한 파일에 대한 정보와 데이터를 담아오는 객체(멤버필드)
	private MultipartFile uploadB_file;
	
	
	public String getB_cnt() {
		return b_cnt;
	}
	public void setB_cnt(String b_cnt) {
		this.b_cnt = b_cnt;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public MultipartFile getUploadB_file() {
		return uploadB_file;
	}
	public void setUploadB_file(MultipartFile uploadB_file) {
		this.uploadB_file = uploadB_file;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getB_sort() {
		return b_sort;
	}
	public void setB_sort(String b_sort) {
		this.b_sort = b_sort;
	}
	public String getB_cat() {
		return b_cat;
	}
	public void setB_cat(String b_cat) {
		this.b_cat = b_cat;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_nick() {
		return b_nick;
	}
	public void setB_nick(String b_nick) {
		this.b_nick = b_nick;
	}
	public Date getB_date() {
		return b_date;
	}
	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_file() {
		return b_file;
	}
	public void setB_file(String b_file) {
		this.b_file = b_file;
	}
	public String getB_status() {
		return b_status;
	}
	public void setB_status(String b_status) {
		this.b_status = b_status;
	}
	public String getB_rev() {
		return b_rev;
	}
	public void setB_rev(String b_rev) {
		this.b_rev = b_rev;
	}
	@Override
	public String toString() {
		return "BoardVO [b_num=" + b_num + ", b_sort=" + b_sort + ", b_cat=" + b_cat + ", b_title=" + b_title
				+ ", b_nick=" + b_nick + ", b_date=" + b_date + ", b_content=" + b_content + ", b_file=" + b_file
				+ ", b_status=" + b_status + ", b_rev=" + b_rev + ", searchCondition=" + searchCondition
				+ ", searchKeyword=" + searchKeyword + ", uploadB_file=" + uploadB_file + "]";
	}
	

	
}
