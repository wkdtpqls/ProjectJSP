create table member(
	id varchar(20) primary key,
	passwd varchar(20) not null,
	name varchar(20) not null,
	reg_date datetime not null
);

insert into member
     values ('aaa', 'aaa', '홍길동', now());

insert into member
     values ('bbb', 'bbb', '이순신', now());
     
insert into member
     values ('manager', 'manager', '관리자', now());  
select * from member order by reg_date desc;