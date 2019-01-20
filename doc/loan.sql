/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : localhost:3306
 Source Schema         : loan

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 17/01/2019 20:04:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_biz_acct
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_acct`;
CREATE TABLE `t_biz_acct`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账户,自增',
  `user_no` bigint(20) NOT NULL COMMENT '用户编号,如果是融资账户指的是用户编号\r\n如果是公司卡账户，为1\r\n如果是借款人账户，指的是客户编号\r\n如果是代偿账户，为4\r\n如果是暂收暂付账户，为5',
  `available_balance` decimal(15, 2) NOT NULL COMMENT '可用余额,默认0.00',
  `freeze_balance` decimal(15, 2) NOT NULL COMMENT '冻结余额,默认0.00',
  `acct_type` bigint(20) NOT NULL COMMENT '账户类型,公司卡账户:1,融资账户:2,借款人账\r\n户:3,代偿账户:4,往来户:5',
  `balance_type` bigint(20) DEFAULT NULL COMMENT '余额性质,可透支:1,不可透支:2',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '账户表（借款人,融资,公司卡账户）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_acct_record
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_acct_record`;
CREATE TABLE `t_biz_acct_record`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水编号,自增',
  `group_no` bigint(20) NOT NULL COMMENT '组号,',
  `org_no` bigint(20) NOT NULL COMMENT '公司编号,',
  `voucher_no` bigint(20) NOT NULL COMMENT '凭证编号,借据编号,融资编号,收支编号，入账编号，\r\n出账编号',
  `acct_no` bigint(20) NOT NULL COMMENT '账户,公司卡账户,融资账户,借款人账\r\n户,代偿账户,暂收,暂付',
  `type` bigint(20) NOT NULL COMMENT '业务类型,放款:1,还款:2,服务费收取:3,\r\n服务费补偿:4,支出:5,融资:6,撤资:7,收入:8,资金登记:9,转账:10,提现:11,结转:12',
  `amt_type` bigint(20) NOT NULL COMMENT '资金类型,本金:1,利息:2,罚息:3,服务费:4,代偿:5,活期利息:6,资金:7',
  `acct_date` date NOT NULL COMMENT '业务日期,',
  `amt` decimal(15, 2) NOT NULL COMMENT '发生金额,',
  `bal_dir` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发生方向,‘+/-’,通过符号表示，相对当前账户来说，是增加还是减少',
  `status` bigint(20) NOT NULL COMMENT '交易状态,成功:1,失败:2',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '账户资金流水表（资金变动流水信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_customer_info`;
CREATE TABLE `t_biz_customer_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '客户编号,自增',
  `cert_no` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '证件号码,',
  `cert_type` bigint(20) NOT NULL COMMENT '证件类型,1:身份证,2:护照,3:营业执照,4:组织机构代\r\n码,5:统一社会信用代码',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户姓名,',
  `gender` bigint(20) NOT NULL COMMENT '性别,1:男,2:女',
  `mobile` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号,',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话,',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮箱,',
  `status` bigint(20) DEFAULT NULL COMMENT '客户状态,正常:1,黑名单:2',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户信息表（描述的是借款人信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_in_out_voucher_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_in_out_voucher_info`;
CREATE TABLE `t_biz_in_out_voucher_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '收支编号,自增',
  `acct_no` bigint(20) NOT NULL COMMENT '账户,指的是从哪个公司卡账户出入钱',
  `external_acct` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '外部账户,指的是从外部那个银行卡出入的,标记',
  `amt` decimal(15, 2) NOT NULL COMMENT '金额,',
  `type` bigint(20) NOT NULL COMMENT '用途,一般预算支出:1,办公支出:2,其他支出:3,股东分润:5,对公支出:6,对公收入:7,利息收入:8',
  `status` bigint(20) NOT NULL COMMENT '状态,成功:1,失败:2',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收支信息表（描述收支凭证信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_invest_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_invest_info`;
CREATE TABLE `t_biz_invest_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '融资编号,自增',
  `org_no` bigint(20) NOT NULL COMMENT '公司编号,',
  `user_no` bigint(20) NOT NULL COMMENT '用户编号,指的是融资',
  `in_acct_no` bigint(20) NOT NULL COMMENT '入账账户,指的是入账到哪个公司卡账户上',
  `external_acct` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '投资人出款账户,指的是融资的出资银行卡卡号',
  `prin` decimal(15, 2) NOT NULL COMMENT '本金,',
  `acct_date` date NOT NULL COMMENT '业务日期,',
  `begin_date` date NOT NULL COMMENT '起息开始日期,',
  `end_date` date DEFAULT NULL COMMENT '起息结束日期,一般指全额提现日或者结转日',
  `rate` decimal(15, 3) NOT NULL COMMENT '利率,',
  `term_no` bigint(20) DEFAULT NULL COMMENT '期数,',
  `cycle_interval` bigint(20) NOT NULL COMMENT '周期间隔,一期的天数，默认是30天',
  `status` bigint(20) NOT NULL COMMENT '状态,登记:1,计息中:2,已延期:3,已撤资:4,\r\n已结转:5',
  `dd_date` bigint(20) DEFAULT NULL COMMENT '计息日,每个月的第几天',
  `extension_no` bigint(20) DEFAULT NULL COMMENT '延期期数,',
  `extension_rate` decimal(15, 3) DEFAULT NULL COMMENT '延期利率,',
  `tot_schd_bigint` decimal(15, 2) DEFAULT NULL COMMENT '应回利息累计,',
  `tot_paid_prin` decimal(15, 2) DEFAULT NULL COMMENT '已提本金累计,',
  `tot_paid_bigint` decimal(15, 2) DEFAULT NULL COMMENT '已提利息累计,',
  `tot_wav_amt` decimal(15, 2) DEFAULT NULL COMMENT '收益调整金额累计,融资提现时增加或者扣除的\r\n金额',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '融资信息表（描述融资的融资信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_invest_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_invest_plan`;
