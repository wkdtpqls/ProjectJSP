create table reply(
     rnum int not null primary key auto_increment,
     rwriter varchar(20) not null,     
     reply varchar(500) not null,
     rreg_date datetime not null,
     ref int not null,
     FOREIGN KEY(rwriter) REFERENCES manager(id),
     FOREIGN KEY(ref) REFERENCES freeboard(num)
);


select * from reply;