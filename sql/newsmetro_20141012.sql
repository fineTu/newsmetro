-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: newsmetro
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `menu_item`
--

DROP TABLE IF EXISTS `menu_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `system_menu_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_menu_item_system_menu1` (`system_menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_item`
--

LOCK TABLES `menu_item` WRITE;
/*!40000 ALTER TABLE `menu_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_menu`
--

DROP TABLE IF EXISTS `system_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_menu`
--

LOCK TABLES `system_menu` WRITE;
/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_mapping`
--

DROP TABLE IF EXISTS `target_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_id` int(11) NOT NULL,
  `items` text,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_unique` (`id`),
  UNIQUE KEY `un_idx_target_id` (`target_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_mapping`
--

LOCK TABLES `target_mapping` WRITE;
/*!40000 ALTER TABLE `target_mapping` DISABLE KEYS */;
INSERT INTO `target_mapping` VALUES (1,3,'[{\"title\":\"媒体：腾格里污染这种事不要总麻烦习近平\",\"link\":\"http://news.sina.com.cn/c/2014-10-04/203630948833.shtml\"},{\"title\":\"李克强访欧前瞻\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/161530946896.shtml\"},{\"title\":\"5大看点\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/151630946844.shtml\"},{\"title\":\"求是:坚持人民当家好制度\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/104630951507.shtml\"},{\"title\":\"制度保障\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135530951809.shtml\"},{\"title\":\"香港部分“占中”者与警方握手后撤离\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950761.shtml\"},{\"title\":\"董建华呼吁占中者撤离以策安全\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/220830950503.shtml\"},{\"title\":\"超千辆出租车货车慢行抗议占中\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/004430950566.shtml\"},{\"title\":\"港警还原87枚催泪弹真相\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/085130951229.shtml\"},{\"title\":\"撒切尔原秘书:占中不切实际\",\"link\":\"http://news.sina.com.cn/w/2014-10-06/110030951555.shtml\"},{\"title\":\"国平评论\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135930951815.shtml\"},{\"title\":\"香港大妈痛诉影响:要吃安眠药\",\"link\":\"http://video.sina.com.cn/news/#1-1-135886086-1\"},{\"title\":\"“担心大叔”视频爆红\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/205630950432.shtml\"},{\"title\":\"全国清理清退超16万吃空饷者及11万辆公车\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950731.shtml\"},{\"title\":\"国庆长假今迎返程高峰 大城市进城路将拥堵\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/070030951136.shtml\"},{\"title\":\"国庆观赛指南\",\"link\":\"http://sports.sina.com.cn/z/2014nationalday/\"},{\"title\":\"美食\",\"link\":\"http://health.sina.com.cn/z/gedimeishi/\"},{\"title\":\"娱乐攻略\",\"link\":\"http://ent.sina.com.cn/f/h/2014guoqinggonglue/\"},{\"title\":\"清华教授:建议国庆只放假1天\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/165730950273.shtml\"}]','2014-10-06 09:37:10'),(2,4,']','2014-10-06 09:37:10'),(3,5,'[{\"title\":\"媒体：腾格里污染这种事不要总麻烦习近平\",\"link\":\"http://news.sina.com.cn/c/2014-10-04/203630948833.shtml\"},{\"title\":\"李克强访欧前瞻\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/161530946896.shtml\"},{\"title\":\"5大看点\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/151630946844.shtml\"},{\"title\":\"求是:坚持人民当家好制度\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/104630951507.shtml\"},{\"title\":\"制度保障\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135530951809.shtml\"},{\"title\":\"香港部分“占中”者与警方握手后撤离\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950761.shtml\"},{\"title\":\"董建华呼吁占中者撤离以策安全\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/220830950503.shtml\"},{\"title\":\"超千辆出租车货车慢行抗议占中\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/004430950566.shtml\"},{\"title\":\"港警还原87枚催泪弹真相\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/085130951229.shtml\"},{\"title\":\"撒切尔原秘书:占中不切实际\",\"link\":\"http://news.sina.com.cn/w/2014-10-06/110030951555.shtml\"},{\"title\":\"国平评论\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135930951815.shtml\"},{\"title\":\"香港大妈痛诉影响:要吃安眠药\",\"link\":\"http://video.sina.com.cn/news/#1-1-135886086-1\"},{\"title\":\"“担心大叔”视频爆红\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/205630950432.shtml\"},{\"title\":\"全国清理清退超16万吃空饷者及11万辆公车\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950731.shtml\"},{\"title\":\"国庆长假今迎返程高峰 大城市进城路将拥堵\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/070030951136.shtml\"},{\"title\":\"国庆观赛指南\",\"link\":\"http://sports.sina.com.cn/z/2014nationalday/\"},{\"title\":\"美食\",\"link\":\"http://health.sina.com.cn/z/gedimeishi/\"},{\"title\":\"娱乐攻略\",\"link\":\"http://ent.sina.com.cn/f/h/2014guoqinggonglue/\"},{\"title\":\"清华教授:建议国庆只放假1天\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/165730950273.shtml\"}]','2014-10-06 09:37:11'),(4,8,'[{\"title\":\"浙江高速公路因堵车现数十米长垃圾带\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/165930952017.shtml\"},{\"title\":\"南昌铁路局:萍乡至南昌段高铁列车脱轨是谣言\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/112130951567.shtml\"},{\"title\":\"海军护航编队组织首次昼夜飞行警戒训练\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/010030950567.shtml\"},{\"title\":\"三亚4名男子裸泳裸晒屡不听劝被拘10日\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/110230951534.shtml\"},{\"title\":\"国家信访局:最大限度将信访事项在阳光下运行\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/101230951424.shtml\"},{\"title\":\"湖北恩施:公车当月违章3次扣公用经费1万元\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/083130951250.shtml\"},{\"title\":\"深圳政府部门在小区无批文占消防通道建餐馆\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/061930950906.shtml\"},{\"title\":\"广东24条高速公路因返程拥堵实施交通管制\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/054130950887.shtml\"},{\"title\":\"辽宁清退超标超配公务用车4163辆\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/025030950782.shtml\"},{\"title\":\"北京燕房线地铁将首次用无人驾驶列车(图)\",\"link\":\"http://news.sina.com.cn/c/p/2014-10-06/023930950768.shtml\"},{\"title\":\"新疆兵团建防暴恐应急队\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950766.shtml\"},{\"title\":\"评论\",\"link\":\"http://news.sina.com.cn/opinion/\"},{\"title\":\"失踪24小时才立案？\",\"link\":\"http://news.sina.com.cn/pl/2014-10-06/023930950759.shtml\"},{\"title\":\"朝鲜新外交攻势目的何在\",\"link\":\"http://news.sina.com.cn/pl/2014-10-06/023930950755.shtml\"},{\"title\":\"人民日报:“占中”是在开民主的倒车\",\"link\":\"http://news.sina.com.cn/pl/2014-10-06/023930950725.shtml\"}]','2014-10-06 09:37:11'),(5,10,'[{\"title\":\"这15个器具看起来很低俗，但它们其实是无辜的\",\"link\":\"http://jandan.net/2014/10/06/innocent-objects.html\"},{\"title\":\"继母与继子结婚，继父出席婚礼\",\"link\":\"http://jandan.net/2014/10/06/win-legal-right.html\"},{\"title\":\"[重口慎入] 阿根廷一农场因诞生人面山羊怪胎而被指责兽奸\",\"link\":\"http://jandan.net/2014/10/06/mutant-goat-born.html\"},{\"title\":\"受够单身了！英国女士跟自己结婚\",\"link\":\"http://jandan.net/2014/10/06/fed-up-being.html\"},{\"title\":\"用充气气球环游百慕大的极限运动员，最终因精神崩溃而中止旅行\",\"link\":\"http://jandan.net/2014/10/06/baluchi-bermuda.html\"},{\"title\":\"西班牙考古学家发现的世界上最老的基督像：他没有胡子\",\"link\":\"http://jandan.net/2014/10/06/unearthed-spain-image.html\"},{\"title\":\"拿什么拯救你，我的大脑\",\"link\":\"http://jandan.net/2014/10/06/save-your-memory.html\"},{\"title\":\"对富人而言，这个世界很公平\",\"link\":\"http://jandan.net/2014/10/06/rich-people.html\"},{\"title\":\"体重280公斤的胖妞觉得自己很美，不想减肥\",\"link\":\"http://jandan.net/2014/10/06/bigger-gainer.html\"},{\"title\":\"“捡零钱”多年的美国老人，把存下的2万多美元都捐给流浪猫\",\"link\":\"http://jandan.net/2014/10/06/collects-spare.html\"},{\"title\":\"没品笑话集：护士给我在床上擦身洗澡时我不由自主地硬了\",\"link\":\"http://jandan.net/2014/10/05/sickipedia-197.html\"},{\"title\":\"创意产品：帮你戒网的电击腕带\",\"link\":\"http://jandan.net/2014/10/05/wristband-shocks.html\"},{\"title\":\"实验室培养的人工铅笔进展顺利，将进入人体测试阶段\",\"link\":\"http://jandan.net/2014/10/05/penises-test.html\"},{\"title\":\"从太空看到的秋色\",\"link\":\"http://jandan.net/2014/10/05/fall-colors-space.html\"},{\"title\":\"那啥时发生的尴尬事\",\"link\":\"http://jandan.net/2014/10/05/time-gone-wrong.html\"},{\"title\":\"给孤身者的抱抱椅\",\"link\":\"http://jandan.net/2014/10/05/hugging-chair.html\"},{\"title\":\"只因朋友在网上跟自己女朋友打招呼，就把对方打死\",\"link\":\"http://jandan.net/2014/10/05/killing-poked.html\"},{\"title\":\"地球最初的氧气可能并非来自植物\",\"link\":\"http://jandan.net/2014/10/05/oxygen-made.html\"},{\"title\":\"幼婴儿接受抗生素治疗后更易肥胖\",\"link\":\"http://jandan.net/2014/10/05/given-antibiotics.html\"},{\"title\":\"餐馆心理学：坐什么位置\",\"link\":\"http://jandan.net/2014/10/05/sit-in-restaurants.html\"},{\"title\":\"世界首个从移植子宫中孕育的宝宝诞生\",\"link\":\"http://jandan.net/2014/10/05/transplant-boy.html\"},{\"title\":\"健身不仅长肌肉，还长脑子？\",\"link\":\"http://jandan.net/2014/10/05/helps-memory.html\"},{\"title\":\"日本一动物园终止历时四年的鬣狗生育计划，因为他们终于发现这两只都是公的\",\"link\":\"http://jandan.net/2014/10/05/two-spotted-mate.html\"},{\"title\":\"新材料或许能让潜水员无需氧气瓶\",\"link\":\"http://jandan.net/2014/10/05/crystal-breathe.html\"},{\"title\":\"美国人的烦恼：“为什么我买不到想要的摩托车”\",\"link\":\"http://jandan.net/2014/10/05/the-bike.html\"},{\"title\":\"好莱坞报告：影星片酬揭秘\",\"link\":\"http://jandan.net/2014/10/04/hollywood-salaries.html\"},{\"title\":\"现代的鸡越来越大，为什么会这样？\",\"link\":\"http://jandan.net/2014/10/04/modern-chickens.html\"},{\"title\":\"美国保留本应销毁的核武器，理由是用于保卫“地球安全”\",\"link\":\"http://jandan.net/2014/10/04/nuclear-weapons.html\"},{\"title\":\"动物们怎么High\",\"link\":\"http://jandan.net/2014/10/04/get-high.html\"},{\"title\":\"时间，时间\",\"link\":\"http://jandan.net/2014/10/04/time-facts.html\"},{\"title\":\"WHAT IF: 物质的地球，反物质的宇宙\",\"link\":\"http://jandan.net/2014/10/04/whatif-114.html\"},{\"title\":\"阿联酋空姐的美丽秘诀\",\"link\":\"http://jandan.net/2014/10/04/reveal-secrets.html\"},{\"title\":\"Quora：脑洞大开的战争诡计\",\"link\":\"http://jandan.net/2014/10/04/mind-blowing-tricks.html\"},{\"title\":\"哥伦比亚女子用土豆避孕，奈何土豆竟然在阴道里发芽\",\"link\":\"http://jandan.net/2014/10/04/grow-roots.html\"},{\"title\":\"日本人引以为荣的10件事\",\"link\":\"http://jandan.net/2014/10/04/be-japanese.html\"},{\"title\":\"美帝水深火热：两位高中女教师与学生3P，被捕\",\"link\":\"http://jandan.net/2014/10/04/having-a-threesome.html\"},{\"title\":\"自带室内泳池、水族馆甚至还有快艇库的超豪华游艇\",\"link\":\"http://jandan.net/2014/10/04/jade-mega-yacht.html\"},{\"title\":\"神奇瞬间：巨大的驼背鲸跃出海面\",\"link\":\"http://jandan.net/2014/10/04/giant-flying-fish.html\"},{\"title\":\"黑人流害死少女，男护士被判处绞刑\",\"link\":\"http://jandan.net/2014/10/03/abortion-kills-nurse.html\"},{\"title\":\"重量级美女的网上约会：“我的体型吸引了奇怪的男人”\",\"link\":\"http://jandan.net/2014/10/03/weight-size-attracts.html\"},{\"title\":\"这种“偷”车方式，把车主郁闷坏了\",\"link\":\"http://jandan.net/2014/10/03/carjacker-steals.html\"},{\"title\":\"STAR CITIZEN(星际公民)，史上最成功的众筹项目\",\"link\":\"http://jandan.net/2014/10/03/crowdfunding-project.html\"},{\"title\":\"流浪汉必备：可以穿在身上的被子\",\"link\":\"http://jandan.net/2014/10/03/wearable-bed-futon.html\"},{\"title\":\"因含致癌成分，意大利突袭缴没两千万根来自中国的橡皮圈\",\"link\":\"http://jandan.net/2014/10/03/deadly-chemicals.html\"},{\"title\":\"在精子银行选购了一位金发蓝眼的白人精子，却生出黑人小孩\",\"link\":\"http://jandan.net/2014/10/03/black-sperm.html\"},{\"title\":\"为什么全世界还有44亿人无法上网？\",\"link\":\"http://jandan.net/2014/10/03/unconnected-people.html\"},{\"title\":\"数百万孟加拉穆斯林爬火车回家过节，一男子不慎掉下火车身首异处\",\"link\":\"http://jandan.net/2014/10/03/make-way-home.html\"},{\"title\":\"是幻觉：人的皮肤并不能感觉到“湿润”，只是大脑的想象\",\"link\":\"http://jandan.net/2014/10/03/feeling-wetness.html\"},{\"title\":\"不玩了：如果民主国家不再申办奥运会\",\"link\":\"http://jandan.net/2014/10/03/pay-for-olympics.html\"},{\"title\":\"是胶囊也是注射器，新的给药方式从肠道内注射药物\",\"link\":\"http://jandan.net/2014/10/03/capsule-microneedles-mit.html\"},{\"title\":\"社会难题：越长越大的宠物猪\",\"link\":\"http://jandan.net/2014/10/03/miniature-pigs.html\"},{\"title\":\"防弹玻璃这种说法对么？\",\"link\":\"http://jandan.net/2014/10/03/bullet-resistant-glass.html\"},{\"title\":\"日本另类相亲节目，不看脸(误)，身材是亮点\",\"link\":\"http://jandan.net/2014/10/03/reality-show.html\"},{\"title\":\"Quora精选：好男人那么少，女青年们怎么办\",\"link\":\"http://jandan.net/2014/10/03/no-good-men.html\"},{\"title\":\"神经质的女生，老了以后更容易得老年痴呆\",\"link\":\"http://jandan.net/2014/10/03/suffer-alzheimer.html\"},{\"title\":\"日本庆祝子弹列车(新干线)运行50周年\",\"link\":\"http://jandan.net/2014/10/02/bullet-trains.html\"},{\"title\":\"乘坐秒杀头等舱的顶级套间舱是什么感觉[多图杀流量]\",\"link\":\"http://jandan.net/2014/10/02/suites-class.html\"},{\"title\":\"健康专家建议：胖学生应该站着上课\",\"link\":\"http://jandan.net/2014/10/02/standing-desks.html\"},{\"title\":\"爷有钱：俄罗斯巨富在伦敦俱乐部玩三小时，花掉200多万英镑\",\"link\":\"http://jandan.net/2014/10/02/just-three-hours.html\"},{\"title\":\"Tikker：这款表可以倒计时你的生命\",\"link\":\"http://jandan.net/2014/10/02/tikker-2.html\"},{\"title\":\"(虽然专利过期可能会很便宜)研究发现伟哥可能导致失明\",\"link\":\"http://jandan.net/2014/10/02/viagra-blindness.html\"},{\"title\":\"那些奇怪的动物\",\"link\":\"http://jandan.net/2014/10/02/weirdest-animals.html\"},{\"title\":\"闻不出食物的气味？可能命不久矣\",\"link\":\"http://jandan.net/2014/10/02/no-longer-smell.html\"},{\"title\":\"家附近有风力发电厂？它的低频噪音可能会让人耳聋\",\"link\":\"http://jandan.net/2014/10/02/damage-inner-ear.html\"},{\"title\":\"民间奇人之：舔一舔，治眼疾\",\"link\":\"http://jandan.net/2014/10/02/bosnian-woman.html\"},{\"title\":\"被猎人射伤的黑熊躺地上装死，待猎人近身查看时将其重伤\",\"link\":\"http://jandan.net/2014/10/02/black-bear-shooting.html\"},{\"title\":\"为迎接万圣节，加州农场主种鬼脸南瓜\",\"link\":\"http://jandan.net/2014/10/02/frankenstein-pumpkins.html\"},{\"title\":\"2014搞笑诺贝尔奖，连颁奖仪式都很逗\",\"link\":\"http://jandan.net/2014/10/01/ig-nobel-2014.html\"},{\"title\":\"Quora精选：我身边的同事都很优秀，我该怎么办？\",\"link\":\"http://jandan.net/2014/10/01/be-an-average.html\"},{\"title\":\"啤酒里有能让人更聪明的成分？科学家说那你得每天喝2000升才行\",\"link\":\"http://jandan.net/2014/10/01/beer-smarter.html\"},{\"title\":\"世界最老的小丑，以98岁高龄去世\",\"link\":\"http://jandan.net/2014/10/01/oldest-clown.html\"},{\"title\":\"印度笨狗误入热沥青后无法动弹，救援组织花2天时间清洗\",\"link\":\"http://jandan.net/2014/10/01/slipped-solidified.html\"},{\"title\":\"身残志坚：全身遍布可怕泡状肿瘤的独居老奶奶，坦然面对人生\",\"link\":\"http://jandan.net/2014/10/01/grandmother-bubble.html\"},{\"title\":\"英国小女孩成为首个3D打印的“钢铁侠”仿生手的使用者\",\"link\":\"http://jandan.net/2014/10/01/iron-man-style.html\"},{\"title\":\"热爱充气娃娃的夫妻\",\"link\":\"http://jandan.net/2014/10/01/sex-dolls-relationship.html\"},{\"title\":\"语言学家眼中的食物史\",\"link\":\"http://jandan.net/2014/10/01/history-of-the-foods.html\"},{\"title\":\"为吸引回头客，餐厅老板在面中加入罂粟壳\",\"link\":\"http://jandan.net/2014/10/01/noodles-with-opium.html\"},{\"title\":\"另类视角：红酒里的益生菌\",\"link\":\"http://jandan.net/2014/10/01/bacteria-probiotics.html\"},{\"title\":\"水深火热：一名携带管制刀具的男子成功入侵白宫行政大楼，被捕\",\"link\":\"http://jandan.net/2014/10/01/into-white-house.html\"},{\"title\":\"Quora精选：为什么很多人都以为自己是天才？\",\"link\":\"http://jandan.net/2014/10/01/many-geniuses.html\"},{\"title\":\"大曝光：飞机上的野蛮人\",\"link\":\"http://jandan.net/2014/10/01/flight-shaming.html\"},{\"title\":\"朝鲜的网络什么样？\",\"link\":\"http://jandan.net/2014/09/30/north-koreas-internet.html\"},{\"title\":\"睾丸癌康复患者带巨球穿越美国宣传睾丸癌\",\"link\":\"http://jandan.net/2014/09/30/cancer-survivor.html\"},{\"title\":\"Firefox 或整合 Tor？\",\"link\":\"http://jandan.net/2014/09/30/tor-mozilla-integration.html\"},{\"title\":\"关于鸟类的十件事\",\"link\":\"http://jandan.net/2014/09/30/facts-about-birds.html\"},{\"title\":\"跟莎翁学骂人\",\"link\":\"http://jandan.net/2014/09/30/shakespeare-insults.html\"},{\"title\":\"美人鱼的传说可能来自真实的医学案例\",\"link\":\"http://jandan.net/2014/09/30/real-life-mermaids.html\"},{\"title\":\"熊孩子在苹果店掰弯新iPhone\",\"link\":\"http://jandan.net/2014/09/30/kids-bend-iphone.html\"},{\"title\":\"模仿八目鳗口器的概念挖掘机\",\"link\":\"http://jandan.net/2014/09/30/futuristic-excavator-concepts.html\"},{\"title\":\"丧心病狂：东京出现超巨型冰淇淋\",\"link\":\"http://jandan.net/2014/09/30/biggest-ice-cream.html\"},{\"title\":\"埃及男士刷新人类潜水记录：水下318米\",\"link\":\"http://jandan.net/2014/09/30/deepest-scuba.html\"},{\"title\":\"为什么人类不像动物那样一脸毛？因为我们需要看“脸色”\",\"link\":\"http://jandan.net/2014/09/30/hairy-faces.html\"},{\"title\":\"因罕见病开启吃货模式，3岁男孩体重69公斤\",\"link\":\"http://jandan.net/2014/09/30/stop-eating.html\"},{\"title\":\"玩GTA让我学到了人生中宝贵的一课\",\"link\":\"http://jandan.net/2014/09/29/gta-life-lesson.html\"},{\"title\":\"Quora精选：有哪些只有你自己超爱吃的零食？\",\"link\":\"http://jandan.net/2014/09/29/weirdest-snacks.html\"},{\"title\":\"世界首批转基因宝宝已长大，即将成年\",\"link\":\"http://jandan.net/2014/09/29/modified-babies.html\"},{\"title\":\"知识库太庞大压力过大让医生的自杀率居高不下\",\"link\":\"http://jandan.net/2014/09/29/doctors-high-suicide-rate.html\"},{\"title\":\"历史上被笑死的人\",\"link\":\"http://jandan.net/2014/09/29/death-of-laughter.html\"},{\"title\":\"什么东西价钱很贵，但是长期看来其实很便宜？\",\"link\":\"http://jandan.net/2014/09/29/expensive-actually-inexpensive.html\"},{\"title\":\"摩洛哥无脸小男孩得到救助，即将做修复手术\",\"link\":\"http://jandan.net/2014/09/29/heartwarming-story.html\"}]','2014-10-06 09:37:13'),(6,11,'[{\"title\":\"惠普计划拆分为二：PC或自立门户\",\"link\":\"http://tech.sina.com.cn/it/2014-10-06/01599668438.shtml\"},{\"title\":\"走回3年前老路\",\"link\":\"http://tech.sina.com.cn/it/2014-10-06/09439668682.shtml\"},{\"title\":\"超IBM成全球第一大服务器厂商\",\"link\":\"http://tech.sina.com.cn/it/2014-08-28/09589582136.shtml\"},{\"title\":\"诺贝尔奖今起揭晓：4位华裔科学家成热门(图)\",\"link\":\"http://tech.sina.com.cn/d/2014-10-06/10179668744.shtml\"},{\"title\":\"新款iPad Air信息汇总：或仍配备9.7寸屏\",\"link\":\"http://tech.sina.com.cn/it/2014-10-06/08369668644.shtml\"},{\"title\":\"粉色iPhone 6曝光：全球限量200台(组图)\",\"link\":\"http://tech.sina.com.cn/t/2014-10-06/08079668636.shtml\"},{\"title\":\"特斯拉神秘新车曝光：仅为Model S升级版(图)\",\"link\":\"http://tech.sina.com.cn/it/2014-10-06/09269668674.shtml\"},{\"title\":\"三星1年需向微软支付10亿美元Android专利费\",\"link\":\"http://tech.sina.com.cn/t/2014-10-06/11179668808.shtml\"},{\"title\":\"33岁网游企业总裁因过度劳累突发心脏病过世\",\"link\":\"http://tech.sina.com.cn/it/2014-10-06/06599668606.shtml\"},{\"title\":\"苹果更新特征库：预防最新后门软件\",\"link\":\"http://tech.sina.com.cn/mobile/n/apple/2014-10-06/09449668684.shtml\"}]','2014-10-06 09:37:13'),(7,13,'[{\"title\":\"房贷新政下市场转风:开发商收紧优惠\",\"link\":\"http://finance.sina.com.cn/china/20141006/061920470664.shtml\"},{\"title\":\"广州多个楼盘放宽限购“赌政策”\",\"link\":\"http://finance.sina.com.cn/china/20141006/075420470870.shtml\"},{\"title\":\"新华社:楼市将较长时间盘整\",\"link\":\"http://finance.sina.com.cn/china/20141005/110820469542.shtml\"},{\"title\":\"央行：继续实施稳健的货币政策\",\"link\":\"http://finance.sina.com.cn/china/jrxw/20141006/004820470226.shtml\"},{\"title\":\"保持适度流动性\",\"link\":\"http://finance.sina.com.cn/china/jrxw/20141005/130520469705.shtml\"},{\"title\":\"进一步推进人民币汇改\",\"link\":\"http://finance.sina.com.cn/china/20141006/021920470412.shtml\"},{\"title\":\"大幅降准降息可能性不大\",\"link\":\"http://finance.sina.com.cn/china/jrxw/20141006/004820470226.shtml\"},{\"title\":\"股票问诊:\",\"link\":\"http://licaishi.sina.com.cn/web/askList\"},{\"title\":\"葛洲坝复牌后涨停 走还是留\",\"link\":\"http://licaishi.sina.com.cn/web/searchList?s=葛洲坝\"},{\"title\":\"大赛:冠军收益36% 23人超20%\",\"link\":\"http://finance.sina.com.cn/focus/tgds3/\"},{\"title\":\"订阅抓涨停\",\"link\":\"http://finance.sina.com.cn/stock/dszb/20140930/150220455154.shtml\"},{\"title\":\"亿元操盘金寻高手\",\"link\":\"http://finance.sina.com.cn/stock/dsgg/20140918/194820345592.shtml\"},{\"title\":\"人民日报称改革最大受益者是人民：促进社会公平正义 \",\"link\":\"http://finance.sina.com.cn/china/20141006/023320470417.shtml\"},{\"title\":\"京津新城别墅缺交通等配套少人问津 实用性差成鬼城\",\"link\":\"http://finance.sina.com.cn/china/20141006/030620470515.shtml\"},{\"title\":\"企业有无不良记录一查便知 一批涉民生新法规施行\",\"link\":\"http://finance.sina.com.cn/china/20141006/051620470594.shtml  \"},{\"title\":\"国务院批准天津港口岸新一轮扩大对外开放计划\",\"link\":\"http://finance.sina.com.cn/china/dfjj/20141005/200520470076.shtml\"},{\"title\":\"鼓浪屿轮渡对外地游客涨价：从8元提高到最少30元\",\"link\":\"http://finance.sina.com.cn/china/dfjj/20141006/005520470228.shtml\"},{\"title\":\"北京527公里轨道交通网年底成型 地铁线将达18条\",\"link\":\"http://finance.sina.com.cn/china/dfjj/20141006/071120470776.shtml\"},{\"title\":\"景区门票为何难降：毛利率可超60% 比房地产还暴利\",\"link\":\"http://finance.sina.com.cn/china/20141006/072220470796.shtml \"},{\"title\":\"大摩:全球投资者过度悲观\",\"link\":\"http://finance.sina.com.cn/stock/usstock/economics/20141006/120020471536.shtml\"},{\"title\":\"美元大涨能否救世界经济？\",\"link\":\"http://finance.sina.com.cn/stock/usstock/economics/20141006/170220472099.shtml\"},{\"title\":\"黄金价格暴跌创56个月新低 中国大妈抢金被套牢\",\"link\":\"http://finance.sina.com.cn/money/nmetal/20141006/072320470811.shtml\"},{\"title\":\"王亚伟重仓股疯狂飙涨 布局9股期待第四季度\",\"link\":\"http://finance.sina.com.cn/money/fund/20141006/141120471830.shtml \"},{\"title\":\"全国清理清退超11万辆公车及16万余吃空饷人员\",\"link\":\"http://finance.sina.com.cn/china/20141006/023320470425.shtml\"},{\"title\":\"上海两家丽池会所突停业 会员卡内资金面临打水漂\",\"link\":\"http://finance.sina.com.cn/chanjing/gsnews/20141006/012120470364.shtml\"},{\"title\":\"蔡澜带你去湖州\",\"link\":\"http://act.zj.sina.com.cn/6154/mobile\"}]','2014-10-06 09:37:14'),(8,14,'[{\"title\":\"媒体：腾格里污染这种事不要总麻烦习近平\",\"link\":\"http://news.sina.com.cn/c/2014-10-04/203630948833.shtml\"},{\"title\":\"李克强访欧前瞻\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/161530946896.shtml\"},{\"title\":\"5大看点\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/151630946844.shtml\"},{\"title\":\"求是:坚持人民当家好制度\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/104630951507.shtml\"},{\"title\":\"制度保障\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135530951809.shtml\"},{\"title\":\"香港部分“占中”者与警方握手后撤离\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950761.shtml\"},{\"title\":\"董建华呼吁占中者撤离以策安全\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/220830950503.shtml\"},{\"title\":\"超千辆出租车货车慢行抗议占中\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/004430950566.shtml\"},{\"title\":\"港警还原87枚催泪弹真相\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/085130951229.shtml\"},{\"title\":\"撒切尔原秘书:占中不切实际\",\"link\":\"http://news.sina.com.cn/w/2014-10-06/110030951555.shtml\"},{\"title\":\"国平评论\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135930951815.shtml\"},{\"title\":\"香港大妈痛诉影响:要吃安眠药\",\"link\":\"http://video.sina.com.cn/news/#1-1-135886086-1\"},{\"title\":\"“担心大叔”视频爆红\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/205630950432.shtml\"},{\"title\":\"全国清理清退超16万吃空饷者及11万辆公车\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950731.shtml\"},{\"title\":\"国庆长假今迎返程高峰 大城市进城路将拥堵\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/070030951136.shtml\"},{\"title\":\"国庆观赛指南\",\"link\":\"http://sports.sina.com.cn/z/2014nationalday/\"},{\"title\":\"美食\",\"link\":\"http://health.sina.com.cn/z/gedimeishi/\"},{\"title\":\"娱乐攻略\",\"link\":\"http://ent.sina.com.cn/f/h/2014guoqinggonglue/\"},{\"title\":\"清华教授:建议国庆只放假1天\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/165730950273.shtml\"}]','2014-10-06 09:37:14'),(9,19,'[{\"title\":\"媒体：腾格里污染这种事不要总麻烦习近平\",\"link\":\"http://news.sina.com.cn/c/2014-10-04/203630948833.shtml\"},{\"title\":\"李克强访欧前瞻\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/161530946896.shtml\"},{\"title\":\"5大看点\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/151630946844.shtml\"},{\"title\":\"求是:坚持人民当家好制度\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/104630951507.shtml\"},{\"title\":\"制度保障\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135530951809.shtml\"},{\"title\":\"香港部分“占中”者与警方握手后撤离\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950761.shtml\"},{\"title\":\"董建华呼吁占中者撤离以策安全\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/220830950503.shtml\"},{\"title\":\"超千辆出租车货车慢行抗议占中\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/004430950566.shtml\"},{\"title\":\"港警还原87枚催泪弹真相\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/085130951229.shtml\"},{\"title\":\"撒切尔原秘书:占中不切实际\",\"link\":\"http://news.sina.com.cn/w/2014-10-06/110030951555.shtml\"},{\"title\":\"国平评论\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135930951815.shtml\"},{\"title\":\"香港大妈痛诉影响:要吃安眠药\",\"link\":\"http://video.sina.com.cn/news/#1-1-135886086-1\"},{\"title\":\"“担心大叔”视频爆红\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/205630950432.shtml\"},{\"title\":\"全国清理清退超16万吃空饷者及11万辆公车\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950731.shtml\"},{\"title\":\"国庆长假今迎返程高峰 大城市进城路将拥堵\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/070030951136.shtml\"},{\"title\":\"国庆观赛指南\",\"link\":\"http://sports.sina.com.cn/z/2014nationalday/\"},{\"title\":\"美食\",\"link\":\"http://health.sina.com.cn/z/gedimeishi/\"},{\"title\":\"娱乐攻略\",\"link\":\"http://ent.sina.com.cn/f/h/2014guoqinggonglue/\"},{\"title\":\"清华教授:建议国庆只放假1天\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/165730950273.shtml\"}]','2014-10-06 09:37:14'),(10,20,'[{\"title\":\"媒体：腾格里污染这种事不要总麻烦习近平\",\"link\":\"http://news.sina.com.cn/c/2014-10-04/203630948833.shtml\"},{\"title\":\"李克强访欧前瞻\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/161530946896.shtml\"},{\"title\":\"5大看点\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/151630946844.shtml\"},{\"title\":\"求是:坚持人民当家好制度\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/104630951507.shtml\"},{\"title\":\"制度保障\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135530951809.shtml\"},{\"title\":\"香港部分“占中”者与警方握手后撤离\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950761.shtml\"},{\"title\":\"董建华呼吁占中者撤离以策安全\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/220830950503.shtml\"},{\"title\":\"超千辆出租车货车慢行抗议占中\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/004430950566.shtml\"},{\"title\":\"港警还原87枚催泪弹真相\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/085130951229.shtml\"},{\"title\":\"撒切尔原秘书:占中不切实际\",\"link\":\"http://news.sina.com.cn/w/2014-10-06/110030951555.shtml\"},{\"title\":\"国平评论\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135930951815.shtml\"},{\"title\":\"香港大妈痛诉影响:要吃安眠药\",\"link\":\"http://video.sina.com.cn/news/#1-1-135886086-1\"},{\"title\":\"“担心大叔”视频爆红\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/205630950432.shtml\"},{\"title\":\"全国清理清退超16万吃空饷者及11万辆公车\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950731.shtml\"},{\"title\":\"国庆长假今迎返程高峰 大城市进城路将拥堵\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/070030951136.shtml\"},{\"title\":\"国庆观赛指南\",\"link\":\"http://sports.sina.com.cn/z/2014nationalday/\"},{\"title\":\"美食\",\"link\":\"http://health.sina.com.cn/z/gedimeishi/\"},{\"title\":\"娱乐攻略\",\"link\":\"http://ent.sina.com.cn/f/h/2014guoqinggonglue/\"},{\"title\":\"清华教授:建议国庆只放假1天\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/165730950273.shtml\"}]','2014-10-06 09:37:15'),(11,22,'[{\"title\":\"媒体：腾格里污染这种事不要总麻烦习近平\",\"link\":\"http://news.sina.com.cn/c/2014-10-04/203630948833.shtml\"},{\"title\":\"李克强访欧前瞻\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/161530946896.shtml\"},{\"title\":\"5大看点\",\"link\":\"http://news.sina.com.cn/c/2014-10-03/151630946844.shtml\"},{\"title\":\"求是:坚持人民当家好制度\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/104630951507.shtml\"},{\"title\":\"制度保障\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135530951809.shtml\"},{\"title\":\"香港部分“占中”者与警方握手后撤离\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950761.shtml\"},{\"title\":\"董建华呼吁占中者撤离以策安全\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/220830950503.shtml\"},{\"title\":\"超千辆出租车货车慢行抗议占中\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/004430950566.shtml\"},{\"title\":\"港警还原87枚催泪弹真相\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/085130951229.shtml\"},{\"title\":\"撒切尔原秘书:占中不切实际\",\"link\":\"http://news.sina.com.cn/w/2014-10-06/110030951555.shtml\"},{\"title\":\"国平评论\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/135930951815.shtml\"},{\"title\":\"香港大妈痛诉影响:要吃安眠药\",\"link\":\"http://video.sina.com.cn/news/#1-1-135886086-1\"},{\"title\":\"“担心大叔”视频爆红\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/205630950432.shtml\"},{\"title\":\"全国清理清退超16万吃空饷者及11万辆公车\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/023930950731.shtml\"},{\"title\":\"国庆长假今迎返程高峰 大城市进城路将拥堵\",\"link\":\"http://news.sina.com.cn/c/2014-10-06/070030951136.shtml\"},{\"title\":\"国庆观赛指南\",\"link\":\"http://sports.sina.com.cn/z/2014nationalday/\"},{\"title\":\"美食\",\"link\":\"http://health.sina.com.cn/z/gedimeishi/\"},{\"title\":\"娱乐攻略\",\"link\":\"http://ent.sina.com.cn/f/h/2014guoqinggonglue/\"},{\"title\":\"清华教授:建议国庆只放假1天\",\"link\":\"http://news.sina.com.cn/c/2014-10-05/165730950273.shtml\"}]','2014-10-06 09:37:15');
/*!40000 ALTER TABLE `target_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_point`
--

DROP TABLE IF EXISTS `target_point`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_point` (
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
  KEY `fk_target_point_user` (`user_id`),
  KEY `idx_url` (`url`(255)),
  KEY `idx_url__rel_xpath` (`url`(255),`rel_xpath`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_point`
--

LOCK TABLES `target_point` WRITE;
/*!40000 ALTER TABLE `target_point` DISABLE KEYS */;
INSERT INTO `target_point` VALUES (1,1,'36氪','http://www.36kr.com/feed',NULL,NULL,NULL,NULL,1,'REGULAR'),(2,1,'CSDM 业界','http://articles.csdn.net/api/rss.php?tid=1008',NULL,NULL,NULL,NULL,1,'REGULAR'),(3,1,'新浪要闻','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[5]/DIV[8]/DIV[2]/DIV[1]/DIV[2]','//*[@id=\"syncad_1\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR'),(4,1,'腾讯要闻','http://www.qq.com/','/HTML/BODY[1]/DIV[7]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/DIV[1]/UL[2]','//*[@id=\"news2\"]',NULL,'a537fc2402bd2fc80298385f3cc72ae7',0,'REGULAR'),(5,4,'新浪要闻','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[6]/DIV[8]/DIV[2]/DIV[1]/DIV[2]','//*[@id=\"syncad_1\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR'),(7,6,'36kr','http://www.36kr.com/feed/',NULL,NULL,NULL,NULL,1,'REGULAR'),(8,4,'新浪内地','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[6]/DIV[9]/DIV[2]/DIV[2]/DIV[1]/UL[1]','//*[@id=\"blk_gnxw_011\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR'),(10,1,'煎蛋最新更新','http://jandan.net/new','/HTML/BODY[1]/DIV[1]/DIV[2]/DIV[1]','//*[@id=\"content\"]',NULL,'119ac9ce031b84cb33d9f398ced471e5',0,'REGULAR'),(11,4,'新浪科技要闻','http://tech.sina.com.cn/','/HTML/BODY[1]/DIV[10]/DIV[1]/DIV[1]/DIV[1]/DIV[1]/DIV[2]/DIV[1]/DIV[1]/DIV[1]','//*[@id=\"impNews1\"]',NULL,'ed8929e693a5edc31b7b25b57c98bdce',0,'REGULAR'),(12,4,'36氪','http://www.36kr.com/feed',NULL,NULL,NULL,NULL,1,'REGULAR'),(13,4,'新浪财经','http://finance.sina.com.cn/','/HTML/BODY[1]/DIV[4]/DIV[6]/DIV[2]/DIV[1]/DIV[3]','//*[@id=\"fin_tabs0_c0\"]',NULL,'310461245a396cfa9f86a1f592baa554',0,'REGULAR'),(14,4,'新浪','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[9]/DIV[8]/DIV[2]/DIV[1]/DIV[2]','//*[@id=\"syncad_1\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR'),(15,4,'36kr','http://www.36kr.com/feed',NULL,NULL,NULL,NULL,1,'REGULAR'),(16,8,'36氪','http://www.36kr.com/feed',NULL,NULL,NULL,NULL,1,'REGULAR'),(18,8,'爱范儿','http://www.ifanr.com/feed',NULL,NULL,NULL,NULL,1,'REGULAR'),(19,4,'新浪要闻','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[6]/DIV[8]/DIV[2]/DIV[1]/DIV[2]','//*[@id=\"syncad_1\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR'),(20,8,'新浪要闻','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[6]/DIV[8]/DIV[2]/DIV[1]/DIV[2]','//*[@id=\"syncad_1\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR'),(22,12,'新浪要闻','http://news.sina.com.cn/','/HTML/BODY[1]/DIV[9]/DIV[8]/DIV[2]/DIV[1]/DIV[2]','//*[@id=\"syncad_1\"]',NULL,'a78993dfb5af54489f4c75e4373631a6',0,'REGULAR');
/*!40000 ALTER TABLE `target_point` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (4,'gklifg','96e79218965eb72c92a549dd5a330112','gklifg@126.com','MALE','img/auto_photo.png',NULL,'REGULAR','YDPhtgInfyOQa6Xb7m4eH543YC1SqipI29LL/YZgJlppBbvXoZJVpo21APSMzIc2Zw9d+pbG1ck=','2014-02-21'),(6,'hr','d2c5f9f70b78877f0ffd66bca54bbc1e','hr@yidian-inc.com','MALE','img/auto_photo.png',NULL,'REGULAR','/lB4v97X+WRKu33r0bjE5hc7WCefzeWYrQwJU0KDoGOdXDQIXMqP+tSK6wmKE1BeUyPPWEzGATQ=','2014-02-24'),(7,'releasemj','e10adc3949ba59abbe56e057f20f883e','releasemj@qq.com','MALE','img/auto_photo.png',NULL,'REGULAR','/lB4v97X+WRAgXGa4A6Z1bQ+byjKecC+8iuXwWGMWhGqOUBLcN/crvXKLrCiikD6KQP1rjxGW4E=','2014-02-24'),(8,'gklifg','3b774fe4f5d86e9b112789a2708e1e91','gklifg@163.com','MALE','img/auto_photo.png',NULL,'REGULAR','/lB4v97X+WSUIhpI7tqgbbgq83FdIQvWNc6iTtiJQ9F5PrPfkjmBGPn+ge4t15KSz2FBdzgd7eA=','2014-06-05'),(10,'sklxz','3b774fe4f5d86e9b112789a2708e1e91','sklxz@qq.com','MALE','img/auto_photo.png',NULL,'REGULAR','/lB4v97X+WR6kRg66YKmF8+tEuiQ1Xp/ogoQt9KFCAuhdH3dUemKWr6iiCmSSiNx','2014-06-05'),(12,'tjgdxs','61aefd05e32f5b38c356b4fe5530cfd7','tjgdxs@qq.com','MALE','img/auto_photo.png',NULL,'REGULAR','/lB4v97X+WTWY/lAKJW2ejAqZT/CKjYskixroExcd1nLJGi3tfRd6rrU6pf8nzawK4MoXezon0o=','2014-06-05'),(14,'david','9925c4f0b140937b09ee715eeefef699','david@lagou.com','MALE','img/auto_photo.png',NULL,'REGULAR','/lB4v97X+WTlXW0jf45uf3UGNwsZOP/a2yMuAPotgS+cfGVI+2eiwiqyOpmh58qnzQbKQHt7xqo=','2014-06-07');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xpath_maping`
--

DROP TABLE IF EXISTS `xpath_maping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xpath_maping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(512) DEFAULT NULL,
  `xpath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xpath_maping`
--

LOCK TABLES `xpath_maping` WRITE;
/*!40000 ALTER TABLE `xpath_maping` DISABLE KEYS */;
/*!40000 ALTER TABLE `xpath_maping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-12 16:36:25