CREATE TABLE `t_biz_invest_plan`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '计划编号,自增',
  `invest_no` bigint(20) NOT NULL COMMENT '融资编号,',
  `org_no` bigint(20) NOT NULL COMMENT '公司编号,',
  `user_no` bigint(20) NOT NULL COMMENT '用户编号,',
  `term_no` bigint(20) NOT NULL COMMENT '期数,第几期',
  `dd_date` date DEFAULT NULL COMMENT '计息日期,',
  `rate` decimal(15, 3) NOT NULL COMMENT '利率,',
  `begin_date` date NOT NULL COMMENT '本期开始日期,',
  `end_date` date DEFAULT NULL COMMENT '本期结束日期,',
  `dd_num` bigint(20) NOT NULL COMMENT '计息天数,',
  `dd_prin` decimal(15, 2) DEFAULT NULL COMMENT '本期计息本金,',
  `chd_bigint` decimal(15, 2) DEFAULT NULL COMMENT '本期应收利息,',
  `paid_bigint` decimal(15, 2) DEFAULT NULL COMMENT '本期已回利息,',
  `status` bigint(20) NOT NULL COMMENT '回款状态,未计息:1,已计息:2,已结息:3,已终止:4',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回款计划表（描述融资的回款计划信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_loan_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_loan_info`;
CREATE TABLE `t_biz_loan_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '借据编号,自增',
  `org_no` bigint(20) NOT NULL COMMENT '公司编号,',
  `product_no` bigint(20) NOT NULL COMMENT '产品编号,',
  `cust_no` bigint(20) NOT NULL COMMENT '客户编号,',
  `contr_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '原始合同编号,',
  `loan_type` bigint(20) NOT NULL COMMENT '贷款类型,抵押:1,网签:2,其他:3',
  `acct_date` date NOT NULL COMMENT '业务日期,',
  `begin_date` date NOT NULL COMMENT '借款开始日期,',
  `end_date` date DEFAULT NULL COMMENT '借款结束日期,',
  `prin` decimal(15, 2) NOT NULL COMMENT '本金,',
  `rate` decimal(15, 3) NOT NULL COMMENT '利率,按年百分比填写',
  `receive_bigint` decimal(15, 2) NOT NULL COMMENT '应收利息,',
  `repay_type` bigint(20) NOT NULL COMMENT '产品还款方式,等额本息:1,等额本金:2;\r\n先息后本:3,先息后本（上交息）:4,一次性还本付息:5',
  `term_no` bigint(20) DEFAULT NULL COMMENT '期数,',
  `lending_date` date DEFAULT NULL COMMENT '放款日期,',
  `lending_amt` decimal(15, 2) DEFAULT NULL COMMENT '放款金额,',
  `lending_acct` bigint(20) NOT NULL COMMENT '放款账户,指出金的公司卡账户信息',
  `external_acct` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '收款账户,借款人收款的银行账户',
  `service_fee` decimal(15, 2) NOT NULL COMMENT '服务费,默认为0.00',
  `service_fee_type` bigint(20) DEFAULT NULL COMMENT '服务费收取方式,首期:1,按期:2',
  `dd_date` bigint(20) DEFAULT NULL COMMENT '约定还款日,每个月的第几天',
  `is_pen` bigint(20) DEFAULT NULL COMMENT '是否罚息,1:是,2:否',
  `pen_rate` decimal(15, 3) DEFAULT NULL COMMENT '罚息利率,按日千分比填写,默认0.000',
  `pen_number` bigint(20) DEFAULT NULL COMMENT '罚息基数,本金:1,未还金额:2',
  `extension_no` bigint(20) DEFAULT NULL COMMENT '展期期数,期数',
  `extension_rate` decimal(15, 3) DEFAULT NULL COMMENT '展期利息,',
  `schd_prin` decimal(15, 2) DEFAULT NULL COMMENT '应还本金,',
  `schd_bigint` decimal(15, 2) DEFAULT NULL COMMENT '应还利息,',
  `schd_serv_fee` decimal(15, 2) DEFAULT NULL COMMENT '应收服务费,',
  `schd_pen` decimal(15, 2) DEFAULT NULL COMMENT '逾期罚息累计,',
  `tot_paid_prin` decimal(15, 2) DEFAULT NULL COMMENT '已还本金累计,',
  `tot_paid_bigint` decimal(15, 2) DEFAULT NULL COMMENT '已还利息累计,',
  `tot_paid_serv_fee` decimal(15, 2) DEFAULT NULL COMMENT '已收服务费累计,',
  `tot_paid_pen` decimal(15, 2) DEFAULT NULL COMMENT '已还罚息累计,',
  `tot_wav_amt` decimal(15, 2) DEFAULT NULL COMMENT '减免金额累计,',
  `satus` bigint(20) NOT NULL COMMENT '借据状态,登记:1,已放款:2,还款中:3,\r\n已逾期:4,已展期:5,已结清:6,已代偿:7,已终止:8',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借据表（借款具体信息，描述具体的借款情况，整个借款的生命周期中，主要变更这个表）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_loan_voucher_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_loan_voucher_info`;
