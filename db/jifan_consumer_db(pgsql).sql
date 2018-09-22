
/*==============================================================*/
/* Table: app_user                                              */
/*==============================================================*/
create table app_user (
   id                   VARCHAR(38)          not null,
   weixinid             VARCHAR(50)          null,
   loginname            VARCHAR(20)          null,
   password             VARCHAR(32)          null,
   imgeurl              VARCHAR(254)         null,
   nickname             VARCHAR(30)          null,
   truename             VARCHAR(20)          null,
   phone                VARCHAR(20)          null,
   sex                  VARCHAR(10)          null,
   states               VARCHAR(20)          null,
   isonline             BOOL                 null,
   createtime           TIMESTAMP            null,
   constraint PK_APP_USER primary key (id)
);

comment on table app_user is
'app_user  客户端用户';

comment on column app_user.id is
'主键';

comment on column app_user.weixinid is
'微信openid';

comment on column app_user.loginname is
'登录名';

comment on column app_user.password is
'密码';

comment on column app_user.imgeurl is
'头像图片';

comment on column app_user.nickname is
'昵称';

comment on column app_user.truename is
'姓名';

comment on column app_user.phone is
'电话';

comment on column app_user.sex is
'性别';

comment on column app_user.states is
'状态（锁定 正常 关闭）';

comment on column app_user.isonline is
'状态（1在线 0 下线 ）';

comment on column app_user.createtime is
'添加时间';

/*==============================================================*/
/* Table: area                                                  */
/*==============================================================*/
create table area (
   id                   SERIAL               not null,
   describe             VARCHAR(32)          null,
   createtime           TIMESTAMP            null,
   creator_id           VARCHAR(36)          null,
   mac                  VARCHAR(36)          null,
   constraint PK_AREA primary key (id)
);

comment on table area is
'area  地区（家）';

comment on column area.id is
'主键';

comment on column area.describe is
'描述';

comment on column area.createtime is
'添加时间';

comment on column area.creator_id is
'创键者id';

comment on column area.mac is
'wifimac地址';

/*==============================================================*/
/* Table: device                                                */
/*==============================================================*/
create table device (
   mac                  VARCHAR(36)          not null,
   chipid               VARCHAR(36)          null,
   sn                   VARCHAR(36)          null,
   createtime           TIMESTAMP            null,
   servercode           INT4                 null,
   isonline             INT2                 null,
   online_time          TIMESTAMP            null,
  constraint PK_DEVICE_INFO primary key (mac)
);

comment on table device is
'device 设备';

comment on column device.mac is
'mac地址(主健)';

comment on column device.chipid is
'芯片id';

comment on column device.sn is
'sn号码';

comment on column device.createtime is
'添加时间';

comment on column device.servercode is
'服务器编号';

comment on column device.isonline is
'是否在线(1在线 0不在线)';

comment on column device.online_time is
'最后在线时间';

/*==============================================================*/
/* Table: device_attention                                      */
/*==============================================================*/
create table device_attention (
   id                   SERIAL               not null,
   mac                  VARCHAR(36)          null,
   userid               VARCHAR(38)          null,
   area_id              INT4                 null,
   createtime           TIMESTAMP            null,
   keyid                INT4                 null,
   key                  VARCHAR(36)          null,
   from_uid             VARCHAR(38)          null,
   constraint PK_DEVICE_ATTENTION primary key (id)
);

comment on table device_attention is
'device_attention 用户和设备关注关联（多对多）';

comment on column device_attention.id is
'主键';

comment on column device_attention.mac is
'mac地址';

comment on column device_attention.userid is
'用户id';

comment on column device_attention.area_id is
'(大区)家id';

comment on column device_attention.createtime is
'添加时间';

comment on column device_attention.keyid is
'keyid';

comment on column device_attention.key is
'key';

comment on column device_attention.from_uid is
'分享者id';

/*==============================================================*/
/* Table: device_info                                           */
/*==============================================================*/
create table device_info (
   mac                  VARCHAR(36)          not null,
   name                 VARCHAR(32)          null,
   guest_key            VARCHAR(36)          null,
   com_key              VARCHAR(36)          null,
   ad_key               VARCHAR(36)          null,
   createtime           TIMESTAMP            null,
   wifimac              VARCHAR(36)          null,
   aids                 VARCHAR(254)         null,
   constraint PK_DEVICE_INFO primary key (mac)
);

