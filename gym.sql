

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adminuser
-- ----------------------------
DROP TABLE IF EXISTS `adminuser`;
CREATE TABLE `adminuser` (
  `adminId` int(20) NOT NULL AUTO_INCREMENT,
  `adminName` varchar(20) DEFAULT NULL,
  `adminPassword` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminuser
-- ----------------------------
INSERT INTO `adminuser` VALUES ('1', 'admin', '0192023a7bbd73250516f069df18b500');
INSERT INTO `adminuser` VALUES ('7', 'liujian', '0192023a7bbd73250516f069df18b500');

-- ----------------------------
-- Table structure for chongzhi
-- ----------------------------
DROP TABLE IF EXISTS `chongzhi`;
CREATE TABLE `chongzhi` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Memberid` int(11) DEFAULT NULL,
  `Typeid` int(11) DEFAULT NULL,
  `Money` int(11) DEFAULT NULL,
  `ssmoney` int(11) DEFAULT NULL,
  `zlmoney` int(11) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `czjine` int(11) DEFAULT NULL,
  `beizhu` varchar(50) DEFAULT NULL,
  `czStatic` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chongzhi
-- ----------------------------
INSERT INTO `chongzhi` VALUES ('6', '38', '2', '150', '150', '0', '2020-04-07 18:58:24', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('8', '34', '1', '500', '1000', '0', '2020-04-08 15:29:09', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('10', '34', null, '500', '500', '0', '2020-04-08 15:31:49', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('11', '25', null, '500', '500', '0', '2020-04-08 15:33:08', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('12', '26', '5', '50', '100', '50', '2020-04-08 15:37:17', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('13', '26', '1', '500', '1000', '500', '2020-04-08 15:38:22', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('14', '26', '1', '500', '500', '0', '2020-04-08 15:40:44', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('15', '26', '1', '500', '500', '0', '2020-04-08 15:42:03', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('16', '34', '5', '50', '50', '0', '2020-04-08 15:43:00', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('17', '34', '3', '1000', '1000', '0', '2020-04-08 15:43:33', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('18', '34', '1', '500', '500', '0', '2020-04-08 15:43:51', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('19', '34', '2', '150', '1000', '850', '2020-04-08 15:44:37', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('20', '34', '1', '500', '500', '0', '2020-04-08 15:46:55', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('32', '25', '1', '500', '500', '0', '2020-04-08 17:43:37', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('57', '26', null, '-10', '200', '0', '2020-04-08 18:25:19', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('58', '26', null, '50', '200', '0', '2020-04-08 18:25:35', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('60', '26', '5', '50', '100', '50', '2020-04-08 18:37:19', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('61', '25', '2', '150', '200', '50', '2020-04-11 16:28:03', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('63', '25', '1', '500', '2000', '1500', '2020-04-11 16:43:37', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('64', '25', '1', '500', '500', '0', '2020-04-11 16:53:43', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('65', '43', '1', '500', '400', '-100', '2020-04-11 16:54:09', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('66', '35', '2', '150', '200', '50', '2020-04-11 16:54:41', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('67', '25', '1', '500', '1', '-499', '2020-04-11 16:55:47', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('68', '25', '3', '1000', '1000', '0', '2020-04-11 16:57:01', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('72', '25', null, '200', '200', '0', '2020-04-11 17:03:03', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('77', '25', null, '200', '200', '0', '2020-04-11 17:13:21', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('78', '26', null, '200', '200', '0', '2020-04-11 17:13:37', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('81', '25', '1', '1000', '1000', '0', '2020-04-11 17:14:32', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('82', '25', null, '200', '200', '0', '2020-04-11 17:14:40', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('83', '35', null, '200', '200', '0', '2020-04-11 17:16:31', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('84', '37', '3', '1000', '1000', '0', '2020-05-03 15:33:32', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('85', '35', '1', '500', '500', '0', '2020-05-03 15:33:56', '0', '', '2');
INSERT INTO `chongzhi` VALUES ('86', '25', null, '500', '500', '0', '2020-05-03 15:34:32', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('87', '34', null, '1000', '1000', '0', '2020-05-03 15:35:37', '0', '', '1');
INSERT INTO `chongzhi` VALUES ('88', '37', null, '1000', '1000', '0', '2020-05-03 15:35:58', '0', '', '1');

-- ----------------------------
-- Table structure for coach
-- ----------------------------
DROP TABLE IF EXISTS `coach`;
CREATE TABLE `coach` (
  `coachId` int(20) NOT NULL AUTO_INCREMENT,
  `coachName` varchar(20) DEFAULT NULL,
  `coachPhone` varchar(50) DEFAULT NULL,
  `coachSex` int(10) DEFAULT NULL,
  `CoachAge` int(10) DEFAULT NULL,
  `CoachData` date DEFAULT NULL,
  `Teach` int(10) DEFAULT NULL,
  `CoachWages` double DEFAULT NULL,
  `CoachAddress` varchar(100) DEFAULT NULL,
  `CoachStatic` int(11) DEFAULT '0',
  PRIMARY KEY (`coachId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of coach
-- ----------------------------
INSERT INTO `coach` VALUES ('2', '张起灵', '13243253432', '0', '22', '2019-08-02', '2', '6000', '张家古楼', '0');
INSERT INTO `coach` VALUES ('3', '蓝忘机', '13324332344', '0', '20', '2019-08-02', '2', '10000', '云深不知处', '0');
INSERT INTO `coach` VALUES ('4', '花城', '13324245453', '1', '25', '2020-04-10', '3', '12000', '仙乐国', '0');
INSERT INTO `coach` VALUES ('11', '婉儿', '13342244112', '1', '18', '2020-05-01', '2', '16500', '长留', '1');
INSERT INTO `coach` VALUES ('12', '白凤九', '13433324335', '1', '20', '2019-10-04', '1', '18000', '青丘', '2');
INSERT INTO `coach` VALUES ('14', '张含', '15299985622', '1', '35', '2020-04-02', '5', '10000', '北京丰台', '1');
INSERT INTO `coach` VALUES ('16', '周命', '15785456231', '1', '22', '2020-05-06', '2', '12000', '陕西西安', '0');

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment` (
  `eqId` int(20) NOT NULL AUTO_INCREMENT,
  `eqName` varchar(20) DEFAULT NULL,
  `eqText` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`eqId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES ('1', '跑步机', '大型斑马牌跑步机');
INSERT INTO `equipment` VALUES ('6', '动感单车', '塑身');
INSERT INTO `equipment` VALUES ('7', '呼啦圈', '10');

-- ----------------------------
-- Table structure for goodinfo
-- ----------------------------
DROP TABLE IF EXISTS `goodinfo`;
CREATE TABLE `goodinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsid` int(11) DEFAULT NULL,
  `memberid` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goodinfo
-- ----------------------------
INSERT INTO `goodinfo` VALUES ('9', '3', '25', '2', '10', '');
INSERT INTO `goodinfo` VALUES ('12', '4', '26', '5', '5', '');
INSERT INTO `goodinfo` VALUES ('14', '5', '34', '6', '30', '');
INSERT INTO `goodinfo` VALUES ('15', '2', '37', '2', '10', '');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `goodsId` int(11) NOT NULL AUTO_INCREMENT,
  `goodsName` varchar(50) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `unitPrice` double DEFAULT NULL,
  `sellPrice` double DEFAULT NULL,
  `inventory` int(11) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`goodsId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('2', '可口可乐', '瓶', '2', '5', '48', '1');
INSERT INTO `goods` VALUES ('3', '百事可乐', '瓶', '2', '5', '3', '');
INSERT INTO `goods` VALUES ('4', '小布丁雪糕', '根', '0.5', '1', '13', '');
INSERT INTO `goods` VALUES ('5', '压缩饼干', '块', '2', '5', '24', '');
INSERT INTO `goods` VALUES ('7', '脉动', '瓶', '3', '6', '0', '');
INSERT INTO `goods` VALUES ('8', '毛巾', '个', '10', '20', '0', '');

-- ----------------------------
-- Table structure for loos
-- ----------------------------
DROP TABLE IF EXISTS `loos`;
CREATE TABLE `loos` (
  `loosId` int(20) NOT NULL AUTO_INCREMENT,
  `loosName` varchar(20) DEFAULT NULL,
  `loosImages` varchar(50) DEFAULT NULL,
  `loosAddress` varchar(50) DEFAULT NULL,
  `loosjdate` datetime DEFAULT NULL,
  `loosStatus` int(10) DEFAULT NULL,
  `scavenger` varchar(50) DEFAULT NULL,
  `scavengerPhone` varchar(50) DEFAULT NULL,
  `ReceiveName` varchar(20) DEFAULT NULL,
  `ReceivePhone` varchar(20) DEFAULT NULL,
  `loosldate` datetime DEFAULT NULL,
  `admin` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`loosId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loos
-- ----------------------------
INSERT INTO `loos` VALUES ('1', '车钥匙', '1', '厕所门口', '2020-04-10 00:00:00', '1', '张三', '13355660000', '22', '25525', '2020-04-12 00:00:00', 'admin');
INSERT INTO `loos` VALUES ('6', '手机', '1', '前台', '2020-05-01 00:00:00', '1', '王能', '15299952320', '张宏', '15899965478', '2020-05-02 00:00:00', 'admin');
INSERT INTO `loos` VALUES ('7', '钱包', '1', '动感单车旁', '2020-05-01 00:00:00', '0', '李镇', '15966325478', null, null, null, 'admin');
INSERT INTO `loos` VALUES ('8', '包', '1', '门口', '2020-05-02 00:00:00', '0', '刘伟', '15326587548', null, null, null, 'admin');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `MemberId` int(20) NOT NULL AUTO_INCREMENT,
  `MemberName` varchar(20) DEFAULT NULL,
  `MemberPhone` varchar(20) DEFAULT NULL,
  `MemberSex` int(10) DEFAULT NULL,
  `MemberAge` int(20) DEFAULT NULL,
  `MemberTypes` int(10) DEFAULT NULL,
  `NenberDate` date DEFAULT NULL,
  `Birthday` varchar(20) DEFAULT NULL,
  `memberStatic` int(20) DEFAULT NULL,
  `Memberbalance` float DEFAULT '0',
  `Memberxufei` date DEFAULT NULL,
  PRIMARY KEY (`MemberId`),
  KEY `fk-member-membertype` (`MemberTypes`),
  CONSTRAINT `fk-member-membertype` FOREIGN KEY (`MemberTypes`) REFERENCES `membertype` (`TypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('25', '刘建', '13456789087', '1', '23', '3', '2020-04-06', '08-24', '1', '390', '2021-05-03');
INSERT INTO `member` VALUES ('26', 'Tom', '15266668585', '1', '24', '2', '2020-04-06', '08-07', '1', '-5', '2020-06-02');
INSERT INTO `member` VALUES ('34', '王泽明', '17858966255', '1', '19', '5', '2020-04-06', '05-08', '2', '820', '2020-04-10');
INSERT INTO `member` VALUES ('35', '张红', '18799256874', '0', '23', '1', '2020-04-07', '04-08', '1', '-7', '2020-08-31');
INSERT INTO `member` VALUES ('37', '王芳', '15299950487', '0', '22', '3', '2020-04-07', '04-21', '1', '990', '2021-08-01');
INSERT INTO `member` VALUES ('38', '李明', '15699588547', '1', '22', '3', '2020-04-07', '04-21', '1', '0', '2021-05-03');
INSERT INTO `member` VALUES ('42', 'jerry', '15266528547', '1', '25', '2', '2020-04-08', '04-08', '1', '-7', '2020-06-02');
INSERT INTO `member` VALUES ('43', '方蓝', '13456789876', '0', '22', '5', '2020-04-10', '04-29', '1', '0', '2020-05-10');
INSERT INTO `member` VALUES ('44', '赵静', '15288888888', '0', '25', '3', '2020-04-12', '04-22', '1', '0', '2021-05-03');
INSERT INTO `member` VALUES ('45', '孙戏', '18566584785', '1', '35', '3', '2020-05-03', '05-03', '1', '-2', '2021-05-03');

-- ----------------------------
-- Table structure for membertype
-- ----------------------------
DROP TABLE IF EXISTS `membertype`;
CREATE TABLE `membertype` (
  `TypeId` int(20) NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(20) DEFAULT NULL,
  `TypeciShu` int(11) DEFAULT NULL,
  `TypeDay` int(11) DEFAULT NULL,
  `Typemoney` float DEFAULT NULL,
  PRIMARY KEY (`TypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of membertype
-- ----------------------------
INSERT INTO `membertype` VALUES ('1', '季卡', '0', '90', '500');
INSERT INTO `membertype` VALUES ('2', '月卡', '0', '30', '150');
INSERT INTO `membertype` VALUES ('3', '年卡', '0', '365', '1000');
INSERT INTO `membertype` VALUES ('5', '周卡', '0', '7', '50');

-- ----------------------------
-- Table structure for privatecoachinfo
-- ----------------------------
DROP TABLE IF EXISTS `privatecoachinfo`;
CREATE TABLE `privatecoachinfo` (
  `pid` int(20) NOT NULL AUTO_INCREMENT,
  `memberid` int(11) DEFAULT NULL,
  `coachid` int(11) DEFAULT NULL,
  `subjectid` int(11) DEFAULT NULL,
  `count` int(20) DEFAULT NULL,
  `countprice` double DEFAULT NULL,
  `realprice` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remark` varchar(20) DEFAULT NULL,
  `admin` varchar(20) DEFAULT 'asdf',
  PRIMARY KEY (`pid`),
  KEY `fk_pri_subject` (`subjectid`),
  KEY `fk_pri_coach` (`coachid`),
  KEY `fk_pri_member` (`memberid`),
  CONSTRAINT `fk_pri_coach` FOREIGN KEY (`coachid`) REFERENCES `coach` (`coachId`),
  CONSTRAINT `fk_pri_member` FOREIGN KEY (`memberid`) REFERENCES `member` (`MemberId`),
  CONSTRAINT `fk_pri_subject` FOREIGN KEY (`subjectid`) REFERENCES `subject` (`subId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of privatecoachinfo
-- ----------------------------
INSERT INTO `privatecoachinfo` VALUES ('3', '25', '16', '1', '1', '200', '30', '2020-04-07', '1', 'fg', 'aa');
INSERT INTO `privatecoachinfo` VALUES ('13', '26', '14', '2', '22', '660', '500.5', '2020-04-15', '1', '', 'asdf');
INSERT INTO `privatecoachinfo` VALUES ('14', '38', '14', '4', '25', '16650', '18888.858', '2020-04-16', '1', '', 'asdf');
INSERT INTO `privatecoachinfo` VALUES ('16', '34', '11', '1', '5', '150', '200', '2020-05-02', '1', '', 'asdf');
INSERT INTO `privatecoachinfo` VALUES ('17', '25', '4', '5', '5', '100', '100', '2020-05-01', '1', '', 'asdf');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `subId` int(20) NOT NULL AUTO_INCREMENT,
  `subname` varchar(20) DEFAULT NULL,
  `sellingPrice` double DEFAULT NULL,
  PRIMARY KEY (`subId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES ('1', '健身球', '30');
INSERT INTO `subject` VALUES ('2', '跑步机', '35');
INSERT INTO `subject` VALUES ('4', '压力车', '50');
INSERT INTO `subject` VALUES ('5', '仰卧起坐', '20');
INSERT INTO `subject` VALUES ('6', '健身操', '50');
