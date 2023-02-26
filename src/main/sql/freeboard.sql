create table freeboard(
     num int not null primary key auto_increment,
     writer varchar(20) not null,     
     subject varchar(50) not null,
     reg_date datetime not null,
     readcount int default 0,
     content text not null,
     FOREIGN KEY(writer) REFERENCES member(id)
);
insert into freeboard(writer, subject, reg_date, content)
values ('manager', 'ABC Company 홈페이지 오픈', now(), 'ABC Company 홈페이지 오픈을 하였습니다!');
select * from freeboard where writer like 'aaa';
select * from freeboard;