CREATE TABLE `t_biz_loan_voucher_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '凭证编号,自增',
  `loan_no` bigint(20) NOT NULL COMMENT '借据编号,',
  `type` bigint(20) NOT NULL COMMENT '凭证类型,身份证:1,电子合同:2,房本:3,解押手\r\n续:4',
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '凭证存储地址,',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借据凭证信息（描述的是贷款的原始凭证信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_product_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_product_info`;
CREATE TABLE `t_biz_product_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '产品编号,自增',
  `org_no` bigint(20) NOT NULL COMMENT '公司编号,',
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称,',
  `rate` decimal(15, 3) NOT NULL COMMENT '产品利率,按年百分比填写',
  `service_fee_scale` decimal(15, 2) NOT NULL COMMENT '服务费比例,默认0.00',
  `service_fee_type` bigint(20) DEFAULT NULL COMMENT '服务费收取方式,首期:1,按期:2',
  `pen_rate` decimal(15, 3) DEFAULT NULL COMMENT '罚息利率,按日千分比填写,默认0.000',
  `is_pen` bigint(20) DEFAULT NULL COMMENT '是否罚息,1:是,2:否',
  `pen_number` bigint(20) DEFAULT NULL COMMENT '罚息基数,本金:1,未还金额:2',
  `repay_type` bigint(20) NOT NULL COMMENT '产品还款方式,等额本息:1,等额本金:2;\r\n先息后本:3,先息后本（上交息）:4,一次性还本付息:5',
  `loan_type` bigint(20) NOT NULL COMMENT '贷款类型,抵押:1,网签:2,3:其他',
  `cycle_interval` bigint(20) NOT NULL COMMENT '周期间隔,一期的天数，默认是30天',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品代码表（描述贷款产品信息，不同公司的产品编码不能一致）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_repay_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_repay_plan`;
CREATE TABLE `t_biz_repay_plan`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '计划编号,自增',
  `loan_no` bigint(20) NOT NULL COMMENT '借据编号,',
  `org_no` bigint(20) NOT NULL COMMENT '公司编号,',
  `product_no` bigint(20) NOT NULL COMMENT '产品编号,',
  `cust_no` bigint(20) NOT NULL COMMENT '客户编号,',
  `acct_date` date NOT NULL COMMENT '业务日期,',
  `term_no` bigint(20) NOT NULL COMMENT '期数,第几期',
  `rate` decimal(15, 3) NOT NULL COMMENT '利率,',
  `begin_date` date NOT NULL COMMENT '本期开始日期,',
  `end_date` date DEFAULT NULL COMMENT '本期结束日期,',
  `dd_num` bigint(20) NOT NULL COMMENT '计息天数,',
  `dd_date` date DEFAULT NULL COMMENT '还款日期,',
  `external_acct` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '还款账户,借款人还款的银行账户',
  `in_acct_no` bigint(20) NOT NULL COMMENT '入账账户,还款的钱入到哪个公司卡账户上面',
  `ctd_prin` decimal(15, 2) DEFAULT NULL COMMENT '本期应还本金,',
  `ctd_bigint` decimal(15, 2) DEFAULT NULL COMMENT '本期应还利息,',
  `ctd_serv_fee` decimal(15, 2) DEFAULT NULL COMMENT '本期应收服务费,',
  `ctd_pen` decimal(15, 2) DEFAULT NULL COMMENT '本期应收罚息,',
  `paid_prin` decimal(15, 2) DEFAULT NULL COMMENT '本期已还本金,',
  `paid_bigint` decimal(15, 2) DEFAULT NULL COMMENT '本期已还利息,',
  `paid_serv_fee` decimal(15, 2) DEFAULT NULL COMMENT '本期已收服务费,',
  `paid_pen` decimal(15, 2) DEFAULT NULL COMMENT '本期已收罚息,',
  `wav_amt` decimal(15, 2) DEFAULT NULL COMMENT '本期减免,',
  `status` bigint(20) NOT NULL COMMENT '还款状态,待还:1,已还:2,已逾期:3,\r\n已代偿:4,已终止:5',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '还款计划表（客户的还款计划信息，根据借据的期数，生成多条记录）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_biz_transfer_voucher_info
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_transfer_voucher_info`;
CREATE TABLE `t_biz_transfer_voucher_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '转账编号,自增',
  `in_acct_no` bigint(20) NOT NULL COMMENT '入账账户,',
  `out_acct_no` bigint(20) NOT NULL COMMENT '出账账户,',
  `amt` decimal(15, 2) NOT NULL COMMENT '金额,',
  `type` bigint(20) NOT NULL COMMENT '用途,账户调整:1,服务费补偿:2,融资人贴息:3,其他:4',
  `status` bigint(20) NOT NULL COMMENT '状态,成功:1,失败:2',
  `operator` bigint(20) NOT NULL COMMENT '操作员,',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间,',
  `update_at` datetime(0) DEFAULT NULL COMMENT '更新时间,默认为当前系统时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '转账凭证表（描述转账凭证信息）' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_sys_cfg
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_cfg`;
CREATE TABLE `t_sys_cfg`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `cfg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '参数名',
  `cfg_value` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '参数值',
  `cfg_desc` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '参数描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 331 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_cfg
-- ----------------------------
INSERT INTO `t_sys_cfg` VALUES (1, 'JS_API_TICKET', 'test', '微信JSAPI_TICKET(produt:kgt8ON7yVITDhtdwci0qeYBa_xOxkaEccepDVZel0heq1M9pKgrfFWOlX2MfHEt122psCpElf4V5eePHPouJPg)');
INSERT INTO `t_sys_cfg` VALUES (2, 'ACCESS_TOKEN', 'test', '微信Token');
INSERT INTO `t_sys_cfg` VALUES (3, 'app_name', 'loan', '小贷登记系统web框架');