comment on table device_info is
'device_info 设备详情';

comment on column device_info.mac is
'mac地址(主健)';

comment on column device_info.name is
'名称';

comment on column device_info.guest_key is
'体验密码';

comment on column device_info.com_key is
'一般密码';

comment on column device_info.ad_key is
'管理员密码';

comment on column device_info.createtime is
'添加时间';

comment on column device_info.aids is
'设备属性AID(多个, 号隔开 )';

/*==============================================================*/
/* Table: device_port                                           */
/*==============================================================*/
create table device_port (
   id                   SERIAL               not null,
   mac                  VARCHAR(36)          null,
   port                 INT4                 null,
   portname             VARCHAR(32)          null,
   aids                 VARCHAR(254)         null,
   aid_dev_type         INT4                 null,
   dev_modelid          INT4                 null,
   constraint PK_DEVICE_PORT primary key (id)
);

comment on table device_port is
'device_port( 端口设备)';

comment on column device_port.id is
'主键';

comment on column device_port.mac is
'设备id';

comment on column device_port.port is
'端口';

comment on column device_port.portname is
'名称';

comment on column device_port.aids is
'AID(多个, 号隔开 )';

comment on column device_port.aid_dev_type is
'设备类型';

comment on column device_port.dev_modelid is
'型号id';

/*==============================================================*/
/* Table: device_port_attention                                 */
/*==============================================================*/
create table device_port_attention (
   id                   SERIAL               not null,
   mac                  VARCHAR(36)          null,
   device_port_id       INT8                 null,
   device_attention_id  INT8                 null,
   userid               VARCHAR(38)          null,
   portname             VARCHAR(32)          null,
   createtime           TIMESTAMP            null,
   region_id            INT4                 null,
   constraint PK_DEVICE_PORT_ATTENTION primary key (id)
);

comment on table device_port_attention is
'device_port_attention 用户和端口设备关联（多对多）';

comment on column device_port_attention.id is
'主键';

comment on column device_port_attention.mac is
'设备id';

comment on column device_port_attention.device_port_id is
'端口id';

comment on column device_port_attention.device_attention_id is
'绑定关联id';

comment on column device_port_attention.userid is
'用户id';

comment on column device_port_attention.portname is
'名称';

comment on column device_port_attention.createtime is
'添加时间';

comment on column device_port_attention.region_id is
'区域id';

/*==============================================================*/
/* Table: region                                                */
/*==============================================================*/
create table region (
   id                   SERIAL               not null,
   describe             VARCHAR(32)          null,
   area_id              INT4                 null,
   createtime           TIMESTAMP            null,
   creator_id           VARCHAR(36)          null,
   constraint PK_REGION primary key (id)
);

comment on table region is
'region 区域（房间）';

comment on column region.id is
'主键';

comment on column region.describe is
'描述';

comment on column region.area_id is
'(大区)家id';

comment on column region.createtime is
'添加时间';

comment on column region.creator_id is
'创键者id';

/*==============================================================*/
/* Table: scene                                                 */
/*==============================================================*/
create table scene (
   id                   VARCHAR(38)          not null,
   describe             VARCHAR(40)          null,
   mac                  VARCHAR(36)          null,
   store_mac            VARCHAR(500)         null,
   area_id              INT4                 null,
   data                 TEXT                 null,
   file_name            VARCHAR(254)         null,
   filedata             TEXT                 null,
   status               INT4                 null,
   creator_id           VARCHAR(38)          null,
   userid_set           VARCHAR(500)         null,
   createtime           TIMESTAMP            null,
   typeid               INT4                 null,
   constraint PK_SCENE primary key (id)
);

comment on table scene is
'情景（编程）';

comment on column scene.id is
'主键';

comment on column scene.describe is
'描述名称';

comment on column scene.mac is
'主储存的设备 mac地址';

comment on column scene.store_mac is
'储存的设备地址';

comment on column scene.area_id is
'家id';

comment on column scene.data is
'数据组合';

comment on column scene.file_name is
'文件名称';

comment on column scene.filedata is
'生成的文件数据';

comment on column scene.status is
'状态';

comment on column scene.creator_id is
'创键者id';

comment on column scene.userid_set is
'(有权限的用户id 逗号隔开)';

comment on column scene.createtime is
'添加时间';

comment on column scene.typeid is
'类型（单联、多联、定时，区间定时）';
