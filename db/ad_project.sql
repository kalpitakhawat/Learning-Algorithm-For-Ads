-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2016 at 05:58 PM
-- Server version: 5.6.21
-- PHP Version: 5.5.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ad_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `ad_live`
--

CREATE TABLE IF NOT EXISTS `ad_live` (
`id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `clicks` int(11) NOT NULL,
  `total_clicks` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ad_live`
--

INSERT INTO `ad_live` (`id`, `page_id`, `ad_id`, `clicks`, `total_clicks`) VALUES
(1, 1, 1, 11, 11),
(2, 1, 5, 14, 14),
(3, 2, 4, 0, 10),
(4, 2, 8, 0, 11);

-- --------------------------------------------------------

--
-- Table structure for table `ad_master`
--

CREATE TABLE IF NOT EXISTS `ad_master` (
`id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `link` text NOT NULL,
  `img` text,
  `position_id` int(11) NOT NULL,
  `reg_ex` text,
  `price` int(11) NOT NULL,
  `width` varchar(200) NOT NULL,
  `height` varchar(200) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ad_master`
--

INSERT INTO `ad_master` (`id`, `provider_id`, `link`, `img`, `position_id`, `reg_ex`, `price`, `width`, `height`) VALUES
(1, 1, 'http://google-one.com', './imgs/ads_1.gif', 1, 'abcd', 100, '150', '200'),
(2, 2, 'http://google-rwo.com', './imgs/ads_2.jpg', 1, 'abcd', 110, '150', '200'),
(3, 3, 'http://google-three.com', './imgs/ads_1.gif', 1, 'abcd', 120, '150', '200'),
(4, 4, 'http://google-four.com', './imgs/ads_2.jpg', 1, 'abcd', 130, '150', '200'),
(5, 1, 'http://facebook.com', './imgs/ads_2.jpg', 2, 'abcd', 105, '150', '200'),
(6, 2, 'http://facebook.com', './imgs/ads_2.jpg', 2, 'abcd', 115, '150', '200'),
(7, 3, 'http://facebook.com', './imgs/ads_1.gif', 2, 'abcd', 125, '150', '200'),
(8, 4, 'http://facebook.com', './imgs/ads_2.jpg', 2, 'abcd', 135, '150', '200');

-- --------------------------------------------------------

--
-- Table structure for table `ad_providers`
--

CREATE TABLE IF NOT EXISTS `ad_providers` (
`id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ad_providers`
--

INSERT INTO `ad_providers` (`id`, `name`) VALUES
(1, 'hp'),
(2, 'glocal'),
(3, 'idreams'),
(4, 'infosysglobal');

-- --------------------------------------------------------

--
-- Table structure for table `page_master`
--

CREATE TABLE IF NOT EXISTS `page_master` (
`id` int(11) NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `page_master`
--

INSERT INTO `page_master` (`id`, `name`) VALUES
(1, 'one.html'),
(2, 'two.html'),
(3, 'three.html'),
(4, 'four.html');

-- --------------------------------------------------------

--
-- Table structure for table `position_master`
--

CREATE TABLE IF NOT EXISTS `position_master` (
`id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `position_master`
--

INSERT INTO `position_master` (`id`, `name`) VALUES
(1, 'left'),
(2, 'right'),
(3, 'top'),
(4, 'bottom');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ad_live`
--
ALTER TABLE `ad_live`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ad_master`
--
ALTER TABLE `ad_master`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ad_providers`
--
ALTER TABLE `ad_providers`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_master`
--
ALTER TABLE `page_master`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `position_master`
--
ALTER TABLE `position_master`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ad_live`
--
ALTER TABLE `ad_live`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `ad_master`
--
ALTER TABLE `ad_master`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `ad_providers`
--
ALTER TABLE `ad_providers`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `page_master`
--
ALTER TABLE `page_master`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `position_master`
--
ALTER TABLE `position_master`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
