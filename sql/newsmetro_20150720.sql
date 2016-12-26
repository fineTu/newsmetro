drop table if exists news;

drop table if exists news_content;

drop table if exists target;

drop table if exists target_group;

drop table if exists target_group_rel;

drop table if exists target_mapping;

drop table if exists user;

drop table if exists user_info;

/*==============================================================*/
/* Table: news                                                  */
/*==============================================================*/
create table news
(
   id                   bigint not null auto_increment,
   target_id            bigint not null,
   target_md5           varchar(32) not null,
   news_id              bigint,
   title                varchar(128) not null comment '排序序号',
   link                 varchar(256),
   status               int comment '1.在线 2.删除',
   publish_time         bigint,
   create_time          bigint not null,
   primary key (id)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: idx_target_id                                         */
/*==============================================================*/
create index idx_target_id on news
(
   target_id
);

/*==============================================================*/
/* Index: idx_target_md5                                        */
/*==============================================================*/
create index idx_target_md5 on news
(
   target_md5
);

/*==============================================================*/
/* Index: idx_news_id                                           */
/*==============================================================*/
create index idx_news_id on news
(
   news_id
);

/*==============================================================*/
/* Index: idx_link                                              */
/*==============================================================*/
create index idx_link on news
(
   link
);

/*==============================================================*/
/* Index: idx_status                                            */
/*==============================================================*/
create index idx_status on news
(
   status
);

/*==============================================================*/
/* Index: idx_publish_time                                      */
/*==============================================================*/
create index idx_publish_time on news
(
   publish_time
);

/*==============================================================*/
/* Index: idx_create_time                                       */
/*==============================================================*/
create index idx_create_time on news
(
   create_time
);

/*==============================================================*/
/* Table: news_content                                          */
/*==============================================================*/
create table news_content
(
   id                   bigint not null auto_increment,
   news_id              bigint not null,
   content              text not null comment '排序序号',
   create_time          bigint not null,
   primary key (id)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: idx_news_id                                           */
/*==============================================================*/
create index idx_news_id on news_content
(
   news_id
);

/*==============================================================*/
/* Index: idx_create_time                                       */
/*==============================================================*/
create index idx_create_time on news_content
(
   create_time
);

/*==============================================================*/
/* Table: target                                                */
/*==============================================================*/
create table target
(
   id                   bigint(11) not null auto_increment,
   user_id              bigint(11) not null,
   name                 varchar(45) not null comment '目标名称',
   url                  varchar(512) not null comment '目标所在url',
   abs_xpath            varchar(255) comment '绝对xpath',
   rel_xpath            varchar(255) comment '相对xpath',
   regex                varchar(128) comment '目标元素的正则分析',
   parent_id            bigint(11),
   md5                  varchar(128) comment '目标的md5值，用来判定是否更新',
   type                 int not null comment '1.web资源 2.rss 3.用户target',
   status               varchar(45) not null comment '目标状态，正常、隐藏',
   create_time          bigint(20),
   primary key (id)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: idx_tp_uid                                            */
/*==============================================================*/
create index idx_tp_uid on target
(
   user_id
);

/*==============================================================*/
/* Index: idx_tp_url                                            */
/*==============================================================*/
create index idx_tp_url on target
(
   url
);

/*==============================================================*/
/* Index: idx_tp_rel_xpath                                      */
/*==============================================================*/
create index idx_tp_rel_xpath on target
(
   rel_xpath
);

/*==============================================================*/
/* Index: idx_tp_parent_id                                      */
/*==============================================================*/
create index idx_tp_parent_id on target
(
   parent_id
);

/*==============================================================*/
/* Index: idx_tp_md5                                            */
/*==============================================================*/
create index idx_tp_md5 on target
(
   md5
);

/*==============================================================*/
/* Index: idx_tp_status                                         */
/*==============================================================*/
create index idx_tp_status on target
(
   status
);

/*==============================================================*/
/* Index: idx_tp_create_time                                    */
/*==============================================================*/
create index idx_tp_create_time on target
(
   create_time
);

/*==============================================================*/
/* Table: target_group                                          */
/*==============================================================*/
create table target_group
(
   id                   bigint not null auto_increment,
   user_id              bigint not null,
   name                 varchar(32) character set utf8 not null,
   position             int not null comment '排序序号',
   status               int not null comment '1.正常 2.隐藏',
   description          varchar(64) character set utf8 comment '描述',
   create_time          bigint not null,
   primary key (id)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: idx_user_id                                           */
/*==============================================================*/
create index idx_user_id on target_group
(
   user_id
);

/*==============================================================*/
/* Index: idx_position                                          */
/*==============================================================*/
create index idx_position on target_group
(
   position
);

/*==============================================================*/
/* Index: idx_status                                            */
/*==============================================================*/
create index idx_status on target_group
(
   status
);

/*==============================================================*/
/* Index: idx_create_time                                       */
/*==============================================================*/
create index idx_create_time on target_group
(
   create_time
);

/*==============================================================*/
/* Table: target_group_rel                                      */
/*==============================================================*/
create table target_group_rel
(
   id                   bigint not null auto_increment,
   target_id            bigint not null,
   target_group_id      bigint not null,
   position             int not null comment '排序序号',
   create_time          bigint not null,
   primary key (id)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: idx_target_id                                         */
/*==============================================================*/
create index idx_target_id on target_group_rel
(
   target_id
);

/*==============================================================*/
/* Index: idx_group_id                                          */
/*==============================================================*/
create index idx_group_id on target_group_rel
(
   target_group_id
);

/*==============================================================*/
/* Index: idx_uq_target_group_id                                */
/*==============================================================*/
create unique index idx_uq_target_group_id on target_group_rel
(
   target_id,
   target_group_id
);

/*==============================================================*/
/* Index: idx_position                                          */
/*==============================================================*/
create index idx_position on target_group_rel
(
   position
);

/*==============================================================*/
/* Index: idx_create_time                                       */
/*==============================================================*/
create index idx_create_time on target_group_rel
(
   create_time
);

/*==============================================================*/
/* Table: target_mapping                                        */
/*==============================================================*/
create table target_mapping
(
   id                   bigint(11) not null auto_increment,
   target_id            bigint(11) not null,
   items                text,
   md5                  varchar(32),
   update_time          bigint not null,
   primary key (id)
)
ENGINE=MyISAM
DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: un_idx_tm_target_id                                   */
/*==============================================================*/
create unique index un_idx_tm_target_id on target_mapping
(
   target_id
);

/*==============================================================*/
/* Index: idx_tm_md5                                            */
/*==============================================================*/
create index idx_tm_md5 on target_mapping
(
   md5
);

/*==============================================================*/
/* Index: idx_tm_update_time                                    */
/*==============================================================*/
create index idx_tm_update_time on target_mapping
(
   update_time
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id                   bigint(11) not null auto_increment,
   password             varchar(45) not null,
   email                varchar(45) not null,
   status               int not null comment '1.正常 2.未激活',
   code                 varchar(255),
   create_time          bigint not null,
   primary key (id)
)
DEFAULT CHARSET=utf8
ENGINE=InnoDB;

/*==============================================================*/
/* Index: idx_password                                          */
/*==============================================================*/
create index idx_password on user
(
   password
);

/*==============================================================*/
/* Index: idx_email                                             */
/*==============================================================*/
create unique index idx_email on user
(
   email
);

/*==============================================================*/
/* Index: idx_status                                            */
/*==============================================================*/
create index idx_status on user
(
   status
);

/*==============================================================*/
/* Index: idx_create_time                                       */
/*==============================================================*/
create index idx_create_time on user
(
   create_time
);

/*==============================================================*/
/* Table: user_info                                             */
/*==============================================================*/
create table user_info
(
   id                   bigint(11) not null auto_increment,
   user_id              bigint not null,
   name                 varchar(45) not null,
   photo                varchar(256),
   sex                  int,
   sign                 varchar(128),
   update_time          bigint,
   create_time          bigint not null,
   primary key (id)
)
ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*==============================================================*/
/* Index: idx_user_id                                           */
/*==============================================================*/
create unique index idx_user_id on user_info
(
   user_id
);

/*==============================================================*/
/* Index: idx_name                                              */
/*==============================================================*/
create index idx_name on user_info
(
   name
);

/*==============================================================*/
/* Index: idx_sex                                               */
/*==============================================================*/
create index idx_sex on user_info
(
   sex
);

/*==============================================================*/
/* Index: idx_update_time                                       */
/*==============================================================*/
create index idx_update_time on user_info
(
   update_time
);

/*==============================================================*/
/* Index: idx_create_time                                       */
/*==============================================================*/
create index idx_create_time on user_info
(
   create_time
);
