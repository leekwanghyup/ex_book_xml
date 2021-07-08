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
values (seq_board.nextval,'�������� ����', '�������� ����', '�׽�Ʈ01', 'notice', '��������' );

insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'�����Խ��� ����', '�����Խ���', '�׽�Ʈ02', 'free', '�����Խ���' );

insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'�������� ����', '�������� ����', '�׽�Ʈ03', 'strategy', '��������' );

insert into tbl_board(bno, title, content, writer, category, cateName)
values (seq_board.nextval,'������ϱ� ����', '������ϱ� ����', '�׽�Ʈ04', 'qna', '������ϱ�' );

commit; 

