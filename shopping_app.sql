-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Gegenereerd op: 21 apr 2021 om 16:36
-- Serverversie: 10.4.17-MariaDB
-- PHP-versie: 7.4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopping_app`
--

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `brand`
--

CREATE TABLE `brand` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `photo_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `brand`
--

INSERT INTO `brand` (`id`, `name`, `photo_url`) VALUES
(1, 'Opus', NULL),
(2, 'Canal', NULL),
(3, 'Attro', NULL),
(4, 'W&D', NULL);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 1),
(2, 6, 1, 1),
(3, 7, 1, 1),
(29, NULL, 1618904059, NULL),
(30, NULL, 1618915721, NULL),
(31, NULL, 1618917784, NULL);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `cart_item`
--

CREATE TABLE `cart_item` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `cart_item`
--

INSERT INTO `cart_item` (`id`, `order_id`, `product_id`, `count`) VALUES
(264, 29, 3, 3),
(265, 29, 4, 1),
(266, 29, 5, 1),
(361, 1, 4, 1),
(362, 1, 5, 1),
(378, 31, 7, 1);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `description` mediumtext NOT NULL,
  `photo_url` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `photo_url`) VALUES
(1, 'Laptops', 'qsdf', NULL),
(2, 'Tv\'s', 'qsdf', NULL),
(3, 'Smartphones', 'qsdf', NULL);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `description` mediumtext NOT NULL,
  `specs` varchar(255) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `product_code` varchar(10) NOT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `in_stock` tinyint(1) NOT NULL,
  `in_stock_weeks` int(11) DEFAULT NULL,
  `rating` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `description`, `specs`, `brand_id`, `created_at`, `updated_at`, `product_code`, `photo_url`, `in_stock`, `in_stock_weeks`, `rating`) VALUES
(1, 'Opus 4K TV - 8E481 - LED ', '1100.00', 'Dankzij de vooruitstrevende LED technologie staat deze unieke televisie garant voor de meest realistische beeldkwaliteit. Dit toestel brengt je kijkervaring ongetwijfeld naar een hoger niveau.', '62 inch | 4K scherm | smart TV | HDR | 4 x HDMI', 1, 161111111, 161111111, 'DJS484', 'uploads/tv-1.jpeg', 1, NULL, '4.80'),
(3, 'Attro Laptop 17 Inch 512GB HDD', '519.50', 'Deze laptop is uitermate geschikt voor het bekijken van je favoriete films en series. Hij is ook zeer draagbaar en compact, wat van hem een handige reislaptop maakt.', '17 inch | 8GB werkgeheugen | 512GB Opslag | HDD | Azertytoetsenbord', 3, 161111111, 161111111, 'SNO816', 'uploads/laptop-1.jpeg', 0, 2, '3.80'),
(4, 'Opus SmartPhone 64GB Dual Sim Zwart', '290.00', 'Deze unieke smartphone ligt goed in de hand en is uitermate gebruiksvriendelijk. Met zijn grote opslagcapaciteit, kwaliteitsvolle camera\'s en dual sim-optie, behoort hij tot de echte topklasse.', '6 inch | 4G | 64GB | Dual Sim | Optimale gebruiksvriendelijkheid', 1, 161111111, NULL, 'GSM001', '/uploads/smartphone-1.jpeg', 1, NULL, '2.90'),
(5, 'Canal Smartphone 32GB Dual Camera Zwart', '450.50', 'Deze recent uitgebrachte smartphone maakt gebruik van de nieuwste technologieën. Hij combineert kracht, snelheid en een lange batterijduur.', '5.5 inch | 4G | 32GB | Dual Camera | Lange batterijduur', 2, 161111111, NULL, 'GSM002', '/uploads/smartphone-2.jpeg', 0, 1, '4.60'),
(6, 'Canal Semibook Pro Laptop 15 Inch 256GB SSD ', '891.00', 'Deze laptop is geschikt voor het spelen van je favoriete games op hoge instellingen. Door de snelle processor en de videokaart is deze laptop zeer geschikt voor grafische toepassingen.', '15 inch | 6GB werkgeheugen | 256GB Opslag | SSD | Qwertytoetsenbord', 2, 161111111, NULL, 'LAP154', '/uploads/laptop-2.jpeg', 1, NULL, '3.50'),
(7, 'Opus Ultra HD TV - 82 Inch', '1583.00', 'Deze tv is de droom voor elke filmfanaat, en zorgt voor een unieke kijkbeleving. Met zijn 82 inch is hij groot genoeg voor de bioscoopfilms naar de huiskamer te brengen.', '44 inch | Full HD scherm | 2 x HDMI | Clean-sound experience', 1, 161111111, NULL, 'TV612', '/uploads/tv-2.jpeg', 1, NULL, '4.00');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `prod_cat`
--

