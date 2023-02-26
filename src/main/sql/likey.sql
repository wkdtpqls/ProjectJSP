create table likey(
     number int not null PRIMARY KEY auto_increment,
     id varchar(20) not null,
     reg_date datetime not null,
	 
     FOREIGN KEY(number) REFERENCES product(pnum),
     FOREIGN KEY(id) REFERENCES member(id)
);
drop table likey;
select * from likey;
insert into likey (number, id, reg_date) values (1,'aaa',now());
select * from product where pnum in(select number from likey where id = ?)order by number desc limit ?, ?;

select * from product where pnum in(select number from likey id ='aaa');