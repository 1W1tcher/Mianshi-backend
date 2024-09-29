# 数据库初始化
# @author qye丶枯寂
#

-- 创建库
create database if not exists mianshi;

-- 切换库
use mianshi;

-- 用户表
create table if not exists user
(
    id           bigint auto_increment comment 'id' primary key,
    userAccount  varchar(64)                            not null comment '用户账号',
    userPassword varchar(64)                            not null comment '用户密码',
    unionId      varchar(256)                           not null comment '微信开放平台id',
    mpOpenId     varchar(256)                           not null comment '公众号id',
    userName     varchar(256)                           not null comment '用户名',
    userAvatar   varchar(1024)                          not null comment '用户头像',
    userProfile  varchar(512)                           not null comment '用户简介',
    userRole     varchar(256) default 'user'            not null comment '用户角色:user/admin/ban',
    editTime     datetime     default CURRENT_TIMESTAMP not null comment '修改时间',
    createTime   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete     tinyint      default 0                 not null comment '是否删除',
    index idx_unionId (unionId)
) comment '用户' collate = utf8mb4_unicode_ci;

-- 题库表
create table if not exists question_bank
(
    id          bigint auto_increment comment 'id' primary key,
    title       varchar(256)                       null comment '标题',
    description text                               null comment '描述',
    picture     varchar(2048)                      null comment '图片',
    userId      bigint                             not null comment '创建用户id',
    editTime    datetime default CURRENT_TIMESTAMP not null comment '修改时间',
    createTime  datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime  datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete    tinyint  default 0                 not null comment '是否删除',
    index idx_title (title)
) comment '题库' collate = utf8mb4_unicode_ci;

-- 题目表
create table if not exists question
(
    id         bigint auto_increment comment 'id' primary key,
    title      varchar(256)                       null comment '标题',
    content    text                               null comment '内容',
    tags       varchar(1024)                      null comment '标签列表(json数组)',
    answer     text                               null comment '推荐答案',
    userId     bigint                             not null comment '创建用户id',
    viewNum    int      default 0                 not null comment '浏览量',
    editTime   datetime default CURRENT_TIMESTAMP not null comment '修改时间',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete   tinyint  default 0                 not null comment '是否删除',
    index idx_title (title),
    index idx_userId (userId)
) comment '题目' collate = utf8mb4_unicode_ci;

-- 题库题目关系表
create table if not exists question_bank_question
(
    id bigint auto_increment comment 'id' primary key,
    questionBankId bigint not null comment '题库id',
    questionId bigint not null comment '题目id',
    userId bigint not null comment '创建用户id',
    createTime datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    UNIQUE (questionBankId, questionId)
)comment '题库题目' collate = utf8mb4_unicode_ci;
