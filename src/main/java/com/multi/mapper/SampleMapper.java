package com.multi.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.multi.domain.NewsVO;

@Mapper
public interface SampleMapper {

	//SampleMapper.xml ==> mybatis-config.xml¿¡ µî·Ï
	public int createNews(NewsVO vo);
}
