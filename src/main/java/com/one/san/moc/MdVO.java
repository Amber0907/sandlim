package com.one.san.moc;

import org.springframework.web.multipart.MultipartFile;

public class MdVO {
	private int m_no;
	private String m_name;
	private String m_img;
	private int m_price;
	private String m_content;
	private String m_kind;
	private int m_sugar;
	private int m_kcal;
	private int m_sfat;
	private int m_nat;
	private int m_pro;
	private int m_cafe;
	private String m_hi;
	private String m_size;
	private String m_state;
	private String m_sel;
	private int m_fat;
	private int m_carbo; 

	
	private MultipartFile uploadfile;
	private String searchKeyword;
	private String searchCondition;
	
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_img() {
		return m_img;
	}
	public void setM_img(String m_img) {
		this.m_img = m_img;
	}
	public int getM_price() {
		return m_price;
	}
	public void setM_price(int m_price) {
		this.m_price = m_price;
	}
	public String getM_content() {
		return m_content;
	}
	public void setM_content(String m_content) {
		this.m_content = m_content;
	}
	public String getM_kind() {
		return m_kind;
	}
	public void setM_kind(String m_kind) {
		this.m_kind = m_kind;
	}
	public int getM_sugar() {
		return m_sugar;
	}
	public void setM_sugar(int m_sugar) {
		this.m_sugar = m_sugar;
	}
	public int getM_kcal() {
		return m_kcal;
	}
	public void setM_kcal(int m_kcal) {
		this.m_kcal = m_kcal;
	}
	public int getM_sfat() {
		return m_sfat;
	}
	public void setM_sfat(int m_sfat) {
		this.m_sfat = m_sfat;
	}
	public int getM_nat() {
		return m_nat;
	}
	public void setM_nat(int m_nat) {
		this.m_nat = m_nat;
	}
	public int getM_pro() {
		return m_pro;
	}
	public void setM_pro(int m_pro) {
		this.m_pro = m_pro;
	}
	public int getM_cafe() {
		return m_cafe;
	}
	public void setM_cafe(int m_cafe) {
		this.m_cafe = m_cafe;
	}
	public String getM_hi() {
		return m_hi;
	}
	public void setM_hi(String m_hi) {
		this.m_hi = m_hi;
	}
	public String getM_size() {
		return m_size;
	}
	public void setM_size(String m_size) {
		this.m_size = m_size;
	}

	public String getM_state() {
		return m_state;
	}
	public void setM_state(String m_state) {
		this.m_state = m_state;
	}
	
	public String getM_sel() {
		return m_sel;
	}
	public void setM_sel(String m_sel) {
		this.m_sel = m_sel;
	}
	public int getM_fat() {
		return m_fat;
	}
	public void setM_fat(int m_fat) {
		this.m_fat = m_fat;
	}
	public int getM_carbo() {
		return m_carbo;
	}
	public void setM_carbo(int m_carbo) {
		this.m_carbo = m_carbo;
	}


	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	
	@Override
	public String toString() {
		return "MdVO [m_no=" + m_no + ", m_name=" + m_name + ", m_img=" + m_img + ", m_price=" + m_price
				+ ", m_content=" + m_content + ", m_kind=" + m_kind + ", m_sugar=" + m_sugar + ", m_kcal=" + m_kcal
				+ ", m_sfat=" + m_sfat + ", m_nat=" + m_nat + ", m_pro=" + m_pro + ", m_cafe=" + m_cafe + ", m_hi="
				+ m_hi + ", m_size=" + m_size + ", m_state=" + m_state + ", m_sel=" + m_sel + ", m_fat=" + m_fat
				+ ", m_carbo=" + m_carbo + ", uploadfile=" + uploadfile + ", searchKeyword=" + searchKeyword
				+ ", searchCondition=" + searchCondition + "]";
	}
}
