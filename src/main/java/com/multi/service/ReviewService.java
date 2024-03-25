package com.multi.service;

import java.util.List;

import com.multi.domain.ReviewVO;

public interface ReviewService {

	int insertReview(ReviewVO rvo);
	
	List<ReviewVO> getReviewList(int pnum);
	int getReviewCount(int pnum);
	
	ReviewVO getReview(int no);//���� �۹�ȣ(PK)�� ��ǰ�� ��������
	int deleteReview(int no);
	int updateReview(ReviewVO rvo);
	
}
