# User: xiacheng
# Date: 2017-12-6 11:52:23
# Desc: idea2t基本表sql及默认数据

set names utf8;
USE `ideatbase`;

#添加系统用户基本信息表

DROP TABLE IF EXISTS `ideatbase`.`base_user`;
CREATE TABLE `ideatbase`.`base_user` (
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户编号',
  `pwd` varchar(64) NOT NULL DEFAULT '' COMMENT '密码(md5)',
  `sex` int(11) NOT NULL DEFAULT '1' COMMENT '性别，0为女，1为男',
  `user_name` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_domain` varchar(255) NOT NULL DEFAULT '' COMMENT '用户域名',
  `user_image` varchar(255) NOT NULL DEFAULT '' COMMENT '用户图片路径',
  `balance` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '总余额',
  `profit` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '总利润',
  `turnover` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '总销售额',
  `shop_name` varchar(255) NOT NULL DEFAULT '' COMMENT '店名',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '运营状态，0为已关闭，1为运营中',
  `role_id` varchar(32) NOT NULL DEFAULT '' COMMENT '角色编号',
  `profession` varchar(255) NOT NULL DEFAULT '' COMMENT '职业',
  `phone` varchar(32) NOT NULL DEFAULT '' COMMENT '联系电话',
  `email` varchar(255) NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `address` varchar(1024) NOT NULL DEFAULT '' COMMENT '地址',
  `register_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '注册时间',
  `last_login_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '上次登录时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统用户基本信息表';


#添加初始化管理员账户
REPLACE INTO ideatbase.base_user(`user_id`,`pwd`,`role_id`,`user_domain`,`register_time`) values('admin','123456','root','admin',now());


#添加用户收支明细表（包括每一次提现行为）
DROP TABLE IF EXISTS `ideatbase`.`base_expense`;
CREATE TABLE `ideatbase`.`base_expense` (
  `expense_id` varchar(32) NOT NULL DEFAULT '' COMMENT '收支编号',
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户编号',
  `expense_count` varchar(255) NOT NULL DEFAULT '' COMMENT '提现金额',
  `expense_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '提现时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`expense_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户收支明细表';



#添加客户基本信息表

DROP TABLE IF EXISTS `ideatbase`.`base_customer`;
CREATE TABLE `ideatbase`.`base_customer` (
  `customer_id` varchar(32) NOT NULL DEFAULT '' COMMENT '客户帐号',
  `customer_pwd` varchar(64) NOT NULL DEFAULT '' COMMENT '客户密码',
  `customer_name` varchar(64) NOT NULL DEFAULT '' COMMENT '客户昵称',
  `customer_image` varchar(255) NOT NULL DEFAULT '' COMMENT '客户图片路径',
  `customer_phone` varchar(32) NOT NULL DEFAULT '' COMMENT '联系电话',
  `address` varchar(1024) NOT NULL DEFAULT '' COMMENT '地址',
  `register_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '注册时间',
  `last_login_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '上一次登录时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户基本信息表';


#添加客户收货地址表
DROP TABLE IF EXISTS `ideatbase`.`base_order_address`;
CREATE TABLE `ideatbase`.`base_order_address` (
  `address_id` varchar(32) NOT NULL DEFAULT '' COMMENT '地址编号',
  `customer_id` varchar(32) NOT NULL DEFAULT '' COMMENT '客户编号',
  `consignee` varchar(32) NOT NULL DEFAULT '' COMMENT '收件人',
  `address` varchar(1024) NOT NULL DEFAULT '' COMMENT '地址',
  `phone` varchar(32) NOT NULL DEFAULT '' COMMENT '联系电话',
  `postcode` varchar(32) NOT NULL DEFAULT '' COMMENT '邮政编码',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收货地址信息表';



#添加角色基本信息表

DROP TABLE IF EXISTS `ideatbase`.`base_role`;
CREATE TABLE `ideatbase`.`base_role` (
  `role_id` varchar(32) NOT NULL DEFAULT '' COMMENT '角色编号',
  `role_name` varchar(255) NOT NULL DEFAULT '' COMMENT '角色名',
  `privilege` varchar(1024) NOT NULL DEFAULT '' COMMENT '权限',
  `descript` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色基本信息表';


#初始化角色表
REPLACE INTO ideatbase.base_role(`role_id`,`role_name`,`update_time`) values('root','系统管理员',now());


#添加基本权限字典表(暂未投入使用)

DROP TABLE IF EXISTS `ideatbase`.`base_functions`;
CREATE TABLE `ideatbase`.`base_functions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL DEFAULT '' COMMENT '功能编号',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '功能名称',
  `parent_code` varchar(32) NOT NULL DEFAULT '' COMMENT '子功能编号,12位',
  `bit_set` int(11) NOT NULL DEFAULT '0' COMMENT '功能占位,从左到右，从0开始记数',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `hide` int(11) NOT NULL DEFAULT '0' COMMENT '是否开放该功能,0开放1隐藏',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='基本权限字典表';



#添加商品基本信息表
DROP TABLE IF EXISTS `ideatbase`.`base_goods`;
CREATE TABLE `ideatbase`.`base_goods` (
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `goods_name` varchar(64) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_type_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品类别编号',
  `printing` varchar(255) NOT NULL DEFAULT '' COMMENT '印花工艺',
  `single_cost` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '单面成本',
  `double_cost` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '双面成本',
  `goods_descript` varchar(1024) NOT NULL DEFAULT '' COMMENT '商品简介',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品基本信息表';



#添加商品详细信息表

DROP TABLE IF EXISTS `ideatbase`.`base_goods_detail`;
CREATE TABLE `ideatbase`.`base_goods_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '后台用户编号',
  `single_price` double(5,2) NOT NULL DEFAULT '0.00' COMMENT '单面单价',
  `double_price` double(5,2) NOT NULL DEFAULT '0.00' COMMENT '双面单价',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '商品状态，0为未上架，1为已上架',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品详细信息表';


#添加商品素材图片信息表
DROP TABLE IF EXISTS `ideatbase`.`base_goods_picture`;
CREATE TABLE `ideatbase`.`base_goods_picture`(
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_pic_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品图片编号',
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `goods_pic_path` varchar(255) NOT NULL DEFAULT '' COMMENT '商品素材图片路径',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品素材图片信息表';


#添加颜色效果图关系表
DROP TABLE IF EXISTS `ideatbase`.`rel_color_image`;
CREATE TABLE `ideatbase`.`rel_color_image` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `color_id` varchar(32) NOT NULL DEFAULT '' COMMENT '颜色编号',
  `front_xg_path` varchar(255) NOT NULL DEFAULT '' COMMENT '正面效果图片路径',
  `back_xg_path` varchar(255) NOT NULL DEFAULT '' COMMENT '反面效果图片路径',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='颜色效果图关系表';


#添加商品尺寸库存关系表

DROP TABLE IF EXISTS `ideatbase`.`rel_size_stock`;
CREATE TABLE `ideatbase`.`rel_size_stock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `color_id` varchar(32) NOT NULL DEFAULT '' COMMENT '颜色编号',
  `size_id` varchar(32) NOT NULL DEFAULT '' COMMENT '尺寸编号',
  `stock_count` int(11) NOT NULL DEFAULT '0' COMMENT '库存数量',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品尺寸库存关系表';



#添加商品尺寸字典表
DROP TABLE IF EXISTS `ideatbase`.`dic_size_info`;
CREATE TABLE `ideatbase`.`dic_size_info` (
  `size_id` varchar(32) NOT NULL DEFAULT '' COMMENT '尺寸编号',
  `size` varchar(32) NOT NULL DEFAULT '' COMMENT '尺寸',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品尺寸字典表';

#插入默认尺寸字典数据

REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('1','XXS',now());
REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('2','XS',now());
REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('3','S',now());
REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('4','M',now());
REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('5','L',now());
REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('6','XL',now());
REPLACE INTO ideatbase.dic_size_info(`size_id`,`size`,`update_time`) values('7','XXL',now());



#添加商品颜色字典表
DROP TABLE IF EXISTS `ideatbase`.`dic_color_info`;
CREATE TABLE `ideatbase`.`dic_color_info` (
  `color_id` varchar(32) NOT NULL DEFAULT '' COMMENT '颜色编号',
  `color` varchar(32) NOT NULL DEFAULT '' COMMENT '颜色',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`color_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品颜色字典表';


#插入默认颜色字典数据

REPLACE INTO ideatbase.dic_color_info(`color_id`,`color`,`update_time`) values('1','白',now());
REPLACE INTO ideatbase.dic_color_info(`color_id`,`color`,`update_time`) values('2','黑',now());
REPLACE INTO ideatbase.dic_color_info(`color_id`,`color`,`update_time`) values('3','红',now());
REPLACE INTO ideatbase.dic_color_info(`color_id`,`color`,`update_time`) values('4','绿',now());



#添加商品类别字典表
DROP TABLE IF EXISTS `ideatbase`.`dic_type_info`;
CREATE TABLE `ideatbase`.`dic_type_info` (
  `goods_type_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品类别编号',
  `goods_type` varchar(255) NOT NULL DEFAULT '' COMMENT '商品类别',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`goods_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品类别字典表';

#插入默认类别字典数据

REPLACE INTO ideatbase.dic_type_info(`goods_type_id`,`goods_type`,`update_time`) values('1','T恤',now());
REPLACE INTO ideatbase.dic_type_info(`goods_type_id`,`goods_type`,`update_time`) values('2','卫衣',now());
REPLACE INTO ideatbase.dic_type_info(`goods_type_id`,`goods_type`,`update_time`) values('3','POLO衫',now());




#添加主订单基本信息表
DROP TABLE IF EXISTS `ideatbase`.`base_order`;
CREATE TABLE `ideatbase`.`base_order`(
  `order_id` varchar(32) NOT NULL DEFAULT '' COMMENT '订单编号',
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户编号',
  `shop_name` varchar(255) NOT NULL DEFAULT '' COMMENT '店名',
  `customer_id` varchar(32) NOT NULL DEFAULT '' COMMENT '客户编号',
  `order_name` varchar(32) NOT NULL DEFAULT '' COMMENT '客户名称',
  `address_id` varchar(32) NOT NULL DEFAULT '' COMMENT '地址编号',
  `goods_count` int(11) NOT NULL DEFAULT '0' COMMENT '订单商品总数',
  `print_count` int(11) NOT NULL DEFAULT '0' COMMENT '印花数量',
  `invoice_title` varchar(32) NOT NULL DEFAULT '' COMMENT '发票抬头',
  `order_cost` double(10,2) NOT NULL DEFAULT '0' COMMENT '订单总成本',
  `order_total` double(10,2) NOT NULL DEFAULT '0' COMMENT '订单总销售额',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '订单状态，0为待付款、1为待发货、2为待收货、3为已签收，4为已关闭',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete`  int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='主订单基本信息表';



#添加子订单商品信息表
DROP TABLE IF EXISTS `ideatbase`.`base_child_order`;
CREATE TABLE `ideatbase`.`base_child_order` (
  `child_order_id` varchar(32) NOT NULL DEFAULT '' COMMENT '子订单编号',
  `order_id` varchar(32) NOT NULL DEFAULT '' COMMENT '订单编号',
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名字',
  `color_id` varchar(32) NOT NULL DEFAULT '' COMMENT '颜色编号',
  `printing` varchar(32) NOT NULL DEFAULT '' COMMENT '印花工艺',
  `child_goods_count` int(11) NOT NULL DEFAULT '0' COMMENT '子订单商品总数',
  `front_sc_path` varchar(255) NOT NULL DEFAULT '' COMMENT '正面素材图片路径',
  `back_sc_path` varchar(255) NOT NULL DEFAULT '' COMMENT '反面素材图片路径',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`child_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='子订单商品信息表';




#添加订单商品尺寸数量表
DROP TABLE IF EXISTS `ideatbase`.`order_size_stock`;
CREATE TABLE `ideatbase`.`order_size_stock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `child_order_id` varchar(32) NOT NULL DEFAULT '' COMMENT '子订单编号',
  `size_id` varchar(32) NOT NULL DEFAULT '' COMMENT '尺寸编号',
  `buy_count` int(11) NOT NULL DEFAULT '0' COMMENT '购买商品数量',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='订单商品尺寸数量表';



#日统计数据信息表
DROP TABLE IF EXISTS `ideatbase`.`base_day_stat`;
CREATE TABLE `ideatbase`.`base_day_stat`(
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户编号',
  `day_profit` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '日利润',
  `day_turnover` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '日销售额',
  `day_order_count` int(11) NOT NULL DEFAULT '0' COMMENT '日订单总数',
  `day_goods_count` int(11) NOT NULL DEFAULT '0' COMMENT '日商品总数',
  `record_time` date NOT NULL DEFAULT '0000-00-00' COMMENT '记录时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='日统计数据信息表';



#月统计数据信息表
DROP TABLE IF EXISTS `ideatbase`.`base_month_stat`;
CREATE TABLE `ideatbase`.`base_month_stat`(
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户编号',
  `month_profit` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '月利润',
  `month_turnover` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '月销售额',
  `month_order_count` int(11) NOT NULL DEFAULT '0' COMMENT '月订单总数',
  `month_goods_count` int(11) NOT NULL DEFAULT '0' COMMENT '月商品总数',
  `stat_month` int(11) NOT NULL DEFAULT '0' COMMENT '所属月份',
  `stat_year` int(11) NOT NULL DEFAULT '0' COMMENT '所属年份',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='月统计数据信息表';


#添加购物车关系表
DROP TABLE IF EXISTS `ideatbase`.`rel_cart_info`;
CREATE TABLE `ideatbase`.`rel_cart_info` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shop_cart_id` varchar(32) NOT NULL DEFAULT '' COMMENT '购物车编号',
  `customer_id` varchar(32) NOT NULL DEFAULT '' COMMENT '客户编号',
  `user_id` varchar(32) NOT NULL DEFAULT '' COMMENT '用户编号',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='购物车关系表';


#购物车商品基本信息表
DROP TABLE IF EXISTS `ideatbase`.`base_shop_cart`;
CREATE TABLE `ideatbase`.`base_shop_cart`(
  `cart_record_id` varchar(32) NOT NULL DEFAULT '' COMMENT '购物车记录编号',
  `goods_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品编号',
  `goods_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商品名字',
  `goods_count` int(11) NOT NULL DEFAULT '0' COMMENT '商品总数',
  `goods_total` double(10,2) NOT NULL DEFAULT '0' COMMENT '总销售额',
  `color_id` varchar(32) NOT NULL DEFAULT '' COMMENT '颜色编号',
  `printing` varchar(32) NOT NULL DEFAULT '' COMMENT '印花工艺',
  `front_sc_path` varchar(255) NOT NULL DEFAULT '' COMMENT '正面素材图片路径',
  `back_sc_path` varchar(255) NOT NULL DEFAULT '' COMMENT '反面素材图片路径',
  `shop_cart_id` varchar(32) NOT NULL DEFAULT '' COMMENT '购物车编号',
  `insert_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '插入时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`cart_record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='购物车商品基本信息表';



#添加购物车商品尺寸数量表
DROP TABLE IF EXISTS `ideatbase`.`cart_size_stock`;
CREATE TABLE `ideatbase`.`cart_size_stock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cart_record_id` varchar(32) NOT NULL DEFAULT '' COMMENT '购物车记录编号',
  `size_id` varchar(32) NOT NULL DEFAULT '' COMMENT '尺寸编号',
  `buy_count` int(11) NOT NULL DEFAULT '0' COMMENT '购买商品数量',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `is_delete` int(11) NOT NULL DEFAULT '0' COMMENT '是否删除，0为否，1为是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='购物车商品尺寸数量表';
