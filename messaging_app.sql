-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Gegenereerd op: 27 mrt 2021 om 10:52
-- Serverversie: 10.1.37-MariaDB
-- PHP-versie: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `messaging_app`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `user_1` int(11) NOT NULL,
  `user_2` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `conv_id` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `contact`
--

INSERT INTO `contact` (`id`, `user_1`, `user_2`, `status`, `conv_id`, `created_at`) VALUES
(53, 9, 10, 2, 31, 1616838196),
(66, 10, 7, 2, 35, 1616838196),
(67, 6, 7, 3, NULL, 1616838196),
(68, 7, 8, 2, 36, 1616838196),
(84, 9, 6, 3, NULL, NULL),
(86, 9, 8, 3, NULL, NULL),
(88, 6, 10, 2, 44, 1616838196),
(90, 11, 10, 2, 46, 1616838408),
(91, 11, 9, 1, NULL, NULL),
(95, 6, 13, 1, NULL, NULL),
(96, 8, 6, 1, NULL, NULL),
(97, 8, 10, 2, 45, 1616838196),
(98, 10, 12, 2, 47, 1616838643);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `conversation`
--

CREATE TABLE `conversation` (
  `id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `created_at` int(15) NOT NULL,
  `created_by` int(11) NOT NULL,
  `photo_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `conversation`
--

INSERT INTO `conversation` (`id`, `name`, `created_at`, `created_by`, `photo_url`) VALUES
(27, NULL, 1616838196, 6, NULL),
(31, NULL, 1616838196, 10, NULL),
(33, 'OG 6', 1616838196, 6, NULL),
(35, NULL, 1616838196, 7, NULL),
(36, NULL, 1616838196, 8, NULL),
(37, NULL, 1616838196, 8, NULL),
(38, NULL, 1616838196, 8, NULL),
(44, NULL, 1616838196, 10, NULL),
(45, NULL, 1616838196, 10, NULL),
(46, NULL, 1616838408, 10, NULL),
(47, NULL, 1616838643, 12, NULL);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `message`
--

CREATE TABLE `message` (
  `id` int(11) NOT NULL,
  `conv_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `body` mediumtext NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `message`
--

INSERT INTO `message` (`id`, `conv_id`, `user_id`, `body`, `created_at`) VALUES
(39, 36, 12, 'Hello!', 1609664893),
(42, 31, 10, 'Testqsqq', 1616837465),
(43, 35, 10, 'Hi John!', 1616837503),
(44, 31, 10, 'Hey man!', 1616838196),
(45, 31, 10, 'What\'s up!', 1616838200),
(46, 31, 10, 'Nog steeds', 1616838348),
(47, 47, 12, 'Klopt niet!', 1616838653);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(55) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(55) NOT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `photo_url`, `created_at`, `updated_at`) VALUES
(6, 'steve', '$2y$10$2rTMBYq7DJ25QKAixgeMMuR1Yoy3DVfFErA5aAByK1Xx6hhfudg8W', 'steve@hotmail.com', NULL, 0, 0),
(7, 'jon', '$2y$10$S2/nAqtHZxeNUuCXf9eYPuf./lH1C5G0cqF.5.g2in7kKE54YY3gi', 'jon@hotmail.com', NULL, 0, 0),
(8, 'natasha', '$2y$10$wMBLnveMvmRPDd4eciNVz.uh8feupf9RLxovWLqsGb7JTDKk7nQo.', 'natasha@hotmail.com', NULL, 0, 0),
(9, 'tony', '$2y$10$TVFchz.FYesx3u9Xi0.iaujjcg7r3Rn9e/ChC6YUlGEd38JC/dQyO', 'tony@hotmail.com', NULL, 0, 0),
(10, 'bruce', '$2y$10$QrCmvIwQqRJJYGIAtannOOMZCEDQw6mdFCoDejMAd8532PgwXvPX2', 'bruce@hotmail.com', NULL, 0, 0),
(11, 'thor', '$2y$10$QMePztau.WqjArT0jzfx2u4LwENab4MoOGx7.5.8QYCHcnM7vnAFq', 'thor@hotmail.com', NULL, 0, 0),
(12, 'scott', '$2y$10$MX3Wa3zdDg093cP4RL2n5u6HWdg2XmfFTaCDPoAT9PuhrBeWY1.lO', 'scott@hotmail.com', NULL, 0, 0),
(13, 'stephen', '$2y$10$nqJJ9N2smYnn3ofgqbrUquKM5eioC.t9skitoxfYRH0aFsH6O4rda', 'stephen@hotmail.com', NULL, 0, 0);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user_conv`
--

CREATE TABLE `user_conv` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `conv_id` int(11) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Gegevens worden geëxporteerd voor tabel `user_conv`
--

INSERT INTO `user_conv` (`id`, `user_id`, `conv_id`, `created_at`) VALUES
(1, 6, 33, 0),
(2, 11, 33, 0),
(3, 10, 33, 0),
(4, 8, 33, 0);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_to_user_1` (`user_1`),
  ADD KEY `fk_to_user_2` (`user_2`),
  ADD KEY `fk_to_conversation` (`conv_id`);

--
-- Indexen voor tabel `conversation`
--
ALTER TABLE `conversation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_conv_created_by` (`created_by`);

--
-- Indexen voor tabel `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_from_conv` (`conv_id`),
  ADD KEY `fk_sent_by` (`user_id`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `user_conv`
--
ALTER TABLE `user_conv`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_to_conv` (`conv_id`),
  ADD KEY `fk_to_user` (`user_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT voor een tabel `conversation`
--
ALTER TABLE `conversation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT voor een tabel `message`
--
ALTER TABLE `message`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT voor een tabel `user_conv`
--
ALTER TABLE `user_conv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `fk_to_conversation` FOREIGN KEY (`conv_id`) REFERENCES `conversation` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `fk_to_user_1` FOREIGN KEY (`user_1`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_to_user_2` FOREIGN KEY (`user_2`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `conversation`
--
ALTER TABLE `conversation`
  ADD CONSTRAINT `fk_conv_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `fk_from_conv` FOREIGN KEY (`conv_id`) REFERENCES `conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sent_by` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `user_conv`
--
ALTER TABLE `user_conv`
  ADD CONSTRAINT `fk_to_conv` FOREIGN KEY (`conv_id`) REFERENCES `conversation` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_to_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
