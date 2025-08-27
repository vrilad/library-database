-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: library_tickets
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `b_id` int NOT NULL,
  `b_name` varchar(50) NOT NULL,
  `b_author` varchar(35) NOT NULL,
  `b_genre` varchar(10) NOT NULL,
  `b_quantity` int DEFAULT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1001,'Война и мир','Лев Толстой','Роман',2),(1002,'Преступление и наказание','Фёдор Достоевский','Роман',3),(1003,'Над пропастью во ржи','Джером Сэлинджер','Роман',3),(1004,'Евгений Онегин','Александр Пушкин','Поэма',4),(1005,'Отцы и дети','Иван Тургенев','Роман',3),(1006,'Анна Каренина','Лев Толстой','Роман',3),(1007,'Старик и море','Эрнест Хемингуэй','Роман',3),(1008,'Великий Гэтсби','Фрэнсис Скотт Фицджеральд','Роман',3),(1009,'Гамлет','Уильям Шекспир','Пьеса',3),(1010,'Герой нашего времени','Михаил Лермонтов','Роман',3);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `given_books`
--

DROP TABLE IF EXISTS `given_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `given_books` (
  `g_id` int NOT NULL,
  `g_num` int NOT NULL,
  `g_given` date NOT NULL,
  `g_return` date DEFAULT NULL,
  PRIMARY KEY (`g_id`,`g_num`),
  KEY `FK_given_books_g_num` (`g_num`),
  CONSTRAINT `FK_given_books_g_id` FOREIGN KEY (`g_id`) REFERENCES `library_ticket` (`l_id`),
  CONSTRAINT `FK_given_books_g_num` FOREIGN KEY (`g_num`) REFERENCES `stock_books` (`s_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `given_books`
--

