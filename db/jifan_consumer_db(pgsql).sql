/*
Navicat PGSQL Data Transfer

Source Server         : myserver
Source Server Version : 90602
Source Host           : 119.23.219.167:40010
Source Database       : jifan_consumer_db
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90602
File Encoding         : 65001

Date: 2019-04-25 13:50:27
*/


-- ----------------------------
-- Sequence structure for area_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."area_id_seq";
CREATE SEQUENCE "public"."area_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 10
 CACHE 1;
SELECT setval('"public"."area_id_seq"', 10, true);

-- ----------------------------
-- Sequence structure for device_attention_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."device_attention_id_seq";
CREATE SEQUENCE "public"."device_attention_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 335
 CACHE 1;
SELECT setval('"public"."device_attention_id_seq"', 335, true);

-- ----------------------------
-- Sequence structure for device_port_attention_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."device_port_attention_id_seq";
CREATE SEQUENCE "public"."device_port_attention_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1215
 CACHE 1;
SELECT setval('"public"."device_port_attention_id_seq"', 1215, true);

-- ----------------------------
-- Sequence structure for device_port_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."device_port_id_seq";
CREATE SEQUENCE "public"."device_port_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1001
 CACHE 1;
SELECT setval('"public"."device_port_id_seq"', 1001, true);

-- ----------------------------
-- Sequence structure for region_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."region_id_seq";
CREATE SEQUENCE "public"."region_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 10
 CACHE 1;
SELECT setval('"public"."region_id_seq"', 10, true);

