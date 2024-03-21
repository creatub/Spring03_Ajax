package com.multi.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //기본생성자 생성
@AllArgsConstructor // 인자생성자 (파라미터를 받는 생성자 생기고 @Data로 만들어진 기본생성자 없어짐)
@NoArgsConstructor // 기본생성자 Overload
public class UserVO {

	private int no;
	private String name;
	private String addr;
	private String phone;
}
