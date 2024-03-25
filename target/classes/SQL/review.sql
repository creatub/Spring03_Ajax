
drop table review;
-- products 테이블의 pnum(PK)과 member 테이블의 userid(PK)를 외래키로 참조
-- 일단 ajax로 간단하게 테스트하기 위해 외래키 관계를 생략하고 생성
create table review(
	no number(8) primary key, --리뷰 글번호
	userid varchar2(20) not null, --references member(userid)
	pnum number(8) not null, --references products(pnum) on delete cascade,
	title varchar2(200) not null, -- 제목
	content varchar2(500), --리뷰 글 내용
	score number(1) constraint score_ck check(score>0 and score<=5),
	filename varchar2(300), --첨부파일명
	wdate date default sysdate
);

drop sequence review_seq;

create sequence review_seq nocache;

