/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : market

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-05-03 11:53:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mk_action
-- ----------------------------
DROP TABLE IF EXISTS `mk_action`;
CREATE TABLE `mk_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text NOT NULL COMMENT '行为规则',
  `log` text NOT NULL COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of mk_action
-- ----------------------------
INSERT INTO `mk_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '-1', '1387181220');
INSERT INTO `mk_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `mk_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `mk_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `mk_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `mk_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `mk_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `mk_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `mk_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `mk_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `mk_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');

-- ----------------------------
-- Table structure for mk_action_log
-- ----------------------------
DROP TABLE IF EXISTS `mk_action_log`;
CREATE TABLE `mk_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of mk_action_log
-- ----------------------------
INSERT INTO `mk_action_log` VALUES ('1', '1', '1', '-1062731400', 'member', '1', 'qiaoyuok在2017-12-28 12:08登录了后台', '1', '1514434098');
INSERT INTO `mk_action_log` VALUES ('2', '10', '1', '-1062731400', 'Menu', '1', '操作url：/index.php?s=/admin/menu/edit.html', '1', '1514434223');
INSERT INTO `mk_action_log` VALUES ('3', '10', '1', '-1062731400', 'Menu', '93', '操作url：/index.php?s=/admin/menu/edit.html', '1', '1514442160');
INSERT INTO `mk_action_log` VALUES ('4', '10', '1', '-1062731400', 'Menu', '93', '操作url：/index.php?s=/admin/menu/edit.html', '1', '1514442173');
INSERT INTO `mk_action_log` VALUES ('25', '10', '1', '-1062731400', 'Menu', '131', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514878920');
INSERT INTO `mk_action_log` VALUES ('24', '10', '1', '-1062731400', 'Menu', '130', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514455212');
INSERT INTO `mk_action_log` VALUES ('23', '10', '1', '-1062731400', 'Menu', '129', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514455194');
INSERT INTO `mk_action_log` VALUES ('22', '10', '1', '-1062731400', 'Menu', '128', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514455181');
INSERT INTO `mk_action_log` VALUES ('21', '10', '1', '-1062731400', 'Menu', '124', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514455165');
INSERT INTO `mk_action_log` VALUES ('20', '10', '1', '-1062731400', 'Menu', '130', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514455079');
INSERT INTO `mk_action_log` VALUES ('19', '10', '1', '-1062731400', 'Menu', '129', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514455044');
INSERT INTO `mk_action_log` VALUES ('18', '10', '1', '-1062731400', 'Menu', '43', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514454864');
INSERT INTO `mk_action_log` VALUES ('17', '10', '1', '-1062731400', 'Menu', '2', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514454854');
INSERT INTO `mk_action_log` VALUES ('16', '10', '1', '-1062731400', 'Menu', '128', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514454841');
INSERT INTO `mk_action_log` VALUES ('15', '1', '1', '-1062731400', 'member', '1', 'qiaoyuok在2017-12-28 16:38登录了后台', '-1', '1514450300');
INSERT INTO `mk_action_log` VALUES ('26', '10', '1', '-1062731400', 'Menu', '132', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514886771');
INSERT INTO `mk_action_log` VALUES ('27', '10', '1', '-1062731400', 'Menu', '133', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514887951');
INSERT INTO `mk_action_log` VALUES ('28', '10', '1', '-1062731400', 'Menu', '2', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1514947327');
INSERT INTO `mk_action_log` VALUES ('29', '10', '1', '-1062731400', 'Menu', '134', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514948358');
INSERT INTO `mk_action_log` VALUES ('30', '10', '1', '-1062731400', 'Menu', '135', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514948706');
INSERT INTO `mk_action_log` VALUES ('31', '10', '1', '-1062731400', 'Menu', '136', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514948774');
INSERT INTO `mk_action_log` VALUES ('32', '10', '1', '-1062731400', 'Menu', '137', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514948867');
INSERT INTO `mk_action_log` VALUES ('33', '10', '1', '-1062731400', 'Menu', '138', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514949391');
INSERT INTO `mk_action_log` VALUES ('34', '10', '1', '-1062731400', 'Menu', '139', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514949508');
INSERT INTO `mk_action_log` VALUES ('35', '10', '1', '-1062731400', 'Menu', '0', '操作url：/index.php?s=/Admin/Menu/del/id/130.html', '1', '1514949534');
INSERT INTO `mk_action_log` VALUES ('36', '10', '1', '-1062731400', 'Menu', '140', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514949604');
INSERT INTO `mk_action_log` VALUES ('37', '10', '1', '-1062731400', 'Menu', '141', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514949639');
INSERT INTO `mk_action_log` VALUES ('38', '10', '1', '-1062731400', 'Menu', '142', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514964625');
INSERT INTO `mk_action_log` VALUES ('39', '10', '1', '-1062731400', 'Menu', '143', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1514964797');
INSERT INTO `mk_action_log` VALUES ('40', '11', '1', '-1062731400', 'category', '39', '操作url：/index.php?s=/Admin/Category/add.html', '1', '1515134246');
INSERT INTO `mk_action_log` VALUES ('41', '10', '1', '2130706433', 'Menu', '148', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1517881746');
INSERT INTO `mk_action_log` VALUES ('42', '10', '1', '2130706433', 'Menu', '149', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1517881827');
INSERT INTO `mk_action_log` VALUES ('43', '10', '1', '2130706433', 'Menu', '150', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1517881900');
INSERT INTO `mk_action_log` VALUES ('44', '10', '1', '2130706433', 'Menu', '151', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1517901632');
INSERT INTO `mk_action_log` VALUES ('45', '10', '1', '2130706433', 'Menu', '152', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1517902795');
INSERT INTO `mk_action_log` VALUES ('46', '10', '1', '2130706433', 'Menu', '153', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1517987604');
INSERT INTO `mk_action_log` VALUES ('47', '10', '1', '2130706433', 'Menu', '154', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1518080193');
INSERT INTO `mk_action_log` VALUES ('48', '10', '1', '2130706433', 'Menu', '155', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1518142768');
INSERT INTO `mk_action_log` VALUES ('49', '10', '1', '2130706433', 'Menu', '156', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1518243812');
INSERT INTO `mk_action_log` VALUES ('50', '10', '1', '2130706433', 'Menu', '157', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520497525');
INSERT INTO `mk_action_log` VALUES ('51', '10', '1', '2130706433', 'Menu', '157', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1520497541');
INSERT INTO `mk_action_log` VALUES ('52', '10', '1', '2130706433', 'Menu', '16', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1520497573');
INSERT INTO `mk_action_log` VALUES ('53', '10', '1', '2130706433', 'Menu', '124', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1520497589');
INSERT INTO `mk_action_log` VALUES ('54', '10', '1', '2130706433', 'Menu', '134', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1520497667');
INSERT INTO `mk_action_log` VALUES ('55', '10', '1', '2130706433', 'Menu', '68', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1520497679');
INSERT INTO `mk_action_log` VALUES ('56', '10', '1', '2130706433', 'Menu', '158', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520498869');
INSERT INTO `mk_action_log` VALUES ('57', '10', '1', '2130706433', 'Menu', '159', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520499230');
INSERT INTO `mk_action_log` VALUES ('58', '10', '1', '2130706433', 'Menu', '160', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520502554');
INSERT INTO `mk_action_log` VALUES ('59', '10', '1', '2130706433', 'Menu', '161', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520577553');
INSERT INTO `mk_action_log` VALUES ('60', '10', '1', '2130706433', 'Menu', '162', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520664595');
INSERT INTO `mk_action_log` VALUES ('61', '10', '1', '2130706433', 'Menu', '163', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520667708');
INSERT INTO `mk_action_log` VALUES ('62', '10', '1', '2130706433', 'Menu', '164', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520669777');
INSERT INTO `mk_action_log` VALUES ('63', '10', '1', '2130706433', 'Menu', '165', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520670700');
INSERT INTO `mk_action_log` VALUES ('64', '10', '1', '2130706433', 'Menu', '166', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520671305');
INSERT INTO `mk_action_log` VALUES ('65', '10', '1', '2130706433', 'Menu', '167', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520827214');
INSERT INTO `mk_action_log` VALUES ('66', '10', '1', '2130706433', 'Menu', '170', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1520910143');
INSERT INTO `mk_action_log` VALUES ('67', '10', '1', '2130706433', 'Menu', '171', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1521266656');
INSERT INTO `mk_action_log` VALUES ('68', '10', '1', '2130706433', 'Menu', '171', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1521266702');
INSERT INTO `mk_action_log` VALUES ('69', '10', '1', '2130706433', 'Menu', '172', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1521266780');
INSERT INTO `mk_action_log` VALUES ('70', '10', '1', '2130706433', 'Menu', '173', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1521273314');
INSERT INTO `mk_action_log` VALUES ('71', '10', '1', '2047789011', 'Menu', '68', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1524112248');
INSERT INTO `mk_action_log` VALUES ('72', '10', '1', '2130706433', 'Menu', '17', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1525242907');
INSERT INTO `mk_action_log` VALUES ('73', '10', '1', '2130706433', 'Menu', '174', '操作url：/index.php?s=/Admin/Menu/add.html', '1', '1525242960');
INSERT INTO `mk_action_log` VALUES ('74', '10', '1', '2130706433', 'Menu', '174', '操作url：/index.php?s=/Admin/Menu/edit.html', '1', '1525243417');

-- ----------------------------
-- Table structure for mk_addons
-- ----------------------------
DROP TABLE IF EXISTS `mk_addons`;
CREATE TABLE `mk_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of mk_addons
-- ----------------------------
INSERT INTO `mk_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `mk_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `mk_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `mk_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `mk_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `mk_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `mk_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');

-- ----------------------------
-- Table structure for mk_attachment
-- ----------------------------
DROP TABLE IF EXISTS `mk_attachment`;
CREATE TABLE `mk_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of mk_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for mk_attribute
-- ----------------------------
DROP TABLE IF EXISTS `mk_attribute`;
CREATE TABLE `mk_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL,
  `validate_time` tinyint(1) unsigned NOT NULL,
  `error_info` varchar(100) NOT NULL,
  `validate_type` varchar(25) NOT NULL,
  `auto_rule` varchar(100) NOT NULL,
  `auto_time` tinyint(1) unsigned NOT NULL,
  `auto_type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of mk_attribute
