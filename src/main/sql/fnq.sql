create table fnq(
     num int not null primary key auto_increment,     
     question varchar(250) null,
     answer varchar(250)  null   
);
drop table fnq;
insert into fnq(num,  question, answer) values (1,  '문의글111','답변111');
insert into fnq(num, question, answer) values (2,  '문의글222','답변222');
insert into fnq(num, question, answer) values (3,  '문의글333','답변333');
select * from fnq;