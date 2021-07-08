select * from tbl_board;

insert into tbl_board (bno,title,content,writer,category,catename) 
(select seq_board.nextval, title, content,writer, category, catename from tbl_board);

select /*+ INDEX_DESC(tbl_board pk_board) */ * from tbl_board where category='free';

create sequence seq_board; 
drop sequence seq_board;

drop table tbl_board;
create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null, 
    content varchar2(2000) not null, 
    category varchar2(100) not null,
    cateName varchar2(100) not null,
    writer varchar2(50) not null, 
    regDate date default sysdate, 
    updateDate date default sysdate
); 

alter table tbl_board add constraint pk_board primary key(bno); 


insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'공지사항 제목', '공지사항 내용', '테스트01', 'notice', '공지사항' );

insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'자유게시판 제목', '자유게시판', '테스트02', 'free', '자유게시판' );

insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'전략전술 제목', '전략전술 내용', '테스트03', 'strategy', '전략전술' );

insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'묻고답하기 제목', '묻고답하기 내용', '테스트04', 'qna', '묻고답하기' );

commit; 

