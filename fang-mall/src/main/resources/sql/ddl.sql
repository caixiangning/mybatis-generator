# ************************************************************
#
# 数据库建表SQL
#
# Host: 127.0.0.1 (MySQL 5.6.36)
# Database: db_fang_mall
# Generation Time: 2018-02-22 05:41:28 +0000
# ************************************************************

-- 创建数据库
DROP DATABASE IF EXISTS db_fang_mall;
CREATE DATABASE db_fang_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 选择数据库
USE db_fang_mall;

-- 用户表
DROP TABLE IF EXISTS mall_user;
CREATE TABLE mall_user(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '用户表id',
  username varchar(50) NOT NULL COMMENT '用户名',
  password varchar(50) NOT NULL COMMENT '用户密码，MD5加密',
  email varchar(50) DEFAULT NULL COMMENT '电子邮箱',
  phone varchar(20) DEFAULT NULL COMMENT '手机号',
  question varchar(100) DEFAULT NULL COMMENT '找回密码问题',
  answer varchar(100) DEFAULT NULL COMMENT '找回密码答案',
  role int(4) NOT NULL COMMENT '角色 0-管理员,1-普通用户',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY username_unique(username) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '用户表';

-- 商品分类表
DROP TABLE IF EXISTS mall_category;
CREATE TABLE mall_category(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '分类表id',
  parent_id int(11) DEFAULT NULL COMMENT '父类别id,id=0-根节点',
  name varchar(50) DEFAULT NULL COMMENT '类别名称',
  status tinyint(1) DEFAULT '1' COMMENT '类别状态，1-正常,2-废弃',
  sort_order int(4) DEFAULT NULL COMMENT '排序编号,相同类别展示的顺序,数值相等则自然排序',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=INNODB AUTO_INCREMENT=10000 DEFAULT CHARSET=UTF8 COMMENT '商品分类表';

-- 商品信息表
DROP TABLE IF EXISTS mall_product;
CREATE TABLE mall_product(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '商品信息表id',
  category_id int(11) NOT NULL COMMENT '分类id,分类表主键id',
  name varchar(100) NOT NULL COMMENT '商品名称',
  subtitle varchar(200) DEFAULT NULL COMMENT '商品副标题',
  main_image varchar(500) DEFAULT NULL COMMENT '商品主图,url相对地址',
  sub_images text COMMENT '商品图片,json格式便于扩展',
  detail text COMMENT '商品详情',
  price decimal(20,2) NOT NULL COMMENT '价格,单位元,保留两位小数',
  stock int(11) NOT NULL COMMENT '库存数量',
  status int(6) DEFAULT '1' COMMENT '商品状态，1-在售,2-下架,3-删除',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=INNODB AUTO_INCREMENT=100000 DEFAULT CHARSET=UTF8 COMMENT '商品信息表';

-- 购物车表
DROP TABLE IF EXISTS mall_cart;
CREATE TABLE mall_cart(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车表id',
  user_id int(11) NOT NULL COMMENT '用户id，用户表主键id',
  product_id int(11) NOT NULL COMMENT '商品id，商品信息表主键id',
  quantity int(11) NOT NULL COMMENT '商品数量',
  checked int(11) NOT NULL COMMENT '是否选择，1-已勾选,0-未勾选',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY user_id_index(user_id) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '购物车表';

-- 支付信息表
DROP TABLE IF EXISTS mall_pay_info;
CREATE TABLE mall_pay_info(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '支付信息表id',
  user_id int(11) NOT NULL COMMENT '用户id，用户表主键id',
  order_no bigint(20) NOT NULL COMMENT '订单号',
  pay_platform int(10) NOT NULL COMMENT '支付平台，1-支付宝,2-微信',
  platform_number varchar(200) DEFAULT NULL COMMENT '支付宝(或其他支付方式)支付流水号',
  platform_status varchar(20) DEFAULT NULL COMMENT '支付宝(或其他支付方式)支付状态',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '支付信息表';

-- 订单表
DROP TABLE IF EXISTS mall_order;
CREATE TABLE mall_order(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '订单表id',
  order_no bigint(20) NOT NULL COMMENT '订单号',
  user_id int(11) NOT NULL COMMENT '用户id，用户表主键id',
  shipping_id int(11) NOT NULL COMMENT '订单地址',
  payment decimal(20,2) NOT NULL COMMENT '实际付款金额，单位元，保留两位小数',
  payment_type int(4) DEFAULT NULL COMMENT '支付类型，1-在线支付,2-货到付款',
  postage int(10) DEFAULT NULL COMMENT '运费，单位元',
  status int(10) NOT NULL COMMENT '订单状态：0-已取消,10-未付款,20-已付款,40-已发货,50-交易成功,60-交易关闭',
  payment_time datetime DEFAULT NULL COMMENT '交易时间',
  send_time datetime DEFAULT NULL COMMENT '发货时间',
  close_time datetime DEFAULT NULL COMMENT '交易关闭时间',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  UNIQUE KEY order_no_index(order_no) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '订单表';

-- 订单明细表
DROP TABLE IF EXISTS mall_order_item;
CREATE TABLE mall_order_item(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '订单子表id',
  user_id int(11) NOT NULL COMMENT '用户id,用户表主键id',
  order_no bigint(20) NOT NULL COMMENT '订单号',
  product_id int(11) NOT NULL COMMENT '商品id，商品信息表主键id',
  product_name varchar(100) DEFAULT NULL COMMENT '商品名称',
  product_image varchar(500) DEFAULT NULL COMMENT '商品图片地址',
  current_unit_price decimal(20,2) DEFAULT NULL COMMENT '生成订单时的商品单价，单位元，保留两位小数',
  quantity int(10) DEFAULT NULL COMMENT '商品数量',
  total_price decimal(20,2) DEFAULT NULL COMMENT '商品总价，单位元，保留两位小数',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id),
  KEY order_no_index(order_no) USING BTREE,
  KEY order_no_user_id_index(user_id,order_no) USING BTREE
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '订单明细表';

-- 收货地址表
DROP TABLE IF EXISTS mall_shipping;
CREATE TABLE mall_shipping(
  id int(11) NOT NULL AUTO_INCREMENT COMMENT '收货地址id',
  user_id int(11) NOT NULL COMMENT '用户id，用户表主键id',
  receiver_name varchar(20) DEFAULT NULL COMMENT '收货姓名',
  receiver_phone varchar(20) DEFAULT NULL COMMENT '收货固定电话',
  receiver_mobile varchar(20) DEFAULT NULL COMMENT '收货移动电话',
  receiver_province varchar(20) DEFAULT NULL COMMENT '省份',
  receiver_city varchar(20) DEFAULT NULL COMMENT '城市',
  receiver_district varchar(20) DEFAULT NULL COMMENT '区县',
  receiver_address varchar(200) DEFAULT NULL COMMENT '详细地址',
  receiver_zip varchar(6) DEFAULT NULL COMMENT '邮编',
  create_time datetime NOT NULL COMMENT '创建时间',
  update_time datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (id)
) ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT '收货地址表';




