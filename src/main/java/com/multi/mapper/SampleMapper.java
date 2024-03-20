package com.multi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface SampleMapper {

	//java_member 테이블에서 회원수 가져오기
	@Select("select count(id) from java_member")
	public int getMemberCount();
	
	public List<String> getMemberNames();//SampleMapper.xml==>mybatis
}
