alter table target_mapping add md5 varchar(32) after items;

/*========================2015-5-28=============================*/
drop table if exists target_group;

create table target_group
(
  id                   bigint not null auto_increment,
  user_id              bigint not null,
  name                 varchar(32) not null,
  position             int not null comment '排序序号',
  status               int not null comment '1.正常 2.隐藏',
  description          varchar(64) comment '描述',
  create_time          bigint not null,
  primary key (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index idx_user_id on target_group
(
  user_id
);

create index idx_position on target_group
(
  position
);

create index idx_status on target_group
(
  status
);

create index idx_create_time on target_group
(
  create_time
);



drop table if exists target_group_rel;

create table target_group_rel
(
  id                   bigint not null auto_increment,
  target_id            bigint not null,
  target_group_id      bigint not null,
  position             int not null comment '排序序号',
  create_time          bigint not null,
  primary key (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create index idx_target_id on target_group_rel
(
  target_id
);

create index idx_group_id on target_group_rel
(
  target_group_id
);

create unique index idx_uq_target_group_id on target_group_rel
(
  target_id,
  target_group_id
);

create index idx_position on target_group_rel
(
  position
);

create index idx_create_time on target_group_rel
(
  create_time
);


/*========================2015-7-16=============================*/

alter table target_point add column parent_id bigint after regex;

alter table target_point add column create_time bigint after status;


create index idx_tp_parent_id on target_point
(
  parent_id
);

create index idx_tp_status on target_point
(
  status
);
