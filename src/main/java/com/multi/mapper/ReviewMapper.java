package com.multi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.multi.domain.ReviewVO;

@Mapper
public interface ReviewMapper {
	int insertReview(ReviewVO rvo);
	
	List<ReviewVO> getReviewList(int pnum);
	int getReviewCount(int pnum);
	
	ReviewVO getReview(int no);//리뷰 글번호(PK)로 상품글 가져오기
	int deleteReview(int no);
	int updateReview(ReviewVO rvo);
}
