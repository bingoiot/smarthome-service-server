/*
Navicat MySQL Data Transfer

Source Server         : 金凤服务器
Source Server Version : 50725
Source Host           : 47.104.15.44:3306
Source Database       : jifan_consumer_db

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-04-25 13:50:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for app_user
-- ----------------------------
DROP TABLE IF EXISTS `app_user`;
CREATE TABLE `app_user` (
  `id` varchar(38) NOT NULL COMMENT '主键',
  `weixinid` varchar(50) DEFAULT NULL COMMENT '微信openid',
  `loginname` varchar(20) DEFAULT NULL COMMENT '登录名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `truename` varchar(32) DEFAULT NULL COMMENT '姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `imgeurl` varchar(254) DEFAULT NULL COMMENT '头像图片',
  `states` varchar(20) DEFAULT NULL COMMENT '状态（锁定 正常 关闭）',
  `isonline` tinyint(4) DEFAULT NULL COMMENT '状态（1在线 0 下线 ）',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='app_user  客户端用户';

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `describe` varchar(40) DEFAULT NULL COMMENT '描述',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `creator_id` varchar(36) DEFAULT NULL COMMENT '创键者id',
  `mac` varchar(32) DEFAULT NULL COMMENT 'wifimac地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='area  地区（家）';

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device` (
  `mac` varchar(36) NOT NULL COMMENT 'mac地址(主健)',
  `chipid` varchar(36) DEFAULT NULL COMMENT '芯片id',
  `sn` varchar(36) DEFAULT NULL COMMENT 'sn号码',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `servercode` smallint(6) DEFAULT NULL,
  `isonline` tinyint(255) DEFAULT NULL,
  `online_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='device 设备';

-- ----------------------------
-- Table structure for device_attention
-- ----------------------------
DROP TABLE IF EXISTS `device_attention`;
CREATE TABLE `device_attention` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mac` varchar(36) DEFAULT NULL COMMENT 'mac地址',
  `userid` varchar(36) DEFAULT NULL COMMENT '用户id',
  `keyid` int(11) DEFAULT NULL COMMENT 'keyid',
  `key` varchar(36) DEFAULT NULL COMMENT 'key',
  `area_id` int(11) DEFAULT NULL COMMENT '(大区)家id',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `from_uid` varchar(38) DEFAULT NULL COMMENT '分享者id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='device_attention 用户和设备关注关联（多对多）';

-- ----------------------------
-- Table structure for device_info
-- ----------------------------
DROP TABLE IF EXISTS `device_info`;
CREATE TABLE `device_info` (
  `mac` varchar(36) NOT NULL COMMENT 'mac地址(主健)',
  `name` char(40) DEFAULT NULL COMMENT '名称',
  `guest_key` varchar(36) DEFAULT NULL COMMENT '体验密码',
  `com_key` varchar(36) DEFAULT NULL COMMENT '一般密码',
  `ad_key` varchar(36) DEFAULT NULL COMMENT '管理员密码',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `wifimac` varchar(36) DEFAULT NULL COMMENT '连接的wifi',
  `aids` varchar(500) DEFAULT NULL COMMENT '设备属性AID(多个, 号隔开 )',
  `dev_type` smallint(6) DEFAULT NULL COMMENT '设备类型',
  PRIMARY KEY (`mac`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='device_info 设备详情';

-- ----------------------------
-- Table structure for device_port
-- ----------------------------
DROP TABLE IF EXISTS `device_port`;
CREATE TABLE `device_port` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mac` varchar(36) DEFAULT NULL COMMENT '设备id',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `portname` varchar(32) DEFAULT NULL COMMENT '名称',
  `aids` varchar(500) DEFAULT NULL COMMENT 'AID(多个, 号隔开 )',
  `aid_dev_type` int(11) DEFAULT NULL COMMENT '设备类型',
  `dev_modelid` int(11) DEFAULT NULL COMMENT '型号id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='device_port( 端口设备)';

-- ----------------------------
-- Table structure for device_port_attention
-- ----------------------------
DROP TABLE IF EXISTS `device_port_attention`;
CREATE TABLE `device_port_attention` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mac` varchar(36) DEFAULT NULL COMMENT '设备id',
  `device_port_id` bigint(20) DEFAULT NULL COMMENT '端口id',
  `device_attention_id` bigint(20) DEFAULT NULL COMMENT '绑定关联id',
  `userid` varchar(36) DEFAULT NULL COMMENT '用户id',
  `portname` varchar(20) DEFAULT NULL COMMENT '名称',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `region_id` int(11) DEFAULT NULL COMMENT '区域id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='device_port_attention 用户和端口设备关联（多对多）';

-- ----------------------------
-- Table structure for device_port_value
-- ----------------------------
DROP TABLE IF EXISTS `device_port_value`;
CREATE TABLE `device_port_value` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mac` varchar(36) DEFAULT NULL COMMENT '设备id',
  `port` int(11) DEFAULT NULL COMMENT '端口',
  `aid` int(11) DEFAULT NULL,
  `values` varchar(0) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `updatetime` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `describe` varchar(40) DEFAULT NULL COMMENT '描述',
  `area_id` int(11) DEFAULT NULL COMMENT '(大区)家id',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `creator_id` varchar(36) DEFAULT NULL COMMENT '创键者id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='region 区域（房间）';

-- ----------------------------
-- Table structure for scene
-- ----------------------------
DROP TABLE IF EXISTS `scene`;
CREATE TABLE `scene` (
  `id` varchar(38) NOT NULL COMMENT '主键',
  `describe` varchar(40) DEFAULT NULL COMMENT '描述名称',
  `mac` varchar(36) DEFAULT NULL COMMENT '主储存的设备 mac地址',
  `store_mac` varchar(500) DEFAULT NULL COMMENT '储存的设备地址',
  `area_id` int(11) DEFAULT NULL COMMENT '家id',
  `data` text COMMENT '数据组合',
  `file_name` varchar(300) DEFAULT NULL COMMENT '文件名称',
  `filedata` text COMMENT '生成的文件数据',
  `status` int(11) DEFAULT NULL COMMENT '状态',
  `creator_id` varchar(36) DEFAULT NULL COMMENT '创键者id',
  `userid_set` varchar(500) DEFAULT NULL COMMENT '(有权限的用户id 逗号隔开)',
  `createtime` timestamp NULL DEFAULT NULL COMMENT '添加时间',
  `typeid` int(11) DEFAULT NULL COMMENT '类型（单联、多联、定时，区间定时）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='情景（编程）';
