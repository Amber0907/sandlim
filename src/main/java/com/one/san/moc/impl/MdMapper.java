package com.one.san.moc.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.one.san.moc.MdVO;

public class MdMapper implements RowMapper<MdVO> {
	
	@Override
	public MdVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		MdVO md = new MdVO();
		md.setM_no(rs.getInt("m_no"));
		md.setM_name(rs.getString("m_name"));
		md.setM_img(rs.getString("m_img"));
		md.setM_price(rs.getInt("m_price"));
		md.setM_content(rs.getString("m_content"));
		md.setM_kind(rs.getString("m_kind"));
		md.setM_sugar(rs.getInt("m_sugar"));
		md.setM_kcal(rs.getInt("m_kcal"));
		md.setM_sfat(rs.getInt("m_sfat"));
		md.setM_nat(rs.getInt("m_nat"));
		md.setM_pro(rs.getInt("m_pro"));
		md.setM_cafe(rs.getInt("m_cafe"));
		md.setM_hi(rs.getString("m_hi"));
		md.setM_size(rs.getString("m_size"));
		md.setM_state(rs.getString("m_state"));
		md.setM_sel(rs.getString("m_sel"));
		
		return md;
		
	}
}
