CREATE DATABASE appDB;
USE appDB;
CREATE TABLE `ADMIN`(
	`username` CHAR(15) PRIMARY KEY,
    `password` CHAR(12) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `ADMIN` VALUES
	('root','12345678');
SELECT* FROM ADMIN;

CREATE TABLE `CUSTOMER`(
	`username` CHAR(15) PRIMARY KEY,
    `password` CHAR(12) NOT NULL,
    `address` VARCHAR(30) NOT NULL,
    `phone` CHAR(15) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `CUSTOMER` VALUES
	('lonelyprince7','77777777','西南石油大学学生宿舍10-222','13844444444'),
    ('小张','55555555','西南石油大学学生宿舍17-555','18833344444');
SELECT* FROM CUSTOMER;
    
CREATE TABLE `RESTAURANT`(
	`username` CHAR(15) PRIMARY KEY,
    `password` CHAR(12) NOT NULL,
    `address` VARCHAR(30) NOT NULL,
    `phone` CHAR(15) NOT NULL,
    `img_res` VARCHAR(50)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `RESTAURANT` VALUES
	('土风土味','77777777','四川省成都市新都区正因村128号','1314074','static/images/res_2.jpg'),
	('统一面馆','88888888','四川省成都市新都区正熊猫大道69号','1884801','static/images/res_1.jpg');
SELECT* FROM RESTAURANT;

CREATE TABLE `DISHES`(
	`dishname` CHAR(15) PRIMARY KEY,
	`restaurant` CHAR(15) NOT NULL,
	`dishinfo` VARCHAR(50) ,
    `nutriention` VARCHAR(30),
    `price` DECIMAL(5,2) NOT NULL,
	`sales` INT(5) NOT NULL,
    `imgsrc` VARCHAR(50),
    `isSpecialty` BOOLEAN,
	FOREIGN KEY (restaurant)
    REFERENCES RESTAURANT(username)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO DISHES VALUES
	('水煮鱼', '土风土味', '松江鲈鱼，巨口细鳞，肉质鲜嫩', '蛋白质，维生素', 26.00, 0, 'static/images/img_2.jpg', 0),
    ('香锅牛肉', '土风土味', '该香锅牛肉味道鲜美，有土豆藕片等蔬菜可添加', '蛋白质，维生素', 14.50, 0, 'static/images/img_5.jpg', 1),
	('牛肉面', '统一面馆', '老坛酸菜牛肉面，麻辣酸爽，美味享受', '蛋白质，淀粉，维生素', 13.00, 1, 'static/images/img_7.jpg', 0);
SELECT* FROM DISHES;

CREATE TABLE `SHOPPINGCART`(
	`username` CHAR(15),
    `restaurant` CHAR(15),
    `dishname` CHAR(15),
    `price` DECIMAL(5,2) NOT NULL,
    `img_res` VARCHAR(50),
	FOREIGN KEY (username)
    REFERENCES CUSTOMER(username),
	FOREIGN KEY (restaurant)
    REFERENCES RESTAURANT(username),
	FOREIGN KEY (dishname)
    REFERENCES DISHES(dishname),
    PRIMARY KEY (username,restaurant,dishname)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `SHOPPINGCART` VALUES
	('lonelyprince7','土风土味','水煮鱼',26.00,'static/images/img_2.jpg');
SELECT* FROM SHOPPINGCART;

CREATE TABLE `ORDER_COMMENT`(
	`orderID` CHAR(15) PRIMARY KEY,
	`username` CHAR(15) NOT NULL,
	`restaurant` VARCHAR(15) NOT NULL,
    `isFinished` BOOLEAN CHECK('isFinshed'=1 or 'isFinshed'=0),
    `cost` DECIMAL(5,2) NOT NULL,
	`c_rank` TINYINT(1) CHECK('c_rank' BETWEEN 1 AND 5),
    `text` VARCHAR(50),
    `transactiontime` TIMESTAMP(0) NOT NULL CHECK('transactiontime' BETWEEN '1970-01-01 00:00:01' AND '2038-01-19 03:14:07'),
    FOREIGN KEY (username)
    REFERENCES CUSTOMER(username),
	FOREIGN KEY (restaurant)
    REFERENCES RESTAURANT(username)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO ORDER_COMMENT VALUES
	('1444000', 'lonelyprince7', '土风土味', 1, 26.00, 1, '鱼肉非常不新鲜，不推荐', '2020-11-7 13:14:07'),
    ('1445000', 'lonelyprince7', '土风土味', 1, 14.50, 3, '牛肉太少，蔬菜太多，希望下次多放点牛肉', '2020-10-13 20:29:13'),
	('1446000', '小张', '统一面馆', 0, 13.00, 5, '分量足，味道好，推荐', '2020-10-27 15:45:21');
SELECT* FROM ORDER_COMMENT;