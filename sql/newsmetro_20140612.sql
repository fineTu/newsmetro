-- phpMyAdmin SQL Dump
-- version 3.4.8
-- http://www.phpmyadmin.net
--
-- 主机: 220.166.64.125
-- 生成日期: 2014 年 06 月 12 日 15:34
-- 服务器版本: 5.1.69
-- PHP 版本: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `gklifg`
--

-- --------------------------------------------------------

--
-- 表的结构 `menu_item`
--

CREATE TABLE IF NOT EXISTS `menu_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `system_menu_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_menu_item_system_menu1` (`system_menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `system_menu`
--

CREATE TABLE IF NOT EXISTS `system_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `target_point`
--

CREATE TABLE IF NOT EXISTS `target_point` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL COMMENT '目标名称',
  `url` varchar(512) NOT NULL COMMENT '目标所在url',
  `abs_xpath` varchar(255) DEFAULT NULL COMMENT '绝对xpath',
  `rel_xpath` varchar(255) DEFAULT NULL COMMENT '相对xpath',
  `regex` varchar(128) DEFAULT NULL COMMENT '目标元素的正则分析',
  `md5` varchar(128) DEFAULT NULL COMMENT '目标的md5值，用来判定是否更新',
  `isRss` tinyint(1) DEFAULT NULL COMMENT '目标是否是rss资源',
  `status` varchar(45) NOT NULL COMMENT '目标状态，正常、隐藏',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_target_point_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- 转存表中的数据 `target_point`
--

INSERT INTO `target_point` (`id`, `user_id`, `name`, `url`, `abs_xpath`, `rel_xpath`, `regex`, `md5`, `isRss`, `status`) VALUES
(1, 1, '36氪', 'http://www.36kr.com/feed', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(2, 1, 'CSDM 业界', 'http://articles.csdn.net/api/rss.php?tid=1008', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(3, 1, '新浪要闻', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[5]/DIV[8]/DIV[2]/DIV[1]/DIV[2]', '//*[@id="syncad_1"]', NULL, NULL, 0, 'REGULAR'),
(4, 1, '腾讯要闻', 'http://www.qq.com/', '/HTML/BODY[1]/DIV[7]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/DIV[1]/UL[2]', '//*[@id="news2"]', NULL, NULL, 0, 'REGULAR'),
(5, 4, '新浪要闻', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[6]/DIV[8]/DIV[2]/DIV[1]/DIV[2]', '//*[@id="syncad_1"]', NULL, NULL, 0, 'REGULAR'),
(7, 6, '36kr', 'http://www.36kr.com/feed/', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(8, 4, '新浪内地', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[6]/DIV[9]/DIV[2]/DIV[2]/DIV[1]/UL[1]', '//*[@id="blk_gnxw_011"]', NULL, NULL, 0, 'REGULAR'),
(10, 1, '煎蛋最新更新', 'http://jandan.net/new', '/HTML/BODY[1]/DIV[1]/DIV[2]/DIV[1]', '//*[@id="content"]', NULL, NULL, 0, 'REGULAR'),
(11, 4, '新浪科技要闻', 'http://tech.sina.com.cn/', '/HTML/BODY[1]/DIV[10]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/DIV[1]/DIV[1]', '//*[@id="impNews1"]', NULL, NULL, 0, 'REGULAR'),
(12, 4, '36氪', 'http://www.36kr.com/feed', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(13, 4, '新浪财经', 'http://finance.sina.com.cn/', '/HTML/BODY[1]/DIV[4]/DIV[6]/DIV[2]/DIV[1]/DIV[3]', '//*[@id="fin_tabs0_c0"]', NULL, NULL, 0, 'REGULAR'),
(14, 4, '新浪', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[9]/DIV[8]/DIV[2]/DIV[1]/DIV[2]', '//*[@id="syncad_1"]', NULL, NULL, 0, 'REGULAR'),
(15, 4, '36kr', 'http://www.36kr.com/feed', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(16, 8, '36氪', 'http://www.36kr.com/feed', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(18, 8, '爱范儿', 'http://www.ifanr.com/feed', NULL, NULL, NULL, NULL, 1, 'REGULAR'),
(19, 4, '新浪要闻', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[6]/DIV[8]/DIV[2]/DIV[1]/DIV[2]', '//*[@id="syncad_1"]', NULL, NULL, 0, 'REGULAR'),
(20, 8, '新浪要闻', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[6]/DIV[8]/DIV[2]/DIV[1]/DIV[2]', '//*[@id="syncad_1"]', NULL, NULL, 0, 'REGULAR'),
(22, 12, '新浪要闻', 'http://news.sina.com.cn/', '/HTML/BODY[1]/DIV[9]/DIV[8]/DIV[2]/DIV[1]/DIV[2]', '//*[@id="syncad_1"]', NULL, NULL, 0, 'REGULAR');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `sex` varchar(45) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `talking` varchar(255) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `code` varchar(255) NOT NULL,
  `registerDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `name`, `password`, `email`, `sex`, `photo`, `talking`, `status`, `code`, `registerDate`) VALUES
(4, 'gklifg', '96e79218965eb72c92a549dd5a330112', 'gklifg@126.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', 'YDPhtgInfyOQa6Xb7m4eH543YC1SqipI29LL/YZgJlppBbvXoZJVpo21APSMzIc2Zw9d+pbG1ck=', '2014-02-21'),
(6, 'hr', 'd2c5f9f70b78877f0ffd66bca54bbc1e', 'hr@yidian-inc.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', '/lB4v97X+WRKu33r0bjE5hc7WCefzeWYrQwJU0KDoGOdXDQIXMqP+tSK6wmKE1BeUyPPWEzGATQ=', '2014-02-24'),
(7, 'releasemj', 'e10adc3949ba59abbe56e057f20f883e', 'releasemj@qq.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', '/lB4v97X+WRAgXGa4A6Z1bQ+byjKecC+8iuXwWGMWhGqOUBLcN/crvXKLrCiikD6KQP1rjxGW4E=', '2014-02-24'),
(8, 'gklifg', '3b774fe4f5d86e9b112789a2708e1e91', 'gklifg@163.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', '/lB4v97X+WSUIhpI7tqgbbgq83FdIQvWNc6iTtiJQ9F5PrPfkjmBGPn+ge4t15KSz2FBdzgd7eA=', '2014-06-05'),
(10, 'sklxz', '3b774fe4f5d86e9b112789a2708e1e91', 'sklxz@qq.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', '/lB4v97X+WR6kRg66YKmF8+tEuiQ1Xp/ogoQt9KFCAuhdH3dUemKWr6iiCmSSiNx', '2014-06-05'),
(12, 'tjgdxs', '61aefd05e32f5b38c356b4fe5530cfd7', 'tjgdxs@qq.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', '/lB4v97X+WTWY/lAKJW2ejAqZT/CKjYskixroExcd1nLJGi3tfRd6rrU6pf8nzawK4MoXezon0o=', '2014-06-05'),
(14, 'david', '9925c4f0b140937b09ee715eeefef699', 'david@lagou.com', 'MALE', 'img/auto_photo.png', NULL, 'REGULAR', '/lB4v97X+WTlXW0jf45uf3UGNwsZOP/a2yMuAPotgS+cfGVI+2eiwiqyOpmh58qnzQbKQHt7xqo=', '2014-06-07');

-- --------------------------------------------------------

--
-- 表的结构 `xpath_maping`
--

CREATE TABLE IF NOT EXISTS `xpath_maping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) DEFAULT NULL,
  `xpath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