-- ----------------------------
-- Table structure for t_sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_dept`;
CREATE TABLE `t_sys_dept`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `num` int(11) DEFAULT NULL COMMENT '排序',
  `pid` int(11) DEFAULT NULL COMMENT '父部门id',
  `pids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '父级ids',
  `simplename` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '简称',
  `fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '全称',
  `tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '提示',
  `version` int(11) DEFAULT NULL COMMENT '版本（乐观锁保留字段）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_dept
-- ----------------------------
INSERT INTO `t_sys_dept` VALUES (24, 1, 0, '[0],', '典当行', '典当行', '', NULL);
INSERT INTO `t_sys_dept` VALUES (28, 2, 0, '[0],', '投资公司', '投资公司', '', NULL);

-- ----------------------------
-- Table structure for t_sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_dict`;
CREATE TABLE `t_sys_dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '排序',
  `pid` int(11) DEFAULT NULL COMMENT '父级字典',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名称',
  `tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '提示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_dict
-- ----------------------------
INSERT INTO `t_sys_dict` VALUES (16, '0', 0, '状态', NULL);
INSERT INTO `t_sys_dict` VALUES (17, '1', 16, '启用', NULL);
INSERT INTO `t_sys_dict` VALUES (18, '2', 16, '禁用', NULL);
INSERT INTO `t_sys_dict` VALUES (35, '0', 0, '账号状态', NULL);
INSERT INTO `t_sys_dict` VALUES (36, '1', 35, '启用', NULL);
INSERT INTO `t_sys_dict` VALUES (37, '2', 35, '冻结', NULL);
INSERT INTO `t_sys_dict` VALUES (38, '3', 35, '已删除', NULL);
INSERT INTO `t_sys_dict` VALUES (39, '0', 0, '银行卡类型', NULL);
INSERT INTO `t_sys_dict` VALUES (40, '0', 39, '借记卡', NULL);
INSERT INTO `t_sys_dict` VALUES (41, '1', 39, '信用卡', NULL);
INSERT INTO `t_sys_dict` VALUES (44, '0', 0, '联系人关系', NULL);
INSERT INTO `t_sys_dict` VALUES (45, '1', 44, '父子', NULL);
INSERT INTO `t_sys_dict` VALUES (46, '2', 44, '母子', NULL);
INSERT INTO `t_sys_dict` VALUES (47, '3', 44, '配偶', NULL);
INSERT INTO `t_sys_dict` VALUES (48, '4', 44, '朋友', NULL);
INSERT INTO `t_sys_dict` VALUES (49, '5', 44, '子女', NULL);
INSERT INTO `t_sys_dict` VALUES (50, '6', 44, '兄弟姐妹', NULL);
INSERT INTO `t_sys_dict` VALUES (56, '0', 0, '学历类型', NULL);
INSERT INTO `t_sys_dict` VALUES (57, '1', 56, '博士', NULL);
INSERT INTO `t_sys_dict` VALUES (58, '2', 56, '硕士', NULL);
INSERT INTO `t_sys_dict` VALUES (59, '3', 56, '本科', NULL);
INSERT INTO `t_sys_dict` VALUES (60, '4', 56, '专科', NULL);
INSERT INTO `t_sys_dict` VALUES (61, '5', 56, '高中及以下', NULL);
INSERT INTO `t_sys_dict` VALUES (68, '0', 0, '证件类型', NULL);
INSERT INTO `t_sys_dict` VALUES (69, '1', 68, '身份证', NULL);
INSERT INTO `t_sys_dict` VALUES (70, '2', 68, '护照', NULL);
INSERT INTO `t_sys_dict` VALUES (71, '3', 68, '营业执照', NULL);
INSERT INTO `t_sys_dict` VALUES (72, '4', 68, '组织机构代码', NULL);
INSERT INTO `t_sys_dict` VALUES (73, '5', 68, '统一社会信用代码', NULL);
INSERT INTO `t_sys_dict` VALUES (74, '0', 0, '性别', NULL);
INSERT INTO `t_sys_dict` VALUES (75, '1', 74, '男', NULL);
INSERT INTO `t_sys_dict` VALUES (76, '2', 74, '女', NULL);
INSERT INTO `t_sys_dict` VALUES (80, '0', 0, '是否', NULL);
INSERT INTO `t_sys_dict` VALUES (81, '1', 80, '是', NULL);
INSERT INTO `t_sys_dict` VALUES (82, '0', 80, '否', NULL);

-- ----------------------------
-- Table structure for t_sys_expense
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_expense`;
CREATE TABLE `t_sys_expense`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` decimal(20, 2) DEFAULT NULL COMMENT '报销金额',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '描述',
  `createtime` datetime(0) DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '状态: 1.待提交  2:待审核   3.审核通过 4:驳回',
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `processId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '流程定义id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报销表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_login_log`;
CREATE TABLE `t_sys_login_log`  (
  `id` int(65) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `logname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志名称',
  `userid` int(65) DEFAULT NULL COMMENT '管理员id',
  `createtime` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `succeed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否执行成功',
  `message` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '具体消息',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 428 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '登录记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_menu`;
CREATE TABLE `t_sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单编号',
  `pcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单父编号',
  `pcodes` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '当前菜单的所有父菜单编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单名称',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单图标',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'url地址',
  `num` int(65) DEFAULT NULL COMMENT '菜单排序号',
  `levels` int(65) DEFAULT NULL COMMENT '菜单层级',
  `ismenu` int(11) DEFAULT NULL COMMENT '是否是菜单（1：是  0：不是）',
  `tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `status` int(65) DEFAULT NULL COMMENT '菜单状态 :  1:启用   0:不启用',
  `isopen` int(11) DEFAULT NULL COMMENT '是否打开:    1:打开   0:不打开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 220 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_menu
-- ----------------------------
INSERT INTO `t_sys_menu` VALUES (105, 'system', '0', '[0],', '系统管理', 'fa-cog', '#', 4, 1, 1, NULL, 1, 1);
INSERT INTO `t_sys_menu` VALUES (106, 'mgr', 'system', '[0],[system],', '用户管理', '', '/mgr', 1, 2, 1, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (107, 'mgr_add', 'mgr', '[0],[system],[mgr],', '添加用户', NULL, '/mgr/add', 1, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (108, 'mgr_edit', 'mgr', '[0],[system],[mgr],', '修改用户', NULL, '/mgr/edit', 2, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (109, 'mgr_delete', 'mgr', '[0],[system],[mgr],', '删除用户', NULL, '/mgr/delete', 3, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (110, 'mgr_reset', 'mgr', '[0],[system],[mgr],', '重置密码', NULL, '/mgr/reset', 4, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (111, 'mgr_freeze', 'mgr', '[0],[system],[mgr],', '冻结用户', NULL, '/mgr/freeze', 5, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (112, 'mgr_unfreeze', 'mgr', '[0],[system],[mgr],', '解除冻结用户', NULL, '/mgr/unfreeze', 6, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (113, 'mgr_setRole', 'mgr', '[0],[system],[mgr],', '分配角色', NULL, '/mgr/setRole', 7, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (114, 'role', 'system', '[0],[system],', '角色管理', NULL, '/role', 2, 2, 1, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (115, 'role_add', 'role', '[0],[system],[role],', '添加角色', NULL, '/role/add', 1, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (116, 'role_edit', 'role', '[0],[system],[role],', '修改角色', NULL, '/role/edit', 2, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (117, 'role_remove', 'role', '[0],[system],[role],', '删除角色', NULL, '/role/remove', 3, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (118, 'role_setAuthority', 'role', '[0],[system],[role],', '配置权限', NULL, '/role/setAuthority', 4, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (119, 'menu', 'system', '[0],[system],', '菜单管理', NULL, '/menu', 4, 2, 1, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (120, 'menu_add', 'menu', '[0],[system],[menu],', '添加菜单', NULL, '/menu/add', 1, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (121, 'menu_edit', 'menu', '[0],[system],[menu],', '修改菜单', NULL, '/menu/edit', 2, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (122, 'menu_remove', 'menu', '[0],[system],[menu],', '删除菜单', NULL, '/menu/remove', 3, 3, 0, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (128, 'log', 'system', '[0],[system],', '业务日志', NULL, '/log', 6, 2, 1, NULL, 1, 0);
INSERT INTO `t_sys_menu` VALUES (130, 'druid', 'system', '[0],[system],', '监控管理', NULL, '/druid', 7, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (131, 'dept', 'system', '[0],[system],', '公司管理', '', '/dept', 3, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (132, 'dict', 'system', '[0],[system],', '字典管理', NULL, '/dict', 4, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (133, 'loginLog', 'system', '[0],[system],', '登录日志', NULL, '/loginLog', 6, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (134, 'log_clean', 'log', '[0],[system],[log],', '清空日志', NULL, '/log/delLog', 3, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (135, 'dept_add', 'dept', '[0],[system],[dept],', '添加部门', NULL, '/dept/add', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (136, 'dept_update', 'dept', '[0],[system],[dept],', '修改部门', NULL, '/dept/update', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (137, 'dept_delete', 'dept', '[0],[system],[dept],', '删除部门', NULL, '/dept/delete', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (138, 'dict_add', 'dict', '[0],[system],[dict],', '添加字典', NULL, '/dict/add', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (139, 'dict_update', 'dict', '[0],[system],[dict],', '修改字典', NULL, '/dict/update', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (140, 'dict_delete', 'dict', '[0],[system],[dict],', '删除字典', NULL, '/dict/delete', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (141, 'notice', 'system', '[0],[system],', '通知管理', NULL, '/notice', 9, 2, 1, NULL, 0, NULL);
INSERT INTO `t_sys_menu` VALUES (142, 'notice_add', 'notice', '[0],[system],[notice],', '添加通知', NULL, '/notice/add', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (143, 'notice_update', 'notice', '[0],[system],[notice],', '修改通知', NULL, '/notice/update', 2, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (144, 'notice_delete', 'notice', '[0],[system],[notice],', '删除通知', NULL, '/notice/delete', 3, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (145, 'hello', '0', '[0],', '通知', 'fa-rocket', '/notice/hello', 1, 1, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (148, 'code', '0', '[0],', '代码生成', 'fa-code', '/code', 3, 1, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (149, 'api_mgr', '0', '[0],', '接口文档', 'fa-leaf', '/swagger-ui.html', 2, 1, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (150, 'to_menu_edit', 'menu', '[0],[system],[menu],', '菜单编辑跳转', '', '/menu/menu_edit', 4, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (151, 'menu_list', 'menu', '[0],[system],[menu],', '菜单列表', '', '/menu/list', 5, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (152, 'to_dept_update', 'dept', '[0],[system],[dept],', '修改部门跳转', '', '/dept/dept_update', 4, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (153, 'dept_list', 'dept', '[0],[system],[dept],', '部门列表', '', '/dept/list', 5, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (154, 'dept_detail', 'dept', '[0],[system],[dept],', '部门详情', '', '/dept/detail', 6, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (155, 'to_dict_edit', 'dict', '[0],[system],[dict],', '修改菜单跳转', '', '/dict/dict_edit', 4, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (156, 'dict_list', 'dict', '[0],[system],[dict],', '字典列表', '', '/dict/list', 5, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (157, 'dict_detail', 'dict', '[0],[system],[dict],', '字典详情', '', '/dict/detail', 6, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (158, 'log_list', 'log', '[0],[system],[log],', '日志列表', '', '/log/list', 2, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (159, 'log_detail', 'log', '[0],[system],[log],', '日志详情', '', '/log/detail', 3, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (160, 'del_login_log', 'loginLog', '[0],[system],[loginLog],', '清空登录日志', '', '/loginLog/delLoginLog', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (161, 'login_log_list', 'loginLog', '[0],[system],[loginLog],', '登录日志列表', '', '/loginLog/list', 2, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (162, 'to_role_edit', 'role', '[0],[system],[role],', '修改角色跳转', '', '/role/role_edit', 5, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (163, 'to_role_assign', 'role', '[0],[system],[role],', '角色分配跳转', '', '/role/role_assign', 6, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (164, 'role_list', 'role', '[0],[system],[role],', '角色列表', '', '/role/list', 7, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (165, 'to_assign_role', 'mgr', '[0],[system],[mgr],', '分配角色跳转', '', '/mgr/role_assign', 8, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (166, 'to_user_edit', 'mgr', '[0],[system],[mgr],', '编辑用户跳转', '', '/mgr/user_edit', 9, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (167, 'mgr_list', 'mgr', '[0],[system],[mgr],', '用户列表', '', '/mgr/list', 10, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (168, 'expense', '0', '[0],', '报销管理', 'fa-clone', '#', 5, 1, 1, NULL, 0, NULL);
INSERT INTO `t_sys_menu` VALUES (169, 'expense_fill', 'expense', '[0],[expense],', '报销申请', '', '/expense', 1, 2, 1, NULL, 0, NULL);
INSERT INTO `t_sys_menu` VALUES (170, 'expense_progress', 'expense', '[0],[expense],', '报销审批', '', '/process', 2, 2, 1, NULL, 0, NULL);
INSERT INTO `t_sys_menu` VALUES (199, 'cfg_add', 'cfg', '[0],[system],[cfg],', '添加系统参数', '', '/cfg/add', 1, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (200, 'cfg_update', 'cfg', '[0],[system],[cfg],', '修改系统参数', '', '/cfg/update', 2, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (201, 'cfg_delete', 'cfg', '[0],[system],[cfg],', '删除系统参数', '', '/cfg/delete', 3, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (202, 'task', 'system', '[0],[system],', '任务管理', '', '/task', 11, 2, 1, '', 0, NULL);
INSERT INTO `t_sys_menu` VALUES (203, 'task_add', 'task', '[0],[system],[task],', '添加任务', '', '/task/add', 1, 3, 0, '', 1, NULL);
INSERT INTO `t_sys_menu` VALUES (204, 'task_update', 'task', '[0],[system],[task],', '修改任务', '', '/task/update', 2, 3, 0, '', 1, NULL);
INSERT INTO `t_sys_menu` VALUES (205, 'task_delete', 'task', '[0],[system],[task],', '删除任务', '', '/task/delete', 3, 3, 0, '', 1, NULL);
INSERT INTO `t_sys_menu` VALUES (206, 'biz', '0', '[0],', '业务管理', 'fa-shopping-cart', '#', 6, 1, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (207, 'product', 'biz', '[0],[biz],', '产品管理', '', '#', 1, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (208, 'product_acc', 'biz', '[0],[biz],', '产品账户', '', '#', 2, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (209, 'customer', 'biz', '[0],[biz],', '客户管理', '', '#', 3, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (210, 'bill', 'biz', '[0],[biz],', '借据管理', '', '#', 4, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (211, 'repayment', 'biz', '[0],[biz],', '还款管理', '', '#', 5, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (212, 'txn', 'biz', '[0],[biz],', '交易流水', '', '#', 6, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (213, 'upAccount', 'biz', '[0],[biz],', '调账', '', '#', 7, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (214, 'report', 'biz', '[0],[biz],', '报表查询', '', '#', 8, 2, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (215, 'loan_account_serial', 'report', '[0],[biz],[report],', '贷款台账报表查询', '', '#', 1, 3, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (216, 'in_out_details', 'report', '[0],[biz],[report],', '收支明细报表查询', '', '#', 2, 3, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (217, 'interest', 'report', '[0],[biz],[report],', '利润报表查询', '', '#', 3, 3, 1, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (218, 'mgr_setDept', 'mgr', '[0],[system],[mgr],', '分配部门', '', '/mgr/setDept', 11, 3, 0, NULL, 1, NULL);
INSERT INTO `t_sys_menu` VALUES (219, 'mgr_depo_assign', 'mgr', '[0],[system],[mgr],', '分配部门跳转', '', '/mgr/depo_assign', 12, 3, 0, NULL, 1, NULL);

-- ----------------------------
-- Table structure for t_sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_notice`;
CREATE TABLE `t_sys_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '标题',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '内容',
  `createtime` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `creater` int(11) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_notice
-- ----------------------------
INSERT INTO `t_sys_notice` VALUES (1, '世界', 10, '欢迎使用小贷业务管理系统', '2017-01-11 08:53:20', 1);

-- ----------------------------
-- Table structure for t_sys_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_operation_log`;
CREATE TABLE `t_sys_operation_log`  (
  `id` int(65) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `logtype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志类型',
  `logname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '日志名称',
  `userid` int(65) DEFAULT NULL COMMENT '用户id',
  `classname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '类名称',
  `method` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '方法名称',
  `createtime` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `succeed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '是否成功',
  `message` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志' ROW_FORMAT = Dynamic;


-- ----------------------------
-- Table structure for t_sys_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_relation`;
CREATE TABLE `t_sys_relation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `menuid` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单id',
  `roleid` int(11) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 617 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_relation
-- ----------------------------
INSERT INTO `t_sys_relation` VALUES (304, '206', 2);
INSERT INTO `t_sys_relation` VALUES (305, '207', 2);
INSERT INTO `t_sys_relation` VALUES (306, '208', 2);
INSERT INTO `t_sys_relation` VALUES (307, '209', 2);
INSERT INTO `t_sys_relation` VALUES (308, '210', 2);
INSERT INTO `t_sys_relation` VALUES (309, '211', 2);
INSERT INTO `t_sys_relation` VALUES (310, '212', 2);
INSERT INTO `t_sys_relation` VALUES (311, '213', 2);
INSERT INTO `t_sys_relation` VALUES (312, '214', 2);
INSERT INTO `t_sys_relation` VALUES (313, '215', 2);
INSERT INTO `t_sys_relation` VALUES (314, '216', 2);
INSERT INTO `t_sys_relation` VALUES (315, '217', 2);
INSERT INTO `t_sys_relation` VALUES (541, '105', 1);
INSERT INTO `t_sys_relation` VALUES (542, '106', 1);
INSERT INTO `t_sys_relation` VALUES (543, '107', 1);
INSERT INTO `t_sys_relation` VALUES (544, '108', 1);
INSERT INTO `t_sys_relation` VALUES (545, '109', 1);
INSERT INTO `t_sys_relation` VALUES (546, '110', 1);
INSERT INTO `t_sys_relation` VALUES (547, '111', 1);
INSERT INTO `t_sys_relation` VALUES (548, '112', 1);
INSERT INTO `t_sys_relation` VALUES (549, '113', 1);
INSERT INTO `t_sys_relation` VALUES (550, '165', 1);
INSERT INTO `t_sys_relation` VALUES (551, '166', 1);
INSERT INTO `t_sys_relation` VALUES (552, '167', 1);
INSERT INTO `t_sys_relation` VALUES (553, '218', 1);
INSERT INTO `t_sys_relation` VALUES (554, '219', 1);
INSERT INTO `t_sys_relation` VALUES (555, '114', 1);
INSERT INTO `t_sys_relation` VALUES (556, '115', 1);
INSERT INTO `t_sys_relation` VALUES (557, '116', 1);
INSERT INTO `t_sys_relation` VALUES (558, '117', 1);
INSERT INTO `t_sys_relation` VALUES (559, '118', 1);
INSERT INTO `t_sys_relation` VALUES (560, '162', 1);
INSERT INTO `t_sys_relation` VALUES (561, '163', 1);
INSERT INTO `t_sys_relation` VALUES (562, '164', 1);
INSERT INTO `t_sys_relation` VALUES (563, '119', 1);
INSERT INTO `t_sys_relation` VALUES (564, '120', 1);
INSERT INTO `t_sys_relation` VALUES (565, '121', 1);
INSERT INTO `t_sys_relation` VALUES (566, '122', 1);
INSERT INTO `t_sys_relation` VALUES (567, '150', 1);
INSERT INTO `t_sys_relation` VALUES (568, '151', 1);
INSERT INTO `t_sys_relation` VALUES (569, '128', 1);
INSERT INTO `t_sys_relation` VALUES (570, '134', 1);
INSERT INTO `t_sys_relation` VALUES (571, '158', 1);
INSERT INTO `t_sys_relation` VALUES (572, '159', 1);
INSERT INTO `t_sys_relation` VALUES (573, '130', 1);
INSERT INTO `t_sys_relation` VALUES (574, '131', 1);
INSERT INTO `t_sys_relation` VALUES (575, '135', 1);
INSERT INTO `t_sys_relation` VALUES (576, '136', 1);
INSERT INTO `t_sys_relation` VALUES (577, '137', 1);
INSERT INTO `t_sys_relation` VALUES (578, '152', 1);
INSERT INTO `t_sys_relation` VALUES (579, '153', 1);
INSERT INTO `t_sys_relation` VALUES (580, '154', 1);
INSERT INTO `t_sys_relation` VALUES (581, '132', 1);
INSERT INTO `t_sys_relation` VALUES (582, '138', 1);
INSERT INTO `t_sys_relation` VALUES (583, '139', 1);
INSERT INTO `t_sys_relation` VALUES (584, '140', 1);
INSERT INTO `t_sys_relation` VALUES (585, '155', 1);
INSERT INTO `t_sys_relation` VALUES (586, '156', 1);
INSERT INTO `t_sys_relation` VALUES (587, '157', 1);
INSERT INTO `t_sys_relation` VALUES (588, '133', 1);
INSERT INTO `t_sys_relation` VALUES (589, '160', 1);
INSERT INTO `t_sys_relation` VALUES (590, '161', 1);
INSERT INTO `t_sys_relation` VALUES (591, '141', 1);
INSERT INTO `t_sys_relation` VALUES (592, '142', 1);
INSERT INTO `t_sys_relation` VALUES (593, '143', 1);
INSERT INTO `t_sys_relation` VALUES (594, '144', 1);
INSERT INTO `t_sys_relation` VALUES (595, '202', 1);
INSERT INTO `t_sys_relation` VALUES (596, '203', 1);
INSERT INTO `t_sys_relation` VALUES (597, '204', 1);
INSERT INTO `t_sys_relation` VALUES (598, '205', 1);
INSERT INTO `t_sys_relation` VALUES (599, '145', 1);
INSERT INTO `t_sys_relation` VALUES (600, '148', 1);
INSERT INTO `t_sys_relation` VALUES (601, '149', 1);
INSERT INTO `t_sys_relation` VALUES (602, '199', 1);
INSERT INTO `t_sys_relation` VALUES (603, '200', 1);
INSERT INTO `t_sys_relation` VALUES (604, '201', 1);
INSERT INTO `t_sys_relation` VALUES (605, '206', 1);
INSERT INTO `t_sys_relation` VALUES (606, '207', 1);
INSERT INTO `t_sys_relation` VALUES (607, '208', 1);
INSERT INTO `t_sys_relation` VALUES (608, '209', 1);
INSERT INTO `t_sys_relation` VALUES (609, '210', 1);
INSERT INTO `t_sys_relation` VALUES (610, '211', 1);
INSERT INTO `t_sys_relation` VALUES (611, '212', 1);
INSERT INTO `t_sys_relation` VALUES (612, '213', 1);
INSERT INTO `t_sys_relation` VALUES (613, '214', 1);
INSERT INTO `t_sys_relation` VALUES (614, '215', 1);
INSERT INTO `t_sys_relation` VALUES (615, '216', 1);
INSERT INTO `t_sys_relation` VALUES (616, '217', 1);

-- ----------------------------
-- Table structure for t_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_role`;
CREATE TABLE `t_sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `num` int(11) DEFAULT NULL COMMENT '序号',
  `pid` int(11) DEFAULT NULL COMMENT '父角色id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色名称',
  `deptid` int(11) DEFAULT NULL COMMENT '部门名称',
  `tips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '提示',
  `version` int(11) DEFAULT NULL COMMENT '保留字段(暂时没用）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_role
-- ----------------------------
INSERT INTO `t_sys_role` VALUES (1, 1, 0, '超级管理员', NULL, 'administrator', NULL);
INSERT INTO `t_sys_role` VALUES (2, 1, 0, '操作员', 24, '操作员', NULL);

-- ----------------------------
-- Table structure for t_sys_task
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_task`;
CREATE TABLE `t_sys_task`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '任务名',
  `job_group` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '任务组',
  `job_class` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '执行类',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '任务说明',
  `cron` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '定时规则',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '执行参数',
  `exec_at` datetime(0) DEFAULT NULL COMMENT '执行时间',
  `exec_result` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '执行结果',
  `disabled` tinyint(1) DEFAULT NULL COMMENT '是否禁用',
  `createtime` datetime(0) DEFAULT NULL,
  `creator` bigint(20) DEFAULT NULL,
  `concurrent` tinyint(4) DEFAULT 0 COMMENT '是否允许并发',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_task
-- ----------------------------
INSERT INTO `t_sys_task` VALUES (1, '测试job', 'default', 'HelloJob', '测试job\n            \n            \n            \n            ', '0 7 11 * * ?', '{\n\"appname\": \"loan-lite\",\n\"version\":1\n}\n            \n            \n            \n            ', '2019-01-02 11:06:00', '执行成功', 1, '2018-12-28 09:54:00', 1, 0);

-- ----------------------------
-- Table structure for t_sys_task_log
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_task_log`;
CREATE TABLE `t_sys_task_log`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '任务名',
  `exec_at` datetime(0) DEFAULT NULL COMMENT '执行时间',
  `exec_success` int(11) DEFAULT NULL COMMENT '执行结果（成功:1、失败:0)',
  `job_exception` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '抛出异常',
  `id_task` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_task_log
-- ----------------------------
INSERT INTO `t_sys_task_log` VALUES (1, '测试job', '2018-12-31 09:54:00', 1, NULL, 1);
INSERT INTO `t_sys_task_log` VALUES (2, '测试job', '2018-12-31 10:04:00', 1, NULL, 1);
INSERT INTO `t_sys_task_log` VALUES (3, '测试job', '2019-01-02 11:06:00', 1, NULL, 1);

-- ----------------------------
-- Table structure for t_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user`;
CREATE TABLE `t_sys_user`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像',
  `account` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `salt` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'md5密码盐',
  `name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '名字',
  `birthday` datetime(0) DEFAULT NULL COMMENT '生日',
  `sex` int(11) DEFAULT NULL COMMENT '性别（1：男 2：女）',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮件',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话',
  `roleid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色id',
  `deptid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '部门id',
  `status` int(11) DEFAULT NULL COMMENT '状态(1：启用  2：冻结  3：删除）',
  `create_at` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime(0) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `operator` int(20) DEFAULT NULL COMMENT '操作员',
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注',
  `version` int(11) DEFAULT NULL COMMENT '保留字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_user
-- ----------------------------
INSERT INTO `t_sys_user` VALUES (1, NULL, 'admin', '6ab1f386d715cfb6be85de941d438b02', '8pgby', '管理员', '2017-05-05 00:00:00', 2, '', '', '1', '0', 1, '2016-01-29 08:49:53', NULL, NULL, NULL, 25);
INSERT INTO `t_sys_user` VALUES (47, NULL, 'gaoyanpeng', '153a71ac3b83dda573ff3b967be0c262', '7zjbn', '高彦鹏', NULL, 1, '', '', '2', '28,24', 1, '2019-01-07 14:24:02', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_role`;
CREATE TABLE `t_sys_user_role`  (
  `roleId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `userId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_user_role
-- ----------------------------
INSERT INTO `t_sys_user_role` VALUES ('c4de3cf1a62e41378d9f1205293485a3', '43e6c8d6d3134e5aa41ae2a85b87586b', 1);

-- ----------------------------
-- Table structure for t_sys_user_unit
-- ----------------------------
DROP TABLE IF EXISTS `t_sys_user_unit`;
CREATE TABLE `t_sys_user_unit`  (
  `userId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `unitId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sys_user_unit
-- ----------------------------
INSERT INTO `t_sys_user_unit` VALUES ('43e6c8d6d3134e5aa41ae2a85b87586b', 'cff0e38c05544085b56dee30e97383b4', 1);

SET FOREIGN_KEY_CHECKS = 1;
