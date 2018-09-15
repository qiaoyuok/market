/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : market

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-05-02 11:26:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mk_user
-- ----------------------------
DROP TABLE IF EXISTS `mk_user`;
CREATE TABLE `mk_user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '前台用户id号',
  `headimgurl` varchar(255) NOT NULL DEFAULT '' COMMENT '用户头像',
  `nickname` varchar(255) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `openid` varchar(255) NOT NULL DEFAULT '' COMMENT '用户openid',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `id` varchar(50) NOT NULL DEFAULT '' COMMENT '身份证号',
  `create_time` varchar(11) NOT NULL DEFAULT '' COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
