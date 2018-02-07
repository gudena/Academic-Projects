-- phpMyAdmin SQL Dump
-- version 4.4.15.5
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 25, 2017 at 07:47 PM
-- Server version: 5.6.34-log
-- PHP Version: 7.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `childcare_schema`
--

-- --------------------------------------------------------

--
-- Table structure for table `caretaker`
--

CREATE TABLE IF NOT EXISTS `caretaker` (
  `CSSN` char(9) NOT NULL,
  `FNAME` varchar(50) NOT NULL,
  `LNAME` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `EMAIL` varchar(20) DEFAULT NULL,
  `CONTACTNO` char(10) DEFAULT NULL,
  `JOBTYPE` char(1) DEFAULT NULL,
  `SUBJECT` varchar(20) DEFAULT NULL,
  `JOB_ID` int(11) DEFAULT NULL,
  `MGR_SSN` char(9) DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `caretaker`
--

INSERT INTO `caretaker` (`CSSN`, `FNAME`, `LNAME`, `DOB`, `EMAIL`, `CONTACTNO`, `JOBTYPE`, `SUBJECT`, `JOB_ID`, `MGR_SSN`, `DEPT_ID`) VALUES
('677777771', 'Jeniffer', 'Ramos', '1980-04-02', 'Jeni.Ramos@gmail.com', '1111111123', 'T', 'Game', 1, '677777772', 1),
('677777772', 'Julia', 'Alexander', NULL, 'Julia@gmail.com', '1111111143', 'M', NULL, 1, NULL, 1),
('677777773', 'Katrina', 'Schroder', '1983-04-02', 'Katrina@gmail.com', '1111111133', 'M', NULL, 2, '677777774', 2),
('677777774', 'Rose', 'William', '1985-04-02', 'Rose@gmail.com', '1111111154', 'M', NULL, 2, NULL, 2),
('677777775', 'Lisaa', 'Tylor', '2000-04-02', 'lissa@gmail.com', '1111111125', 'T', 'English', 1, '677777771', 1),
('677777776', 'Aisha', 'Beiber', '1999-04-02', 'Aisha@gmail.com', '1111111126', 'T', 'English', 1, '677777771', 1),
('677777777', 'Sonam', 'Sen', '1991-04-10', ' Sonam@gmail.com', '1111111199', 'M', NULL, 2, '677777773', 2);

-- --------------------------------------------------------

--
-- Table structure for table `child`
--

CREATE TABLE IF NOT EXISTS `child` (
  `CHILD_ID` int(11) NOT NULL,
  `FNAME` varchar(50) NOT NULL,
  `LNAME` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `ENAME` varchar(10) DEFAULT NULL,
  `EPHONENO` char(10) DEFAULT NULL,
  `PSSN` char(9) DEFAULT NULL,
  `CLASS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `child`
--

INSERT INTO `child` (`CHILD_ID`, `FNAME`, `LNAME`, `DOB`, `ENAME`, `EPHONENO`, `PSSN`, `CLASS`) VALUES
(1, 'Alexa', 'William', '2015-04-02', 'Michael', '1111111111', '777777771', 1),
(2, 'Bob', 'Ryne', '2014-04-10', 'Evan', '1111111112', '777777772', 2),
(3, 'Chelsea', 'William', '2014-04-03', 'Michael', '1111111111', '777777771', 1);

-- --------------------------------------------------------

--
-- Table structure for table `classsection`
--

CREATE TABLE IF NOT EXISTS `classsection` (
  `CLASS_ID` int(11) NOT NULL,
  `ROOM` varchar(10) DEFAULT NULL,
  `LOCATION` varchar(20) DEFAULT NULL,
  `CLASS_TEACHER` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classsection`
--

INSERT INTO `classsection` (`CLASS_ID`, `ROOM`, `LOCATION`, `CLASS_TEACHER`) VALUES
(1, '2.1', 'ECSS', '677777771'),
(2, '2.3', 'ECSS', '677777773'),
(3, '3.4', 'ECSN', '677777772');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE IF NOT EXISTS `department` (
  `DEPT_ID` int(11) NOT NULL,
  `DEPT_NAME` varchar(20) DEFAULT NULL,
  `MGR_SSN` char(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DEPT_ID`, `DEPT_NAME`, `MGR_SSN`) VALUES
(1, 'Teaching', '677777772'),
(2, 'Management', '677777774');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE IF NOT EXISTS `food` (
  `F_ID` int(11) NOT NULL,
  `FOOD_NAME` varchar(20) DEFAULT NULL,
  `PRICE` int(11) DEFAULT NULL,
  `QUANTITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`F_ID`, `FOOD_NAME`, `PRICE`, `QUANTITY`) VALUES
(1, 'Chocolates', 5, 10),
(2, 'Pizza', 52, 12),
(3, 'Sandwich', 2, 40),
(4, 'Burger', 5, 12);

-- --------------------------------------------------------

--
-- Table structure for table `foodorderedby`
--

CREATE TABLE IF NOT EXISTS `foodorderedby` (
  `STAFFSSN` char(9) NOT NULL,
  `FOOD_ID` int(11) NOT NULL,
  `DATEORDERED` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `foodorderedby`
--

INSERT INTO `foodorderedby` (`STAFFSSN`, `FOOD_ID`, `DATEORDERED`) VALUES
('677777771', 1, '2017-04-02'),
('677777773', 2, '2017-04-04');

-- --------------------------------------------------------

--
-- Table structure for table `foodrecord`
--

CREATE TABLE IF NOT EXISTS `foodrecord` (
  `CHILD_ID` int(11) NOT NULL,
  `FOOD_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `foodrecord`
--

INSERT INTO `foodrecord` (`CHILD_ID`, `FOOD_ID`) VALUES
(1, 1),
(2, 1),
(3, 2),
(2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE IF NOT EXISTS `job` (
  `JOB_ID` int(11) NOT NULL,
  `BASIC_SALARY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`JOB_ID`, `BASIC_SALARY`) VALUES
(1, 18),
(2, 15);

-- --------------------------------------------------------

--
-- Table structure for table `parent`
--

CREATE TABLE IF NOT EXISTS `parent` (
  `SSN` char(9) NOT NULL,
  `FNAME` varchar(50) NOT NULL,
  `LNAME` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `EMAIL` varchar(20) DEFAULT NULL,
  `CONTACTNO` char(10) DEFAULT NULL,
  `ADDRESS` varchar(30) DEFAULT NULL,
  `ZIPCODE` char(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parent`
--

INSERT INTO `parent` (`SSN`, `FNAME`, `LNAME`, `DOB`, `EMAIL`, `CONTACTNO`, `ADDRESS`, `ZIPCODE`) VALUES
('777777102', 'Hyde', 'Victor', '1998-04-12', 'Hyde@gmail.com', '321654932', '1234 fshteh', '32178'),
('777777104', 'zfdsg', 'asf', '1979-04-02', 'asf@gmail.com', '987326544', '123 sdfg', '65432'),
('777777771', 'Amin', 'William', '2015-04-05', 'amin@gmail.com', '1111111111', '777777771', '1'),
('777777772', 'Bill', 'Ryne', '1985-09-06', 'b@gmail.com', '3111111111', '232, James Blvd', '75080'),
('777777773', 'qwe', 'wer', '1985-04-17', 'qwe@gmail.com', '3111113232', '32, James Blvd', '12345'),
('777777774', 'asd', 'sdf', '1980-04-20', 'asd@gmail.com', '12', '12,dsdfs', '12345'),
('777777775', 'zxc', 'xcv', '1990-04-02', 'xcv@gmail.com', '123456987', '64 dsfse', '78945'),
('777777776', 'gfdf', 'dsfd', NULL, 'dgd@vdgd.com', '363453567', '123 amanda ', '24554'),
('777777777', 'mnb', 'vbnn', '1991-04-03', 'ssf@csd.com', '3231441343', 'xvsfdgs', '65555'),
('777777778', 'dsfs', 'sf', '1988-04-02', 'vdgg@sad.com', '12345', '6543 Eve', '75395'),
('777777779', 'sdfdg', 'sdsf', '1985-04-03', 'cdsg@gmail.com', 'sfsr', '123 qwerty eve', '54245');

-- --------------------------------------------------------

--
-- Table structure for table `salarycomputation`
--

CREATE TABLE IF NOT EXISTS `salarycomputation` (
  `CARETAKERSSN` char(9) NOT NULL,
  `TIMINGID` int(11) NOT NULL,
  `JOBID` int(11) NOT NULL,
  `SALARY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `timing`
--

CREATE TABLE IF NOT EXISTS `timing` (
  `TIME_ID` int(11) NOT NULL,
  `CSSN` char(9) NOT NULL,
  `TIMEIN` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `TIMEOUT` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `timing`
--

INSERT INTO `timing` (`TIME_ID`, `CSSN`, `TIMEIN`, `TIMEOUT`) VALUES
(1, '677777771', '2017-04-25 14:38:51', '2017-04-25 23:00:00'),
(2, '677777772', '2017-04-25 19:41:10', '2017-04-17 22:32:27'),
(3, '677777773', '2017-04-25 14:23:23', '2017-04-25 22:27:23');

-- --------------------------------------------------------

--
-- Table structure for table `toys`
--

CREATE TABLE IF NOT EXISTS `toys` (
  `T_ID` int(11) NOT NULL,
  `TOY_NAME` varchar(20) DEFAULT NULL,
  `DATE_OF_PURCHASE` date DEFAULT NULL,
  `COMPANY` varchar(10) DEFAULT NULL,
  `TOTAL_QUANTITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toys`
--

INSERT INTO `toys` (`T_ID`, `TOY_NAME`, `DATE_OF_PURCHASE`, `COMPANY`, `TOTAL_QUANTITY`) VALUES
(1, ' Electric Car', '2014-03-07', 'ABC', 100),
(2, 'Doll', '2016-04-05', 'ABC', 10),
(3, 'Frisbee', '2015-04-24', 'XYZ', 20);

-- --------------------------------------------------------

--
-- Table structure for table `toy_distribution`
--

CREATE TABLE IF NOT EXISTS `toy_distribution` (
  `TOY_ID` int(11) NOT NULL,
  `CLASS_ID` int(11) NOT NULL,
  `QUANTITY` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toy_distribution`
--

INSERT INTO `toy_distribution` (`TOY_ID`, `CLASS_ID`, `QUANTITY`) VALUES
(1, 1, 5),
(2, 1, 4),
(1, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tuition_payment`
--

CREATE TABLE IF NOT EXISTS `tuition_payment` (
  `PAYMENT_ID` int(11) NOT NULL,
  `PAYMENT_TYPE` varchar(20) NOT NULL,
  `PAYMENT_DATE` date DEFAULT NULL,
  `AMOUNT` int(11) DEFAULT NULL,
  `CHILD_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tuition_payment`
--

INSERT INTO `tuition_payment` (`PAYMENT_ID`, `PAYMENT_TYPE`, `PAYMENT_DATE`, `AMOUNT`, `CHILD_ID`) VALUES
(22221, 'Credit', '2017-04-03', 500, 1),
(22222, 'Debit', '2017-04-24', 1000, 2),
(22223, 'Credit', '2017-04-03', 500, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `caretaker`
--
ALTER TABLE `caretaker`
  ADD PRIMARY KEY (`CSSN`),
  ADD KEY `JOB_ID` (`JOB_ID`),
  ADD KEY `DEPT_ID` (`DEPT_ID`),
  ADD KEY `SUPERVISOR_KEY` (`MGR_SSN`);

--
-- Indexes for table `child`
--
ALTER TABLE `child`
  ADD PRIMARY KEY (`CHILD_ID`),
  ADD KEY `PSSN` (`PSSN`),
  ADD KEY `CLASS` (`CLASS`);

--
-- Indexes for table `classsection`
--
ALTER TABLE `classsection`
  ADD PRIMARY KEY (`CLASS_ID`),
  ADD KEY `CLASS_TEACHER` (`CLASS_TEACHER`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DEPT_ID`),
  ADD KEY `MGR_KEY` (`MGR_SSN`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`F_ID`);

--
-- Indexes for table `foodorderedby`
--
ALTER TABLE `foodorderedby`
  ADD KEY `STAFFSSN` (`STAFFSSN`),
  ADD KEY `FOOD_ID` (`FOOD_ID`);

--
-- Indexes for table `foodrecord`
--
ALTER TABLE `foodrecord`
  ADD PRIMARY KEY (`CHILD_ID`,`FOOD_ID`),
  ADD KEY `FOOD_ID` (`FOOD_ID`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`JOB_ID`);

--
-- Indexes for table `parent`
--
ALTER TABLE `parent`
  ADD PRIMARY KEY (`SSN`);

--
-- Indexes for table `salarycomputation`
--
ALTER TABLE `salarycomputation`
  ADD PRIMARY KEY (`CARETAKERSSN`,`TIMINGID`,`JOBID`),
  ADD KEY `TIMINGID` (`TIMINGID`),
  ADD KEY `JOBID` (`JOBID`);

--
-- Indexes for table `timing`
--
ALTER TABLE `timing`
  ADD PRIMARY KEY (`TIME_ID`),
  ADD KEY `CSSN` (`CSSN`);

--
-- Indexes for table `toys`
--
ALTER TABLE `toys`
  ADD PRIMARY KEY (`T_ID`);

--
-- Indexes for table `toy_distribution`
--
ALTER TABLE `toy_distribution`
  ADD KEY `TOY_ID` (`TOY_ID`),
  ADD KEY `CLASS_ID` (`CLASS_ID`);

--
-- Indexes for table `tuition_payment`
--
ALTER TABLE `tuition_payment`
  ADD PRIMARY KEY (`PAYMENT_ID`),
  ADD KEY `CHILD_ID` (`CHILD_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `caretaker`
--
ALTER TABLE `caretaker`
  ADD CONSTRAINT `SUPERVISOR_KEY` FOREIGN KEY (`MGR_SSN`) REFERENCES `caretaker` (`CSSN`),
  ADD CONSTRAINT `caretaker_ibfk_1` FOREIGN KEY (`JOB_ID`) REFERENCES `job` (`JOB_ID`),
  ADD CONSTRAINT `caretaker_ibfk_2` FOREIGN KEY (`DEPT_ID`) REFERENCES `department` (`DEPT_ID`);

--
-- Constraints for table `child`
--
ALTER TABLE `child`
  ADD CONSTRAINT `child_ibfk_1` FOREIGN KEY (`PSSN`) REFERENCES `parent` (`SSN`),
  ADD CONSTRAINT `child_ibfk_2` FOREIGN KEY (`CLASS`) REFERENCES `classsection` (`CLASS_ID`);

--
-- Constraints for table `classsection`
--
ALTER TABLE `classsection`
  ADD CONSTRAINT `classsection_ibfk_1` FOREIGN KEY (`CLASS_TEACHER`) REFERENCES `caretaker` (`CSSN`);

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `MGR_KEY` FOREIGN KEY (`MGR_SSN`) REFERENCES `caretaker` (`CSSN`);

--
-- Constraints for table `foodorderedby`
--
ALTER TABLE `foodorderedby`
  ADD CONSTRAINT `foodorderedby_ibfk_1` FOREIGN KEY (`STAFFSSN`) REFERENCES `caretaker` (`CSSN`),
  ADD CONSTRAINT `foodorderedby_ibfk_2` FOREIGN KEY (`FOOD_ID`) REFERENCES `food` (`F_ID`);

--
-- Constraints for table `foodrecord`
--
ALTER TABLE `foodrecord`
  ADD CONSTRAINT `foodrecord_ibfk_1` FOREIGN KEY (`CHILD_ID`) REFERENCES `child` (`CHILD_ID`),
  ADD CONSTRAINT `foodrecord_ibfk_2` FOREIGN KEY (`FOOD_ID`) REFERENCES `food` (`F_ID`);

--
-- Constraints for table `salarycomputation`
--
ALTER TABLE `salarycomputation`
  ADD CONSTRAINT `salarycomputation_ibfk_1` FOREIGN KEY (`CARETAKERSSN`) REFERENCES `caretaker` (`CSSN`),
  ADD CONSTRAINT `salarycomputation_ibfk_2` FOREIGN KEY (`TIMINGID`) REFERENCES `timing` (`TIME_ID`),
  ADD CONSTRAINT `salarycomputation_ibfk_3` FOREIGN KEY (`JOBID`) REFERENCES `job` (`JOB_ID`);

--
-- Constraints for table `timing`
--
ALTER TABLE `timing`
  ADD CONSTRAINT `timing_ibfk_1` FOREIGN KEY (`CSSN`) REFERENCES `caretaker` (`CSSN`);

--
-- Constraints for table `toy_distribution`
--
ALTER TABLE `toy_distribution`
  ADD CONSTRAINT `toy_distribution_ibfk_1` FOREIGN KEY (`TOY_ID`) REFERENCES `toys` (`T_ID`),
  ADD CONSTRAINT `toy_distribution_ibfk_2` FOREIGN KEY (`CLASS_ID`) REFERENCES `classsection` (`CLASS_ID`);

--
-- Constraints for table `tuition_payment`
--
ALTER TABLE `tuition_payment`
  ADD CONSTRAINT `tuition_payment_ibfk_1` FOREIGN KEY (`CHILD_ID`) REFERENCES `child` (`CHILD_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