-- ----------------------------
INSERT INTO `mk_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '1:列表推荐\r\n2:频道页推荐\r\n4:首页推荐', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `mk_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `mk_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `mk_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `mk_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `mk_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for mk_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `mk_auth_extend`;
CREATE TABLE `mk_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of mk_auth_extend
-- ----------------------------
INSERT INTO `mk_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `mk_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `mk_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `mk_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `mk_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `mk_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `mk_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `mk_auth_extend` VALUES ('1', '37', '1');

-- ----------------------------
-- Table structure for mk_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `mk_auth_group`;
CREATE TABLE `mk_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(500) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_auth_group
-- ----------------------------
INSERT INTO `mk_auth_group` VALUES ('1', 'admin', '1', '超级', '', '1', '1,2,3,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,100,102,103,107,108,109,110,195,218,219,220,221,222,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264');
INSERT INTO `mk_auth_group` VALUES ('2', 'admin', '1', '加盟商', '测试用户', '1', '1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,82,83,84,88,89,90,91,92,93,94,95,100,102,103,107,108,109,110,195,209,210,218,219,220,221,222,225,226,227,228,229,230,231,232,233,234,235,236,237,238,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264');
INSERT INTO `mk_auth_group` VALUES ('3', 'admin', '1', '店铺管理员', '后台管理员', '1', '1,3,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,88,94,95,107,108,109,110,218,219,220,221,222,225,226,227,228,229,230,231,232,233,234,235,236,237,238,240,241,245,246,247,248,249,250,252,253,254,255,256,257,258,259,260,261,262,263,264');

-- ----------------------------
-- Table structure for mk_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `mk_auth_group_access`;
CREATE TABLE `mk_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_auth_group_access
-- ----------------------------
INSERT INTO `mk_auth_group_access` VALUES ('2', '1');
INSERT INTO `mk_auth_group_access` VALUES ('7', '3');
INSERT INTO `mk_auth_group_access` VALUES ('10', '3');
INSERT INTO `mk_auth_group_access` VALUES ('11', '3');
INSERT INTO `mk_auth_group_access` VALUES ('15', '3');
INSERT INTO `mk_auth_group_access` VALUES ('41', '3');
INSERT INTO `mk_auth_group_access` VALUES ('42', '3');
INSERT INTO `mk_auth_group_access` VALUES ('43', '3');
INSERT INTO `mk_auth_group_access` VALUES ('44', '3');
INSERT INTO `mk_auth_group_access` VALUES ('45', '1');
INSERT INTO `mk_auth_group_access` VALUES ('46', '1');
INSERT INTO `mk_auth_group_access` VALUES ('49', '1');
INSERT INTO `mk_auth_group_access` VALUES ('50', '2');
INSERT INTO `mk_auth_group_access` VALUES ('51', '3');
INSERT INTO `mk_auth_group_access` VALUES ('52', '3');
INSERT INTO `mk_auth_group_access` VALUES ('53', '1');
INSERT INTO `mk_auth_group_access` VALUES ('54', '3');

