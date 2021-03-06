-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 21. Aug 2016 um 21:20
-- Server-Version: 10.1.8-MariaDB
-- PHP-Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `accountsystem`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ban`
--

CREATE TABLE `ban` (
  `Name` varchar(256) NOT NULL,
  `Serial` varchar(256) NOT NULL,
  `Timestamp` varchar(256) NOT NULL,
  `Grund` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `house`
--

CREATE TABLE `house` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(256) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Interior` varchar(256) NOT NULL,
  `Price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `players`
--

CREATE TABLE `players` (
  `ID` int(11) NOT NULL,
  `Name` varchar(256) NOT NULL,
  `Password` varchar(256) NOT NULL,
  `Serial` varchar(256) NOT NULL,
  `Geld` int(11) NOT NULL,
  `Level` int(11) NOT NULL,
  `Coins` int(11) NOT NULL,
  `Bankgeld` int(11) NOT NULL,
  `Adminlvl` int(11) NOT NULL,
  `VIP` int(11) NOT NULL,
  `Skin` int(11) NOT NULL,
  `playtime` int(11) NOT NULL,
  `position` varchar(256) NOT NULL,
  `Securetoken` varchar(256) NOT NULL,
  `Autologin` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `ID` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Owner` varchar(256) NOT NULL,
  `Koords` varchar(256) NOT NULL,
  `Numberplate` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`Name`);

--
-- Indizes für die Tabelle `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `house`
--
ALTER TABLE `house`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `players`
--
ALTER TABLE `players`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
