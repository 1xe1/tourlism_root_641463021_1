-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 31, 2024 at 07:28 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tourlism`
--

-- --------------------------------------------------------

--
-- Table structure for table `busschedule`
--

CREATE TABLE `busschedule` (
  `ScheduleID` int(11) DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `PlaceID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `busschedule`
--

INSERT INTO `busschedule` (`ScheduleID`, `Time`, `PlaceID`) VALUES
(2001, '08:00:00', 1),
(2002, '10:30:00', 2),
(2003, '13:15:00', 3),
(2004, '15:45:00', 1),
(2005, '18:20:00', 2),
(NULL, '18:30:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `gettemp`
--

CREATE TABLE `gettemp` (
  `tempId` int(11) DEFAULT NULL,
  `date_log` date DEFAULT NULL,
  `time_log` time DEFAULT NULL,
  `temp_value` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `gettemp`
--

INSERT INTO `gettemp` (`tempId`, `date_log`, `time_log`, `temp_value`) VALUES
(1, '2024-02-02', '10:00:00', 22.8),
(2, '2024-02-02', '12:30:00', 23.5),
(3, '2024-02-03', '08:45:00', 24.3),
(4, '2024-02-03', '15:15:00', 25.1),
(5, '2024-02-04', '09:30:00', 23.9);

-- --------------------------------------------------------

--
-- Table structure for table `storenames`
--

CREATE TABLE `storenames` (
  `StoreID` int(11) DEFAULT NULL,
  `StoreName` varchar(255) NOT NULL,
  `TypeID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `storenames`
--

INSERT INTO `storenames` (`StoreID`, `StoreName`, `TypeID`) VALUES
(1001, 'ร้าน A', 1),
(1002, 'ร้าน B', 2),
(1003, 'ร้าน C', 3),
(1004, 'ร้าน D', 1),
(1005, 'ร้าน E', 4),
(1006, 'ร้าน F', 2),
(1007, 'ร้าน G', 5),
(1008, 'ร้าน H', 3),
(1009, 'ร้าน I', 4),
(1010, 'ร้าน J', 5),
(1011, 'ดอยหลวง', 2);

-- --------------------------------------------------------

--
-- Table structure for table `storetypes`
--

CREATE TABLE `storetypes` (
  `TypeID` int(11) DEFAULT NULL,
  `TypeName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `storetypes`
--

INSERT INTO `storetypes` (`TypeID`, `TypeName`) VALUES
(1, 'ร้านอาหาร'),
(2, 'ร้านกาแฟ'),
(3, 'ร้านเสื้อผ้า'),
(4, 'ร้านหนังสือ'),
(5, 'ร้านอุปกรณ์อิเล็กทรอนิกส์');

-- --------------------------------------------------------

--
-- Table structure for table `touristplaces`
--

CREATE TABLE `touristplaces` (
  `PlaceID` int(11) DEFAULT NULL,
  `PlaceName` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `touristplaces`
--

INSERT INTO `touristplaces` (`PlaceID`, `PlaceName`, `Description`, `Latitude`, `Longitude`) VALUES
(1, 'วัดร่องขุ่น', 'วัดร่องขุ่น เป็นวัดที่สวยงามตั้งอยู่ที่เชียงราย', 19.9076, 99.8322),
(2, 'ดอยตุง', 'ดอยตุง เป็นภูเขาที่สูงและมีทางเดินป่าสวยงาม', 20.0437, 99.39),
(3, 'ถ้ำขุนน้ำนม', 'ถ้ำขุนน้ำนม เป็นถ้ำที่มีน้ำนมไหลตลอดปี', 20.2543, 99.8536),
(4, 'แม่ฮ่องสอน', 'แม่ฮ่องสอน เป็นจังหวัดที่มีธรรมชาติที่งดงาม', 20.4297, 99.8862),
(5, 'aa', 'aa', 12.36, 123.23),
(6, 'bb', 'bb', 11.4, 12.4),
(7, 'cc', 'cc', 12.25, 12.44),
(8, 'gg', 'gg', 124, 12),
(9, 'rr', 'rr', 23, 33);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