-- ----------------------------
-- Table structure for mk_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `mk_auth_rule`;
CREATE TABLE `mk_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=265 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_auth_rule
-- ----------------------------
INSERT INTO `mk_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/mydocument', '内容', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('17', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '管理员', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '用户行为', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '权限管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('217', 'admin', '1', 'Admin/device/indx', '货柜列表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('218', 'admin', '1', 'Admin/Device/index', '货柜列表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('219', 'admin', '2', 'Admin/Device/index', '货柜', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Device/add', '添加货柜', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('221', 'admin', '1', 'Admin/Shop/index', '店面管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('222', 'admin', '2', 'Admin/Shop/index', '店面', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('223', 'admin', '2', 'Admin/Money/index', '财务', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('224', 'admin', '2', 'Admin/Look/index', '统计', '-1', '');
INSERT INTO `mk_auth_rule` VALUES ('225', 'admin', '1', 'Admin/Finance/index', '财务管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('226', 'admin', '1', 'Admin/Shop/add', '添加店面', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('227', 'admin', '1', 'Admin/Goods/index', '货品列表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('228', 'admin', '1', 'Admin/Count/index', '查看统计', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('229', 'admin', '1', 'Admin/Goods/add', '货品添加', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('230', 'admin', '1', 'Admin/Goods/cate_add', '分类添加', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('231', 'admin', '1', 'Admin/Goods/editAction', '编辑商品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('232', 'admin', '1', 'Admin/User/tocheck', '用户审核', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('233', 'admin', '1', 'Admin/Goods/cate_edit', '编辑分类', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('234', 'admin', '1', 'Admin/Device/lock', '锁板管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('235', 'admin', '1', 'Admin/Device/cupboard', '设备管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('236', 'admin', '1', 'Admin/Device/addlock', '天假锁板', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('237', 'admin', '1', 'Admin/Device/addcupboard', '货柜添加', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('238', 'admin', '1', 'Admin/Device/addboard', '添加货板', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('239', 'admin', '2', 'Admin/Showpage/index', '展示界面', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('240', 'admin', '1', 'Admin/User/look', '查看资料', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('241', 'admin', '1', 'Admin/Device/deviceedit', '货柜编辑', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('242', 'admin', '1', 'Admin/Business/index', '加盟商管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('243', 'admin', '1', 'Admin/Business/add', '新增加盟商', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('244', 'admin', '1', 'Admin/Business/edit', '编辑加盟商', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('245', 'admin', '1', 'Admin/Goods/category', '分类管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('246', 'admin', '1', 'Admin/Device/board', '货板管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('247', 'admin', '2', 'Admin/Goods/index', '货品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('248', 'admin', '1', 'Admin/Goods/out', '已下架', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('249', 'admin', '2', 'Admin/Finance/index', '财务', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('250', 'admin', '2', 'Admin/Count/index', '统计', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('251', 'admin', '2', 'Admin/Business/index', '加盟商', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('252', 'admin', '1', 'Admin/User/normal', '用户列表', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('253', 'admin', '1', 'Admin/Device/setgoodslists', '获取商品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('254', 'admin', '1', 'Admin/Shop/edit', '编辑店铺', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('255', 'admin', '1', 'Admin/Shop/shopgoods', '配置货品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('256', 'admin', '1', 'Admin/Shop/addshopgoods', '添加货品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('257', 'admin', '1', 'Admin/Shop/shopgoodsedit', '编辑货品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('258', 'admin', '1', 'Admin/Shop/setgoodslists', '获取商品', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('259', 'admin', '1', 'Admin/Shop/changeStatus', '删除店铺', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('260', 'admin', '1', 'Admin/Device/editboard', '编辑货板', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('261', 'admin', '1', 'Admin/Order/index', '订单管理', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('262', 'admin', '1', 'Admin/Order/orderdetail', '查看订单', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('263', 'admin', '2', 'Admin/Order/index', '订单', '1', '');
INSERT INTO `mk_auth_rule` VALUES ('264', 'admin', '1', 'Admin/User/user', '会员用户', '1', '');

-- ----------------------------
-- Table structure for mk_board
-- ----------------------------
DROP TABLE IF EXISTS `mk_board`;
CREATE TABLE `mk_board` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL,
  `shop_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `updata_time` varchar(10) NOT NULL,
  `add_time` varchar(10) NOT NULL,
  `goods_status` varchar(10000) NOT NULL DEFAULT '',
  `new_status` varchar(10000) NOT NULL,
  `device_id` varchar(50) NOT NULL DEFAULT '' COMMENT '设备ID号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `board` (`board_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_board
-- ----------------------------
INSERT INTO `mk_board` VALUES ('33', '1001', '23', '1', '', '1521171250', '{\"1\":{\"20\":\"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1\"},\"2\":null,\"3\":null,\"4\":null,\"5\":null,\"6\":null,\"7\":null,\"8\":null,\"9\":null,\"10\":null,\"11\":null,\"12\":null,\"13\":null,\"14\":null,\"15\":null,\"16\":null,\"17\":null,\"18\":null}', '', '1001');
INSERT INTO `mk_board` VALUES ('35', '1002', '23', '1', '', '1523669306', '', '', '');
INSERT INTO `mk_board` VALUES ('36', '12', '25', '1', '', '1523971847', '', '', '');
INSERT INTO `mk_board` VALUES ('34', '1003', '24', '1', '', '1523668852', '{\"1\":{\"22\":\"1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1\"},\"2\":null,\"3\":null,\"4\":null,\"5\":null,\"6\":null,\"7\":null,\"8\":null,\"9\":null,\"10\":null,\"11\":null,\"12\":null,\"13\":null,\"14\":null,\"15\":null,\"16\":null,\"17\":null,\"18\":null}', '', '10');

-- ----------------------------
-- Table structure for mk_business
-- ----------------------------
DROP TABLE IF EXISTS `mk_business`;
CREATE TABLE `mk_business` (
  `business_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_name` varchar(255) NOT NULL,
  `business_tel` varchar(255) NOT NULL,
  `business_address` varchar(255) NOT NULL,
  `business_email` varchar(255) NOT NULL,
  `business_bossname` varchar(255) NOT NULL,
  `add_time` varchar(11) NOT NULL,
  `update_time` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`business_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_business
-- ----------------------------
INSERT INTO `mk_business` VALUES ('1', '总部', '', '', '', '', '1521102847', '', '0');
INSERT INTO `mk_business` VALUES ('7', '阿里巴巴', '4324324', '发斯蒂芬斯蒂芬', '放到沙发沙发', '放到', '1521171213', '', '0');
INSERT INTO `mk_business` VALUES ('8', 'fdsf', '4324', '', '', '', '1523971546', '', '0');

-- ----------------------------
-- Table structure for mk_cate
-- ----------------------------
DROP TABLE IF EXISTS `mk_cate`;
CREATE TABLE `mk_cate` (
  `cate_id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(255) NOT NULL,
  `cate_parent` int(11) NOT NULL,
  `add_time` varchar(11) NOT NULL,
  `update_time` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_cate
-- ----------------------------
INSERT INTO `mk_cate` VALUES ('1', '休闲零食', '0', '1515043199', '1519443566', '-1');
INSERT INTO `mk_cate` VALUES ('2', '牛奶', '1', '1515043199', '1519443531', '-1');
INSERT INTO `mk_cate` VALUES ('3', '哈哈哈', '1', '1515043199', '1519443541', '-1');
INSERT INTO `mk_cate` VALUES ('4', '日用百货', '0', '1515043199', '1519443563', '-1');
INSERT INTO `mk_cate` VALUES ('5', '纸品湿巾', '1', '1515043199', '1519443546', '-1');
INSERT INTO `mk_cate` VALUES ('6', '家庭清洁', '4', '1515043199', '1519443558', '-1');
INSERT INTO `mk_cate` VALUES ('14', '饼干', '1', '1515060753', '1519443550', '-1');
INSERT INTO `mk_cate` VALUES ('15', '饮料', '1', '1515060803', '1519443554', '-1');
INSERT INTO `mk_cate` VALUES ('16', '衣服', '0', '1515060832', '1516159475', '-1');
INSERT INTO `mk_cate` VALUES ('17', '男士衣服', '16', '1515060875', '1516159383', '-1');
INSERT INTO `mk_cate` VALUES ('18', '海鲜水产', '0', '1519443586', '1519443586', '1');
INSERT INTO `mk_cate` VALUES ('19', '零嘴零食', '0', '1519443597', '1519443597', '1');
INSERT INTO `mk_cate` VALUES ('20', '豆制品', '0', '1519443606', '1519443606', '1');
INSERT INTO `mk_cate` VALUES ('21', '饮料', '0', '1519443614', '1519443614', '1');
INSERT INTO `mk_cate` VALUES ('22', '家庭百货', '0', '1519443622', '1519443622', '1');

-- ----------------------------
-- Table structure for mk_category
-- ----------------------------
DROP TABLE IF EXISTS `mk_category`;
CREATE TABLE `mk_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '关联模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text NOT NULL COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of mk_category
-- ----------------------------
INSERT INTO `mk_category` VALUES ('1', 'blog', '博客', '0', '0', '10', '', '', '', '', '', '', '', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1382701539', '1', '0');
INSERT INTO `mk_category` VALUES ('2', 'default_blog', '默认分类', '1', '1', '10', '', '', '', '', '', '', '', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1386839751', '1', '31');
INSERT INTO `mk_category` VALUES ('39', 's', '子分类', '2', '0', '10', '', '', '', '', '', '', '', '', '', '0', '1', '1', '1', '0', '', '', '1515134246', '1515134246', '1', '0');

-- ----------------------------
-- Table structure for mk_channel
-- ----------------------------
DROP TABLE IF EXISTS `mk_channel`;
CREATE TABLE `mk_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_channel
-- ----------------------------
INSERT INTO `mk_channel` VALUES ('1', '0', '首页', 'Index/index', '1', '1379475111', '1379923177', '0', '0');
INSERT INTO `mk_channel` VALUES ('2', '0', '博客', 'Article/index?category=blog', '2', '1379475131', '1379483713', '1', '0');
INSERT INTO `mk_channel` VALUES ('3', '0', '官网', 'http://www.onethink.cn', '3', '1379475154', '1387163458', '1', '0');

-- ----------------------------
-- Table structure for mk_config
-- ----------------------------
DROP TABLE IF EXISTS `mk_config`;
CREATE TABLE `mk_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text NOT NULL COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_config
-- ----------------------------
INSERT INTO `mk_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', '无人超市', '0');
INSERT INTO `mk_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', '无人超市', '1');
INSERT INTO `mk_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', '无人超市，超市', '8');
INSERT INTO `mk_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `mk_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `mk_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“沪ICP备12007941号-2', '1378900335', '1379235859', '1', '', '9');
INSERT INTO `mk_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表页推荐\r\n2:频道页推荐\r\n4:网站首页推荐', '3');
INSERT INTO `mk_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `mk_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `mk_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '4');
INSERT INTO `mk_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `mk_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `mk_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `mk_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `mk_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `mk_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `mk_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `mk_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `mk_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `mk_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `mk_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `mk_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `mk_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `mk_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `mk_config` VALUES ('35', 'REPLY_LIST_ROWS', '0', '回复列表每页条数', '2', '', '', '1386645376', '1387178083', '1', '10', '0');
INSERT INTO `mk_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `mk_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '0', '0', '1');

-- ----------------------------
-- Table structure for mk_cupboard
-- ----------------------------
DROP TABLE IF EXISTS `mk_cupboard`;
CREATE TABLE `mk_cupboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cupboard_id` int(11) NOT NULL COMMENT '货柜id',
  `lock_id` int(11) NOT NULL COMMENT '锁板id',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '货柜状态',
  `add_time` varchar(10) NOT NULL DEFAULT '',
  `update_time` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cup` (`cupboard_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_cupboard
-- ----------------------------

-- ----------------------------
-- Table structure for mk_device
-- ----------------------------
DROP TABLE IF EXISTS `mk_device`;
CREATE TABLE `mk_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) NOT NULL COMMENT '店铺id号，标志该设备所属店铺',
  `device_id` varchar(255) NOT NULL DEFAULT '' COMMENT '设备id号',
  `device_name` varchar(255) NOT NULL DEFAULT '' COMMENT '设备名称',
  `device_qr` varchar(255) NOT NULL DEFAULT '' COMMENT '设备二维码',
  `add_time` varchar(11) NOT NULL DEFAULT '' COMMENT '添加时间',
  `update_time` varchar(11) NOT NULL DEFAULT '' COMMENT '上次更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '设备状态',
  `lock_id` int(11) NOT NULL,
  `lock_num` int(11) DEFAULT NULL,
  `board_id` int(11) NOT NULL DEFAULT '0' COMMENT '货板ID号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deviced` (`device_id`)
) ENGINE=MyISAM AUTO_INCREMENT=263 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_device
-- ----------------------------
INSERT INTO `mk_device` VALUES ('259', '23', '1001', '测试柜1', '1524314401', '1521171289', '', '1', '1001', '1', '1001');
INSERT INTO `mk_device` VALUES ('260', '23', '1002', '九化店一号柜', '1524054022', '1521185418', '', '1', '1001', '2', '1001');
INSERT INTO `mk_device` VALUES ('261', '24', '10', '辽化店一号柜', '1523969547', '1523668648', '', '1', '2', '1', '1003');
INSERT INTO `mk_device` VALUES ('262', '25', '1234', 'fdsf', '1523971887', '1523971887', '', '1', '12', '1', '0');

-- ----------------------------
-- Table structure for mk_devicelog
-- ----------------------------
DROP TABLE IF EXISTS `mk_devicelog`;
CREATE TABLE `mk_devicelog` (
  `device_logid` int(11) NOT NULL AUTO_INCREMENT,
  `device_id` int(11) NOT NULL,
  `lock_num` int(11) NOT NULL,
  `add_time` varchar(11) NOT NULL,
  `update_time` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：默认打开，0：关闭',
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`device_logid`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_devicelog
-- ----------------------------
INSERT INTO `mk_devicelog` VALUES ('49', '1002', '1', '1523437515', '1523437515', '0', '40');
INSERT INTO `mk_devicelog` VALUES ('50', '1001', '3', '1524054325', '1524054325', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('51', '1001', '1', '1524057487', '1524057487', '0', '45');
INSERT INTO `mk_devicelog` VALUES ('52', '1001', '1', '1524058077', '1524058077', '0', '45');
INSERT INTO `mk_devicelog` VALUES ('53', '1001', '1', '1524058219', '1524058219', '0', '45');
INSERT INTO `mk_devicelog` VALUES ('54', '1001', '1', '1524058296', '1524058296', '0', '45');
INSERT INTO `mk_devicelog` VALUES ('55', '1001', '1', '1524058370', '1524058370', '0', '45');
INSERT INTO `mk_devicelog` VALUES ('56', '1001', '1', '1524101860', '1524106933', '0', '45');
INSERT INTO `mk_devicelog` VALUES ('57', '1001', '1', '1524106954', '1524112022', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('58', '1001', '1', '1524116325', '1524124951', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('59', '1001', '1', '1524125108', '1524126264', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('60', '1001', '1', '1524126282', '1524126342', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('61', '1001', '1', '1524126495', '1524126614', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('62', '1001', '1', '1524127103', '1524306429', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('63', '1001', '1', '1524306638', '1524306793', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('64', '1001', '1', '1524306935', '1524306957', '0', '46');
INSERT INTO `mk_devicelog` VALUES ('65', '1001', '1', '1524313714', '1524314257', '0', '16');
INSERT INTO `mk_devicelog` VALUES ('66', '1001', '1', '1524314481', '1524314549', '0', '16');

-- ----------------------------
-- Table structure for mk_document
-- ----------------------------
DROP TABLE IF EXISTS `mk_document`;
CREATE TABLE `mk_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of mk_document
-- ----------------------------
INSERT INTO `mk_document` VALUES ('1', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1387260660', '1387263112', '0');
INSERT INTO `mk_document` VALUES ('2', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1514947560', '1515120721', '0');
INSERT INTO `mk_document` VALUES ('3', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133038', '1515133038', '0');
INSERT INTO `mk_document` VALUES ('4', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133038', '1515133038', '0');
INSERT INTO `mk_document` VALUES ('5', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133044', '1515133044', '0');
INSERT INTO `mk_document` VALUES ('6', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133044', '1515133044', '0');
INSERT INTO `mk_document` VALUES ('7', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133044', '1515133044', '0');
INSERT INTO `mk_document` VALUES ('8', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133044', '1515133044', '0');
INSERT INTO `mk_document` VALUES ('9', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('10', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('11', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('12', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('13', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('14', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('15', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');
INSERT INTO `mk_document` VALUES ('16', '1', '', 'OneThink1.0正式版发布', '2', '大家期待的OneThink正式版发布', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '9', '0', '0', '0', '1515133048', '1515133048', '0');

-- ----------------------------
-- Table structure for mk_document_article
-- ----------------------------
DROP TABLE IF EXISTS `mk_document_article`;
CREATE TABLE `mk_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of mk_document_article
-- ----------------------------
INSERT INTO `mk_document_article` VALUES ('1', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('2', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('3', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('4', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('5', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('6', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('7', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('8', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('9', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('10', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('11', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('12', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('13', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('14', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('15', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');
INSERT INTO `mk_document_article` VALUES ('16', '0', '<h1>\r\n	OneThink1.0正式版发布&nbsp;\r\n</h1>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink是一个开源的内容管理框架，基于最新的ThinkPHP3.2版本开发，提供更方便、更安全的WEB应用开发体验，采用了全新的架构设计和命名空间机制，融合了模块化、驱动化和插件化的设计理念于一体，开启了国内WEB应用傻瓜式开发的新潮流。&nbsp;</strong> \r\n</p>\r\n<h2>\r\n	主要特性：\r\n</h2>\r\n<p>\r\n	1. 基于ThinkPHP最新3.2版本。\r\n</p>\r\n<p>\r\n	2. 模块化：全新的架构和模块化的开发机制，便于灵活扩展和二次开发。&nbsp;\r\n</p>\r\n<p>\r\n	3. 文档模型/分类体系：通过和文档模型绑定，以及不同的文档类型，不同分类可以实现差异化的功能，轻松实现诸如资讯、下载、讨论和图片等功能。\r\n</p>\r\n<p>\r\n	4. 开源免费：OneThink遵循Apache2开源协议,免费提供使用。&nbsp;\r\n</p>\r\n<p>\r\n	5. 用户行为：支持自定义用户行为，可以对单个用户或者群体用户的行为进行记录及分享，为您的运营决策提供有效参考数据。\r\n</p>\r\n<p>\r\n	6. 云端部署：通过驱动的方式可以轻松支持平台的部署，让您的网站无缝迁移，内置已经支持SAE和BAE3.0。\r\n</p>\r\n<p>\r\n	7. 云服务支持：即将启动支持云存储、云安全、云过滤和云统计等服务，更多贴心的服务让您的网站更安心。\r\n</p>\r\n<p>\r\n	8. 安全稳健：提供稳健的安全策略，包括备份恢复、容错、防止恶意攻击登录，网页防篡改等多项安全管理功能，保证系统安全，可靠、稳定的运行。&nbsp;\r\n</p>\r\n<p>\r\n	9. 应用仓库：官方应用仓库拥有大量来自第三方插件和应用模块、模板主题，有众多来自开源社区的贡献，让您的网站“One”美无缺。&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>&nbsp;OneThink集成了一个完善的后台管理体系和前台模板标签系统，让你轻松管理数据和进行前台网站的标签式开发。&nbsp;</strong> \r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<h2>\r\n	后台主要功能：\r\n</h2>\r\n<p>\r\n	1. 用户Passport系统\r\n</p>\r\n<p>\r\n	2. 配置管理系统&nbsp;\r\n</p>\r\n<p>\r\n	3. 权限控制系统\r\n</p>\r\n<p>\r\n	4. 后台建模系统&nbsp;\r\n</p>\r\n<p>\r\n	5. 多级分类系统&nbsp;\r\n</p>\r\n<p>\r\n	6. 用户行为系统&nbsp;\r\n</p>\r\n<p>\r\n	7. 钩子和插件系统\r\n</p>\r\n<p>\r\n	8. 系统日志系统&nbsp;\r\n</p>\r\n<p>\r\n	9. 数据备份和还原\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	&nbsp;[ 官方下载：&nbsp;<a href=\"http://www.onethink.cn/download.html\" target=\"_blank\">http://www.onethink.cn/download.html</a>&nbsp;&nbsp;开发手册：<a href=\"http://document.onethink.cn/\" target=\"_blank\">http://document.onethink.cn/</a>&nbsp;]&nbsp;\r\n</p>\r\n<p>\r\n	<br />\r\n</p>\r\n<p>\r\n	<strong>OneThink开发团队 2013</strong> \r\n</p>', '', '0');

-- ----------------------------
-- Table structure for mk_document_download
-- ----------------------------
DROP TABLE IF EXISTS `mk_document_download`;
CREATE TABLE `mk_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of mk_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for mk_file
-- ----------------------------
DROP TABLE IF EXISTS `mk_file`;
CREATE TABLE `mk_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of mk_file
-- ----------------------------

-- ----------------------------
-- Table structure for mk_finance
-- ----------------------------
DROP TABLE IF EXISTS `mk_finance`;
CREATE TABLE `mk_finance` (
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单ID号',
  `shopgoods_id` int(11) DEFAULT NULL,
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `num` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量',
  `cell_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品售价',
  `cost` decimal(10,2) DEFAULT '0.00' COMMENT '商品进价',
  `small_count` decimal(10,2) DEFAULT '0.00' COMMENT '小计'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_finance
-- ----------------------------
INSERT INTO `mk_finance` VALUES ('16', '20', '基地虾仁', '13', '6.00', '5.00', '78.00');
INSERT INTO `mk_finance` VALUES ('17', '25', '带鱼', '2', '78.00', '67.00', '156.00');
INSERT INTO `mk_finance` VALUES ('19', '20', '基地虾仁', '3', '6.00', '5.00', '18.00');
INSERT INTO `mk_finance` VALUES ('22', '25', '带鱼', '2', '78.00', '67.00', '156.00');

-- ----------------------------
-- Table structure for mk_goods
-- ----------------------------
DROP TABLE IF EXISTS `mk_goods`;
CREATE TABLE `mk_goods` (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(255) NOT NULL,
  `goods_num` int(11) NOT NULL,
  `goods_des` text NOT NULL,
  `add_time` varchar(255) NOT NULL,
  `update_time` varchar(255) NOT NULL,
  `goods_price` decimal(10,2) NOT NULL,
  `cate_id` varchar(5) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_goods
-- ----------------------------
INSERT INTO `mk_goods` VALUES ('34', '基地虾仁', '100', '', '1519443652', '', '18.90', '18', '1');
INSERT INTO `mk_goods` VALUES ('35', '海鲈鱼', '0', '', '1519443672', '', '23.99', '18', '1');
INSERT INTO `mk_goods` VALUES ('36', '鸦片鱼头', '100', '', '1519443690', '', '21.90', '18', '1');
INSERT INTO `mk_goods` VALUES ('37', '带鱼', '0', '', '1519443703', '', '12.80', '18', '1');
INSERT INTO `mk_goods` VALUES ('38', '草鱼', '100', '', '1519443754', '', '14.00', '18', '1');
INSERT INTO `mk_goods` VALUES ('39', '豆腐', '100', '', '1519443774', '', '3.00', '20', '1');
INSERT INTO `mk_goods` VALUES ('40', '千豆腐', '100', '', '1519443801', '', '2.50', '20', '1');
INSERT INTO `mk_goods` VALUES ('41', '红牛', '100', '', '1519443828', '', '6.00', '21', '1');
INSERT INTO `mk_goods` VALUES ('42', '百事可乐', '100', '', '1519443842', '', '3.00', '21', '1');
INSERT INTO `mk_goods` VALUES ('43', '可口可乐', '100', '', '1519443854', '', '3.00', '21', '1');
INSERT INTO `mk_goods` VALUES ('44', '洗洁精', '100', '', '1519443916', '', '9.99', '22', '1');
INSERT INTO `mk_goods` VALUES ('45', '毛巾', '100', '', '1519443931', '', '25.00', '22', '1');
INSERT INTO `mk_goods` VALUES ('46', '洗衣粉', '100', '', '1519443943', '', '5.00', '22', '1');
INSERT INTO `mk_goods` VALUES ('47', '瓜子', '100', '', '1519443970', '', '14.50', '19', '1');
INSERT INTO `mk_goods` VALUES ('48', '牛肉干', '100', '', '1519443985', '', '35.00', '19', '1');
INSERT INTO `mk_goods` VALUES ('49', '娃哈哈', '1000', '', '1523437716', '', '15.00', '21', '1');
INSERT INTO `mk_goods` VALUES ('50', 'wawa', '212', '', '1523931877', '', '212.00', '22', '1');

-- ----------------------------
-- Table structure for mk_grouplocks
-- ----------------------------
DROP TABLE IF EXISTS `mk_grouplocks`;
CREATE TABLE `mk_grouplocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lock_id` int(11) NOT NULL,
  `lock_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_grouplocks
-- ----------------------------
INSERT INTO `mk_grouplocks` VALUES ('21', '1001', '1');
INSERT INTO `mk_grouplocks` VALUES ('22', '1001', '1');
INSERT INTO `mk_grouplocks` VALUES ('23', '1001', '1');
INSERT INTO `mk_grouplocks` VALUES ('24', '12', '1');

-- ----------------------------
-- Table structure for mk_hooks
-- ----------------------------
DROP TABLE IF EXISTS `mk_hooks`;
CREATE TABLE `mk_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text NOT NULL COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_hooks
-- ----------------------------
INSERT INTO `mk_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '');
INSERT INTO `mk_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop');
INSERT INTO `mk_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment');
INSERT INTO `mk_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment');
INSERT INTO `mk_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '');
INSERT INTO `mk_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment');
INSERT INTO `mk_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor');
INSERT INTO `mk_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin');
INSERT INTO `mk_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam');
INSERT INTO `mk_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor');
INSERT INTO `mk_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '');

-- ----------------------------
-- Table structure for mk_lock
-- ----------------------------
DROP TABLE IF EXISTS `mk_lock`;
CREATE TABLE `mk_lock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lock_id` int(11) NOT NULL COMMENT '锁板id',
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '锁板状态 0关闭 1正常 -1删除',
  `add_time` varchar(10) NOT NULL DEFAULT '',
  `update_time` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lock` (`lock_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_lock
-- ----------------------------
INSERT INTO `mk_lock` VALUES ('24', '1001', '23', '1', '1521171242', '');
INSERT INTO `mk_lock` VALUES ('25', '2', '24', '1', '1523668799', '');
INSERT INTO `mk_lock` VALUES ('26', '0', '23', '1', '1523669219', '');
INSERT INTO `mk_lock` VALUES ('27', '12', '25', '1', '1523971792', '');

-- ----------------------------
-- Table structure for mk_member
-- ----------------------------
DROP TABLE IF EXISTS `mk_member`;
CREATE TABLE `mk_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  `business_id` int(11) DEFAULT '0' COMMENT '所属供应商ID号',
  `manager` tinyint(1) NOT NULL DEFAULT '0' COMMENT '添加的管理员 1:所有权限；2：加盟商管理员；3：店铺管理员',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of mk_member
-- ----------------------------
INSERT INTO `mk_member` VALUES ('1', 'qiaoyuok', '0', '0000-00-00', '', '10', '91', '0', '1514434067', '2130706433', '1525316487', '1', '1', '0');
INSERT INTO `mk_member` VALUES ('42', '优惠多服务', '0', '0000-00-00', '', '0', '0', '0', '1523667939', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('43', '优惠多管理', '0', '0000-00-00', '', '0', '0', '0', '1523668142', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('44', '123456', '0', '0000-00-00', '', '0', '0', '0', '1523971671', '0', '0', '1', '8', '0');
INSERT INTO `mk_member` VALUES ('45', 'wa', '0', '0000-00-00', '', '0', '0', '0', '1525257457', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('46', 'lala', '0', '0000-00-00', '', '0', '0', '0', '1525257519', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('49', 'lalla', '0', '0000-00-00', '', '0', '0', '0', '1525258177', '0', '0', '1', null, '0');
INSERT INTO `mk_member` VALUES ('50', 'wasai', '0', '0000-00-00', '', '0', '0', '0', '1525258235', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('51', 'wahahah', '0', '0000-00-00', '', '0', '0', '0', '1525258256', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('52', 'www', '0', '0000-00-00', '', '0', '0', '0', '1525258525', '0', '0', '1', '7', '0');
INSERT INTO `mk_member` VALUES ('53', 'super', '0', '0000-00-00', '', '0', '1', '0', '1525313309', '2130706433', '1525313326', '1', null, '0');
INSERT INTO `mk_member` VALUES ('54', 'shop', '0', '0000-00-00', '', '0', '2', '0', '1525316382', '2130706433', '1525316531', '1', '7', '0');

-- ----------------------------
-- Table structure for mk_member1
-- ----------------------------
DROP TABLE IF EXISTS `mk_member1`;
CREATE TABLE `mk_member1` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `headimgurl` varchar(255) NOT NULL,
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  `openid` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `idcard` varchar(255) NOT NULL,
  `business_id` int(11) DEFAULT '0' COMMENT '所属供应商ID号',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of mk_member1
-- ----------------------------
INSERT INTO `mk_member1` VALUES ('1', '', 'qiaoyuok', '0', '0000-00-00', '', '10', '70', '0', '1514434067', '2047789011', '1523428363', '1', '', '', '', '1');
INSERT INTO `mk_member1` VALUES ('15', '', 'wahaha', '0', '0000-00-00', '', '0', '2', '0', '1521279916', '2047789011', '1521280253', '1', '', '', '', '7');
INSERT INTO `mk_member1` VALUES ('16', 'http://thirdwx.qlogo.cn/mmopen/vi_32/a3PX0PPmFJqVpYatlWAZVr3Phs0sIQ7qM4G2pqkGdATkHOpjYkaRBps1tTicjh6TG8BdQ21ZafAhf2ZSMvuHiaNA/132', 'handey', '0', '0000-00-00', '', '0', '0', '0', '0', '0', '0', '2', 'oCG--0slxXk977VILDgsiUBbyAsM', '王小明', '33555554442', '0');

-- ----------------------------
-- Table structure for mk_menu
-- ----------------------------
DROP TABLE IF EXISTS `mk_menu`;
CREATE TABLE `mk_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=175 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_menu
-- ----------------------------
INSERT INTO `mk_menu` VALUES ('1', '首页', '0', '1', 'Index/index', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('2', '内容', '0', '2', 'Article/mydocument', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('3', '文档列表', '2', '0', 'article/index', '1', '', '内容', '0');
INSERT INTO `mk_menu` VALUES ('4', '新增', '3', '0', 'article/add', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('5', '编辑', '3', '0', 'article/edit', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('6', '改变状态', '3', '0', 'article/setStatus', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('7', '保存', '3', '0', 'article/update', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('8', '保存草稿', '3', '0', 'article/autoSave', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('9', '移动', '3', '0', 'article/move', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('10', '复制', '3', '0', 'article/copy', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('11', '粘贴', '3', '0', 'article/paste', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('12', '导入', '3', '0', 'article/batchOperate', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('13', '回收站', '2', '0', 'article/recycle', '1', '', '内容', '0');
INSERT INTO `mk_menu` VALUES ('14', '还原', '13', '0', 'article/permit', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('15', '清空', '13', '0', 'article/clear', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('16', '用户', '0', '0', 'User/index', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('17', '管理员', '16', '0', 'User/index', '0', '', '用户管理', '0');
INSERT INTO `mk_menu` VALUES ('18', '新增用户', '17', '0', 'User/add', '0', '添加新用户', '', '0');
INSERT INTO `mk_menu` VALUES ('19', '用户行为', '16', '0', 'User/action', '1', '', '行为管理', '0');
INSERT INTO `mk_menu` VALUES ('20', '新增用户行为', '19', '0', 'User/addaction', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('21', '编辑用户行为', '19', '0', 'User/editaction', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('22', '保存用户行为', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0');
INSERT INTO `mk_menu` VALUES ('23', '变更行为状态', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0');
INSERT INTO `mk_menu` VALUES ('24', '禁用会员', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0');
INSERT INTO `mk_menu` VALUES ('25', '启用会员', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0');
INSERT INTO `mk_menu` VALUES ('26', '删除会员', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0');
INSERT INTO `mk_menu` VALUES ('27', '权限管理', '16', '0', 'AuthManager/index', '0', '', '用户管理', '0');
INSERT INTO `mk_menu` VALUES ('28', '删除', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0');
INSERT INTO `mk_menu` VALUES ('29', '禁用', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0');
INSERT INTO `mk_menu` VALUES ('30', '恢复', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0');
INSERT INTO `mk_menu` VALUES ('31', '新增', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0');
INSERT INTO `mk_menu` VALUES ('32', '编辑', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0');
INSERT INTO `mk_menu` VALUES ('33', '保存用户组', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('34', '授权', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0');
INSERT INTO `mk_menu` VALUES ('35', '访问授权', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('36', '成员授权', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('37', '解除授权', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('38', '保存成员授权', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0');
INSERT INTO `mk_menu` VALUES ('39', '分类授权', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('40', '保存分类授权', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('41', '模型授权', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('42', '保存模型授权', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0');
INSERT INTO `mk_menu` VALUES ('43', '扩展', '0', '7', 'Addons/index', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('44', '插件管理', '43', '1', 'Addons/index', '0', '', '扩展', '0');
INSERT INTO `mk_menu` VALUES ('45', '创建', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0');
INSERT INTO `mk_menu` VALUES ('46', '检测创建', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0');
INSERT INTO `mk_menu` VALUES ('47', '预览', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0');
INSERT INTO `mk_menu` VALUES ('48', '快速生成插件', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0');
INSERT INTO `mk_menu` VALUES ('49', '设置', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0');
INSERT INTO `mk_menu` VALUES ('50', '禁用', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0');
INSERT INTO `mk_menu` VALUES ('51', '启用', '44', '0', 'Addons/enable', '0', '启用插件', '', '0');
INSERT INTO `mk_menu` VALUES ('52', '安装', '44', '0', 'Addons/install', '0', '安装插件', '', '0');
INSERT INTO `mk_menu` VALUES ('53', '卸载', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0');
INSERT INTO `mk_menu` VALUES ('54', '更新配置', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0');
INSERT INTO `mk_menu` VALUES ('55', '插件后台列表', '44', '0', 'Addons/adminList', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('56', 'URL方式访问插件', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0');
INSERT INTO `mk_menu` VALUES ('57', '钩子管理', '43', '2', 'Addons/hooks', '0', '', '扩展', '0');
INSERT INTO `mk_menu` VALUES ('58', '模型管理', '68', '3', 'Model/index', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('59', '新增', '58', '0', 'model/add', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('60', '编辑', '58', '0', 'model/edit', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('61', '改变状态', '58', '0', 'model/setStatus', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('62', '保存数据', '58', '0', 'model/update', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('63', '属性管理', '68', '0', 'Attribute/index', '1', '网站属性配置。', '', '0');
INSERT INTO `mk_menu` VALUES ('64', '新增', '63', '0', 'Attribute/add', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('65', '编辑', '63', '0', 'Attribute/edit', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('66', '改变状态', '63', '0', 'Attribute/setStatus', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('67', '保存数据', '63', '0', 'Attribute/update', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('68', '系统', '0', '44', 'Config/group', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('69', '网站设置', '68', '1', 'Config/group', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('70', '配置管理', '68', '4', 'Config/index', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('71', '编辑', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0');
INSERT INTO `mk_menu` VALUES ('72', '删除', '70', '0', 'Config/del', '0', '删除配置', '', '0');
INSERT INTO `mk_menu` VALUES ('73', '新增', '70', '0', 'Config/add', '0', '新增配置', '', '0');
INSERT INTO `mk_menu` VALUES ('74', '保存', '70', '0', 'Config/save', '0', '保存配置', '', '0');
INSERT INTO `mk_menu` VALUES ('75', '菜单管理', '68', '5', 'Menu/index', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('76', '导航管理', '68', '6', 'Channel/index', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('77', '新增', '76', '0', 'Channel/add', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('78', '编辑', '76', '0', 'Channel/edit', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('79', '删除', '76', '0', 'Channel/del', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('80', '分类管理', '68', '2', 'Category/index', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('81', '编辑', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0');
INSERT INTO `mk_menu` VALUES ('82', '新增', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0');
INSERT INTO `mk_menu` VALUES ('83', '删除', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0');
INSERT INTO `mk_menu` VALUES ('84', '移动', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0');
INSERT INTO `mk_menu` VALUES ('85', '合并', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0');
INSERT INTO `mk_menu` VALUES ('86', '备份数据库', '68', '0', 'Database/index?type=export', '0', '', '数据备份', '0');
INSERT INTO `mk_menu` VALUES ('87', '备份', '86', '0', 'Database/export', '0', '备份数据库', '', '0');
INSERT INTO `mk_menu` VALUES ('88', '优化表', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0');
INSERT INTO `mk_menu` VALUES ('89', '修复表', '86', '0', 'Database/repair', '0', '修复数据表', '', '0');
INSERT INTO `mk_menu` VALUES ('90', '还原数据库', '68', '0', 'Database/index?type=import', '0', '', '数据备份', '0');
INSERT INTO `mk_menu` VALUES ('91', '恢复', '90', '0', 'Database/import', '0', '数据库恢复', '', '0');
INSERT INTO `mk_menu` VALUES ('92', '删除', '90', '0', 'Database/del', '0', '删除备份文件', '', '0');
INSERT INTO `mk_menu` VALUES ('93', '其他', '0', '5', 'other', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('96', '新增', '75', '0', 'Menu/add', '0', '', '系统设置', '0');
INSERT INTO `mk_menu` VALUES ('98', '编辑', '75', '0', 'Menu/edit', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('104', '下载管理', '102', '0', 'Think/lists?model=download', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('105', '配置管理', '102', '0', 'Think/lists?model=config', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('106', '行为日志', '16', '0', 'Action/actionlog', '1', '', '行为管理', '0');
INSERT INTO `mk_menu` VALUES ('108', '修改密码', '16', '0', 'User/updatePassword', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('109', '修改昵称', '16', '0', 'User/updateNickname', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('110', '查看行为日志', '106', '0', 'action/edit', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('112', '新增数据', '58', '0', 'think/add', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('113', '编辑数据', '58', '0', 'think/edit', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('114', '导入', '75', '0', 'Menu/import', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('115', '生成', '58', '0', 'Model/generate', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('116', '新增钩子', '57', '0', 'Addons/addHook', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('117', '编辑钩子', '57', '0', 'Addons/edithook', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('118', '文档排序', '3', '0', 'Article/sort', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('119', '排序', '70', '0', 'Config/sort', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('120', '排序', '75', '0', 'Menu/sort', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('121', '排序', '76', '0', 'Channel/sort', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('124', '货柜', '0', '2', 'Device/index', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('123', '货柜列表', '122', '0', 'device/indx', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('128', '店面', '0', '1', 'Shop/index', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('127', '货柜列表', '124', '0', 'Device/index', '0', '', '设备管理', '0');
INSERT INTO `mk_menu` VALUES ('139', '财务管理', '138', '0', 'Finance/index', '0', '', '财务管理', '0');
INSERT INTO `mk_menu` VALUES ('140', '统计', '0', '6', 'Count/index', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('131', '添加货柜', '127', '0', 'Device/add', '0', '', '货柜', '0');
INSERT INTO `mk_menu` VALUES ('132', '店面管理', '128', '0', 'Shop/index', '0', '', '店面管理', '0');
INSERT INTO `mk_menu` VALUES ('133', '添加店面', '132', '0', 'Shop/add', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('134', '货品', '0', '3', 'Goods/index', '0', '', '货品管理', '0');
INSERT INTO `mk_menu` VALUES ('135', '货品列表', '134', '0', 'Goods/index', '0', '', '货品管理', '0');
INSERT INTO `mk_menu` VALUES ('136', '分类管理', '134', '1', 'Goods/category', '0', '', '货品管理', '0');
INSERT INTO `mk_menu` VALUES ('137', '已下架', '134', '3', 'Goods/out', '0', '', '货品管理', '0');
INSERT INTO `mk_menu` VALUES ('138', '财务', '0', '5', 'Finance/index', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('141', '查看统计', '140', '0', 'Count/index', '0', '', '统计管理', '0');
INSERT INTO `mk_menu` VALUES ('143', '货品添加', '135', '0', 'Goods/add', '0', '', '货品', '0');
INSERT INTO `mk_menu` VALUES ('144', '分类添加', '135', '0', 'Goods/cate_add', '0', '', '分类管理', '0');
INSERT INTO `mk_menu` VALUES ('145', '编辑商品', '135', '0', 'Goods/editAction', '0', '', '分类管理', '0');
INSERT INTO `mk_menu` VALUES ('146', '用户审核', '17', '0', 'User/tocheck', '0', '', '用户信息', '0');
INSERT INTO `mk_menu` VALUES ('147', '编辑分类', '135', '0', 'Goods/cate_edit', '0', '', '分类管理', '0');
INSERT INTO `mk_menu` VALUES ('148', '锁板管理', '124', '0', 'Device/lock', '0', '', '设备管理', '0');
INSERT INTO `mk_menu` VALUES ('149', '设备管理', '124', '0', 'Device/cupboard', '1', '', '设备管理', '0');
INSERT INTO `mk_menu` VALUES ('150', '货板管理', '124', '2', 'Device/board', '0', '', '设备管理', '0');
INSERT INTO `mk_menu` VALUES ('151', '天假锁板', '148', '0', 'Device/addlock', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('152', '货柜添加', '149', '0', 'Device/addcupboard', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('153', '添加货板', '150', '0', 'Device/addboard', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('154', '展示界面', '0', '0', 'Showpage/index', '1', '', '', '0');
INSERT INTO `mk_menu` VALUES ('155', '查看资料', '17', '0', 'User/look', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('156', '货柜编辑', '127', '0', 'Device/deviceedit', '0', '', '货柜列表', '0');
INSERT INTO `mk_menu` VALUES ('157', '加盟商', '0', '9', 'Business/index', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('158', '加盟商管理', '157', '0', 'Business/index', '0', '', '加盟商管理', '0');
INSERT INTO `mk_menu` VALUES ('159', '新增加盟商', '158', '0', 'Business/add', '0', '', '加盟商管理', '0');
INSERT INTO `mk_menu` VALUES ('160', '编辑加盟商', '158', '0', 'Business/edit', '0', '', '加盟商管理', '0');
INSERT INTO `mk_menu` VALUES ('161', '用户列表', '17', '0', 'User/normal', '0', '', '用户信息', '0');
INSERT INTO `mk_menu` VALUES ('162', '获取商品', '150', '0', 'Device/setgoodslists', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('164', '编辑店铺', '132', '0', 'Shop/edit', '0', '', '店面管理', '0');
INSERT INTO `mk_menu` VALUES ('165', '配置货品', '132', '0', 'Shop/shopgoods', '0', '', '店面管理', '0');
INSERT INTO `mk_menu` VALUES ('166', '添加货品', '132', '0', 'Shop/addshopgoods', '0', '', '店面管理', '0');
INSERT INTO `mk_menu` VALUES ('167', '编辑货品', '132', '0', 'Shop/shopgoodsedit', '0', '', '店面管理', '0');
INSERT INTO `mk_menu` VALUES ('168', '获取商品', '132', '0', 'Shop/setgoodslists', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('169', '删除店铺', '132', '0', 'Shop/changeStatus', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('170', '编辑货板', '150', '0', 'Device/editboard', '0', '', '货板管理', '0');
INSERT INTO `mk_menu` VALUES ('171', '订单', '0', '4', 'Order/index', '0', '', '', '0');
INSERT INTO `mk_menu` VALUES ('172', '订单管理', '171', '0', 'Order/index', '0', '', '订单管理', '0');
INSERT INTO `mk_menu` VALUES ('173', '查看订单', '172', '0', 'Order/orderdetail', '0', '', '订单管理', '0');
INSERT INTO `mk_menu` VALUES ('174', '会员用户', '16', '0', 'User/user', '0', '', '用户管理', '0');

-- ----------------------------
-- Table structure for mk_model
-- ----------------------------
DROP TABLE IF EXISTS `mk_model`;
CREATE TABLE `mk_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text NOT NULL COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text NOT NULL COMMENT '属性列表（表的字段）',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text NOT NULL COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of mk_model
-- ----------------------------
INSERT INTO `mk_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"15\",\"16\",\"17\",\"18\",\"19\",\"20\",\"21\",\"22\"]}', '1:基础', '', '', '', '', 'id:编号\r\ntitle:标题:article/index?cate_id=[category_id]&pid=[id]\r\ntype|get_document_type:类型\r\nlevel:优先级\r\nupdate_time|time_format:最后更新\r\nstatus_text:状态\r\nview:浏览\r\nid:操作:[EDIT]&cate_id=[category_id]|编辑,article/setstatus?status=-1&ids=[id]|删除', '0', '', '', '1383891233', '1384507827', '1', 'MyISAM');
INSERT INTO `mk_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题:article/edit?cate_id=[category_id]&id=[id]\r\ncontent:内容', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `mk_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', 'id:编号\r\ntitle:标题', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');

-- ----------------------------
-- Table structure for mk_order
-- ----------------------------
DROP TABLE IF EXISTS `mk_order`;
CREATE TABLE `mk_order` (
  `order_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sn` varchar(255) NOT NULL,
  `allcount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品合计',
  `allnum` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态；0默认状态，待支付；1已完成',
  `add_time` varchar(11) NOT NULL DEFAULT '',
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `device_id` int(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `goodsdetail` varchar(5000) NOT NULL DEFAULT '' COMMENT '订单详情，商品id，价格，进价，数量。。',
  `update_time` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_order
-- ----------------------------

-- ----------------------------
-- Table structure for mk_picture
-- ----------------------------
DROP TABLE IF EXISTS `mk_picture`;
CREATE TABLE `mk_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_picture
-- ----------------------------

-- ----------------------------
-- Table structure for mk_shop
-- ----------------------------
DROP TABLE IF EXISTS `mk_shop`;
CREATE TABLE `mk_shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(255) NOT NULL,
  `shop_address` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `add_time` varchar(11) NOT NULL,
  `update_time` varchar(11) NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID号',
  `business_id` int(11) NOT NULL DEFAULT '0' COMMENT '加盟商ID号',
  PRIMARY KEY (`shop_id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_shop
-- ----------------------------
INSERT INTO `mk_shop` VALUES ('23', '九化店', '打赏1', '1', '1521171230', '1525317874', '54', '7');
INSERT INTO `mk_shop` VALUES ('24', '辽化店', '分段收费', '1', '1521278364', '1523668511', '1', '7');
INSERT INTO `mk_shop` VALUES ('25', 'fdsfsd', 'fdsfsdf', '1', '1523971739', '', '1', '7');

-- ----------------------------
-- Table structure for mk_shopgoods
-- ----------------------------
DROP TABLE IF EXISTS `mk_shopgoods`;
CREATE TABLE `mk_shopgoods` (
  `shopgoods_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品ID号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '店铺ID号',
  `cost` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `cell_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '售价',
  `add_time` varchar(11) NOT NULL DEFAULT '' COMMENT '添加时间',
  `update_time` varchar(11) NOT NULL DEFAULT '' COMMENT '更新时间',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名称',
  `cate_id` int(11) NOT NULL DEFAULT '0',
  `stock` int(10) NOT NULL DEFAULT '0' COMMENT '当前商品库存',
  PRIMARY KEY (`shopgoods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_shopgoods
-- ----------------------------
INSERT INTO `mk_shopgoods` VALUES ('5', '34', '19', '1.00', '12.00', '1520837955', '', '基地虾仁', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('6', '47', '19', '2.00', '3.00', '1520837965', '', '瓜子', '19', '0');
INSERT INTO `mk_shopgoods` VALUES ('12', '43', '16', '3.00', '4.00', '1520932938', '', '可口可乐', '21', '0');
INSERT INTO `mk_shopgoods` VALUES ('9', '35', '19', '323.00', '3234.00', '1520840121', '', '海鲈鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('10', '36', '20', '15.00', '51.00', '1520843167', '', '鸦片鱼头', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('11', '35', '18', '32.00', '54.00', '1520930796', '', '海鲈鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('13', '34', '16', '56.00', '69.00', '1520936391', '', '基地虾仁', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('14', '48', '16', '20.00', '35.00', '1520936407', '', '牛肉干', '19', '0');
INSERT INTO `mk_shopgoods` VALUES ('15', '34', '22', '1.00', '2.00', '1521102994', '', '基地虾仁', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('16', '37', '22', '5.00', '7.00', '1521103004', '', '带鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('17', '44', '22', '5.00', '7.00', '1521103013', '', '洗洁精', '22', '0');
INSERT INTO `mk_shopgoods` VALUES ('18', '46', '22', '4.00', '32.00', '1521103023', '', '洗衣粉', '22', '0');
INSERT INTO `mk_shopgoods` VALUES ('19', '36', '22', '43.00', '54.00', '1521103040', '', '鸦片鱼头', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('20', '34', '23', '5.00', '6.00', '1521171311', '', '基地虾仁', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('21', '36', '23', '6.00', '12.00', '1521171320', '', '鸦片鱼头', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('22', '34', '24', '2.00', '3.00', '1521280340', '1523668403', '基地虾仁', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('23', '35', '23', '323.00', '324.00', '1521623669', '', '海鲈鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('24', '38', '23', '5.00', '7.00', '1521623677', '', '草鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('25', '37', '23', '67.00', '78.00', '1521623689', '', '带鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('26', '41', '23', '4.00', '5.00', '1521623699', '', '红牛', '21', '0');
INSERT INTO `mk_shopgoods` VALUES ('27', '45', '23', '3.00', '4.00', '1521623709', '', '毛巾', '22', '0');
INSERT INTO `mk_shopgoods` VALUES ('28', '40', '23', '3.01', '4.35', '1521623721', '', '千豆腐', '20', '0');
INSERT INTO `mk_shopgoods` VALUES ('29', '42', '23', '2.00', '3.00', '1523970708', '', '百事可乐', '21', '0');
INSERT INTO `mk_shopgoods` VALUES ('30', '35', '24', '23.00', '33.00', '1523970727', '', '海鲈鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('31', '38', '24', '5.00', '7.00', '1523970846', '', '草鱼', '18', '0');
INSERT INTO `mk_shopgoods` VALUES ('32', '39', '25', '2.00', '3.00', '1523971763', '', '豆腐', '20', '0');
INSERT INTO `mk_shopgoods` VALUES ('33', '43', '23', '11.00', '2.00', '1525317885', '', '可口可乐', '21', '0');

-- ----------------------------
-- Table structure for mk_smallbox
-- ----------------------------
DROP TABLE IF EXISTS `mk_smallbox`;
CREATE TABLE `mk_smallbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL DEFAULT '0' COMMENT '货板id号',
  `smallbox_id` int(5) NOT NULL DEFAULT '0' COMMENT '货板内的18个小板',
  `status` varchar(255) NOT NULL DEFAULT '' COMMENT '每个小板内商品的状态',
  `add_time` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_smallbox
-- ----------------------------

-- ----------------------------
-- Table structure for mk_ucenter_admin
-- ----------------------------
DROP TABLE IF EXISTS `mk_ucenter_admin`;
CREATE TABLE `mk_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of mk_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for mk_ucenter_app
-- ----------------------------
DROP TABLE IF EXISTS `mk_ucenter_app`;
CREATE TABLE `mk_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of mk_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for mk_ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `mk_ucenter_member`;
CREATE TABLE `mk_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `business_id` int(11) DEFAULT '0' COMMENT '所属供应商ID号',
  `manager` tinyint(1) NOT NULL DEFAULT '0' COMMENT '添加的管理员 1:所有权限；2：加盟商管理员；3：店铺管理员',
  `shop_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理的店铺',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of mk_ucenter_member
-- ----------------------------
INSERT INTO `mk_ucenter_member` VALUES ('1', 'qiaoyuok', 'd16b55b2ce888997b33c13142fee82af', '1589946526@qq.com', '', '1514434067', '3232235896', '1525316487', '2130706433', '1514434067', '1', '1', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('42', '优惠多服务', 'b4d7ca4ceb41a9039595a224dffe40f3', '394278870@qq.com', '', '1523667939', '2047789011', '0', '0', '1523667939', '1', '7', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('43', '优惠多管理', '76d9cc6bfcd11fd5e24847a719e4e482', '1034175565@qq.com', '', '1523668142', '2047789011', '0', '0', '1523668142', '1', '7', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('44', '123456', '04f872a649ddd920e3f1099a0c013e94', '', '', '1523971671', '2047789011', '0', '0', '1523971671', '1', '8', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('45', 'wa', '04f872a649ddd920e3f1099a0c013e94', '', '', '1525257457', '2130706433', '0', '0', '1525257457', '1', '7', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('46', 'lala', 'b738925c8e6a1c95996ea5b01d58a22c', '', '', '1525257519', '2130706433', '0', '0', '1525257519', '1', '7', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('47', 'fdsfdsf', 'b738925c8e6a1c95996ea5b01d58a22c', '', '', '1525257766', '2130706433', '0', '0', '1525257766', '1', '7', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('48', 'fdsfd11sf', 'b738925c8e6a1c95996ea5b01d58a22c', '', '', '1525257766', '2130706433', '0', '0', '1525257766', '1', '7', '0', '0');
INSERT INTO `mk_ucenter_member` VALUES ('49', 'lalla', '7aad5ec61a7e8a8a66ef312f5d860f05', '', '', '1525258177', '2130706433', '0', '0', '1525258177', '1', null, '1', '0');
INSERT INTO `mk_ucenter_member` VALUES ('50', 'wasai', 'b738925c8e6a1c95996ea5b01d58a22c', '', '', '1525258235', '2130706433', '0', '0', '1525258235', '1', '7', '2', '0');
INSERT INTO `mk_ucenter_member` VALUES ('51', 'wahahah', 'b738925c8e6a1c95996ea5b01d58a22c', '', '', '1525258256', '2130706433', '0', '0', '1525258256', '1', '7', '3', '0');
INSERT INTO `mk_ucenter_member` VALUES ('52', 'www', '772824f7aed340f6cb830ba0511b3d2c', '', '', '1525258525', '2130706433', '0', '0', '1525258525', '1', '7', '3', '23');
INSERT INTO `mk_ucenter_member` VALUES ('53', 'super', '04f872a649ddd920e3f1099a0c013e94', '', '', '1525313309', '2130706433', '1525313326', '2130706433', '1525313309', '1', null, '1', '0');
INSERT INTO `mk_ucenter_member` VALUES ('54', 'shop', '04f872a649ddd920e3f1099a0c013e94', '', '', '1525316382', '2130706433', '1525316531', '2130706433', '1525316382', '1', '7', '3', '23');

-- ----------------------------
-- Table structure for mk_ucenter_member1
-- ----------------------------
DROP TABLE IF EXISTS `mk_ucenter_member1`;
CREATE TABLE `mk_ucenter_member1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户状态',
  `business_id` int(11) DEFAULT '0' COMMENT '所属供应商ID号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of mk_ucenter_member1
-- ----------------------------
INSERT INTO `mk_ucenter_member1` VALUES ('1', 'qiaoyuok', 'd16b55b2ce888997b33c13142fee82af', '1589946526@qq.com', '', '1514434067', '3232235896', '1523428363', '2047789011', '1514434067', '1', '1');
INSERT INTO `mk_ucenter_member1` VALUES ('15', 'wahaha', 'd16b55b2ce888997b33c13142fee82af', '', '', '1521279916', '2047789011', '1521280253', '2047789011', '1521279916', '1', '7');
INSERT INTO `mk_ucenter_member1` VALUES ('16', 'handey', '', '', '', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for mk_ucenter_setting
-- ----------------------------
DROP TABLE IF EXISTS `mk_ucenter_setting`;
CREATE TABLE `mk_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of mk_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for mk_url
-- ----------------------------
DROP TABLE IF EXISTS `mk_url`;
CREATE TABLE `mk_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of mk_url
-- ----------------------------

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
  `idcard` varchar(50) NOT NULL DEFAULT '' COMMENT '身份证号',
  `create_time` varchar(11) NOT NULL DEFAULT '' COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_user
-- ----------------------------

-- ----------------------------
-- Table structure for mk_userdata
-- ----------------------------
DROP TABLE IF EXISTS `mk_userdata`;
CREATE TABLE `mk_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mk_userdata
-- ----------------------------
