-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 17, 2020 at 07:06 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cod4status`
--

-- --------------------------------------------------------

--
-- Table structure for table `banned_players`
--

CREATE TABLE `banned_players` (
  `id` int(11) NOT NULL,
  `player_name` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `map` varchar(255) DEFAULT NULL,
  `guid` varchar(255) DEFAULT NULL,
  `banned_by` varchar(255) DEFAULT NULL,
  `admin_uid` varchar(255) DEFAULT NULL,
  `screenshot_url` varchar(255) DEFAULT NULL,
  `server_name` varchar(255) DEFAULT NULL,
  `server_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `my_servers`
--

CREATE TABLE `my_servers` (
  `id` int(11) NOT NULL,
  `server_name` varchar(255) NOT NULL,
  `server_ip` varchar(255) NOT NULL,
  `server_port` int(11) NOT NULL,
  `server_maxplayers` int(11) DEFAULT NULL,
  `server_online_players` int(11) DEFAULT NULL,
  `server_game` varchar(255) NOT NULL DEFAULT 'Call of Duty 4 Server',
  `server_current_map` varchar(255) DEFAULT NULL,
  `server_location` varchar(255) DEFAULT NULL,
  `last_refresh` datetime DEFAULT NULL,
  `steam_group_url` varchar(255) DEFAULT NULL,
  `server_identkey` varchar(255) DEFAULT NULL,
  `server_status` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `my_servers`
--

INSERT INTO `my_servers` (`id`, `server_name`, `server_ip`, `server_port`, `server_maxplayers`, `server_online_players`, `server_game`, `server_current_map`, `server_location`, `last_refresh`, `steam_group_url`, `server_identkey`, `server_status`) VALUES
(1, 'SLeSPORTS SnD Promod |REMASTERED|', 'slescod4.tk', 28960, 34, NULL, 'Call of Duty 4 Server', NULL, 'LK', '2020-04-17 22:25:07', '', '123321456654', '0'),
(2, 'SLeSPORTS TDM Promod |REMASTERED|', 'slescod4.tk', 28961, 32, NULL, 'Call of Duty 4 Server', NULL, 'LK', '2020-04-17 22:25:05', '', '123321456654', '0');

-- --------------------------------------------------------

--
-- Table structure for table `steam_admins`
--

CREATE TABLE `steam_admins` (
  `id` int(11) NOT NULL,
  `steam_id` varchar(255) NOT NULL,
  `server_id` int(11) NOT NULL,
  `role` int(11) NOT NULL DEFAULT 1,
  `steam_user_personaname` varchar(255) DEFAULT NULL,
  `steam_avatar` varchar(255) DEFAULT NULL,
  `steam_profile_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(16) NOT NULL,
  `user_password_hash` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `admin_uid` varchar(255) DEFAULT NULL,
  `steam_profile_url` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_password_hash`, `user_email`, `admin_uid`, `steam_profile_url`, `role`) VALUES
(1, 'sles', '$2y$10$Au2dqNVHbM2rRm63RfoqYundGIF/Ux3dXLkyCeZEwfIIcXKVDAcRK', 'dulkith@outlook.com', '1234', 'test', '100');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banned_players`
--
ALTER TABLE `banned_players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `player_name` (`screenshot_url`);

--
-- Indexes for table `my_servers`
--
ALTER TABLE `my_servers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `steam_admins`
--
ALTER TABLE `steam_admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`,`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banned_players`
--
ALTER TABLE `banned_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `my_servers`
--
ALTER TABLE `my_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `steam_admins`
--
ALTER TABLE `steam_admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
