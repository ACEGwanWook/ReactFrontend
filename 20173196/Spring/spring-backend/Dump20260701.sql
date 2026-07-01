-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hmd_weld_robot_v2
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abn_pict_tbl`
--

DROP TABLE IF EXISTS `abn_pict_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abn_pict_tbl` (
  `ErrNum` int NOT NULL AUTO_INCREMENT,
  `ErrDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProjNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BlockName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RobotNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ErrInfo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `LocationMM` int NOT NULL DEFAULT '0',
  `LocationX` double NOT NULL DEFAULT '0',
  `LocationY` double NOT NULL DEFAULT '0',
  `Action` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Assy` varchar(10) NOT NULL DEFAULT 'NA',
  `CellNum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ErrNum`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abn_pict_tbl`
--

LOCK TABLES `abn_pict_tbl` WRITE;
/*!40000 ALTER TABLE `abn_pict_tbl` DISABLE KEYS */;
INSERT INTO `abn_pict_tbl` VALUES (1,'2025-08-01','380706','B13P','UR01','용접불량',3,24.1,43.6,'완료','TT1',1),(2,'2025-08-01','470606','ER3P','UR01','용접불량',7,27.7,47.5,'완료','BC1',3),(3,'2025-08-01','293606','DE1P','UR03','부재Gap칫수',12,30.5,52.6,'미완료','ER2',1),(4,'2025-08-01','380706','B13P','UR04','부재Gap칫수',15,32.9,55.1,'완료','TT2',1),(5,'2025-08-01','450206','GE2P','UR03','용접불량',19,34.5,58.8,'완료','DE4',3),(6,'2025-08-01','843206','ES1P','UR06','부재Gap칫수',24,39,63.9,'미완료','GS1',2);
/*!40000 ALTER TABLE `abn_pict_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `breakdn_tbl`
--

DROP TABLE IF EXISTS `breakdn_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `breakdn_tbl` (
  `BreakdnNo` varchar(50) NOT NULL COMMENT '고장 순번\n',
  `RobotNo` varchar(50) NOT NULL COMMENT '로봇번호',
  `BreakdnDate` varchar(50) NOT NULL COMMENT '고장 일자',
  `BreakdnReason` varchar(255) DEFAULT NULL COMMENT '고장 사유',
  `BreakdnDesc` varchar(255) NOT NULL COMMENT '고장 내용',
  `EmployeeNumber` varchar(50) NOT NULL DEFAULT 'NA',
  `File` varchar(10) NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`BreakdnNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `breakdn_tbl`
--

LOCK TABLES `breakdn_tbl` WRITE;
/*!40000 ALTER TABLE `breakdn_tbl` DISABLE KEYS */;
INSERT INTO `breakdn_tbl` VALUES ('1','UR01','2024-08-01','Power 접속 불량','전원 안들어옴','323187','YES'),('2','UR04','2024-08-10','용접 조절 장치 고장','용접 불량','821432','NO'),('3','UR07','2024-09-11','로봇 관절 부품 변형','로봇 팔 구동시 소음 발생','853123','NO'),('4','UR08','2024-09-12','2F 영역 전압 발생 불량','2F 용접 불량 발생','837646','YES'),('5','UR06','2024-09-30','이동체 캐터필더 부품 불량','이동체 오작동','832514','NO'),('6','UR04','2024-10-02','Power 접속 불량','전원 안들어옴','821432','YES'),('7','UR05','2024-10-30','통신 센서 불량','통신 불가 메세지 발생','853123','NO'),('8','UR09','2025-03-02','HMI 네트워크 IP 재설정','설계 데이터 Import 불가능','323187','YES'),('9','UR09','2025-09-25','HMI 네트워크 IP 재설정','포트포워딩 연결 실패','20173196','YES');
/*!40000 ALTER TABLE `breakdn_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cad_block_tbl`
--

DROP TABLE IF EXISTS `cad_block_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cad_block_tbl` (
  `ProjBlockName` varchar(50) NOT NULL COMMENT '호선 블록 Name',
  `ProjNo` varchar(50) NOT NULL COMMENT '호선 No',
  `BlockModelName` varchar(50) NOT NULL COMMENT '블록 모델 파일명',
  `BlockModelFolder` varchar(50) NOT NULL COMMENT '블록 모델 폴더명',
  `SizeL` varchar(50) NOT NULL COMMENT '길이',
  `SizeB` varchar(50) NOT NULL COMMENT '폭',
  `SizeD` varchar(50) NOT NULL COMMENT '깊이',
  `Weight` varchar(50) NOT NULL COMMENT '중량',
  `ProdPlant` varchar(50) DEFAULT NULL,
  `MidActStartDate` varchar(50) DEFAULT NULL COMMENT '중일정 착수 일정',
  `MidActFinishDate` varchar(50) DEFAULT NULL COMMENT '중일정 완료 일정',
  `AssyPlanStartDate` varchar(50) DEFAULT NULL,
  `AssyPlanFinishDate` varchar(50) DEFAULT NULL,
  `StdManHour` varchar(50) DEFAULT NULL,
  `WorkManHour` varchar(50) DEFAULT NULL,
  `InspStatusDate` varchar(50) DEFAULT NULL,
  `InspResult` varchar(50) DEFAULT NULL,
  `AssyFinishDate` varchar(50) DEFAULT NULL,
  `WorkTeam` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ProjBlockName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cad_block_tbl`
--

LOCK TABLES `cad_block_tbl` WRITE;
/*!40000 ALTER TABLE `cad_block_tbl` DISABLE KEYS */;
INSERT INTO `cad_block_tbl` VALUES ('840806_B11C','840806','840806-B11C.rvm','Z:\\HMD\\Robot\\Weld\\Block','15.4','27.4','12.2','48.3','용연공장','2025-02-10','2025-02-19','2025-01-22','2025-02-20','8','17','2025-02-20','AC','2025-02-20','진서'),('840806_B12C','840806','840806-B12C.rvm','Z:\\HMD\\Robot\\Weld\\Block','18.4','32.8','12.2','58.3','용연공장','2025-02-11','2025-02-17','2025-01-17','2025-02-17','16','30','2025-02-18','AC','2025-02-19','우성'),('840806_B13P','840806','840806-B13P.rvm','Z:\\HMD\\Robot\\Weld\\Block','17.2','17.9','13.5','37.5','용연공장','2025-02-07','2025-02-16','2025-01-15','2025-02-15','15','28','2025-02-17','AC','2025-02-17','우성'),('840806_B13S','840806','840806-B13S.rvm','Z:\\HMD\\Robot\\Weld\\Block','17.2','17.9','13.5','35.8','용연공장','2025-02-08','2025-02-18','2025-01-10','2025-02-10','15','32','2025-02-19','AA','2025-02-21','태운'),('840806_S19P','840806','840806-S19P.rvm','Z:\\HMD\\Robot\\Weld\\Block','15.9','18.1','12.4','32.6','용연공장','2025-02-01','2025-02-14','2025-01-05','2025-02-01','12','25','2025-02-15','AD','2025-02-15','진서'),('840806_S19S','840806','840806-S19S.rvm','Z:\\HMD\\Robot\\Weld\\Block','15.9','18.1','12.4','31.9','용연공장','2025-02-03','2025-02-13','2025-01-08','2025-02-01','10','22','2025-02-15','AC','2025-02-17','연서');
/*!40000 ALTER TABLE `cad_block_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cad_cell_tbl`
--

DROP TABLE IF EXISTS `cad_cell_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cad_cell_tbl` (
  `CellID` varchar(100) NOT NULL COMMENT 'Cell ID',
  `CellNo` int NOT NULL COMMENT 'Cell No',
  `CellType` varchar(50) NOT NULL DEFAULT 'NULL' COMMENT 'Cell Type',
  `CellDimW` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Cell 칫수 W',
  `CellDimH` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Cell 칫수 H',
  `CellDimCW` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CW',
  `CellDimCW1` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CW1',
  `CellDimCW2` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CW2',
  `CellDimCH` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CH',
  `CellDimCH1` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CH1',
  `CellDimCH2` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CH2',
  `CellDimCh3` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 CH3',
  `CellDimRH` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 RH',
  `CellDimRW1` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 RW1',
  `CellDimRW2` varchar(50) DEFAULT NULL COMMENT 'Cell 칫수 RW2',
  `CellDataDateTime` varchar(50) DEFAULT NULL COMMENT 'Cell 데이터 생성일시',
  `CellDrawName` varchar(255) DEFAULT NULL COMMENT 'Cell 도면 명',
  `CellDataFileName` varchar(100) DEFAULT NULL COMMENT 'Cell 데이터 파일명',
  `CellDataFileFolder` varchar(255) DEFAULT NULL COMMENT 'Cell 데이터 파일 폴더명',
  `ProjNo` varchar(50) DEFAULT NULL,
  `BlockName` varchar(50) DEFAULT NULL COMMENT '블록 Name',
  `AssyName` varchar(50) DEFAULT NULL COMMENT 'Assy Name',
  `CellDataLW` varchar(255) DEFAULT NULL,
  `CellDataLH` varchar(255) DEFAULT NULL,
  `CellDataLRH` varchar(255) DEFAULT NULL,
  `CellDataLRW` varchar(255) DEFAULT NULL,
  `CellDataLCH` varchar(255) DEFAULT NULL,
  `CellDataLCW` varchar(255) DEFAULT NULL,
  `CellDataRW` varchar(255) DEFAULT NULL,
  `CellDataRH` varchar(255) DEFAULT NULL,
  `CellDataRRH` varchar(255) DEFAULT NULL,
  `CellDataRRW` varchar(255) DEFAULT NULL,
  `CellDataRCH` varchar(255) DEFAULT NULL,
  `CellDataRCW` varchar(255) DEFAULT NULL,
  `RobotNo` varchar(50) DEFAULT NULL COMMENT '로봇 번호',
  `WeldID` varchar(100) DEFAULT NULL COMMENT '용접기 식별 번호',
  `WeldStartDateTime` varchar(50) DEFAULT NULL COMMENT '용접 시작 일시',
  `WeldFinishDateTime` varchar(50) DEFAULT NULL COMMENT '용접 종료 일시',
  `WeldMtrl` varchar(50) DEFAULT NULL,
  `F2WeldCondNo` varchar(50) DEFAULT NULL,
  `F3WeldCondNo` varchar(50) DEFAULT NULL,
  `F2GapStart` varchar(50) DEFAULT NULL COMMENT '2F 갭 Start',
  `F2GapEnd` varchar(50) DEFAULT NULL COMMENT '2F 갭 End',
  `F3GapRightStart` varchar(50) DEFAULT NULL COMMENT '3F 갭 우 Start',
  `F3GapRightEnd` varchar(50) DEFAULT NULL COMMENT '3F 갭 우 End',
  `F3GapLeftStart` varchar(50) DEFAULT NULL COMMENT '3F 갭 좌 Start',
  `F3GapLeftEnd` varchar(50) DEFAULT NULL COMMENT '3F 갭 좌 End',
  `Cpl2FGapStart` varchar(50) DEFAULT NULL COMMENT 'CPL 2F 갭 Start',
  `Cpl2FGapEnd` varchar(50) DEFAULT NULL COMMENT 'CPL 2F 갭 End',
  `Cpl3FGapStart` varchar(50) DEFAULT NULL COMMENT 'CPL 3F 갭 Start',
  `Cpl3FGapEnd` varchar(50) DEFAULT NULL COMMENT 'CPL 3F 갭 End',
  `F2Dim` varchar(50) DEFAULT NULL,
  `F3DimL` varchar(50) DEFAULT NULL,
  `F3DimR` varchar(50) DEFAULT NULL,
  `F2NoWeldL` varchar(50) DEFAULT NULL,
  `F2NoWeldR` varchar(50) DEFAULT NULL,
  `F3NoWeldL` varchar(50) DEFAULT NULL,
  `F3NoWeldR` varchar(50) DEFAULT NULL,
  `Cham` varchar(50) DEFAULT NULL,
  `F2Div` varchar(50) DEFAULT NULL,
  `CollarJoint` varchar(50) DEFAULT NULL,
  `DirectNavi` varchar(50) DEFAULT NULL,
  `RobotHeiCorrect` varchar(50) DEFAULT NULL,
  `DirectNaviDim` varchar(50) DEFAULT NULL,
  `TouchHei` varchar(50) DEFAULT NULL,
  `TotalPassNum` varchar(50) DEFAULT NULL,
  `CurPassNum` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CellNo`,`CellID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cad_cell_tbl`
--

LOCK TABLES `cad_cell_tbl` WRITE;
/*!40000 ALTER TABLE `cad_cell_tbl` DISABLE KEYS */;
INSERT INTO `cad_cell_tbl` VALUES ('C289606-B12P-TT1_1',1,'A-B','10','-10','5','-15','-10','5','10','15','10','+10','+20','+20','2025-02-01 13:07:38','C289606-B12P-TT1.pdf','C289606-B12P-TT1.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT1','49130,1084,2150,49130,1600,2150$5.5','49130,1069,2135,49130,1069,1857.08$5.5',NULL,NULL,'49142.5,5678.2,2150,49142.5,5678.2,1900$5.5','49155,5882.09,2150,49155,5678.2,2150$5.5','49130,1600,2150,49130,1084,2150$5.5','49149,1750,2140,49149,1750,1875$5.5',NULL,NULL,'49149,1600,2150,49149,1600,1875$5.5','49149,1740,2150,49149,1600,2150$5.5','6호기','BEIA60021_','2025-02-24 14:16:08','2025-02-24 14:21:12','71LH','5','102','1','3','1','1','5','5','0','0','0','0','700','140','130','0','0','0','0','OFF','OFF','OFF','우','ON','50','50','5','1'),('C289606-B12P-TT1_2',2,'B-C','0','-10','0','-15','0','0','0','0','0','+10','+20','+20','2025-02-01 13:07:38','C289606-B12P-TT2.pdf','C289606-B12P-TT2.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT2','49130,1884,2150,49130,2400,2150$5.5','49130,1869,2135,49130,1869,1857.08$5.5',NULL,NULL,'49142.5,6478.2,2150,49142.5,6478.2,1900$5.5','49155,6682.09,2150,49155,6478.2,2150$5.5','49130,2400,2150,49130,1884,2150$5.5','49149,2550,2140,49149,2550,1875$5.5',NULL,NULL,'49149,2400,2150,49149,2400,1875$5.5','49149,2540,2150,49149,2400,2150$5.5','6호기','BEIA60021_','2025-02-24 16:23:05','2025-02-24 16:26:15','71LH','4','102','0','0','2','2','3','3','1','1','1','1','800','135','135','0','0','0','0','OFF','ON','OFF','우','OFF','50','50','3','1'),('C289606-B12P-TT1_3',3,'C-A','0','-11','0','-16','0','0','0','0','0','+11','+21','+21','2025-02-01 13:07:38','C289606-B12P-TT3.pdf','C289606-B12P-TT3.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT3','49130,2684,2150,49130,3200,2150$5.5','49130,2669,2135,49130,2669,1857.08$5.5',NULL,NULL,'49142.5,7278.2,2150,49142.5,7278.2,1900$5.5','49155,7482.09,2150,49155,7278.2,2150$5.5','49130,3200,2150,49130,2684,2150$5.5','49149,3350,2140,49149,3350,1875$5.5',NULL,NULL,'49149,3200,2150,49149,3200,1875$5.5','49149,3340,2150,49149,3200,2150$5.5','6호기','BEIA60021_','2025-02-24 16:27:56','2025-02-24 16:29:06','71LH','6','103','1','1','2','2','4','4','2','2','0','0','780','150','120','0','0','0','0','OFF','OFF','OFF','우','OFF','50','45','3','2'),('C289606-B12P-TT1_4',4,'C-B','8','-9','4','-14','-9','4','9','14','9','+9','+19','+19','2025-02-01 13:07:38','C289606-B12P-TT4.pdf','C289606-B12P-TT4.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT4','49130,3484,2150,49130,4000,2150$5.5','49130,3469,2135,49130,3469,1857.08$5.5',NULL,NULL,'49142.5,8078.2,2150,49142.5,8078.2,1900$5.5','49155,8282.09,2150,49155,8078.2,2150$5.5','49130,4000,2150,49130,3484,2150$5.5','49149,4150,2140,49149,4150,1875$5.5',NULL,NULL,'49149,4000,2150,49149,4000,1875$5.5','49149,4140,2150,49149,4000,2150$5.5','6호기','BEIA60021_','2025-02-24 16:31:04','2025-02-24 16:33:00','71LH','5','101','2','2','0','0','4','4','0','0','0','0','770','140','135','0','0','0','0','OFF','OFF','ON','우','OFF','50','50','3','3'),('C289606-B12P-TT1_5',5,'C-A','0','-10','0','-17','0','0','0','0','0','+12','+22','+22','2025-02-01 13:07:38','C289606-B12P-TT5.pdf','C289606-B12P-TT5.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT5','49130,4284,2150,49130,4800,2150$5.5','49130,4269,2135,49130,4269,1857.08$5.5',NULL,NULL,'49142.5,8878.2,2150,49142.5,8878.2,1900$5.5','49155,9082.09,2150,49155,8878.2,2150$5.5','49130,4800,2150,49130,4284,2150$5.5','49149,4950,2140,49149,4950,1875$5.5',NULL,NULL,'49149,4800,2150,49149,4800,1875$5.5','49149,4940,2150,49149,4800,2150$5.5','6호기','BEIA60021_','2025-02-24 16:34:12','2025-02-24 16:35:58','71LH','1','103','1','2','1','1','3','3','0','0','1','1','750','145','130','0','0','0','0','ON','OFF','ON','우','OFF','50','55','2','2'),('C289606-B12P-TT1_6',6,'C-A','0','-8','0','-14','0','0','0','0','0','+11','+21','+20','2025-02-01 13:07:38','C289606-B12P-TT6.pdf','C289606-B12P-TT6.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT6','49130,5084,2150,49130,5600,2150$5.5','49130,5069,2135,49130,5069,1857.08$5.5',NULL,NULL,'49142.5,9678.2,2150,49142.5,9678.2,1900$5.5','49155,9882.09,2150,49155,9678.2,2150$5.5','49130,5600,2150,49130,5084,2150$5.5','49149,5750,2140,49149,5750,1875$5.5',NULL,NULL,'49149,5600,2150,49149,5600,1875$5.5','49149,5740,2150,49149,5600,2150$5.5','6호기','BEIA60021_','2025-02-24 16:37:16','2025-02-24 16:39:34','71LH','2','101','2','0','2','2','5','5','1','1','3','3','800','130','140','0','0','0','0','OFF','OFF','OFF','우','OFF','50','47','2','1'),('C289606-B12P-TT1_7',7,'E-B','12','-12','8','-20','-15','10','12','13','11','+13','+26','+24','2025-02-02 09:35:25','C289606-B12P-TT7.pdf','C289606-B12P-TT7.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT7','49130,5884,2150,49130,6400,2150$5.5','49130,5869,2135,49130,5869,1857.08$5.5',NULL,NULL,'49142.5,10478.2,2150,49142.5,10478.2,1900$5.5','49155,10682.09,2150,49155,10478.2,2150$5.5','49130,6400,2150,49130,5884,2150$5.5','49149,6550,2140,49149,6550,1875$5.5',NULL,NULL,'49149,6400,2150,49149,6400,1875$5.5','49149,6540,2150,49149,6400,2150$5.5','6호기','BEIA60021_','2025-02-24 16:42:16','2025-02-24 16:45:01','71LH','3','102','5','5','3','3','5','5','3','3','5','5','700','135','145','0','0','0','0','OFF','OFF','OFF','좌','ON','50','50','1','1'),('C289606-B12P-TT1_8',8,'B-C','6','-10','5','-15','-10','5','10','15','10','+10','+22','+22','2025-02-01 13:07:38','C289606-B12P-TT8.pdf','C289606-B12P-TT8.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT8','49130,6684,2150,49130,7200,2150$5.5','49130,6669,2135,49130,6669,1857.08$5.5',NULL,NULL,'49142.5,11278.2,2150,49142.5,11278.2,1900$5.5','49155,11482.09,2150,49155,11278.2,2150$5.5','49130,7200,2150,49130,6684,2150$5.5','49149,7350,2140,49149,7350,1875$5.5',NULL,NULL,'49149,7200,2150,49149,7200,1875$5.5','49149,7340,2150,49149,7200,2150$5.5','6호기','BEIA60021_','2025-02-24 16:47:55','2025-02-24 16:49:53','71LH','3','101','0','0','5','5','3','3','1','1','0','0','720','120','145','0','0','0','0','ON','OFF','OFF','우','OFF','50','55','1','1'),('C289606-B12P-TT1_9',9,'A-A','0','-10','0','-15','0','0','0','0','0','+10','+20','+20','2025-02-01 13:07:38','C289606-B12P-TT9.pdf','C289606-B12P-TT9.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT9','49130,7484,2150,49130,8000,2150$5.5','49130,7469,2135,49130,7469,1857.08$5.5',NULL,NULL,'49142.5,12078.2,2150,49142.5,12078.2,1900$5.5','49155,12282.09,2150,49155,12078.2,2150$5.5','49130,8000,2150,49130,7484,2150$5.5','49149,8150,2140,49149,8150,1875$5.5',NULL,NULL,'49149,8000,2150,49149,8000,1875$5.5','49149,8140,2150,49149,8000,2150$5.5','6호기','BEIA60021_','2025-02-24 16:51:17','2025-02-24 16:52:57','71LH','1','103','3','3','0','0','0','0','1','1','3','3','740','150','130','0','0','0','0','ON','ON','OFF','좌','OFF','50','60','2','1'),('C289606-B12P-TT10-10',10,'A-C','0','0','0','0','0','0','0','0','0','0','0','0','2025-10-14 11:56:23','C289606-B12P-TT10.pdf','C289606-B12P-TT10.csv','Z:\\HMD\\Robot\\Weld\\Dwg','289606','B12P','TT10','49130,8284,2150,49130,8800,2150$5.5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('C843206-C11F-AS1_11',11,'NULL','0','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-05-13 16:47:53','C843206-C11F-AS1.pdf','C843206-C11F-AS1.csv','Z:\\HMD\\Robot\\Weld\\Dwg','843206','C11F','AS1','49130,8284,2150,49130,8800,2150$5.5',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cad_cell_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cad_hopper_tbl`
--

DROP TABLE IF EXISTS `cad_hopper_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cad_hopper_tbl` (
  `HopperID` varchar(100) NOT NULL COMMENT 'Hopper Model Name',
  `ProjNo` varchar(50) NOT NULL COMMENT '호선 No',
  `BlockName` varchar(50) NOT NULL COMMENT '블록 Name',
  `ModelFileName` varchar(50) DEFAULT NULL,
  `ModelFileFolder` varchar(255) DEFAULT NULL,
  `RobotNo` varchar(50) DEFAULT NULL COMMENT '로봇 번호',
  `WeldID` varchar(100) DEFAULT NULL COMMENT '용접기 식별 번호',
  `WeldStartDateTime` varchar(50) DEFAULT NULL COMMENT '용접 시작 일시',
  `WeldFinishDateTime` varchar(50) DEFAULT NULL COMMENT '용접 종료 일시',
  PRIMARY KEY (`HopperID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cad_hopper_tbl`
--

LOCK TABLES `cad_hopper_tbl` WRITE;
/*!40000 ALTER TABLE `cad_hopper_tbl` DISABLE KEYS */;
INSERT INTO `cad_hopper_tbl` VALUES ('291206_B11P-HP1','291206','B11P','291206_B14P-HP1.stp','Z:\\HMD\\Robot\\Weld\\Model','9호기','BEIA60021_','2025-02-24 15:12:41','2025-02-24 15:16:35'),('291206_B11P-HP3','291206','B11P','291206_B11P-HP3.stp','Z:\\HMD\\Robot\\Weld\\Model','9호기','BEIA60021_','2025-02-24 15:02:28','2025-02-24 15:09:45'),('291206_B11P-HP5','291206','B11P','291206_B11P-HP5.stp','Z:\\HMD\\Robot\\Weld\\Model','9호기','BEIA60021_','2025-02-24 14:49:15','2025-02-24 14:57:39'),('291206_B12P-HP1','291206','B12P','291206_B12P-HP1.stp','Z:\\HMD\\Robot\\Weld\\Model','9호기','BEIA60021_','2025-02-24 15:19:21','2025-02-24 15:23:45'),('291206_B13P-HP1','291206','B13P','291206_B13P-HP1.stp','Z:\\HMD\\Robot\\Weld\\Model','9호기','BEIA60021_','2025-02-24 15:26:43','2025-02-24 15:29:56'),('291206_B14P-HP1','291206','B14P','291206_B14P-HP1.stp','Z:\\HMD\\Robot\\Weld\\Model','9호기','BEIA60021_','2025-02-24 14:16:08','2025-02-24 14:21:12'),('291206_B14P-HP2','291206','B14P','291206_B14P-HP2.stp','Z:\\HMD\\Robot\\Weld\\Model','6호기','BEIA60061_','2025-02-24 14:37:12','2025-02-24 14:42:54'),('291206_B15P-HP3','291206','B15P','291206_B15P-HP3.stp','Z:\\HMD\\Robot\\Weld\\Model','6호기','BEIA60061_','2025-02-24 15:35:28','2025-02-24 15:41:13');
/*!40000 ALTER TABLE `cad_hopper_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cad_hopper_weld_tbl`
--

DROP TABLE IF EXISTS `cad_hopper_weld_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cad_hopper_weld_tbl` (
  `HopperWeldID` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `HopperID` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ProjNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BlockName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BasePart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `AttPart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Length` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Posture` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ButtFillet` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ModFilePath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Bevel` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `BevelCode` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Stage` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `StageCode` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ModRvmName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldStart3d` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldEnd3d` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ToolPassStartSeq` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ToolPassEndSeq` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RobotNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldStartDateTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldFinishDateTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`HopperWeldID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cad_hopper_weld_tbl`
--

LOCK TABLES `cad_hopper_weld_tbl` WRITE;
/*!40000 ALTER TABLE `cad_hopper_weld_tbl` DISABLE KEYS */;
INSERT INTO `cad_hopper_weld_tbl` VALUES ('291206_B14P-HP1A-K1_1','291206_B14P-HP1','291206','B14P','B14P-HP1-B1','B14P-HP1A-K1','260200','HORI','FILLET','\\\\210.118.131.6\\library\\PLM_Viz\\291206\\weld\\B14P\\WELD_B14P.rvm','FV3V','920','Z','49','W_291206_B14P-HP1A-K1_1.FRMW','49130,1084,2150','49130,1600,2150','2','3','6호기','BEIA60021_','2025-02-24 14:16:08','2025-02-24 14:21:12'),('291206_B14P-HP1A-K2_1','291206_B14P-HP1','291206','B14P','B14P-HP1-B1','B14P-HP1A-K2','301000','HORI','FILLET','\\\\210.118.131.6\\library\\PLM_Viz\\291206\\weld\\B14P\\WELD_B14P.rvm','FV3V','920','Z','49','W_291206_B14P-HP1A-K2_1.FRMW','51130,1284,2150','51130,1810,2150','1','2','6호기','BEIA60021_','2025-02-24 14:23:15','2025-02-24 14:35:07');
/*!40000 ALTER TABLE `cad_hopper_weld_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cell_weld_cond_tbl`
--

DROP TABLE IF EXISTS `cell_weld_cond_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cell_weld_cond_tbl` (
  `CellWeldCondID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldMtrl` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldPos` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldCondNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `CurPassNum` varchar(50) NOT NULL,
  `TotalPassNum` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ElecVolt` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ElecCurrent` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpeedGap1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpeedGap3` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `SpeedGap5` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WidthGap1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WidthGap3` varchar(50) NOT NULL,
  `WidthGap5` varchar(50) NOT NULL,
  `WeldWeavWidth` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DeskStopTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WallStopTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WorkAng` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OffsetX` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OffsetZ` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSens` varchar(50) NOT NULL,
  `ElecVoltComp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CellWeldCondID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cell_weld_cond_tbl`
--

LOCK TABLES `cell_weld_cond_tbl` WRITE;
/*!40000 ALTER TABLE `cell_weld_cond_tbl` DISABLE KEYS */;
INSERT INTO `cell_weld_cond_tbl` VALUES ('71LH_2_10_1_3','71LH','2','10','1','3','30','310','46','0','0','3.4','0','0','3','0','0','0','0','0','3','0'),('71LH_2_10_2_3','71LH','2','10','2','3','29','290','45','0','0','3','0','0','1.4','0','0','0','7.5','0','0','0'),('71LH_2_10_3_3','71LH','2','10','3','3','29.5','310','44','0','0','3.5','0','0','3.1','0','0.3','-8','0','4.3','0','0'),('71LH_2_11_1_3','71LH','2','11','1','3','33','340','45','0','0','3.5','0','0','3.2','0','0','0','0','0','3','0'),('71LH_2_11_2_3','71LH','2','11','2','3','30','305','44','0','0','3.8','0','0','3','0','0','5','5.8','0','0','0'),('71LH_2_11_3_3','71LH','2','11','3','3','30','320','43','0','0','3.7','0','0','3.2','0','0','-8','0','4.5','0','0'),('71LH_2_5_1_1','71LH','2','5','1','1','30','290','48','0','0','3.4','0','0','2','0','0','0','0','0','3','0'),('71LH_2_6_1_1','71LH','2','6','1','1','32','310','40','0','0','3.4','0','0','1.5','0','0','0','0','0.1','3','0'),('71LH_2_7_1_2','71LH','2','7','1','2','34','335','40','0','0','3.6','0','0','2','0','0','5','3.1','0','3','0'),('71LH_2_7_2_2','71LH','2','7','2','2','26','240','60','0','0','1','0','0','2','0','0','-5','0','3.5','0','0'),('71LH_2_8_1_2','71LH','2','8','1','2','34','345','40','0','0','3.7','0','0','2','0','0','5','3.2','0','3','0'),('71LH_2_8_2_2','71LH','2','8','2','2','26.5','245','60','0','0','1.1','0','0','2','0','0','-5','0','3.8','0','0'),('71LH_2_9_1_2','71LH','2','9','1','2','36','365','37','0','0','4.1','0','0','1.5','0','0','5','4','0','3','0'),('71LH_2_9_2_2','71LH','2','9','2','2','29','285','51','0','0','2.5','0','0','1.5','0','0','-5','0','4','0','0');
/*!40000 ALTER TABLE `cell_weld_cond_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cell_weld_set_tbl`
--

DROP TABLE IF EXISTS `cell_weld_set_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cell_weld_set_tbl` (
  `CellWeldSetID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldPosCheck` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F2CPJointWeld` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F2CorTurWeld` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F2DivWeld` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F3ChamCompWeld` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DirectNaviDim` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `TouchHei` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `PassWait` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DirectNavi` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `DevMode` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldTime2fStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldTime2fEnd1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldTime2fEnd2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldTime3fStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldTime3fEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldCur2fStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldCur2fEnd1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldCur2fEnd2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldCur3fStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldCur3fEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldVolt2fStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldVolt2fEnd1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldVolt2fEnd2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldVolt3fStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `WeldVolt3fEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensUDP2f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensUDP3f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensUDI2f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensUDI3f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensLRP2f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensLRP3f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensLRI2f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ArcSensLRI3f` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`CellWeldSetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cell_weld_set_tbl`
--

LOCK TABLES `cell_weld_set_tbl` WRITE;
/*!40000 ALTER TABLE `cell_weld_set_tbl` DISABLE KEYS */;
INSERT INTO `cell_weld_set_tbl` VALUES ('1','Off','On','Off','On','Off','50','50','대기 없음','우측','Off','0.25','0.3','1.5','3','1','280','200','200','180','180','30','25','24','25','25','0','20','0','1','0','7','0','1');
/*!40000 ALTER TABLE `cell_weld_set_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `code_tbl`
--

DROP TABLE IF EXISTS `code_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `code_tbl` (
  `CodeID` varchar(50) NOT NULL COMMENT '그룹 코드',
  `CodeType` varchar(50) NOT NULL COMMENT '코드 명',
  `GroupName` varchar(50) NOT NULL COMMENT '비고1',
  `GroupCode` varchar(50) NOT NULL COMMENT '코드',
  `CodeName` varchar(50) NOT NULL COMMENT '코드 구분',
  `Remarks1` varchar(255) NOT NULL COMMENT '그룹 명',
  `Remarks2` varchar(50) NOT NULL COMMENT '비고2',
  PRIMARY KEY (`CodeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `code_tbl`
--

LOCK TABLES `code_tbl` WRITE;
/*!40000 ALTER TABLE `code_tbl` DISABLE KEYS */;
INSERT INTO `code_tbl` VALUES ('1','공통','시스템접근코드','AccessLevel','ADMIN','RW','1'),('10','공통','부서코드','DeptCode','정보기술부','HD현대미포','4'),('11','공통','부서코드','DeptCode','용연공장','HD현대미포','2'),('12','공통','고장코드','FaultCode','교체','Change','1'),('13','공통','고장코드','FaultCode','기타','Etc','4'),('14','공통','고장코드','FaultCode','결함','Fault','2'),('15','공통','고장코드','FaultCode','수리','Repair','3'),('16','공통','부품코드','PartCode','액추에이터','actuator','2'),('17','공통','부품코드','PartCode','캐터필러','Caterpillar','3'),('18','공통','부품코드','PartCode','컴프레서','compressor','4'),('19','공통','부품코드','PartCode','통신/무선시스템','Comm System','5'),('2','공통','시스템접근코드','AccessLevel','LEVEL1','RW','2'),('20','공통','부품코드','PartCode','컨트롤러','Controller','6'),('21','공통','부품코드','PartCode','기타','Etc','11'),('22','공통','부품코드','PartCode','파워 서플라이','Power Supply','7'),('23','공통','부품코드','PartCode','로봇 암','Robot Arm','8'),('24','공통','부품코드','PartCode','스위치/센서','Swich/Senser','9'),('25','공통','부품코드','PartCode','비젼','Vision','10'),('26','공통','부품코드','PartCode','용접기','Welding Tool','1'),('27','공통','직책코드','PositionCode','본부장','Executives','6'),('28','공통','직책코드','PositionCode','반장','-','3'),('29','공통','직책코드','PositionCode','부서장','Department Head','5'),('3','공통','시스템접근코드','AccessLevel','LEVEL2','R','3'),('30','공통','직책코드','PositionCode','과장','-','4'),('31','공통','직책코드','PositionCode','팀장','Team Manager','2'),('32','공통','직책코드','PositionCode','팀원','Team Member','1'),('33','공통','직급코드','RankCode','부장','General Manager','9'),('34','공통','직급코드','RankCode','대표이사','CEO','14'),('35','공통','직급코드','RankCode','책임','-','3'),('36','공통','직급코드','RankCode','차장','Associate Director','8'),('37','공통','직급코드','RankCode','대리','Assistant Manager','6'),('38','공통','직급코드','RankCode','과장','Manager','7'),('39','공통','직급코드','RankCode','인턴','Intern','1'),('4','공통','시스템접근코드','AccessLevel','LEVEL3','W','4'),('40','공통','직급코드','RankCode','주임','Associate','5'),('41','공통','직급코드','RankCode','전무이사','Executive Vice','13'),('42','공통','직급코드','RankCode','선임','-','4'),('43','공통','직급코드','RankCode','소장','Chief Director','10'),('44','','직급코드','RankCode','상무이사','Executive Director','12'),('45','공통','직급코드','RankCode','사원','Staff','2'),('46','공통','로봇번호','RobotNo','1호기','UR3','1'),('47','공통','로봇번호','RobotNo','2호기','UR3','2'),('48','공통','로봇번호','RobotNo','3호기','UR3','3'),('49','공통','로봇번호','RobotNo','4호기','UR3','4'),('5','공통','부서코드','DeptCode','IT개발부','에이스이앤티','2'),('50','공통','로봇번호','RobotNo','5호기','UR3','5'),('51','공통','로봇번호','RobotNo','6호기','UR3','6'),('52','공통','로봇번호','RobotNo','7호기','RB3-730','7'),('53','공통','로봇번호','RobotNo','8호기','RB3-730','8'),('54','공통','로봇번호','RobotNo','9호기','HDR20-17','9'),('55','공통','용접재료','WeldMatl','71LH','A','1'),('56','공통','용접재료','WeldMatl','71N14','B','2'),('57','공통','용접재료','WeldMatl','81K2','C','3'),('58','공통','직급코드','RankCode','이사','General Manager','11'),('6','공통','부서코드','DeptCode','경영지원팀','에이스이앤티','3'),('7','공통','부서코드','DeptCode','연구본부','에이스이앤티','1'),('8','공통','부서코드','DeptCode','DMIC','HD현대미포','1'),('9','공통','부서코드','DeptCode','선체내업부','HD현대미포','3');
/*!40000 ALTER TABLE `code_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_summary`
--

DROP TABLE IF EXISTS `daily_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_summary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `work_date` date DEFAULT NULL,
  `operation_time` time DEFAULT NULL,
  `arc_time` time DEFAULT NULL,
  `arc_rate` decimal(5,2) DEFAULT NULL,
  `weld_length` decimal(10,3) DEFAULT NULL,
  `vessel_no` varchar(20) DEFAULT NULL,
  `block` varchar(20) DEFAULT NULL,
  `assy` varchar(20) DEFAULT NULL,
  `worker` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_summary`
--

LOCK TABLES `daily_summary` WRITE;
/*!40000 ALTER TABLE `daily_summary` DISABLE KEYS */;
INSERT INTO `daily_summary` VALUES (1,'2026-01-22','06:59:59','02:21:50',33.80,29.841,'2936','B16P','TT1A','E2-A');
/*!40000 ALTER TABLE `daily_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_donut`
--

DROP TABLE IF EXISTS `dashboard_donut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_donut` (
  `Tindex` int NOT NULL,
  `Title` varchar(45) NOT NULL,
  `Selected` varchar(45) NOT NULL,
  `Alldata` int NOT NULL DEFAULT '0',
  `Graphdata` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Tindex`,`Title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='대시보드 도넛 그래프';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_donut`
--

LOCK TABLES `dashboard_donut` WRITE;
/*!40000 ALTER TABLE `dashboard_donut` DISABLE KEYS */;
INSERT INTO `dashboard_donut` VALUES (1,'지시량','양품량',1150,776),(2,'생산량','불량량',801,25),(3,'설비보유시간','작업시간',6060,4090),(4,'설비보유대수','가동설비대수',10,7);
/*!40000 ALTER TABLE `dashboard_donut` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_eqskill`
--

DROP TABLE IF EXISTS `dashboard_eqskill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_eqskill` (
  `EqNum` int NOT NULL,
  `skill1` int NOT NULL DEFAULT '0',
  `skill2` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`EqNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_eqskill`
--

LOCK TABLES `dashboard_eqskill` WRITE;
/*!40000 ALTER TABLE `dashboard_eqskill` DISABLE KEYS */;
INSERT INTO `dashboard_eqskill` VALUES (1,100,60),(2,94,75),(3,56,28),(4,80,0),(5,80,64),(6,92,58);
/*!40000 ALTER TABLE `dashboard_eqskill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_order`
--

DROP TABLE IF EXISTS `dashboard_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_order` (
  `Month` int NOT NULL,
  `percent` int DEFAULT NULL,
  PRIMARY KEY (`Month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_order`
--

LOCK TABLES `dashboard_order` WRITE;
/*!40000 ALTER TABLE `dashboard_order` DISABLE KEYS */;
INSERT INTO `dashboard_order` VALUES (1,50),(2,105),(3,115),(4,80),(5,120),(6,105),(7,140),(8,180),(9,NULL),(10,NULL),(11,NULL),(12,NULL);
/*!40000 ALTER TABLE `dashboard_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gas_usage`
--

DROP TABLE IF EXISTS `gas_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gas_usage` (
  `date` varchar(45) NOT NULL,
  `usage` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='가스 사용량';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gas_usage`
--

LOCK TABLES `gas_usage` WRITE;
/*!40000 ALTER TABLE `gas_usage` DISABLE KEYS */;
INSERT INTO `gas_usage` VALUES ('5/21',0),('5/22',1104),('5/23',2534),('5/24',1007),('5/25',0),('5/26',990),('5/27',4175),('5/28',3650),('5/29',2321),('5/30',1662),('5/31',1477),('6/1',0),('6/10',2488),('6/11',2909),('6/12',2238),('6/13',1990),('6/2',1421),('6/3',1428),('6/4',2557),('6/5',3348),('6/6',2288),('6/7',773),('6/8',0),('6/9',2253);
/*!40000 ALTER TABLE `gas_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mis_pp_tbl`
--

DROP TABLE IF EXISTS `mis_pp_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mis_pp_tbl` (
  `ProdActID` varchar(50) NOT NULL COMMENT '생산 Activity ID',
  `ProjectNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '호선 No',
  `ProdPlant` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '생산 Activity 작업공장',
  `ProdWorkPlace` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '생산 Activity 작업장',
  `PlanStartDateTime` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '생산 Activity 계획 시작 일시',
  `PlanFinishDateTime` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '생산 Activity 계획 종료 일시',
  `PlanQuant` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '생산 Activity 계획 물량',
  `PlanManHours` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '생산 Activity 계획 공수',
  `PerfStartDateTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '생산 Activity 실적 시작 일시',
  `PerfFinishDateTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '생산 Activity 실적 종료 일시',
  `PerfQuant` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '생산 Activity 실적 물량',
  `PerfManHours` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '생산 Activity 실적 공수',
  `EmployeeNumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '사번(작업자)',
  `InspectDate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '검사일',
  `InspectResult` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '검사 결과',
  `RobotWeldTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '생산 Activity 로봇 용접 시간',
  `RobotWeldLength` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '생산 Activity 로봇 용접 길이',
  `CadModelFileName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'CAD 모델 파일명',
  `CellDrawFileName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Cell 도면 파일명',
  `WeldModelNames` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '용접장 Model Names',
  PRIMARY KEY (`ProdActID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mis_pp_tbl`
--

LOCK TABLES `mis_pp_tbl` WRITE;
/*!40000 ALTER TABLE `mis_pp_tbl` DISABLE KEYS */;
INSERT INTO `mis_pp_tbl` VALUES ('292906_734266458_2','292906','용연공장','S1(용연4B북)','2025-07-11','2025-07-24','32.5','35','2025-07-11','2025-0-723','33.8','36','323187','2025-07-23','AA','13:25:45','2152800','292906_B13S-F51.stp','292906_B13S-F51.pdf','B13S'),('292906_734266534_6','292906','용연공장','S1(용연4B북)','2025-07-13','2025-07-19','24.6','28','2025-07-15','2025-07-22','29.5','31','356656','2025-07-22','AA','24:04:32','1056559','292906_B12S-TB48.stp','292906_B12S-TB48.pdf','B12S'),('292906_734266742_11','292906','용연공장','S1(용연4B북)','2025-07-10','2025-07-14','45.7','52','2025-07-09','2025-07-12','44.6','49','835457','2025-07-12','AC','22:34:02','2906280','292906_B13S-F50.stp','292906_B13S-F50.pdf','B13S'),('292906_734266769_13','292906','용연공장','S2(용연4C동)','2025-06-29','2025-07-05','37.0','47','2025-07-03','2025-07-15','39.0','46','835459','2025-07-15','AC','23:41:56','2691000','292906_B13S-F52.stp','292906_B13S-F52.pdf','B13S'),('292906_734266776_4','292906','용연공장','S2(용연4C동)','2025-07-11','2025-07-20','29.6','37','2025-07-11','2025-07-21','28.4','33','845654','2025-07-21','AA','19:43:09','7480385','292906_B13S-ST3A.stp','292906_B13S-ST3A.pdf','B13S'),('292906_734266782_4','292906','용연공장','S1(용연4B북)','2025-07-04','2025-07-09','34.6','44','2025-07-03','2025-07-12','32.5','37','835457','2025-07-12','AB','24:47:40','4528664','292906_B13S-F49.stp','292906_B13S-F49.pdf','B13S'),('292906_734266986_5','292906','용연공장','S1(용연4B북)','2025-07-06','2025-07-15','33.2','43','2025-07-07','2025-07-15','31.9','40','845654','2025-07-15','AB','22:15:48','10354468','292906_B13S-F49A.stp','292906_B13S-F49A.pdf','B13S'),('843206_734266765_12','843206','용연공장','S4(용연4F서)','2025-07-08','2025-07-11','30.8','37','2025-07-08','2025-07-12','31.3','38','845654','2025-07-12','AA','21:48:39','1864744','843206_B12S-F45.stp','843206_B12S-F45.pdf','B12S'),('843206_734266765_8','843206','용연공장','S1(용연4B북)','2025-07-10','2025-07-25','32.8','35','2025-07-13','2025-07-25','37.3','35','835457','2025-07-25','AB','23:45:38','3213837','843206_B12S-F47.stp','843206_B12S-F47.pdf','B12S'),('843206_734266766_1','843206','용연공장','S1(용연4B북)','2025-07-09','2025-07-24','31.6','35','2025-07-08','2025-07-25','33.7','34','835457','2025-07-25','A','22:13:15','19887526','843206_B12S-F46.stp','843206_B12S-F46.pdf','B12S');
/*!40000 ALTER TABLE `mis_pp_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pict_gap_dim`
--

DROP TABLE IF EXISTS `pict_gap_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pict_gap_dim` (
  `PictFileName` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '영상 파일명',
  `PictFileDateTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '영상 파일 생성 일시',
  `PictFileFolder` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '영상 파일 폴더명',
  `QualityTagInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '품질 태깅 정보',
  `QualityErrorDesc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '품질 불량 사유',
  `TagUser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '태깅 작업자(사번 or AI)',
  `RobotNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '로봇 번호',
  `ProjNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '호선 No',
  `BlockName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '블록 Name',
  `AssyName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Assy Name',
  `CellNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Cell No',
  `F2GapStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `F2GapEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `F3GapRightStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `F3GapRightEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `F3GapLeftStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `F3GapLeftEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Cpl2FGapStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Cpl2FGapEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Cpl3FGapStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Cpl3FGapEnd` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CellType` varchar(10) NOT NULL DEFAULT '',
  `Gap` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`PictFileName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pict_gap_dim`
--

LOCK TABLES `pict_gap_dim` WRITE;
/*!40000 ALTER TABLE `pict_gap_dim` DISABLE KEYS */;
INSERT INTO `pict_gap_dim` VALUES ('H843206-B13P-LB1A-A-10_0.pdf','2026-04-30 17:49:37','Z:\\HMD\\Robot\\Weld\\IOTImage','불량','-','AI','UR08','843206','DB11P','TT9A','9',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'A-C','CW:-10,CW1:-5,CH:5,CH1:10,RW1:10'),('H843206-B13P-LB1A-A-1_0.pdf','2026-04-30 17:31:30','Z:\\HMD\\Robot\\Weld\\IOTImage','불량','-','AI','UR08','843206','DB11P','TT1A','1','0','2','0','2','0','0','0','1','2','5','A-A','H:-10,CW1:-15,RH:10,RW1:20,RW2:20'),('H843206-B13P-LB1A-A-2_0.pdf','2026-04-30 17:33:04','Z:\\HMD\\Robot\\Weld\\IOTImage','불량','-','AI','UR08','843206','DB11P','TT2A','2','1','0','0','1','3','0','0','2','0','1','A-C','W:5,CW:10,CH:15,CH3:-5,RW2:10'),('H843206-B13P-LB1A-A-3_0.pdf','2026-04-30 17:34:49','Z:\\HMD\\Robot\\Weld\\IOTImage','정상','-','AI','UR08','843206','DB11P','TT3A','3','0','0','2','0','4','0','2','0','1','2','B-A','H:15,CW:-5,CH3:5,RW1:-10,RW2:15'),('H843206-B13P-LB1A-A-4_0.pdf','2026-04-30 17:35:58','Z:\\HMD\\Robot\\Weld\\IOTImage','불량','-','AI','UR08','843206','DB11P','TT4A','4','0','2','1','0','0','0','2','1','4','1','A-B','H:-10,CW1:-15,RH:10,RW1:20,RW2:20'),('H843206-B13P-LB1A-A-5_0.pdf','2026-04-30 17:38:10','Z:\\HMD\\Robot\\Weld\\IOTImage','정상','-','AI','UR08','843206','DB11P','TT5A','5','3','0','0','3','0','3','0','0','0','0','D-C','H:-10,CW1:-15,RH:10,RW1:20,RW2:20'),('H843206-B13P-LB1A-A-6_0.pdf','2026-04-30 17:41:02','Z:\\HMD\\Robot\\Weld\\IOTImage','정상','-','AI','UR08','843206','DB11P','TT6A','6','0','1','2','3','4','5','0','0','0','0','A-B','W:15,CH2:10,CH3:5,RW1:-5,RW2:-5'),('H843206-B13P-LB1A-A-7_0.pdf','2026-04-30 17:44:24','Z:\\HMD\\Robot\\Weld\\IOTImage','불량','CW값 실측 시 -8로 측정됨.','홍길동','UR08','843206','DB13P','TT1A','1','3','0','0','0','0','5','4','3','2','1','B-D','H:10,CW:-5,CW1:5,CW3:10,RW2:20'),('H843206-B13P-LB1A-A-8_0.pdf','2026-04-30 17:47:42','Z:\\HMD\\Robot\\Weld\\IOTImage','불량','-','AI','UR08','843206','DB11P','TT7A','7','5','1','2','0','0','0','0','5','5','5','C-A','W:-5,H:-10,CH:10,CH1:15,RH:20'),('H843206-B13P-LB1A-A-9_0.pdf','2026-04-30 17:48:52','Z:\\HMD\\Robot\\Weld\\IOTImage','정상','CH값 측정 시 12로 측정됨.','홍길동','UR08','843206','DB11P','TT8A','8','0','0','0','0','3','2','0','0','1','1','A-B','H:-15,CW:-5,CW3:5,CH:15,CH3:10');
/*!40000 ALTER TABLE `pict_gap_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preceding_process`
--

DROP TABLE IF EXISTS `preceding_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preceding_process` (
  `pronum` int NOT NULL DEFAULT '0',
  `division` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `performance` int NOT NULL DEFAULT '0',
  `expectation` int NOT NULL DEFAULT '0',
  `diff` int DEFAULT '0',
  `unproperfom` int DEFAULT NULL,
  `unproexpect` int DEFAULT NULL,
  `unprodiff` int DEFAULT NULL,
  PRIMARY KEY (`pronum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preceding_process`
--

LOCK TABLES `preceding_process` WRITE;
/*!40000 ALTER TABLE `preceding_process` DISABLE KEYS */;
INSERT INTO `preceding_process` VALUES (1,'조립',272,575,303,2,2,NULL),(2,'선행의장',108,78,30,4,7,75),(3,'1차PE',111,20,91,NULL,5,NULL),(4,'선행도장',160,200,40,2,1,50);
/*!40000 ALTER TABLE `preceding_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_chart`
--

DROP TABLE IF EXISTS `ps_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ps_chart` (
  `Month` int NOT NULL,
  `WorkTimes` int NOT NULL DEFAULT '0',
  `CuttingAmount` int NOT NULL DEFAULT '0',
  `DefensiveCount` int NOT NULL DEFAULT '0',
  `ToolChance` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='4-1차트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_chart`
--

LOCK TABLES `ps_chart` WRITE;
/*!40000 ALTER TABLE `ps_chart` DISABLE KEYS */;
INSERT INTO `ps_chart` VALUES (1,44,0,0,0),(2,36,0,0,0),(3,52,0,0,0),(4,37,12,4,0),(5,45,36,15,0),(6,43,32,36,0),(7,53,55,47,0),(8,42,122,55,0),(9,47,169,63,0),(10,50,198,120,0),(11,44,187,232,0),(12,48,122,210,0);
/*!40000 ALTER TABLE `ps_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repair_tbl`
--

DROP TABLE IF EXISTS `repair_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repair_tbl` (
  `RepairNo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '수선 순번',
  `BreakdnNo` varchar(50) NOT NULL COMMENT '고장 순번',
  `RobotNo` varchar(50) NOT NULL COMMENT '로봇 번호',
  `RepairDateTime` varchar(50) NOT NULL COMMENT '수선 일시',
  `RepairPart` varchar(50) NOT NULL COMMENT '수선 부품',
  `RepairCost` varchar(50) DEFAULT NULL COMMENT '수선 비용',
  `RepairDesc` varchar(255) DEFAULT NULL COMMENT '수선 내용',
  `File` varchar(10) NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`RepairNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repair_tbl`
--

LOCK TABLES `repair_tbl` WRITE;
/*!40000 ALTER TABLE `repair_tbl` DISABLE KEYS */;
INSERT INTO `repair_tbl` VALUES ('1_1','1','UR01','2024-08-01','파워 서플라이','5000000원','파워 서플라이 교체','YES'),('1_2','1','UR01','2024-08-01','파워 연결 케이블','150000원','파워 연결 라인 교체','YES'),('1_3','1','UR01','2024-08-01','파워 스위치','100000원','파워 스위치 교체','YES'),('2_1','2','UR04','2024-08-12','용접 조절 장치 ','1000000원','용접 조절 장치 교체','NO'),('3_1','3','UR07','2024-09-13','로봇 관절 연결 부품','250000원','로봇 관절 연결 부품 교체','NO'),('5_1','5','UR06','2024-10-03','이동체 캐터필더','300000원','이동체 캐터필더 교체','NO'),('6_1','6','UR04','2024-10-03','파워 연결 케이블','150000원','파워 연결 라인 교체','YES'),('7_1','7','UR05','2024-10-31','통신 센서','180000원','통신 센서 교체','NO'),('8_1','9','UR09','2025-09-25','파워 연결 케이블','160000원','포트포워딩 정상화','YES');
/*!40000 ALTER TABLE `repair_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot_kpi`
--

DROP TABLE IF EXISTS `robot_kpi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_kpi` (
  `robot` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `robotcount` int NOT NULL DEFAULT '0',
  `operate` int NOT NULL DEFAULT '0',
  `wait` int NOT NULL DEFAULT '0',
  `error` int NOT NULL DEFAULT '0',
  `operationrate` int NOT NULL DEFAULT '0',
  `controlrate` int NOT NULL DEFAULT '0',
  `productivity` int NOT NULL DEFAULT '0',
  `accuracy` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`robot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot_kpi`
--

LOCK TABLES `robot_kpi` WRITE;
/*!40000 ALTER TABLE `robot_kpi` DISABLE KEYS */;
INSERT INTO `robot_kpi` VALUES ('Total',5,4,0,1,80,90,30,98),('소조',4,4,0,0,100,85,10,92),('중조',1,0,0,1,0,80,15,95);
/*!40000 ALTER TABLE `robot_kpi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot_record_tbl`
--

DROP TABLE IF EXISTS `robot_record_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_record_tbl` (
  `RobotRecordID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `RobotNo` varchar(50) NOT NULL COMMENT '로봇 번호\\n',
  `WeldID` varchar(100) NOT NULL,
  `RobotPowerTime` varchar(50) NOT NULL,
  `RobotErrorTime` varchar(50) NOT NULL,
  `TouchTime` varchar(50) NOT NULL,
  `WeldTime` varchar(50) NOT NULL,
  `F2WeldTime` varchar(50) NOT NULL,
  `F3WeldTime` varchar(50) NOT NULL,
  `WorkPrepTime` varchar(50) NOT NULL,
  `CrossTime` varchar(50) NOT NULL,
  `DeckStopTime` varchar(50) NOT NULL,
  `WallStopTime` varchar(50) NOT NULL,
  `WeldOperStatus1Time` varchar(50) NOT NULL,
  `WeldOperStatus2Time` varchar(50) NOT NULL,
  `WeldOperStatus3Time` varchar(50) NOT NULL,
  `WeldOperStatus4Time` varchar(50) NOT NULL,
  `ControllerStatus0Time` varchar(50) NOT NULL,
  `ControllerStatus1Time` varchar(50) NOT NULL,
  `ControllerStatus2Time` varchar(50) NOT NULL,
  `ControllerStatus3Time` varchar(50) NOT NULL,
  `ControllerStatus4Time` varchar(50) NOT NULL,
  `ControllerStatus5Time` varchar(50) NOT NULL,
  `ControllerStatus6Time` varchar(45) NOT NULL,
  `ControllerStatus7Time` varchar(45) NOT NULL,
  `WeldElecCurrent` varchar(50) NOT NULL,
  `F2ElecCurrent` varchar(50) NOT NULL,
  `F3ElecCurrent` varchar(50) NOT NULL,
  `WeldElecVolt` varchar(50) NOT NULL,
  `F2ElecVolt` varchar(50) NOT NULL,
  `F3ElecVolt` varchar(50) NOT NULL,
  `WeldTemp` varchar(50) NOT NULL,
  `WeldArcRate` varchar(50) NOT NULL,
  `WeldLength` varchar(50) NOT NULL,
  `WeldSpeed` varchar(50) NOT NULL,
  `DeliverySpeed` varchar(50) NOT NULL,
  `WeldWeavWidth` varchar(50) NOT NULL,
  `WeldTypeSet` varchar(50) NOT NULL,
  `WireSettingSet` varchar(50) NOT NULL,
  `DigitalInputSet` varchar(50) NOT NULL,
  `DigitalOutputSet` varchar(50) NOT NULL,
  `SeqStatusSet` varchar(50) NOT NULL,
  `ErrorStatusSet` varchar(50) NOT NULL,
  `MovingDist` varchar(50) NOT NULL,
  PRIMARY KEY (`RobotRecordID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot_record_tbl`
--

LOCK TABLES `robot_record_tbl` WRITE;
/*!40000 ALTER TABLE `robot_record_tbl` DISABLE KEYS */;
INSERT INTO `robot_record_tbl` VALUES ('20250801_13_BEIA60021_','6호기','BEIA60021_','0:52:15','0:03:26','0:08:22','0:41:55','0:16:50','0:25:05','0:01:04','0:02:31','0:01:38','0:00:59','0:00:00','0:12:34','0:08:28','0:43:56','0:00:00','0:51:23','0:03:07','0:03:31','0:03:32','0:03:39','0:03:50','0:03:46','153A','143A','166A','227V','231V','222V','47','85%','16403mm','12mm/sec','22.3m/min','30.3mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','8420mm'),('20250801_13_BEIA60022_','1호기','BEIA60022_','0:51:38','0:04:12','0:05:06','0:40:27','0:09:21','0:29:13','0:03:51','0:04:48','0:03:34','0:02:57','0:04:50','0:07:56','0:06:51','0:36:17','0:02:43','0:46:27','0:03:07','0:04:42','0:03:33','0:03:38','0:03:51','0:03:55','149A','152A','146A','225V','230V','219V','45','83%','15812mm','11mm/sec','21.8m/min','31.0mm','CO2','2Torch','Touch','WCR','크레이터','통신','7931mm'),('20250801_14_BEIA60021_','6호기','BEIA60021_','0:54:15','0:02:13','0:07:37','0:47:34','0:21:46','0:30:09','0:02:19','0:03:12','0:02:19','0:01:55','0:02:00','0:10:45','0:07:37','0:40:59','0:00:00','0:48:51','0:02:01','0:05:23','0:03:34','0:03:37','0:03:49','0:03:45','150A','152A','149A','226V','230V','221V','47','84%','16816mm','12mm/sec','21.9m/min','29.9mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','8639mm'),('20250801_14_BEIA60022_','1호기','BEIA60022_','0:55:09','0:01:10','0:04:02','0:49:17','0:30:20','0:26:58','0:02:00','0:06:09','0:03:04','0:03:57','0:01:25','0:06:15','0:09:13','0:36:51','0:00:00','0:52:51','0:01:45','0:03:25','0:03:35','0:03:36','0:03:52','0:03:56','147A','151A','144A','229V','233V','226V','48','81%','17140mm','12mm/sec','22.3m/min','30.2mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','8912mm'),('20250801_15_BEIA60021_','6호기','BEIA60021_','0:37:28','0:00:00','0:02:41','0:35:51','0:20:31','0:12:45','0:03:07','0:03:12','0:01:11','0:01:55','0:01:05','0:03:05','0:06:37','0:29:45','0:03:10','0:24:35','0:01:58','0:01:57','0:03:36','0:03:35','0:03:48','0:03:44','148A','154A','143A','231V','236V','228V','48','84%','9034mm','14mm/sec','20.3m/min','31.5mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','5015mm'),('20250801_15_BEIA60022_','1호기','BEIA60022_','0:39:51','0:02:39','0:01:38','0:34:36','0:30:25','0:12:34','0:01:45','0:02:11','0:02:26','0:02:43','0:00:24','0:03:53','0:04:56','0:28:56','0:00:00','0:26:37','0:00:57','0:01:28','0:03:37','0:03:34','0:03:53','0:03:57','150A','142A','160A','226V','230V','221V','45','80%','10543mm','13mm/sec','19.4m/min','33.6mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','4567mm'),('20250801_16_BEIA60021_','6호기','BEIA60021_','0:56:34','0:03:19','0:06:23','0:52:14','0:41:51','0:30:42','0:03:04','0:08:49','0:07:45','0:05:33','0:05:10','0:06:41','0:10:11','0:39:24','0:00:00','0:54:49','0:03:00','0:05:25','0:03:38','0:03:33','0:03:47','0:03:43','152A','156A','144A','229V','234V','225V','45','81%','21142mm','14mm/sec','24.9m/min','30.2mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','9122mm'),('20250801_16_BEIA60022_','1호기','BEIA60022_','0:52:31','0:04:26','0:08:10','0:47:51','0:43:40','0:28:44','0:04:05','0:07:18','0:05:28','0:04:49','0:03:25','0:07:11','0:12:17','0:41:43','0:00:00','0:53:02','0:02:51','0:04:25','0:03:39','0:03:32','0:03:54','0:03:30','146A','155A','143A','228V','235V','224V','48','89%','19416mm','10mm/sec','20.1m/min','36.2mm','CO2','2Torch','Touch','WCR','크레이터','2차 과전류','9947mm');
/*!40000 ALTER TABLE `robot_record_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot_tbl`
--

DROP TABLE IF EXISTS `robot_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_tbl` (
  `RobotNo` int NOT NULL AUTO_INCREMENT COMMENT '로봇 번호',
  `RobotName` varchar(50) NOT NULL DEFAULT '로봇명',
  `Maker` varchar(100) NOT NULL COMMENT 'Maker',
  `ModelName` varchar(100) NOT NULL COMMENT '모델명',
  `SerialNo` varchar(100) NOT NULL COMMENT 'Serial No',
  `WeldID` varchar(100) NOT NULL DEFAULT 'NA' COMMENT '용접기 식별 번호',
  `WeldModelName` varchar(100) NOT NULL DEFAULT 'NA' COMMENT '용접기 모델명',
  `ControllerSerialNo` varchar(100) NOT NULL DEFAULT '0' COMMENT '제어기 S/N',
  `RobotStatus` varchar(100) NOT NULL DEFAULT '미가동' COMMENT '로봇 상태',
  `Weight` varchar(50) NOT NULL COMMENT '중량',
  `PurchDate` varchar(50) NOT NULL COMMENT '구매 일자',
  `InspectDate` varchar(50) DEFAULT NULL COMMENT '점검 일자',
  `MaintPeriod` varchar(50) DEFAULT NULL COMMENT '점검 기간',
  `RobotType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`RobotNo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot_tbl`
--

LOCK TABLES `robot_tbl` WRITE;
/*!40000 ALTER TABLE `robot_tbl` DISABLE KEYS */;
INSERT INTO `robot_tbl` VALUES (1,'UR01','Universal Robots','UR3','UR3A001001','BEIA60021_','H600MR','0','정상','10.5kg','2024-07-01','2026-04-01','7개월','중조(Cell)'),(2,'UR02','Universal Robots','UR3','UR3A001002','BEIA60022_','H600MR','0','정상','10.5kg','2024-07-01','2026-07-01','6개월','중조(Cell)'),(3,'UR03','Universal Robots','UR3','UR3A001003','BEIA60023_','H600MR','0','정상','10.5kg','2024-07-01','2026-07-01','6개월','중조(Cell)'),(4,'UR04','Universal Robots','UR3','UR3A001004','BEIA60024_','H600MR','0','정상','10.5kg','2024-08-01','2026-02-02','6개월','중조(Cell)'),(5,'UR05','Universal Robots','UR3','UR3A001005','BEIA60025_','H600MR','0','정상','10.5kg','2024-08-01','2026-02-02','6개월','중조(Cell)'),(6,'UR06','Universal Robots','UR3','UR3A001006','BEIA60026_','H600MR','0','정상','10.5kg','2024-08-01','2026-02-02','6개월','중조(Cell)'),(7,'RB01','Rainbow Robotics','RB3-730','RB37302001','BEIA70021_','H730MR','0','정상','11.0kg','2024-09-16','2026-05-15','5개월','중조(Cell)'),(8,'RB02','Rainbow Robotics','RB3-730','RB37302002','BEIA70022_','H730MR','0','비정상','11.0kg','2024-09-16','2026-05-15','5개월','중조(Cell)'),(9,'HR01','Hyundai Robotics','HDR20-17','HR20171001','BEIA80031_','H1742MR','0','정상','20.0kg','2025-01-10','2026-01-12','12개월','중조(Cell)'),(10,'HR02','Hyundai Robotics','HDR20-20','HR20201001','NA','NA','0','미가동','20.0kg','2023-01-02','2026-07-02','6개월','중조(Cell)'),(11,'HR03','Hyundai Robotics','HDR21-20','HR20211234','NA','NA','0','미가동','21.0kg','2021-02-22','2026-02-23','12개월','중조(Cell)');
/*!40000 ALTER TABLE `robot_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robot_weld_tbl`
--

DROP TABLE IF EXISTS `robot_weld_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `robot_weld_tbl` (
  `WeldID` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접기 식별 번호',
  `RobotNo` varchar(50) NOT NULL COMMENT '로봇 번호',
  `DataCount` varchar(50) NOT NULL COMMENT 'Data Count',
  `WeldOperatStatus` varchar(50) NOT NULL COMMENT '용접기 동작 상태',
  `WeldSpeed` varchar(50) NOT NULL COMMENT '용접기 속도',
  `DeliverySpeed` varchar(50) NOT NULL COMMENT '송급 속도',
  `WeldElecVolt` varchar(50) NOT NULL COMMENT '용접기 전압',
  `2FElecVolt` varchar(50) NOT NULL COMMENT '2F 전압',
  `3FElecVolt` varchar(50) NOT NULL COMMENT '3F 전압',
  `WeldElecCurrent` varchar(50) NOT NULL COMMENT '용접기 전류',
  `2FElecCurrent` varchar(50) NOT NULL COMMENT '2F 전류',
  `3FElecCurrent` varchar(50) NOT NULL COMMENT '3F 전류',
  `WeldTemp` varchar(50) NOT NULL COMMENT '용접 온도',
  `WeldArcRate` varchar(50) NOT NULL COMMENT '용접 아크율',
  `WeldWeavWidth` varchar(50) NOT NULL COMMENT '용접 위빙 폭',
  `WeldLength` varchar(50) NOT NULL COMMENT '용접 길이',
  `WorkPrepTime` varchar(50) NOT NULL COMMENT '작업 준비 시간',
  `IntersectTime` varchar(50) NOT NULL COMMENT '교차 시간',
  `TouchTime` varchar(50) NOT NULL COMMENT '터치 시간',
  `WeldTime` varchar(50) NOT NULL COMMENT '용접 시간',
  `2FWeldTime` varchar(50) NOT NULL COMMENT '2F 용접 시간',
  `3FWeldTime` varchar(50) NOT NULL COMMENT '3F 용접 시간',
  `WeldTypeSet` varchar(50) NOT NULL COMMENT '용접 종류 설정',
  `WireSettingSet` varchar(50) NOT NULL COMMENT 'Wire/Setting 설정',
  `DigitalInputSet` varchar(50) NOT NULL COMMENT 'Digital Input 설정',
  `DigitalOutputSet` varchar(50) NOT NULL COMMENT 'Digital Output 설정',
  `SeqStatusSet` varchar(50) NOT NULL COMMENT '시퀀스 상태 설정',
  `ErrorStatusSet` varchar(50) NOT NULL COMMENT '에러 상태 설정',
  `WeldModelName` varchar(50) DEFAULT NULL COMMENT '용접장 Model Name',
  `WeldPartName` varchar(50) DEFAULT NULL COMMENT '용접장 Part Name',
  `CurrentPass` varchar(50) NOT NULL COMMENT '현재 패스',
  `CellNo` varchar(50) NOT NULL,
  `CellType` varchar(50) NOT NULL COMMENT 'Cell Type',
  `ProjectNo` varchar(50) NOT NULL COMMENT '호선 No',
  `BlockName` varchar(50) NOT NULL COMMENT '블록 Name',
  `AssyName` varchar(50) NOT NULL COMMENT 'Ass''y Name',
  `UserName` varchar(50) NOT NULL COMMENT '작업자',
  PRIMARY KEY (`WeldID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robot_weld_tbl`
--

LOCK TABLES `robot_weld_tbl` WRITE;
/*!40000 ALTER TABLE `robot_weld_tbl` DISABLE KEYS */;
INSERT INTO `robot_weld_tbl` VALUES ('48','0','12','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','4m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('49','1','14','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','2m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('50','0','13','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','5m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('54','1','11','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','3m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('65','1','10','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','1m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('66','0','7','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','13.3m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('69','0','8','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','13.3m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('73','1','9','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','13.3m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555'),('95','1','15','1','11','42','230','0','0 > 250','168,0','0','0 > 180','0','3','30','10m','10','13','23','46','0','30','1','10','0','0','1','0','34383835-30533133-34343434','Iron','4','0','13','34383835','30533133','34343434','55555555');
/*!40000 ALTER TABLE `robot_weld_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `row_data_tbl`
--

DROP TABLE IF EXISTS `row_data_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `row_data_tbl` (
  `RowDataID` varchar(255) NOT NULL COMMENT 'Row Data ID',
  `CommStart` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '통신 시작',
  `DataCount` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Data Count',
  `EquipmentType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '설비 종류',
  `FeederType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '송급기 종류',
  `WelderModel` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접기 모델명',
  `WelderVersion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접기 버전',
  `FeederVersion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '송급기 버전',
  `ExtFeederVersion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '익스텐션 송급기 버전',
  `WeldID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접기 식별번호',
  `FeedID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '송급기 식별번호',
  `ExtFeedID` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '익스텐션 송급기 식별번호',
  `WeldMethod` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '기법',
  `WiresettingSet` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Wire/Setting',
  `DigitalInput` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Digital Input',
  `DigitalOutput` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Digital Output',
  `SequenceStatus` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '시퀀스 상태',
  `ErrorStatus` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '에러 상태',
  `CurrentCommand` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전류 지령',
  `VlotageCommand` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전압 지령',
  `FeedSpeedCommand` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '송급 속도 지령',
  `CurrentFeedback1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전류 피드백 1',
  `VoltageFeedback1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전압 피드백 1',
  `FeedSpeedFeedback1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '송급 속도 피드백 1',
  `CurrentFeedback2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전류 피드백 2',
  `VoltageFeedback2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전압 피드백 2',
  `FeedSpeedFeedback2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '송급 속도 피드백 2',
  `TempData1` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '온도데이터 1',
  `TempData2` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '온도데이터 2',
  `TempData3` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '온도데이터 3',
  `TempData4` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '온도데이터 4',
  `TempData5` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '온도데이터 5',
  `RelayOperation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '릴레이 동작',
  `CheckSUM` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Check SUM',
  `CRC` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'CRC/1차 DATA 종료',
  `Cobot` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Cobot',
  `CommStatusCheck` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '통신 상태 체크',
  `ControllerStatus` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '제어기 상태',
  `RobotSerialNumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '로봇 S/N',
  `ControllerSerialNumber` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '제어기 S/N',
  `CableInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '호선정보',
  `BlockInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '블록정보',
  `AssyInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '아세이 정보',
  `OperatorInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '작업자 정보',
  `HighBit` varchar(50) NOT NULL,
  `RobotProgramVersion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '로봇 프로그램 버전',
  `PendantPorgramVersion` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '팬던트 프로그램 버전',
  `TCPInfoX` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'TCP 정보 X',
  `TCPInfoY` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'TCP 정보 Y',
  `TCPInfoZ` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'TCP 정보 Z',
  `TCPInfoRx` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'TCP 정보 Rx',
  `TCPInfoRy` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'TCP 정보 Ry',
  `TCPInfoRz` varchar(50) NOT NULL COMMENT 'TCP 정보 Rz',
  `TCPChangeCount` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'TCP 변경 횟수',
  `OperatStatus` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '동작 상태',
  `RobotStatus` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '로봇 상태',
  `TouchInfoStart` varchar(50) NOT NULL,
  `TouchInfoEnd` varchar(50) NOT NULL,
  `TouchInfoCell` varchar(50) NOT NULL,
  `TouchInfoNum` varchar(50) NOT NULL,
  `FullPass` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전체패스',
  `CurrentPass` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '현재패스',
  `NavHeight` varchar(50) NOT NULL COMMENT '방향 탐색 높이',
  `TouchHeight` varchar(50) NOT NULL COMMENT '터치 높이',
  `StartOperatSpeed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Start 주행 속도',
  `StartWeavWidth` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Start 위빙 폭',
  `EndOperatSpeed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'End 주행 속도',
  `EndWeavWidth` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'End 위빙 폭',
  `FloorStopTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '바닥 멈춤 시간',
  `WallStopTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '벽 멈춤 시간',
  `WorkAngle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '작업 각',
  `XOffset` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'X 오프셋',
  `ZOffset` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Z 오프셋',
  `VoltageOffset` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '전압옵셋',
  `ArcsensingOffset` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '아크센싱옵셋',
  `WeldTimeStart2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 용접시간(Start)',
  `CurrentStart2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 전류 (Start)',
  `VoltageStart2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 전압 (Start)',
  `WeldTime1End2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 용접시간 1(End)',
  `Current1End2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 전류 1 (End)',
  `Voltage1End2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 전압 1 (End)',
  `WeldTime2End2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 용접시간 2(End)',
  `Current2End2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 전류 2 (End)',
  `Voltage2End2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 전압 2 (End)',
  `WeldTimeStart3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 용접시간 (Start)',
  `CurrentStart3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 전류 (Start)',
  `VoltageStart3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 전압 (Start)',
  `WeldTimeEnd3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 용접시간 (End)',
  `CurrentEnd3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 전류 (End)',
  `VoltageEnd3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 전압 (End)',
  `InitialGasTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '초기 가스 시간',
  `FinalGasTime` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '후기 가스 시간',
  `CellType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '셀 타입',
  `Dimension2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 치수',
  `LeftNonWeldLength2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 왼쪽 비용접장',
  `RightNonWeldLength2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 오른쪽 비용접장',
  `CPL2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F CPL',
  `LeftDimension3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 왼쪽 치수',
  `RightDimension3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 오른쪽 치수',
  `CPL3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F CPL',
  `WireType` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Wire 종류',
  `Leglength2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 각장',
  `Leglength3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 각장',
  `CPL2FLeglength` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'CPL 2F 각장',
  `CPL3FLeglength` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'CPL 3F 각장',
  `GapInfo2F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '2F 갭 정보',
  `GapInfo3F` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '3F 갭 정보',
  `CPL2FGapInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'CPL 2F 갭 정보',
  `CPL3FGapInfo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'CPL 3F 갭 정보',
  `FunctionFlag` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '기능 플래그',
  `CellSelectFlag` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `OtherInfoFlag` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '기타 정보 플래그',
  `WeldStartPointX` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접 시작점 Start_X',
  `WeldStartPointY` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접 시작점 Start_Y',
  `WeldStartPointZ` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접 시작점 Start_Z',
  `WeldEndPointX` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접 끝점 End_X',
  `WeldEndPointY` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용접 끝점 End_Y',
  `WeldEndPointZ` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '용점 끝점 End_Z',
  `AxisInfo1Current` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 1_Current',
  `AxisInfo2Current` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 2_Current',
  `AxisInfo3Current` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 3_Current',
  `AxisInfo4Current` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 4_Current',
  `AxisInfo5Current` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 5_Current',
  `AxisInfo6Current` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 6_Current',
  `AxisInfo1Angle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 1_Angle',
  `AxisInfo2Angle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 2_Angle',
  `AxisInfo3Angle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 3_Angle',
  `AxisInfo4Angle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 4_Angle',
  `AxisInfo5Angle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 5_Angle',
  `AxisInfo6Angle` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 6_Angle',
  `AxisInfo1Speed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 1_Speed',
  `AxisInfo2Speed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 2_Speed',
  `AxisInfo3Speed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 3_Speed',
  `AxisInfo4Speed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 4_Speed',
  `AxisInfo5Speed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 5_Speed',
  `AxisInfo6Speed` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 6_Speed',
  `AxisInfo1Temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 1_Temp',
  `AxisInfo2Temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 2_Temp',
  `AxisInfo3Temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 3_Temp',
  `AxisInfo4Temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 4_Temp',
  `AxisInfo5Temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 5_Temp',
  `AxisInfo6Temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '축별 정보 6_Temp',
  PRIMARY KEY (`RowDataID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `row_data_tbl`
--

LOCK TABLES `row_data_tbl` WRITE;
/*!40000 ALTER TABLE `row_data_tbl` DISABLE KEYS */;
INSERT INTO `row_data_tbl` VALUES ('Data1','3A','7','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','31','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFCC','160','52F','2BA','FF37','FFF6','15B','1974','197A','1711','365','4EA','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data10','3A','10','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','3A','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFCF','51','6B5','18F','F8CC','281','1B5','199E','169B','19A8','247','6F1','0','0A','92AE','0','92AE','0','25','27','2C','2D','30','2D'),('Data11','3A','11','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','3B','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFCF','51','6B5','18F','F8CC','281','1C1','19A7','16A3','1991','240','6FF','0A','929A','0A','0','92AE','0','25','27','2C','2D','30','2D'),('Data12','3A','12','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','3C','3B','1','3','7','1','0/0/0/FD','1/3/FA/0','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FF05','1D0','4BE','1A1','F862','1CA','1C1','19A7','16A3','1991','240','6FF','0A','929A','0A','0','92AE','0','25','27','2C','2D','30','2D'),('Data13','3A','13','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','3D','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FF05','1D0','4BE','1A1','F862','209','1CD','19B6','16A8','1973','23A','70D','0','0','92AE','0','0','0','25','27','2C','2D','30','2D'),('Data14','3A','14','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','3E','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFF0','27B','4E7','16B','F71C','209','1D6','19C3','16AC','195C','234','718','0','0','92AE','0','0','0','25','27','2C','2D','30','2D'),('Data15','3A','15','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','3F','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFF7','223','46A','1C1','F73C','1BB','1D6','19C3','16AC','195C','234','718','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data16','3A','16','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','40','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFF7','223','46A','1C1','F73C','1BB','232','1A09','16E0','189B','24B','782','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data17','3A','17','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','41','3B','1','3','7','1','0/0/0/FD','1/3/FA/0','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FE73','82','6F4','0A0','23','FF4C','232','1A09','16E0','189B','24B','782','9218','925E','122','91DC','82','91DC','25','27','2C','2D','30','2D'),('Data18','3A','18','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','5B','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FE73','82','6F4','0A0','23','FF4C','157','1973','1976','170F','364','4F7','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data19','3A','19','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','5C','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/0/0','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','2D','22','2D','22','0','0','32','1E','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','00CC','0E0','5FA','2A7','FF74','FFF5','1BC8','1920','1860','18B1','362','508','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data2','3A','8','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','32','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFD8','18F','529','2C0','FF32','FFFE','15B','1974','197A','1711','365','4EA','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data20','3A','1A','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','5D','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','2D','22','2D','22','0','0','32','1E','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FD78','28F','60F','2F0','FAA3','FEVF','1BC8','1920','1860','18B1','362','508','64','918C','12C','91F0','9204','9290','25','27','2C','2D','30','2D'),('Data21','3A','1B','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','5E','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','2D','22','2D','22','0','0','32','1E','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FD78','28F','60F','2F0','FAA3','FEVF','19','1794','19E8','17C4','296','4E6','28','03C','924A','28','0','28','25','27','2C','2D','30','2D'),('Data22','3A','1C','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','5F','3B','1','3','7','1','0/0/0/FD','1/3/FA/0','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FF46','369','55D','0FB','FDF7','FEC4','19','1794','19E8','17C4','296','4E6','28','03C','924A','28','0','28','25','27','2C','2D','30','2D'),('Data23','3A','1D','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','60','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','018F','4F3','44F','0FB','FDF7','FEC4','02A','17B6','19CE','17C0','2A9','4DD','28','32','924A','1E','0','28','25','27','2C','2D','30','2D'),('Data24','3A','1E','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','61','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','018F','4F3','44F','180','FFF5','02F','39','17D3','19BB','17BB','2BD','4D3','28','32','924A','1E','0','28','25','27','2C','2D','30','2D'),('Data25','3A','1F','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','62','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','012D','78E','322','0A2','27','FFCA','39','17D3','19BB','17BB','2BD','4D3','32','32','924A','1E','0A','32','25','27','2C','2D','30','2D'),('Data26','3A','20','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','63','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','012D','78E','322','0A2','27','FFCA','45','17EA','19B5','17B2','2D0','4C4','32','32','9254','1E','0A','28','25','27','2C','2D','30','2D'),('Data27','3A','21','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','64','3B','1','3','7','1','0/0/0/FD','1/3/FA/0','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','216','600','2FC','0FF','1ED','4','45','17EA','19B5','17B2','2D0','4C4','32','32','9254','1E','0A','28','25','27','2C','2D','30','2D'),('Data28','3A','22','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','4C','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','011B','61B','2F7','0D5','20E','FFC9','51','17FE','19B1','17A9','2E4','4B6','9290','929A','28','9286','92A4','9286','25','27','2C','2D','30','2D'),('Data29','3A','23','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','4D','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','011B','61B','2F7','0D5','20E','FFC9','69','1842','1943','17F1','2E9','4B7','9290','929A','28','92A4','0','927C','25','27','2C','2D','30','2D'),('Data3','3A','9','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','33','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFD8','18F','529','2C0','FF32','FFFE','15B','1974','197A','1711','365','4EA','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data30','3A','24','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','4E','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FF61','267','638','152','22','FE89','69','1842','1943','17F1','2E9','4B7','9286','9290','3C','92A4','0','927C','25','27','2C','2D','30','2D'),('Data31','3A','25','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','4F','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FF61','267','638','152','22','FE89','80','187D','18F6','1820','2F5','4B4','9268','9290','46','92A4','14','9240','25','27','2C','2D','30','2D'),('Data32','3A','26','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','50','3B','1','3','7','1','0/0/0/FD','1/3/FA/0','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','020F','4B0','308','0BA','30D','FF9C','80','187D','18F6','1820','2F5','4B4','9268','9290','46','92A4','14','9240','25','27','2C','2D','30','2D'),('Data33','3A','27','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','51','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','51','71','32','32','30','22','30','22','0','0','0','0','0','0','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','169','3B9','34E','FFF5','313','FEBB','92','189C','18DB','1829','307','4AC','32','1E','9286','0A','0','32','25','27','2C','2D','30','2D'),('Data4','3A','0A','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','34','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FFD1','184','52C','2BF','FF26','FFFE','15B','1974','197A','1711','365','4EA','0','0','0','0','0','0','25','27','2C','2D','30','2D'),('Data5','3A','0B','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','35','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FDF5','128','533','3D5','FA16','1BD','18A','19CF','18DB','175E','33A','558','92A4','92A4','916E','12C','9236','BE','25','27','2C','2D','30','2D'),('Data6','3A','0C','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','36','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','FDF5','128','533','3D5','FA16','1BD','19E','1982','168F','19DD','256','6D6','92A4','92A4','916E','12C','9236','BE','25','27','2C','2D','30','2D'),('Data7','3A','0D','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','37','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','10','1CC','71D','376','F9B4','75','19E','1982','168F','19DD','256','6D6','0','01E','929A','929A','92AE','0A','25','27','2C','2D','30','2D'),('Data8','3A','0E','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','38','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','10','1CC','71D','376','F9B4','75','1AA','1995','1694','19C0','24E','6E4','0','01E','92A4','929A','92AE','0','25','27','2C','2D','30','2D'),('Data9','3A','0F','5','1','48/36/30/30/4D/52/5F/5F/5F/5F/5F','30/31/30/30','30/30/30/30','30/30/30/30','42/45/49/41/36/30/30/32/31/5F','30/30/30/30/30/30/30/30/30/5F','30/30/30/30/30/30/30/30/30/5F','1','0A','0','0','1','0','0A8','0E6','2A','0','0','0','0','0','0','0','0','0','0','0','40','39','3B','1','3','7','1','34/38/38/35','30/53/31/33','34/34/34/34','55/55/55/55','02F','0','263','FF34','FFFF','17F','4E7','00A','F4C2','0','1','0','17','23','23','0','0','50','41','32','32','0C','1E','0C','1E','2','2','0','0','0','F5','3','0','0','0','0','0','0','0','0','0','1E','0B4','0FA','1E','0B4','0FA','0','0','13','2BC','0','0','96','8C','82','82','1','6','66','7','6','5','55','5','11','8','4','1','1380','F629','FECA','1380','F629','3DF','005E','0D7','7B2','313','F868','1EC','1AA','1995','1694','19A8','247','6F1','0','01E','92A4','929A','92AE','0','25','27','2C','2D','30','2D');
/*!40000 ALTER TABLE `row_data_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_event`
--

DROP TABLE IF EXISTS `schedule_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `start_dt` datetime NOT NULL,
  `end_dt` datetime DEFAULT NULL,
  `all_day` tinyint(1) DEFAULT '0',
  `category` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ev_type` enum('HUMAN','ROBOT') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_schedule_range` (`start_dt`,`end_dt`),
  KEY `idx_schedule_event_range` (`start_dt`,`end_dt`,`ev_type`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_event`
--

LOCK TABLES `schedule_event` WRITE;
/*!40000 ALTER TABLE `schedule_event` DISABLE KEYS */;
INSERT INTO `schedule_event` VALUES (1,'라인2 정기점검','2025-08-28 09:00:00','2025-08-28 11:00:00',0,'업무','#2e86de','','2025-08-27 07:34:01','HUMAN'),(2,'[25059] 4021-E32P, 1~5, 이몽룡[UR5]','2025-08-25 09:00:00','2025-08-27 18:00:00',0,'업무','#2e86de','[25059] 4021-E32P, 1~5, 이몽룡[5]','2025-08-27 07:34:01','HUMAN'),(3,'연차','2025-08-25 00:00:00','2025-08-26 00:00:00',1,'개인','#27ae60','','2025-08-27 07:34:01','HUMAN'),(4,'[25038] 4201-B22S, 1~15, 이몽룡[UR1]','2025-09-10 09:30:00','2025-09-12 18:30:00',0,'업무','#2e86de','[25038] 4201-B22S, 1~15, 이몽룡[1]','2025-09-15 07:20:32','HUMAN'),(5,'[UR6] 4021-B22S, 1~15','2025-09-16 09:00:00','2025-09-19 19:00:00',0,NULL,'#8e44ad','[6] 4021-B22S, 1~15','2025-09-16 07:40:13','ROBOT'),(6,'[UR6] 4021-E21P, 11~27','2025-09-08 10:00:00','2025-09-10 19:00:00',0,NULL,'#8e44ad','[6] 40210-E21P, 11~27','2025-09-16 07:41:50','ROBOT'),(7,'[25047] 4021-E31S, 6~15, 홍길동[UR6]','2025-09-11 09:30:00','2025-09-12 18:30:00',0,'업무','#2e86de','[25047] 4021-E31S, 6~15, 홍길동[6]','2025-09-17 01:30:24','HUMAN'),(8,'[25061] 4021-E42S-ER4, 1~15, 미정[UR2]','2025-09-29 10:00:00','2025-10-01 18:10:00',0,'업무','#2e86de','워크오더[미정]','2025-09-17 01:32:53','HUMAN'),(9,'추석연휴','2025-10-02 00:44:00','2025-10-10 00:00:00',0,'개인','#27ae60','추석연휴','2025-09-17 01:44:48','HUMAN'),(10,'[25044] 4201-B12P, 1~19, 홍길동[UR6]','2025-09-08 09:30:00','2025-09-08 18:30:00',0,'업무','#2e86de','[25044] 4201-B12P, 1~19, 홍길동[6]','2025-09-17 04:21:51','HUMAN'),(11,'[25059] 4021-E32P-DB3, 1~25, 이몽룡[UR5]','2025-11-10 14:00:00','2025-11-12 15:30:00',0,'업무','#2e86de','[25059] 4021-E32P, 1~25, 이몽룡[6]','2025-09-17 06:59:46','HUMAN'),(12,'[25036] 4201-B22S-TT1, 1~10, 홍길동[UR6]','2025-11-10 08:00:00','2025-11-12 18:00:00',0,'업무','#2e86de','[25036] 4201-B22S, 1~15, 홍길동[UR-6]','2025-09-17 07:07:47','HUMAN'),(13,'[25057] 4021-E31P-ER3, 8~32, 홍길동[UR1]','2025-11-17 09:30:00','2025-11-18 17:50:00',0,'업무','#2e86de','[25057] 4021-E31P, 8~32, 홍길동[1]','2025-09-17 07:36:38','HUMAN'),(14,'[25053] 4201-E21P-ER2, 6~15, 이몽룡[UR1]','2025-11-19 09:00:00','2025-11-21 18:00:00',0,'업무','#2e86de','[25053] 4201-E21P, 6~15, 이몽룡[UR1]','2025-09-17 08:27:18','HUMAN'),(15,'[UR6] 8620-B12P, 1~19','2025-09-01 10:00:00','2025-09-04 18:00:00',0,'','#8e44ad','[6] 8620-B12P, 1~19','2025-09-17 08:28:36','ROBOT'),(16,'[UR6] 4021-E31S, 6~15','2025-09-11 08:00:00','2025-09-12 18:30:00',0,'','#8e44ad','[6] 4021-E31S, 6~15','2025-09-17 08:30:16','ROBOT'),(17,'[UR6] 고장 수리','2025-09-05 10:00:00','2025-09-06 21:00:00',0,'','#8e44ad','6호가 수리중','2025-09-18 08:58:52','ROBOT'),(18,'[UR6] 40210-E21P. 11~27','2025-09-08 09:00:00','2025-09-10 18:00:00',1,'업무','#2e86de','[6] 40210-E21P. 11~27','2025-09-18 08:59:57','HUMAN'),(19,'[UR6] 4021-E31S6~15','2025-09-15 09:00:00','2025-09-15 18:00:00',1,'','#8e44ad','[6] 4021-E31S6~15','2025-09-18 09:14:36','ROBOT'),(20,'[25048] 4201-E21P, 1~15, 홍길동[UR2]','2025-09-22 10:25:00','2025-09-26 18:25:00',0,'업무','#2e86de','[25048] 4201-E21P, 1~15, 홍길동[2]','2025-09-19 01:26:36','HUMAN'),(21,'오더 일정 작성','2025-09-01 08:00:00','2025-09-03 18:00:00',0,'업무','#2e86de','홍길동, 이몽룡 오더 일정 작성','2025-09-19 02:20:20','HUMAN'),(22,'[25061] 4021-E42S-ER4','2025-11-17 07:30:00','2025-11-19 19:30:00',0,'','#8e44ad','[25061] 4021-E42S','2025-09-19 04:28:57','ROBOT'),(24,'용접로봇 점검','2025-08-11 08:30:00','2025-08-14 18:30:00',0,NULL,'#8e44ad','용접로봇 ALL 점검','2025-09-22 02:35:28','ROBOT'),(25,'dd','2025-10-19 20:41:00','2025-10-21 20:41:00',0,'업무','#2e86de','수정 테스트','2025-09-22 05:41:43','HUMAN'),(27,'연구본부 출장','2025-09-22 09:00:00','2025-09-26 18:00:00',0,'개인','#27ae60','본부장, 팀장 중국 상하이 방문','2025-09-23 05:34:06','HUMAN'),(28,'[UR1] 842506-B12P 작업','2025-11-03 09:00:00','2025-11-07 18:00:00',0,'','#8e44ad','R1 - 842506-B12P-Cell1, R2 - 842506-B12P-Cell2, R3 - 842506-B12P-Cell3 로봇 해당 호선 작업','2025-11-07 01:36:26','ROBOT'),(29,'박미진 대리 오후반차','2025-11-07 13:00:00','2025-11-07 18:00:00',0,'개인','#27ae60','병원 방문 위한 오후 반차','2025-11-07 01:38:59','HUMAN'),(30,'인수인계 회의','2025-10-31 14:00:00','2025-10-31 15:00:00',0,'업무','#2e86de','마킹기 작업 인수인계 회의\n주최자 : 정명훈 대리\n참석자 : 손관욱 사원, 조현빈 인턴','2025-11-07 01:42:22','HUMAN'),(31,'마킹기 동작 확인','2025-11-03 09:00:00','2025-11-06 18:00:00',1,'업무','#2e86de','손관욱 사원, 조현빈 인턴','2025-11-07 01:43:37','HUMAN'),(32,'UR4 용접로봇 고장','2025-11-03 09:00:00','2025-11-06 18:00:00',0,'','#8e44ad','R4 용접로봇 고장 및 수리','2025-11-07 01:44:24','ROBOT'),(33,'UR4 용접로봇 수선','2025-11-07 09:00:00','2025-11-07 09:00:00',1,'','#8e44ad','R4 용접로봇 수리 완료','2025-11-07 01:45:51','ROBOT'),(34,'풍력사업부 출장','2025-11-10 09:00:00','2025-11-12 18:00:00',0,'개인','#27ae60','풍력에너지 추계 학회','2025-11-07 01:50:23','HUMAN'),(35,'부산 발표','2025-10-27 11:00:00','2025-10-27 15:00:00',0,'업무','#2e86de','손관욱 사원, 울산대 김성민 교수','2025-11-07 01:56:28','HUMAN'),(36,'신규 로봇 도입','2025-11-24 09:00:00','2025-11-25 18:00:00',1,'','#8e44ad','R5, R6 로봇 도입','2025-11-07 01:57:20','ROBOT'),(39,'정명훈 대리 파견','2025-12-08 11:00:00','2025-12-08 18:00:00',1,'업무','#2e86de','현대로템 창원공장 안전관리자 파견','2025-12-09 02:25:45','HUMAN'),(40,'상하이 전시회 출장','2025-12-03 09:00:00','2025-12-06 18:00:00',0,'개인','#27ae60','참가자 : 김병석 본부장','2025-12-09 02:26:56','HUMAN'),(42,'손관욱 사원 연차','2025-12-01 09:00:00','2025-12-01 18:00:00',1,'개인','#27ae60','감기몸살로 인한 연차','2025-12-09 02:29:43','HUMAN'),(44,'신인 인턴 입사','2026-01-02 09:00:00','2026-01-02 18:00:00',0,'업무','#2e86de','연구본부 - 장경호 인턴, 풍력부 - 김채은 인턴','2026-01-05 07:47:12','HUMAN'),(46,'연구본부 XiRobot 방문','2026-01-25 09:00:00','2026-01-27 18:00:00',0,'개인','#27ae60','연구본부 XiRobot 방문\n장소 : 우후시\n방문자 : 김병석 이사, 허철수 소장, 김성민 울산대 교수','2026-01-27 01:01:35','HUMAN'),(47,'설 연휴','2026-02-16 09:00:00','2026-02-19 18:00:00',0,'개인','#27ae60','설 연휴','2026-02-03 00:03:58','HUMAN'),(48,'대체공휴일','2026-03-02 00:00:00','2026-03-02 23:59:00',1,'개인','#27ae60','3.1절 대체공휴일','2026-02-25 07:42:43','HUMAN'),(49,'연차보고서 작성','2026-03-03 09:00:00','2026-03-06 18:00:00',0,'업무','#2e86de','작성자 : 장경호 인턴, 손관욱 사원, 허철수 소장','2026-03-11 05:58:26','HUMAN'),(50,'홍진수 부장 파견','2026-02-20 09:00:00','2026-02-20 18:00:00',0,'업무','#2e86de','현대로템 창원공장 파견','2026-03-11 06:03:20','HUMAN'),(51,'연차보고서 수정','2026-03-09 09:00:00','2026-03-13 18:00:00',0,'업무','#2e86de','작성자 : 손관욱 사원, 장경호 인턴, 허철수 소장','2026-03-11 06:05:35','HUMAN'),(52,'1차년도 종료','2026-03-31 09:00:00','2026-03-31 18:00:00',0,'업무','#2e86de','AI자율제조과제 1차년도 종료','2026-03-11 08:34:29','HUMAN'),(53,'2차년도 시작','2026-04-01 09:00:00','2026-04-01 18:00:00',0,'업무','#2e86de','AI자율제조과제 2차년도 시작','2026-03-11 08:34:52','HUMAN'),(54,'연차보고서 제출','2026-03-13 10:00:00','2026-03-13 18:00:00',0,'업무','#2e86de','제출자 : 허철수 소장','2026-03-13 01:54:33','HUMAN'),(55,'노동절','2026-05-01 00:00:00','2026-05-01 23:59:00',0,'개인','#27ae60','노동절 공휴일','2026-03-13 04:54:28','HUMAN'),(56,'권장휴무','2026-05-04 00:00:00','2026-05-04 23:59:00',0,'개인','#27ae60','전 직원 권장휴무 사용(연차 1일 차감)','2026-03-13 04:55:33','HUMAN'),(57,'어린이날','2026-05-05 00:00:00','2026-05-05 23:59:00',0,'개인','#27ae60','어린이날 공휴일','2026-03-13 04:56:07','HUMAN'),(58,'대체공휴일','2026-05-25 00:00:00','2026-05-25 23:59:00',0,'개인','#27ae60','석가탄신일 대체공휴일','2026-03-13 04:58:07','HUMAN'),(59,'지방선거일','2026-06-03 00:00:00','2026-06-03 23:59:00',1,'개인','#27ae60','제9회 전국동시지방선거','2026-03-13 04:59:33','HUMAN'),(60,'Transguard 설치작업','2026-03-04 13:00:00','2026-03-04 17:00:00',0,'업무','#2e86de','장소 : 에이스 서생공장\nFBOE,  임상덕 팀장, 손관욱 사원','2026-03-16 06:51:55','HUMAN'),(61,'현대중공업 회의','2026-05-06 09:30:00','2026-05-06 18:00:00',0,'업무','#2e86de','AI 자율제조 관련 회의','2026-05-04 07:52:00','HUMAN'),(62,'손관욱 사원 연차','2026-05-07 09:00:00','2026-05-08 18:00:00',0,'개인','#27ae60','5.7, 5.8 연차','2026-05-11 01:53:06','HUMAN'),(63,'연구본부 출근','2026-05-04 09:00:00','2026-05-04 18:00:00',0,'업무','#2e86de','손관욱 사원, 허철수 소장, 김병석 이사 출근','2026-05-11 01:53:47','HUMAN'),(64,'연구본부 전시회 참석','2026-05-27 09:00:00','2026-05-29 18:00:00',0,'개인','#27ae60','2026 스마트팜 코리아\n장소 : 창원컨벤션센터(CECO) 제1, 2 전시장','2026-05-22 05:44:56','HUMAN'),(65,'AI자율제조 1단계 평가 회의','2026-05-19 15:00:00','2026-05-19 17:00:00',0,'업무','#2e86de','장소 : 현대중공업 기술혁신관 A202\n참석자 : 허철수 소장, 손관욱 사원','2026-05-22 05:51:45','HUMAN'),(67,'여름휴가','2026-08-03 11:00:00','2026-08-07 23:59:00',1,'개인','#27ae60','에이스이앤티 전 직원 여름휴가','2026-06-24 00:09:18','HUMAN'),(68,'개인연차','2026-06-29 09:00:00','2026-06-29 18:00:00',0,'개인','#27ae60','박미진 대리, 고성운 차장 연차','2026-06-29 00:16:11','HUMAN');
/*!40000 ALTER TABLE `schedule_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simulation_info`
--

DROP TABLE IF EXISTS `simulation_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `simulation_info` (
  `ac_time` int NOT NULL,
  `ac_electric` int NOT NULL DEFAULT '0',
  `ac_voltage` int NOT NULL DEFAULT '0',
  `dc_electric` int NOT NULL DEFAULT '0',
  `dc_voltage` int NOT NULL DEFAULT '0',
  `speed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ac_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simulation_info`
--

LOCK TABLES `simulation_info` WRITE;
/*!40000 ALTER TABLE `simulation_info` DISABLE KEYS */;
INSERT INTO `simulation_info` VALUES (62,670,456,1140,302,750),(100,680,386,1140,330,750),(138,682,368,1140,321,750),(174,684,351,1140,295,750),(213,685,391,1140,332,740),(249,685,366,1140,302,740),(286,685,394,1140,334,740),(323,685,360,1140,307,740),(361,685,377,1140,335,725),(398,689,351,1150,316,725),(435,689,390,1150,295,725),(472,689,407,1150,328,725),(507,690,374,1150,314,725),(544,690,393,1150,320,725),(580,691,369,1150,325,725),(618,691,332,1150,332,725),(654,691,374,1150,315,725),(681,692,395,1150,329,725);
/*!40000 ALTER TABLE `simulation_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_humid_chart`
--

DROP TABLE IF EXISTS `temp_humid_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_humid_chart` (
  `Time` varchar(45) NOT NULL COMMENT '측정시간',
  `OutTemp` int NOT NULL DEFAULT '0' COMMENT '장소(안, 밖)',
  `OutHumid` int NOT NULL DEFAULT '0',
  `InTemp` int DEFAULT NULL,
  `InHumid` int DEFAULT NULL,
  PRIMARY KEY (`Time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='온도 습도 차트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_humid_chart`
--

LOCK TABLES `temp_humid_chart` WRITE;
/*!40000 ALTER TABLE `temp_humid_chart` DISABLE KEYS */;
INSERT INTO `temp_humid_chart` VALUES ('01/23 18:00',12,48,26,70),('01/23 19:00',10,49,NULL,NULL),('01/23 20:00',9,50,NULL,NULL),('01/23 21:00',7,50,NULL,NULL),('01/23 22:00',5,54,NULL,NULL),('01/23 23:00',5,54,NULL,NULL),('01/24 00:00',4,57,10,80),('01/24 01:00',4,57,NULL,NULL),('01/24 02:00',4,58,NULL,NULL),('01/24 03:00',4,60,NULL,NULL),('01/24 04:00',1,62,NULL,NULL),('01/24 05:00',1,65,NULL,NULL),('01/24 06:00',1,63,18,80),('01/24 07:00',3,70,NULL,NULL),('01/24 08:00',3,66,NULL,NULL),('01/24 09:00',8,62,NULL,NULL),('01/24 10:00',10,59,NULL,NULL),('01/24 11:00',11,54,NULL,NULL),('01/24 12:00',11,53,20,58),('01/24 13:00',11,51,NULL,NULL),('01/24 14:00',11,54,NULL,NULL),('01/24 15:00',11,54,NULL,NULL);
/*!40000 ALTER TABLE `temp_humid_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `today_weld`
--

DROP TABLE IF EXISTS `today_weld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `today_weld` (
  `process` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `expectation` int NOT NULL DEFAULT '0',
  `performance` int NOT NULL DEFAULT '0',
  `progress` double NOT NULL DEFAULT '0',
  `error` int NOT NULL DEFAULT '0',
  `errorrate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`process`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `today_weld`
--

LOCK TABLES `today_weld` WRITE;
/*!40000 ALTER TABLE `today_weld` DISABLE KEYS */;
INSERT INTO `today_weld` VALUES ('Total',209,272,82.6,3,1.1),('소조',134,222,98.5,2,0.2),('중조',75,50,66.7,1,2);
/*!40000 ALTER TABLE `today_weld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tbl`
--

DROP TABLE IF EXISTS `user_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_tbl` (
  `EmployeeNumber` varchar(50) NOT NULL COMMENT '사번',
  `UserName` varchar(256) NOT NULL COMMENT '이름',
  `CompanyName` varchar(100) NOT NULL COMMENT '회사명',
  `DepartName` varchar(100) DEFAULT NULL COMMENT '부서명',
  `SectionName` varchar(100) DEFAULT NULL COMMENT '과명',
  `TeamName` varchar(100) DEFAULT NULL COMMENT '팀명',
  `ClassName` varchar(100) DEFAULT NULL COMMENT '반명',
  `HireDate` varchar(50) DEFAULT NULL COMMENT '입사일',
  `Position` varchar(100) DEFAULT NULL COMMENT '직책',
  `JobGrade` varchar(100) DEFAULT NULL COMMENT '직급',
  `Email` varchar(256) NOT NULL COMMENT '이메일',
  `PhoneNumber` varchar(50) NOT NULL COMMENT '휴대폰 번호',
  `PasswordHash` varchar(50) NOT NULL COMMENT '비밀번호(암호화)',
  `AccessLevel` varchar(100) NOT NULL COMMENT '시스템 접근 권한',
  PRIMARY KEY (`EmployeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tbl`
--

LOCK TABLES `user_tbl` WRITE;
/*!40000 ALTER TABLE `user_tbl` DISABLE KEYS */;
INSERT INTO `user_tbl` VALUES ('1','김대환','에이스이앤티','에이스이앤티','에이스이앤티','CEO','NA','2004-12-27','대표이사','대표이사','NA','NA','NA','Level1'),('10000000','김철수','HD현대미포','용연공장','엔지니어링','-','NA','2017-03-02','대리','대리','NA','NA','NA','Level1'),('10000001','성춘향','에이스이앤티','IT 개발팀','개발팀','개발팀','NA','2025-01-02','사원','사원','NA','NA','NA','Level1'),('20150000','이몽룡','HD현대미포','용연공장','선체조립과','중조팀','NA','2015-03-02','과장','차장','NA','NA','NA','Level1'),('20173196','손관욱','에이스이앤티','연구본부','연구개발','개발자','NA','2025-03-24','팀원','사원','3977uk@aceent.co.kr','010-5607-9824','111143','Admin'),('20180806','김삼성','에이스이앤티','사업본부','IT개발','본부장','NA','2018-08-06','상무','상무이사','NA','NA','NA','Level1'),('330957','신광철','HD현대미포','디지털생산혁신센터','자동화생산과','-','연구소','1999-01-05','과원','책임','330957@hd.com','010-5614-1679','111111','Level1'),('337935','권오욱','HD현대미포','디지털생산혁신센터','선체설계혁신과','-','연구소','2000-03-04','과장','책임','337935@hd.com','010-5744-0219','222222','Level2'),('345499','홍길동','HD현대미포','용연공장','선체조립과','중조팀','선체내업부문','2025-07-10','팀원','선임','hongkd@hd.com','010-4567-8901','135690','Level2'),('6756555','허철수','에이스이앤티','연구본부','엔지니어링','엔지니어링연구소','연구소','2021-02-01','부서장','소장','acehcs@aceent.co.kr','010-2275-5068','627878','Level1'),('7373777','김병석','에이스이앤티','연구본부','본부장','이사','연구소','2007-10-08','본부장','이사','bsk0077@aceent.co.kr','010-4874-2436','367934','Level2'),('751021','임상덕','에이스이앤티','연구본부','온클린','온클린','온클린','2010-11-04','팀장','차장','fifoal24@aceent.co.kr','010-9159-3535','246885','Level3');
/*!40000 ALTER TABLE `user_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weld_model_tbl`
--

DROP TABLE IF EXISTS `weld_model_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weld_model_tbl` (
  `WeldModelName` varchar(50) NOT NULL COMMENT '용접장 Model Name',
  `ProjectNo` varchar(50) NOT NULL COMMENT '호선 No',
  `BlockName` varchar(50) NOT NULL COMMENT '블록 Name',
  `AssyName` varchar(50) NOT NULL COMMENT 'Assy Name',
  `WeldLength` varchar(50) DEFAULT NULL COMMENT '용접 길이',
  `WeldModelFileName` varchar(50) NOT NULL COMMENT '용접장 모델 파일명',
  `WeldModelFileFolder` varchar(256) NOT NULL COMMENT '용접장 모델 파일 폴더명',
  PRIMARY KEY (`WeldModelName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weld_model_tbl`
--

LOCK TABLES `weld_model_tbl` WRITE;
/*!40000 ALTER TABLE `weld_model_tbl` DISABLE KEYS */;
INSERT INTO `weld_model_tbl` VALUES ('840806_WL_S19P-LB1A-J1-CELL1','840806','S19P','LB1A','6150.039mm','840806_WL_S19P-LB1A-J1-CELL1.rev','NA');
/*!40000 ALTER TABLE `weld_model_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weld_part_tbl`
--

DROP TABLE IF EXISTS `weld_part_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weld_part_tbl` (
  `WeldPartName` varchar(100) NOT NULL COMMENT '용접장 Part Name',
  `WeldPartPoints` varchar(100) NOT NULL COMMENT '용접장 Part Points',
  `WeldPartVectors` varchar(100) NOT NULL COMMENT '용접장 Part Vectors',
  `WeldPartSpeed` varchar(50) NOT NULL COMMENT '용접장 Part 구간 속도',
  `WeldPartVolt` varchar(50) NOT NULL COMMENT '용접장 Part 구간 전압',
  `WeldPartCurrent` varchar(50) NOT NULL COMMENT '용접장 Part 구간 전류',
  `WeldPartAuto` varchar(50) NOT NULL COMMENT '용접장 Part 구간 자동화',
  PRIMARY KEY (`WeldPartName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weld_part_tbl`
--

LOCK TABLES `weld_part_tbl` WRITE;
/*!40000 ALTER TABLE `weld_part_tbl` DISABLE KEYS */;
INSERT INTO `weld_part_tbl` VALUES ('840806_WL_S19P-LB1A-J1-CELL1/1','0,0,0','0D X','80mm/sec','220V','14A','가능');
/*!40000 ALTER TABLE `weld_part_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weld_progress`
--

DROP TABLE IF EXISTS `weld_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weld_progress` (
  `weld_num` int NOT NULL,
  `weld_now` int NOT NULL DEFAULT '0' COMMENT '실시간 장비별 용접 현황(%)',
  `weld_percent` int NOT NULL DEFAULT '0' COMMENT '장비별 용접률',
  `day1` int NOT NULL DEFAULT '0',
  `day2` int NOT NULL DEFAULT '0',
  `day3` int NOT NULL DEFAULT '0',
  `day4` int NOT NULL DEFAULT '0',
  `day5` int NOT NULL DEFAULT '0',
  `day6` int NOT NULL DEFAULT '0',
  `day7` int NOT NULL DEFAULT '0',
  `day8` int NOT NULL DEFAULT '0',
  `day9` int NOT NULL DEFAULT '0',
  `day10` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`weld_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weld_progress`
--

LOCK TABLES `weld_progress` WRITE;
/*!40000 ALTER TABLE `weld_progress` DISABLE KEYS */;
INSERT INTO `weld_progress` VALUES (1,50,100,20,22,20,18,20,22,20,20,20,18),(2,75,75,20,18,18,0,0,16,17,22,15,14),(3,25,50,15,0,0,0,0,0,20,22,23,20),(4,0,80,20,22,17,0,16,22,0,15,19,19),(5,25,80,20,21,22,18,20,18,0,0,20,16),(6,50,75,0,0,20,18,20,22,18,22,20,0),(7,0,80,22,20,22,0,0,22,18,16,16,15),(8,75,80,20,22,21,20,22,19,18,18,0,0);
/*!40000 ALTER TABLE `weld_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `welding_records`
--

DROP TABLE IF EXISTS `welding_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `welding_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `summary_id` int DEFAULT NULL,
  `time_start` varchar(20) DEFAULT NULL,
  `time_end` varchar(20) DEFAULT NULL,
  `arc_time` time DEFAULT NULL,
  `weld_length` decimal(10,2) DEFAULT NULL,
  `set_current` decimal(7,1) DEFAULT NULL,
  `out_current` decimal(7,1) DEFAULT NULL,
  `set_voltage` decimal(6,1) DEFAULT NULL,
  `out_voltage` decimal(6,1) DEFAULT NULL,
  `cell_shape` varchar(10) DEFAULT NULL,
  `section` varchar(20) DEFAULT NULL,
  `leg_length` int DEFAULT NULL,
  `total_pass` int DEFAULT NULL,
  `current_pass` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `summary_id` (`summary_id`),
  CONSTRAINT `welding_records_ibfk_1` FOREIGN KEY (`summary_id`) REFERENCES `daily_summary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `welding_records`
--

LOCK TABLES `welding_records` WRITE;
/*!40000 ALTER TABLE `welding_records` DISABLE KEYS */;
INSERT INTO `welding_records` VALUES (1,1,'오후 4:13:06','오후 4:13:45','00:00:38',292.41,310.0,317.3,32.0,34.3,'A-B','2F_L',6,3,1),(2,1,'오후 4:13:59','오후 4:14:33','00:00:34',255.83,310.0,312.6,32.0,33.6,'A-B','2F_R',6,2,1),(3,1,'오후 4:14:45','오후 4:17:21','00:02:36',234.19,185.0,206.5,24.0,26.7,'A-B','3F_L',7,2,2),(4,1,'오후 4:20:15','오후 4:20:54','00:00:39',292.69,310.0,323.3,32.0,34.4,'A-B','2F_L',6,2,NULL),(5,1,'오후 4:21:05','오후 4:21:42','00:00:36',274.40,280.0,314.9,30.0,33.5,'A-B','2F_R',6,2,1),(6,1,'오후 4:21:56','오후 4:24:32','00:02:36',234.23,185.0,206.9,24.0,26.7,'A-B','3F_L',7,3,3),(7,1,'오후 4:28:08','오후 4:28:50','00:00:41',310.45,280.0,314.9,30.0,32.7,'A-B','2F_L',6,2,NULL),(8,1,'오후 4:29:01','오후 4:29:38','00:00:36',273.94,310.0,315.7,32.0,33.6,'A-B','2F_R',6,2,1),(9,1,'오후 4:29:49','오후 4:32:26','00:02:36',234.29,185.0,208.6,24.0,26.7,'A-B','3F_L',7,2,2),(10,1,'오후 4:41:47','오후 4:43:41','00:01:53',227.34,180.0,189.4,23.0,25.7,'A-C','3F_R2',6,5,NULL),(11,1,'오후 4:43:57','오후 4:44:51','00:00:53',397.81,325.0,379.7,34.0,34.7,'A-C','2F_R',6,5,1),(12,1,'오후 4:45:02','오후 4:45:48','00:00:46',347.37,280.0,303.0,30.0,32.5,'A-C','2F_L',6,5,2),(13,1,'오후 4:46:00','오후 4:46:19','00:00:19',194.53,280.0,210.6,30.0,27.2,'A-C','2F_R',6,5,3),(14,1,'오후 4:46:40','오후 4:46:59','00:00:19',16.01,185.0,192.8,24.0,27.8,'A-C','3F_L',7,5,4),(15,1,'오후 4:56:42','오후 4:58:45','00:02:03',246.62,168.0,188.0,23.0,25.7,'A-C','3F_R2',6,6,NULL),(16,1,'오후 4:59:02','오후 4:59:53','00:00:51',381.70,325.0,292.8,34.0,35.2,'A-C','2F_R',6,5,1),(17,1,'오후 5:00:04','오후 5:00:48','00:00:43',329.29,280.0,266.4,30.0,33.8,'A-C','2F_L',6,5,2),(18,1,'오후 5:01:02','오후 5:01:19','00:00:17',170.06,240.0,207.4,26.0,28.7,'A-C','2F_R',6,6,4),(19,1,'오후 5:01:35','오후 5:03:50','00:02:14',246.56,185.0,203.1,24.0,26.7,'A-C','3F_L',7,6,5),(20,1,'오후 5:04:03','오후 5:05:56','00:01:52',206.95,180.0,202.9,23.0,26.4,'A-C','3F_R',7,5,5),(21,1,'오후 5:12:59','오후 5:13:28','00:00:29',219.06,310.0,293.8,32.0,32.9,'B-A','2F_L',6,2,1),(22,1,'오후 5:13:42','오후 5:14:26','00:00:43',328.95,310.0,297.2,32.0,33.8,'B-A','2F_R',6,1,2),(23,1,'오후 5:28:46','오후 5:29:27','00:00:41',310.50,310.0,320.1,32.0,34.3,'A-B','2F_L',6,3,1),(24,1,'오후 5:29:41','오후 5:30:12','00:00:31',237.82,310.0,310.6,32.0,33.5,'A-B','2F_R',6,2,1),(25,1,'오후 5:30:24','오후 5:33:00','00:02:36',182.15,180.0,205.6,23.0,26.5,'A-B','3F_L',7,2,2),(26,1,'오후 5:41:11','오후 5:41:52','00:00:41',310.09,310.0,317.3,32.0,33.0,'A-B','2F_L',6,3,1),(27,1,'오후 5:42:04','오후 5:42:38','00:00:34',256.03,280.0,313.5,30.0,33.7,'A-B','2F_R',6,2,1),(28,1,'오후 5:42:52','오후 5:46:52','00:04:00',280.22,185.0,204.5,24.0,26.7,'A-B','3F_L',7,3,2),(29,1,'오후 5:54:24','오후 5:55:06','00:00:41',310.94,310.0,320.7,32.0,34.2,'A-B','2F_L',6,2,NULL),(30,1,'오후 5:55:20','오후 5:55:51','00:00:31',237.50,310.0,310.3,32.0,33.5,'A-B','2F_R',6,3,2),(31,1,'오후 5:56:05','오후 5:59:27','00:03:21',235.40,185.0,204.8,24.0,26.5,'A-B','3F_L',7,2,2),(32,1,'오후 6:05:48','오후 6:07:52','00:02:03',246.89,180.0,186.4,23.0,25.7,'A-C','3F_R2',6,4,NULL),(33,1,'오후 6:08:10','오후 6:09:01','00:00:51',380.76,325.0,306.7,34.0,35.2,'A-C','2F_R',6,4,1),(34,1,'오후 6:10:16','오후 6:10:35','00:00:19',193.63,240.0,217.8,26.0,28.2,'A-C','2F_R',6,5,4),(35,1,'오후 6:10:51','오후 6:13:01','00:02:09',194.58,185.0,206.3,24.0,26.7,'A-C','3F_R',7,5,5),(36,1,'오후 7:12:03','오후 7:14:16','00:02:13',266.84,180.0,184.4,23.0,25.6,'A-C','3F_R2',6,5,NULL),(37,1,'오후 7:14:34','오후 7:15:23','00:00:48',363.50,325.0,335.3,34.0,35.1,'A-C','2F_R',6,6,2),(38,1,'오후 7:15:37','오후 7:16:23','00:00:46',347.32,280.0,317.9,30.0,33.6,'A-C','2F_L',6,5,2),(39,1,'오후 7:16:37','오후 7:16:56','00:00:19',193.74,240.0,232.5,26.0,28.1,'A-C','2F_R',6,6,4),(40,1,'오후 7:17:10','오후 7:19:03','00:01:52',169.33,180.0,207.3,23.0,26.6,'A-C','3F_L',7,5,4),(41,1,'오후 7:19:17','오후 7:21:29','00:02:12',198.16,180.0,206.2,23.0,26.7,'A-C','3F_R',7,5,5),(42,1,'오후 7:24:37','오후 7:25:03','00:00:26',201.15,310.0,338.0,32.0,34.3,'B-A','2F_L',6,2,NULL),(43,1,'오후 7:25:17','오후 7:26:04','00:00:46',347.45,310.0,331.0,32.0,33.7,'B-A','2F_R',6,3,2),(44,1,'오후 7:26:15','오후 7:28:54','00:02:38',237.82,180.0,207.8,23.0,26.7,'B-A','3F_R',7,2,2),(45,1,'오후 7:34:23','오후 7:36:36','00:02:13',266.27,168.0,187.5,23.0,25.7,'B-C','3F_R2',6,5,1),(46,1,'오후 7:36:52','오후 7:37:43','00:00:51',381.07,280.0,337.5,30.0,34.3,'B-C','2F_R',6,4,1),(47,1,'오후 7:37:55','오후 7:38:44','00:00:48',365.51,310.0,314.8,32.0,33.0,'B-C','2F_L',6,4,2),(48,1,'오후 7:38:55','오후 7:39:15','00:00:19',194.13,240.0,243.7,26.0,28.6,'B-C','2F_R',6,4,3),(49,1,'오후 7:39:31','오후 7:41:02','00:01:31',136.93,185.0,204.3,24.0,27.1,'B-C','3F_R',7,5,4),(50,1,'오후 7:43:52','오후 7:46:05','00:02:13',266.21,168.0,186.8,23.0,25.8,'B-C','3F_R2',6,4,1),(51,1,'오후 7:46:21','오후 7:47:10','00:00:48',362.99,325.0,334.3,34.0,34.9,'B-C','2F_R',6,5,2),(52,1,'오후 7:47:24','오후 7:48:07','00:00:43',329.01,310.0,316.3,32.0,33.7,'B-C','2F_L',6,5,3),(53,1,'오후 7:48:21','오후 7:48:41','00:00:19',193.99,240.0,246.2,26.0,28.1,'B-C','2F_R',6,4,3),(54,1,'오후 7:48:57','오후 7:51:07','00:02:09',194.60,185.0,206.6,24.0,26.7,'B-C','3F_R',7,5,4),(55,1,'오후 7:55:12','오후 7:57:25','00:02:13',266.36,168.0,187.3,23.0,25.7,'B-C','3F_R2',6,4,1),(56,1,'오후 7:57:41','오후 7:58:30','00:00:48',361.53,325.0,348.5,34.0,35.1,'B-C','2F_R',6,5,2),(57,1,'오후 7:58:43','오후 7:59:30','00:00:46',347.61,310.0,337.4,32.0,33.6,'B-C','2F_L',6,4,2),(58,1,'오후 7:59:44','오후 8:00:03','00:00:19',194.25,240.0,244.0,26.0,28.2,'B-C','2F_R',6,5,4),(59,1,'오후 8:00:19','오후 8:02:29','00:02:09',194.58,185.0,206.5,24.0,26.7,'B-C','3F_R',7,5,5),(60,1,'오후 8:05:41','오후 8:07:52','00:02:10',261.42,168.0,185.1,23.0,25.8,'B-C','3F_R2',6,5,1),(61,1,'오후 8:08:08','오후 8:08:57','00:00:48',361.62,280.0,341.5,30.0,34.9,'B-C','2F_R',6,4,1),(62,1,'오후 8:09:11','오후 8:09:30','00:00:19',146.15,310.0,335.0,32.0,32.7,'B-C','2F_L',6,4,2),(63,1,'오후 8:09:42','오후 8:10:01','00:00:19',194.28,280.0,239.6,30.0,28.9,'B-C','2F_R',6,4,3),(64,1,'오후 8:10:17','오후 8:12:30','00:02:12',198.24,185.0,206.5,24.0,26.6,'B-C','3F_R',7,4,4),(65,1,'오후 8:26:07','오후 8:28:18','00:02:10',261.34,168.0,186.0,23.0,25.7,'B-C','3F_R2',6,6,1),(66,1,'오후 8:28:34','오후 8:29:23','00:00:48',361.14,280.0,331.1,30.0,34.1,'B-C','2F_R',6,5,1),(67,1,'오후 8:29:36','오후 8:30:23','00:00:46',347.38,310.0,335.1,32.0,33.5,'B-C','2F_L',6,6,3),(68,1,'오후 8:30:37','오후 8:30:56','00:00:19',194.14,240.0,234.2,26.0,28.2,'B-C','2F_R',6,6,4),(69,1,'오후 8:31:12','오후 8:33:03','00:01:50',165.76,185.0,206.8,24.0,26.6,'B-C','3F_L',7,6,5),(70,1,'오후 8:34:14','오후 8:36:23','00:02:09',194.61,185.0,205.1,24.0,26.7,'B-C','3F_R',7,5,5),(71,1,'오후 8:41:45','오후 8:42:12','00:00:26',200.87,310.0,312.2,32.0,32.4,'B-A','2F_L',6,2,NULL),(72,1,'오후 8:42:26','오후 8:43:12','00:00:46',347.36,310.0,317.6,32.0,33.7,'B-A','2F_R',6,3,2),(73,1,'오후 8:43:24','오후 8:46:03','00:02:38',237.85,180.0,206.7,23.0,26.6,'B-A','3F_R',7,2,2),(74,1,'오후 9:01:15','오후 9:01:29','00:00:14',109.70,310.0,343.6,32.0,34.2,'B-B','2F_L',6,2,NULL),(75,1,'오후 9:01:43','오후 9:02:34','00:00:51',384.02,310.0,327.6,32.0,33.6,'B-B','2F_R',6,2,1),(76,1,'오후 9:02:46','오후 9:04:32','00:01:45',158.55,185.0,206.7,24.0,26.6,'B-B','3F_R',7,2,2),(77,1,'오후 9:40:04','오후 9:42:42','00:02:37',314.56,168.0,187.9,23.0,25.8,'B-C','3F_R2',6,4,NULL),(78,1,'오후 9:42:58','오후 9:43:49','00:00:51',379.63,280.0,354.1,30.0,34.8,'B-C','2F_R',6,4,1),(79,1,'오후 9:44:03','오후 9:44:49','00:00:46',347.16,310.0,331.6,32.0,33.6,'B-C','2F_L',6,5,3),(80,1,'오후 9:45:01','오후 9:45:20','00:00:19',194.39,240.0,256.6,26.0,28.4,'B-C','2F_R',6,4,3),(81,1,'오후 9:45:36','오후 9:48:20','00:02:43',245.02,185.0,206.8,24.0,26.7,'B-C','3F_R',7,4,4),(82,1,'오후 9:51:53','오후 9:54:46','00:02:53',317.18,185.0,206.6,24.0,26.7,'B-C','3F_R2',7,6,1),(83,1,'오후 9:55:02','오후 9:55:55','00:00:53',356.99,325.0,356.2,34.0,35.5,'B-C','2F_R',7,5,1),(84,1,'오후 9:56:09','오후 9:57:00','00:00:51',340.46,325.0,339.4,34.0,35.1,'B-C','2F_L',7,6,3),(85,1,'오후 9:57:14','오후 9:57:53','00:00:38',388.40,240.0,239.7,26.0,28.3,'B-C','2F_R',7,6,4),(86,1,'오후 9:58:04','오후 9:58:43','00:00:38',388.95,280.0,244.7,30.0,28.7,'B-C','2F_L',7,5,4),(87,1,'오후 9:58:57','오후 10:01:41','00:02:43',245.11,185.0,207.3,24.0,26.7,'B-C','3F_R',7,5,5),(88,1,'오후 10:05:00','오후 10:07:55','00:02:55',321.55,180.0,204.5,23.0,26.3,'B-C','3F_R2',7,5,NULL),(89,1,'오후 10:08:11','오후 10:09:05','00:00:53',356.33,325.0,337.8,34.0,34.6,'B-C','2F_R',7,6,2),(90,1,'오후 10:09:16','오후 10:10:07','00:00:51',340.61,325.0,333.7,34.0,35.1,'B-C','2F_L',7,6,3),(91,1,'오후 10:10:21','오후 10:11:00','00:00:38',388.63,240.0,233.6,26.0,28.3,'B-C','2F_R',7,6,4),(92,1,'오후 10:11:14','오후 10:11:50','00:00:36',364.53,240.0,240.0,26.0,28.2,'B-C','2F_L',7,6,5),(93,1,'오후 10:12:04','오후 10:14:48','00:02:43',245.10,180.0,204.3,23.0,26.8,'B-C','3F_R',7,5,5),(94,1,'오후 10:17:55','오후 10:20:48','00:02:53',317.17,185.0,206.7,24.0,26.7,'B-C','3F_R2',7,6,1),(95,1,'오후 10:21:05','오후 10:21:58','00:00:53',356.67,325.0,338.0,34.0,35.2,'B-C','2F_R',7,5,1),(96,1,'오후 10:22:12','오후 10:22:29','00:00:17',113.67,325.0,321.1,34.0,34.1,'B-C','2F_L',7,6,3),(97,1,'오후 10:22:43','오후 10:23:22','00:00:38',388.29,240.0,231.6,26.0,28.3,'B-C','2F_R',7,6,3),(98,1,'오후 10:23:33','오후 10:23:48','00:00:14',145.90,280.0,243.1,30.0,28.2,'B-C','2F_L',7,5,4),(99,1,'오후 10:24:02','오후 10:26:45','00:02:43',245.06,185.0,208.1,24.0,26.7,'B-C','3F_R',7,5,5),(100,1,'오후 10:35:42','오후 10:38:52','00:03:10',317.54,180.0,202.7,25.0,27.7,'A-C','3F_R2',9,7,1),(101,1,'오후 10:39:11','오후 10:40:09','00:00:58',361.07,365.0,364.0,36.0,37.3,'A-C','2F_R',9,7,1),(102,1,'오후 10:40:23','오후 10:41:19','00:00:56',346.17,365.0,356.1,36.0,37.1,'A-C','2F_L',9,7,3),(103,1,'오후 10:41:33','오후 10:42:17','00:00:43',369.54,285.0,260.2,29.0,31.1,'A-C','2F_R',9,6,3),(104,1,'오후 10:42:28','오후 10:43:09','00:00:41',349.85,285.0,274.6,29.0,30.9,'A-C','2F_L',9,6,4),(105,1,'오후 10:43:21','오후 10:43:35','00:00:14',19.29,180.0,178.9,23.0,24.8,'A-C','3F_L',8,6,5),(106,1,'오후 10:44:05','오후 10:46:51','00:02:45',248.68,180.0,202.6,23.0,26.3,'A-C','3F_R',7,6,6),(107,1,'오후 10:50:31','오후 10:52:17','00:01:46',213.05,168.0,187.3,23.0,25.5,'B-C','3F_R2',6,5,1),(108,1,'오후 10:52:33','오후 10:53:24','00:00:51',380.16,325.0,328.7,34.0,34.5,'B-C','2F_R',6,4,1),(109,1,'오후 10:53:36','오후 10:53:51','00:00:14',109.84,310.0,317.9,32.0,33.9,'B-C','2F_L',6,4,2),(110,1,'오후 10:54:05','오후 10:54:24','00:00:19',194.17,240.0,235.3,26.0,28.1,'B-C','2F_R',6,4,3),(111,1,'오후 10:54:40','오후 10:57:16','00:02:36',234.25,185.0,204.6,24.0,26.8,'B-C','3F_R',7,5,5);
/*!40000 ALTER TABLE `welding_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_order_tbl`
--

DROP TABLE IF EXISTS `work_order_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_order_tbl` (
  `ProdActID` varchar(50) NOT NULL COMMENT '생산 Activity ID',
  `OrderDate` varchar(50) NOT NULL COMMENT '오더 일자',
  `ProjNo` varchar(50) NOT NULL COMMENT '호선 No',
  `BlockName` varchar(50) NOT NULL COMMENT 'Block Name',
  `AssyName` varchar(50) NOT NULL COMMENT 'Assy Name',
  `ProdActNo` varchar(100) NOT NULL COMMENT '생산 Activity No',
  `RobotNo` varchar(50) NOT NULL COMMENT '로봇 번호',
  `EmployeeNumber` varchar(50) NOT NULL COMMENT '작업자',
  `WorkDetail` varchar(256) DEFAULT '-' COMMENT '작업 내용',
  `FinishStatus` varchar(50) NOT NULL DEFAULT 'N' COMMENT '완료 여부',
  `WorkNum` varchar(50) DEFAULT NULL COMMENT '작업 순번',
  `StartDateTime` varchar(50) NOT NULL COMMENT '작업 시작 일지',
  `FinishDateTime` varchar(50) NOT NULL COMMENT '작업 종료 일시',
  `AIAct` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ProdActID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_order_tbl`
--

LOCK TABLES `work_order_tbl` WRITE;
/*!40000 ALTER TABLE `work_order_tbl` DISABLE KEYS */;
INSERT INTO `work_order_tbl` VALUES ('843206_1','2025-06-13','843206','B13P','TT1_C3','3','UR6','손관욱','Cell 25','Y','2','2025-08-01','2025-08-18','4'),('843206_2','2025-06-20','843206','B13S','LB3','2','UR1','홍길동','Cell 22','Y','6','2025-08-11','2025-08-25','2'),('843206_3','2025-07-01','843206','B14P','DK1A','0','UR7','손관욱','Cell 31','N','3','2025-08-13','2025-09-03','1'),('843206_4','2025-07-09','843206','B12C','FR35A','2','UR4','손관욱','Cell 29','Y','5','2025-08-13','2025-08-20','2'),('843206_5','2026-05-21','843206','B14P','DK1A','0','UR7','홍길동','-','N',NULL,'2026-05-21','2026-09-03','2'),('843206_6','2026-06-23','843206','B13P','TT1_C3','0','UR1','홍길동','-','N',NULL,'2026-06-23','2026-10-08','5'),('843206_7','2026-06-24','843206','B14P','LB3','0','UR6','임꺽정','-','N',NULL,'2026-06-24','2026-09-24','5');
/*!40000 ALTER TABLE `work_order_tbl` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-01 14:54:41
