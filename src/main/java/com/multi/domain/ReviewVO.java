package com.multi.domain;

import lombok.Data;

@Data
public class ReviewVO {

	private int no;
	private String userid;//fk
	private int pnum;//fk
	
	private String title;
	private String content;
	private int score;
	private String filename;
	
	private java.sql.Date wdate;
}
