package com.multi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.multi.domain.ReviewVO;

@Mapper
public interface ReviewMapper {
	int insertReview(ReviewVO rvo);
	
	List<ReviewVO> getReviewList(int pnum);
	int getReviewCount(int pnum);
	
	ReviewVO getReview(int no);//���� �۹�ȣ(PK)�� ��ǰ�� ��������
	int deleteReview(int no);
	int updateReview(ReviewVO rvo);
}