-- ----------------------------
-- Table structure for app_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."app_user";
CREATE TABLE "public"."app_user" (
"id" varchar(38) COLLATE "default" NOT NULL,
"weixinid" varchar(50) COLLATE "default",
"loginname" varchar(20) COLLATE "default",
"password" varchar(32) COLLATE "default",
"imgeurl" varchar(254) COLLATE "default",
"nickname" varchar(30) COLLATE "default",
"truename" varchar(20) COLLATE "default",
"phone" varchar(20) COLLATE "default",
"sex" varchar(10) COLLATE "default",
"states" varchar(20) COLLATE "default",
"isonline" bool,
"createtime" timestamp(6)
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."app_user" IS 'app_user  客户端用户';
COMMENT ON COLUMN "public"."app_user"."id" IS '主键';
COMMENT ON COLUMN "public"."app_user"."weixinid" IS '微信openid';
COMMENT ON COLUMN "public"."app_user"."loginname" IS '登录名';
COMMENT ON COLUMN "public"."app_user"."password" IS '密码';
COMMENT ON COLUMN "public"."app_user"."imgeurl" IS '头像图片';
COMMENT ON COLUMN "public"."app_user"."nickname" IS '昵称';
COMMENT ON COLUMN "public"."app_user"."truename" IS '姓名';
COMMENT ON COLUMN "public"."app_user"."phone" IS '电话';
COMMENT ON COLUMN "public"."app_user"."sex" IS '性别';
COMMENT ON COLUMN "public"."app_user"."states" IS '状态（锁定 正常 关闭）';
COMMENT ON COLUMN "public"."app_user"."isonline" IS '状态（1在线 0 下线 ）';
COMMENT ON COLUMN "public"."app_user"."createtime" IS '添加时间';

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS "public"."area";
CREATE TABLE "public"."area" (
"id" int4 DEFAULT nextval('area_id_seq'::regclass) NOT NULL,
"describe" varchar(32) COLLATE "default",
"createtime" timestamp(6),
"creator_id" varchar(36) COLLATE "default",
"mac" varchar(36) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."area" IS 'area  地区（家）';
COMMENT ON COLUMN "public"."area"."id" IS '主键';
COMMENT ON COLUMN "public"."area"."describe" IS '描述';
COMMENT ON COLUMN "public"."area"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."area"."creator_id" IS '创键者id';
COMMENT ON COLUMN "public"."area"."mac" IS 'wifimac地址';

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS "public"."device";
CREATE TABLE "public"."device" (
"mac" varchar(36) COLLATE "default" NOT NULL,
"chipid" varchar(36) COLLATE "default",
"sn" varchar(36) COLLATE "default",
"createtime" timestamp(6),
"servercode" int2,
"isonline" int2,
"online_time" timestamp(6)
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."device" IS 'device 设备';
COMMENT ON COLUMN "public"."device"."mac" IS 'mac地址(主健)';
COMMENT ON COLUMN "public"."device"."chipid" IS '芯片id';
COMMENT ON COLUMN "public"."device"."sn" IS 'sn号码';
COMMENT ON COLUMN "public"."device"."createtime" IS '添加时间';

-- ----------------------------
-- Table structure for device_attention
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_attention";
CREATE TABLE "public"."device_attention" (
"id" int4 DEFAULT nextval('device_attention_id_seq'::regclass) NOT NULL,
"mac" varchar(36) COLLATE "default",
"userid" varchar(38) COLLATE "default",
"area_id" int4,
"createtime" timestamp(6),
"keyid" int4,
"key" varchar(36) COLLATE "default",
"from_uid" varchar(38) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."device_attention" IS 'device_attention 用户和设备关注关联（多对多）';
COMMENT ON COLUMN "public"."device_attention"."id" IS '主键';
COMMENT ON COLUMN "public"."device_attention"."mac" IS 'mac地址';
COMMENT ON COLUMN "public"."device_attention"."userid" IS '用户id';
COMMENT ON COLUMN "public"."device_attention"."area_id" IS '(大区)家id';
COMMENT ON COLUMN "public"."device_attention"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."device_attention"."keyid" IS 'keyid';
COMMENT ON COLUMN "public"."device_attention"."key" IS 'key';
COMMENT ON COLUMN "public"."device_attention"."from_uid" IS '分享者id';

-- ----------------------------
-- Table structure for device_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_info";
CREATE TABLE "public"."device_info" (
"mac" varchar(36) COLLATE "default" NOT NULL,
"name" varchar(32) COLLATE "default",
"guest_key" varchar(36) COLLATE "default",
"com_key" varchar(36) COLLATE "default",
"ad_key" varchar(36) COLLATE "default",
"createtime" timestamp(6),
"wifimac" varchar(36) COLLATE "default",
"aids" varchar(254) COLLATE "default",
"dev_type" int2
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."device_info" IS 'device_info 设备详情';
COMMENT ON COLUMN "public"."device_info"."mac" IS 'mac地址(主健)';
COMMENT ON COLUMN "public"."device_info"."name" IS '名称';
COMMENT ON COLUMN "public"."device_info"."guest_key" IS '体验密码';
COMMENT ON COLUMN "public"."device_info"."com_key" IS '一般密码';
COMMENT ON COLUMN "public"."device_info"."ad_key" IS '管理员密码';
COMMENT ON COLUMN "public"."device_info"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."device_info"."aids" IS '设备属性AID(多个, 号隔开 )';
COMMENT ON COLUMN "public"."device_info"."dev_type" IS '设备类型';

-- ----------------------------
-- Table structure for device_port
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_port";
CREATE TABLE "public"."device_port" (
"id" int4 DEFAULT nextval('device_port_id_seq'::regclass) NOT NULL,
"mac" varchar(36) COLLATE "default",
"port" int4,
"portname" varchar(32) COLLATE "default",
"aids" varchar(254) COLLATE "default",
"aid_dev_type" int4,
"dev_modelid" int4
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."device_port" IS 'device_port( 端口设备)';
COMMENT ON COLUMN "public"."device_port"."id" IS '主键';
COMMENT ON COLUMN "public"."device_port"."mac" IS '设备id';
COMMENT ON COLUMN "public"."device_port"."port" IS '端口';
COMMENT ON COLUMN "public"."device_port"."portname" IS '名称';
COMMENT ON COLUMN "public"."device_port"."aids" IS 'AID(多个, 号隔开 )';
COMMENT ON COLUMN "public"."device_port"."aid_dev_type" IS '设备类型';
COMMENT ON COLUMN "public"."device_port"."dev_modelid" IS '型号id';

-- ----------------------------
-- Table structure for device_port_attention
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_port_attention";
CREATE TABLE "public"."device_port_attention" (
"id" int4 DEFAULT nextval('device_port_attention_id_seq'::regclass) NOT NULL,
"mac" varchar(36) COLLATE "default",
"device_port_id" int8,
"device_attention_id" int8,
"userid" varchar(38) COLLATE "default",
"portname" varchar(32) COLLATE "default",
"createtime" timestamp(6),
"region_id" int4
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."device_port_attention" IS 'device_port_attention 用户和端口设备关联（多对多）';
COMMENT ON COLUMN "public"."device_port_attention"."id" IS '主键';
COMMENT ON COLUMN "public"."device_port_attention"."mac" IS '设备id';
COMMENT ON COLUMN "public"."device_port_attention"."device_port_id" IS '端口id';
COMMENT ON COLUMN "public"."device_port_attention"."device_attention_id" IS '绑定关联id';
COMMENT ON COLUMN "public"."device_port_attention"."userid" IS '用户id';
COMMENT ON COLUMN "public"."device_port_attention"."portname" IS '名称';
COMMENT ON COLUMN "public"."device_port_attention"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."device_port_attention"."region_id" IS '区域id';

-- ----------------------------
-- Table structure for device_port_value
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_port_value";
CREATE TABLE "public"."device_port_value" (
"id" int8 DEFAULT nextval('device_port_id_seq'::regclass) NOT NULL,
"mac" varchar(36) COLLATE "default",
"port" int4,
"aid" int4,
"values" varchar(2048) COLLATE "default",
"createtime" timestamp(6),
"updatetime" timestamp(6)
)
WITH (OIDS=FALSE)

;
COMMENT ON COLUMN "public"."device_port_value"."id" IS '主键';
COMMENT ON COLUMN "public"."device_port_value"."mac" IS '设备id';
COMMENT ON COLUMN "public"."device_port_value"."port" IS '端口';
COMMENT ON COLUMN "public"."device_port_value"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."device_port_value"."updatetime" IS '修改时间';

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS "public"."region";
CREATE TABLE "public"."region" (
"id" int4 DEFAULT nextval('region_id_seq'::regclass) NOT NULL,
"describe" varchar(32) COLLATE "default",
"area_id" int4,
"createtime" timestamp(6),
"creator_id" varchar(36) COLLATE "default"
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."region" IS 'region 区域（房间）';
COMMENT ON COLUMN "public"."region"."id" IS '主键';
COMMENT ON COLUMN "public"."region"."describe" IS '描述';
COMMENT ON COLUMN "public"."region"."area_id" IS '(大区)家id';
COMMENT ON COLUMN "public"."region"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."region"."creator_id" IS '创键者id';

-- ----------------------------
-- Table structure for scene
-- ----------------------------
DROP TABLE IF EXISTS "public"."scene";
CREATE TABLE "public"."scene" (
"id" varchar(38) COLLATE "default" NOT NULL,
"describe" varchar(40) COLLATE "default",
"mac" varchar(36) COLLATE "default",
"store_mac" varchar(500) COLLATE "default",
"area_id" int4,
"data" text COLLATE "default",
"file_name" varchar(254) COLLATE "default",
"filedata" text COLLATE "default",
"status" int4,
"creator_id" varchar(38) COLLATE "default",
"userid_set" varchar(500) COLLATE "default",
"createtime" timestamp(6),
"typeid" int4
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "public"."scene" IS '情景（编程）';
COMMENT ON COLUMN "public"."scene"."id" IS '主键';
COMMENT ON COLUMN "public"."scene"."describe" IS '描述名称';
COMMENT ON COLUMN "public"."scene"."mac" IS '主储存的设备 mac地址';
COMMENT ON COLUMN "public"."scene"."store_mac" IS '储存的设备地址';
COMMENT ON COLUMN "public"."scene"."area_id" IS '家id';
COMMENT ON COLUMN "public"."scene"."data" IS '数据组合';
COMMENT ON COLUMN "public"."scene"."file_name" IS '文件名称';
COMMENT ON COLUMN "public"."scene"."filedata" IS '生成的文件数据';
COMMENT ON COLUMN "public"."scene"."status" IS '状态';
COMMENT ON COLUMN "public"."scene"."creator_id" IS '创键者id';
COMMENT ON COLUMN "public"."scene"."userid_set" IS '(有权限的用户id 逗号隔开)';
COMMENT ON COLUMN "public"."scene"."createtime" IS '添加时间';
COMMENT ON COLUMN "public"."scene"."typeid" IS '类型（单联、多联、定时，区间定时）';

-- ----------------------------
-- View structure for v_attention_device
-- ----------------------------
CREATE OR REPLACE VIEW "public"."v_attention_device" AS 
 SELECT device_info.name,
    device_info.ad_key,
    device_info.createtime,
    device_attention.userid AS bind_userid,
    device_attention.keyid,
    device_attention.key,
    device_info.guest_key,
    device_attention.area_id,
    device_attention.createtime AS adddevtime,
    area.describe AS homename,
    device_attention.id AS atten_id,
    device_info.wifimac,
    device_info.com_key,
    device_info.aids,
    device_attention.mac
   FROM ((device_attention
     LEFT JOIN device_info ON (((device_info.mac)::text = (device_attention.mac)::text)))
     LEFT JOIN area ON (((area.id)::text = (device_attention.area_id)::text)));

-- ----------------------------
-- View structure for v_device_port
-- ----------------------------
CREATE OR REPLACE VIEW "public"."v_device_port" AS 
 SELECT device_port.id,
    device_port.port,
    device_port.portname,
    device_port.aids,
    device_port.aid_dev_type,
    device_port.mac,
    device_info.ad_key,
    device_port.dev_modelid
   FROM (device_port
     LEFT JOIN device_info ON (((device_port.mac)::text = (device_info.mac)::text)));

-- ----------------------------
-- View structure for v_device_port_attention
-- ----------------------------
CREATE OR REPLACE VIEW "public"."v_device_port_attention" AS 
 SELECT device_port_attention.device_attention_id,
    device_port_attention.userid,
    device_port_attention.region_id,
    device_port.port,
    device_port.aids,
    device_port.aid_dev_type,
    device_attention.keyid,
    device_attention.key,
    device_port_attention.createtime AS add_port_time,
    device_port_attention.portname,
    device_attention.area_id,
    device_port_attention.id AS dp_attenid,
    device_port_attention.device_port_id,
    device_port.id,
    region.describe AS regionname,
    device_port.dev_modelid,
    device_port_attention.mac
   FROM (((device_port_attention
     LEFT JOIN region ON (((region.id)::text = (device_port_attention.region_id)::text)))
     LEFT JOIN device_attention ON (((device_attention.id)::text = (device_port_attention.device_attention_id)::text)))
     LEFT JOIN device_port ON (((device_port.id)::text = (device_port_attention.device_port_id)::text)));

-- ----------------------------
-- View structure for v_scene
-- ----------------------------
CREATE OR REPLACE VIEW "public"."v_scene" AS 
 SELECT scene.id,
    scene.describe,
    scene.store_mac,
    scene.area_id,
    scene.data,
    scene.file_name,
    scene.filedata,
    scene.status,
    scene.creator_id,
    scene.userid_set,
    scene.createtime,
    scene.typeid,
    app_user.loginname,
    app_user.truename,
    scene.mac
   FROM (scene
     LEFT JOIN app_user ON (((scene.creator_id)::text = (app_user.id)::text)));

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------
ALTER SEQUENCE "public"."area_id_seq" OWNED BY "area"."id";
ALTER SEQUENCE "public"."device_attention_id_seq" OWNED BY "device_attention"."id";
ALTER SEQUENCE "public"."device_port_attention_id_seq" OWNED BY "device_port_attention"."id";
ALTER SEQUENCE "public"."device_port_id_seq" OWNED BY "device_port"."id";
ALTER SEQUENCE "public"."region_id_seq" OWNED BY "region"."id";

-- ----------------------------
-- Primary Key structure for table app_user
-- ----------------------------
ALTER TABLE "public"."app_user" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table area
-- ----------------------------
ALTER TABLE "public"."area" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table device
-- ----------------------------
ALTER TABLE "public"."device" ADD UNIQUE ("mac");

-- ----------------------------
-- Primary Key structure for table device
-- ----------------------------
ALTER TABLE "public"."device" ADD PRIMARY KEY ("mac");

-- ----------------------------
-- Primary Key structure for table device_attention
-- ----------------------------
ALTER TABLE "public"."device_attention" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_info
-- ----------------------------
ALTER TABLE "public"."device_info" ADD PRIMARY KEY ("mac");

-- ----------------------------
-- Primary Key structure for table device_port
-- ----------------------------
ALTER TABLE "public"."device_port" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_port_attention
-- ----------------------------
ALTER TABLE "public"."device_port_attention" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_port_value
-- ----------------------------
ALTER TABLE "public"."device_port_value" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table region
-- ----------------------------
ALTER TABLE "public"."region" ADD PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table scene
-- ----------------------------
ALTER TABLE "public"."scene" ADD PRIMARY KEY ("id");