LOCK TABLES `given_books` WRITE;
/*!40000 ALTER TABLE `given_books` DISABLE KEYS */;
INSERT INTO `given_books` VALUES (1001,100022,'2024-02-03','2024-02-25'),(1001,100031,'2024-02-05','2024-03-15'),(1002,100001,'2024-03-23',NULL),(1002,100003,'2024-02-21','2024-03-10'),(1002,100026,'2024-02-11','2024-02-28'),(1003,100010,'2024-02-22','2024-03-25'),(1004,100011,'2024-02-25','2024-03-15'),(1004,100025,'2024-02-28','2024-03-11'),(1005,100012,'2024-03-03','2024-03-27'),(1005,100021,'2024-03-03','2024-04-15'),(1006,100030,'2024-03-05','2024-03-20'),(1007,100001,'2024-03-06','2024-03-20'),(1007,100004,'2024-04-04','2024-04-29'),(1008,100007,'2024-03-07','2024-03-17'),(1009,100008,'2024-03-13','2024-04-01'),(1010,100009,'2024-03-17','2024-04-02'),(1010,100017,'2024-03-21','2024-04-02'),(1011,100015,'2024-03-22','2024-04-10');
/*!40000 ALTER TABLE `given_books` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_given_books_check_status` BEFORE INSERT ON `given_books` FOR EACH ROW begin
    declare book_status varchar(25);
    select s_stat into book_status
    from stock_books
    where s_num = new.g_num;
    if book_status = '�뤠��' then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '�஢���� �������� ����� �����. �� ����� 㦥 �뤠�� ��㣮�� ��⥫�.';    
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_insert_given_books_check_limit` BEFORE INSERT ON `given_books` FOR EACH ROW begin
    declare book_count int;
    declare late_return_count int;
    declare last_three_count int;
    declare max_books int;
    select count(*) into book_count
    from given_books
    where g_id = new.g_id and g_return is null;
    select count(*) into late_return_count
    from given_books
    where g_id = new.g_id and g_return is not null and datediff(g_return, g_given) > 30;
    select count(*) into last_three_count
    from (
        select g_return, g_given
        from given_books
        where g_id = new.g_id and g_return is not null
        order by g_return desc
        limit 3
    ) as last_returns
    where datediff(g_return, g_given) <= 30;
    if late_return_count > 0 then
        if last_three_count = 3 then
            set max_books = 5;
        else
            set max_books = 3;
        end if;
    else
        set max_books = 5;
    end if;
    if book_count >= max_books then
        signal sqlstate '45000' set message_text = '���⥫� 㦥 ����� ���ᨬ��쭮� ������⢮ ���� �� �㪠�';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_given_books_update_status` AFTER INSERT ON `given_books` FOR EACH ROW begin
        update stock_books
        set s_stat = '�뤠��'
        where s_num = new.g_num;
        update books
        set b_quantity = b_quantity - 1
        where b_id = (select s_id from stock_books where s_num = new.g_num);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_given_books` AFTER UPDATE ON `given_books` FOR EACH ROW begin
  declare days_diff int;
  set days_diff = datediff(new.g_return, old.g_given);
    if days_diff <= 30 then
        update stock_books
        set s_stat = "�����饭� ���६�"
        where s_num = old.g_num;
    else 
        update stock_books
        set s_stat = "�����饭� �� ���६�"
        where s_num = old.g_num;
    end if;
  update books
  set b_quantity = b_quantity + 1
  where b_id = (select s_id from stock_books where s_num = old.g_num);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `library_ticket`
--

DROP TABLE IF EXISTS `library_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_ticket` (
  `l_id` int NOT NULL,
  `l_name` varchar(50) NOT NULL,
  `l_birth` date NOT NULL,
  `l_tel` varchar(11) NOT NULL,
  `l_given` date NOT NULL,
  PRIMARY KEY (`l_id`),
  UNIQUE KEY `UQ_library_ticket_l_tel` (`l_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_ticket`
--

LOCK TABLES `library_ticket` WRITE;
/*!40000 ALTER TABLE `library_ticket` DISABLE KEYS */;
INSERT INTO `library_ticket` VALUES (1001,'Иванов Иван Иванович','2000-01-15','89161234501','2024-02-03'),(1002,'Петров Петр Петрович','1995-02-20','89161234502','2024-02-11'),(1003,'Сидоров Сидор Сидорович','2002-03-30','89161234503','2024-02-22'),(1004,'Кузнецов Михаил Иванович','1998-04-10','89161234504','2024-02-25'),(1005,'Смирнова Анна Сергеевна','1995-05-25','89161234505','2024-03-03'),(1006,'Попова Мария Петровна','2001-06-15','89161234506','2024-03-05'),(1007,'Лебедев Алексей Николаевич','1993-07-07','89161234507','2024-03-06'),(1008,'Козлов Виктор Андреевич','1997-08-08','89161234508','2024-03-07'),(1009,'Новикова Екатерина Павловна','1989-09-19','89161234509','2024-03-13'),(1010,'Морозов Дмитрий Александрович','2004-10-22','89161234510','2024-03-17'),(1011,'Федорова Ольга Владимировна','1996-11-11','89161234511','2024-03-22');
/*!40000 ALTER TABLE `library_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_books`
--

DROP TABLE IF EXISTS `stock_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_books` (
  `s_num` int NOT NULL,
  `s_id` int NOT NULL,
  `s_stat` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`s_num`),
  KEY `FK_stock_books_s_id` (`s_id`),
  CONSTRAINT `FK_stock_books_s_id` FOREIGN KEY (`s_id`) REFERENCES `books` (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_books`
--

LOCK TABLES `stock_books` WRITE;
/*!40000 ALTER TABLE `stock_books` DISABLE KEYS */;
INSERT INTO `stock_books` VALUES (100001,1001,'Выдана'),(100002,1001,NULL),(100003,1002,'Возвращена вовремя'),(100004,1003,'Возвращена вовремя'),(100005,1001,NULL),(100006,1002,NULL),(100007,1003,'Возвращена вовремя'),(100008,1002,'Возвращена вовремя'),(100009,1003,'Возвращена вовремя'),(100010,1004,'Возвращена не вовремя'),(100011,1004,'Возвращена вовремя'),(100012,1004,'Возвращена вовремя'),(100013,1005,NULL),(100014,1004,NULL),(100015,1005,'Возвращена вовремя'),(100016,1006,NULL),(100017,1005,'Возвращена вовремя'),(100018,1006,NULL),(100019,1006,NULL),(100020,1007,NULL),(100021,1007,'Возвращена не вовремя'),(100022,1007,'Возвращена вовремя'),(100023,1008,NULL),(100024,1009,NULL),(100025,1009,'Возвращена вовремя'),(100026,1008,'Возвращена вовремя'),(100027,1010,NULL),(100028,1009,NULL),(100029,1008,NULL),(100030,1010,'Возвращена вовремя'),(100031,1010,'Возвращена не вовремя');
/*!40000 ALTER TABLE `stock_books` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp866 */ ;
/*!50003 SET character_set_results = cp866 */ ;
/*!50003 SET collation_connection  = cp866_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_stock_books` AFTER INSERT ON `stock_books` FOR EACH ROW begin
    update books
    set b_quantity = b_quantity + 1
    where b_id = new.s_id;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-27 18:22:57
