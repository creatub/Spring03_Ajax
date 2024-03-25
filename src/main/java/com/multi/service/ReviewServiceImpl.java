package com.multi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.multi.domain.ReviewVO;
import com.multi.mapper.ReviewMapper;

import lombok.RequiredArgsConstructor;

@Service("reviewService")
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

	private final ReviewMapper rMapper;
	
	@Override
	public int insertReview(ReviewVO rvo) {
		return rMapper.insertReview(rvo);
	}

	@Override
	public List<ReviewVO> getReviewList(int pnum) {
		return rMapper.getReviewList(pnum);
	}

	@Override
	public int getReviewCount(int pnum) {
		return rMapper.getReviewCount(pnum);
	}

	@Override
	public ReviewVO getReview(int no) {
		return rMapper.getReview(no);
	}

	@Override
	public int deleteReview(int no) {
		return rMapper.deleteReview(no);
	}

	@Override
	public int updateReview(ReviewVO rvo) {
		return rMapper.updateReview(rvo);
	}

}
