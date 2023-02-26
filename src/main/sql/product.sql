create table product(
     pnum int not null primary key auto_increment,
     pid int not null,
     ptitle varchar(100) not null,
     price int not null,
     calory int not null,
     sugar int not null,
     caffeine int not null,
     pimage varchar(100) default 'nothing.jpg',     
     pcontent text not null
);
select * from product where pid='1';
drop table product;
insert into product (pnum, pid, ptitle, price, calory, sugar, caffeine, pimage, pcontent) 
	values (1, 1, '아메리카노', 4000, 12, 0, 200, 'americano.jpg', '구운 견과류와 다크초콜릿의 풍미가 어우러진 대표 음료');
 select * from product;
 drop table product;
 