CREATE TABLE `prod_cat` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `prod_cat`
--

INSERT INTO `prod_cat` (`id`, `product_id`, `cat_id`) VALUES
(1, 1, 2),
(3, 3, 1),
(5, 7, 2),
(6, 6, 1),
(7, 5, 3),
(8, 4, 3);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `prod_spec`
--

CREATE TABLE `prod_spec` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `prod_spec`
--

INSERT INTO `prod_spec` (`id`, `product_id`, `type_id`, `value`) VALUES
(1, 1, 1, '62 inch'),
(2, 1, 2, '4K'),
(3, 1, 3, '4 X HDMI'),
(4, 1, 8, 'Smart TV'),
(15, 3, 1, '17 inch'),
(16, 3, 5, '8GB RAM'),
(17, 3, 4, '512GB'),
(18, 3, 7, 'HDD'),
(19, 3, 6, 'Azerty'),
(20, 4, 1, '6 inch'),
(21, 4, 4, '64GB'),
(22, 4, 8, 'Smartphone'),
(23, 4, 9, 'Dual Sim'),
(24, 5, 1, '5.5 inch'),
(25, 5, 4, '32GB'),
(26, 5, 10, 'Dual Lens Camera'),
(27, 5, 8, 'Smartphone'),
(28, 6, 1, '15 inch'),
(29, 6, 5, '6GB RAM'),
(30, 6, 4, '256GB'),
(31, 6, 7, 'SSD'),
(32, 6, 6, 'Qwerty'),
(33, 7, 1, '82 inch'),
(34, 7, 2, 'Full HD'),
(35, 7, 3, '2 x HDMI'),
(36, 7, 8, 'Non-smart TV');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `spec`
--

CREATE TABLE `spec` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `spec`
--

INSERT INTO `spec` (`id`, `type`) VALUES
(1, 'Schermgrootte'),
(2, 'Resolutie'),
(3, 'Aansluitingen'),
(4, 'Opslagruimte'),
(5, 'Ram Geheugen'),
(6, 'Toetsenbord'),
(7, 'Opslagtype'),
(8, 'Type'),
(9, 'Simkaart'),
(10, 'Camera');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(55) NOT NULL,
  `email` varchar(55) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `photo_url`, `created_at`, `updated_at`) VALUES
(5, 'john', 'john@hotmail.com', '$2y$10$4WgKfMkoxFMGRrZxGw74x.Y6tNxOyGXyUo0QKgI6V4TFAoWLDCkum', NULL, 1618304587, NULL),
(6, 'james', 'james@hotmail.com', '$2y$10$zk8nqGl4e1AS7w/bhQAnrejLtEeuZfpo0dFc78Ttzd9OixZRvBgqm', NULL, 1618304726, NULL),
(7, 'harry', 'harry@hotmail.com', '$2y$10$v7YEUkW01ryKsnm6JDPWgexyb3D0KQr0k8XkRs59xgjMp9yrEbuK.', NULL, 1618307062, NULL);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `brand`
--
ALTER TABLE `brand`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_to_user` (`user_id`);

--
-- Indexen voor tabel `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order` (`order_id`),
  ADD KEY `fk_item` (`product_id`);

--
-- Indexen voor tabel `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_brand_id` (`brand_id`);

--
-- Indexen voor tabel `prod_cat`
--
ALTER TABLE `prod_cat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_prodcat_product` (`product_id`),
  ADD KEY `fk_prodcat_cat` (`cat_id`);

--
-- Indexen voor tabel `prod_spec`
--
ALTER TABLE `prod_spec`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_spec_prod` (`product_id`),
  ADD KEY `fk_spec_spec` (`type_id`);

--
-- Indexen voor tabel `spec`
--
ALTER TABLE `spec`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `brand`
--
ALTER TABLE `brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT voor een tabel `cart_item`
--
ALTER TABLE `cart_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=469;

--
-- AUTO_INCREMENT voor een tabel `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT voor een tabel `prod_cat`
--
ALTER TABLE `prod_cat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT voor een tabel `prod_spec`
--
ALTER TABLE `prod_spec`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT voor een tabel `spec`
--
ALTER TABLE `spec`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_to_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Beperkingen voor tabel `cart_item`
--
ALTER TABLE `cart_item`
  ADD CONSTRAINT `fk_item` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `cart` (`id`);

--
-- Beperkingen voor tabel `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`);

--
-- Beperkingen voor tabel `prod_cat`
--
ALTER TABLE `prod_cat`
  ADD CONSTRAINT `fk_prodcat_cat` FOREIGN KEY (`cat_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `fk_prodcat_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Beperkingen voor tabel `prod_spec`
--
ALTER TABLE `prod_spec`
  ADD CONSTRAINT `fk_spec_prod` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `fk_spec_spec` FOREIGN KEY (`type_id`) REFERENCES `spec` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
