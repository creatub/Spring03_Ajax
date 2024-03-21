package com.multi.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.domain.NewsVO;
import com.multi.mapper.SampleMapper;

@Service
public class SampleServiceImpl implements SampleService {

	@Inject
	private SampleMapper sMapper;
	
	@Override
	public int createNews(NewsVO vo) {
		return sMapper.createNews(vo);
	}

}
