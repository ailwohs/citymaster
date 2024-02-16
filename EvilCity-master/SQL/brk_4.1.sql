-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Lun 22 Mai 2017 à 21:55
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gta5_gamemode_essential`
--
CREATE DATABASE IF NOT EXISTS `gta5_gamemode_essential` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gta5_gamemode_essential`;

-- --------------------------------------------------------

--
-- Structure de la table `bans`
--

CREATE TABLE `bans` (
  `id` int(10) NOT NULL,
  `banned` varchar(50) NOT NULL DEFAULT '0',
  `banner` varchar(50) NOT NULL,
  `reason` varchar(150) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `coordinates`
--

CREATE TABLE `coordinates` (
  `id` int(11) UNSIGNED NOT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `Nom` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `coordinates`
--

INSERT INTO `coordinates` (`id`, `x`, `y`, `z`, `Nom`) VALUES
(1, -99.3197, 1910.35, 197.005, 'Champ de canabis'),
(2, -2946.86, 439.896, 15.2521, 'Traitement weed'),
(3, -572.908, -1609.92, 27.0108, 'Revente weed 1'),
(4, 2645.97143554688, 2806.37280273438, 33.9922828674316, NULL),
(5, 1108.08, -2008.67, 30.885, 'fonderie'),
(6, 172.151062011719, 2279.62280273438, 92.6908645629883, NULL),
(7, -1767.95, 2201.6, 102.744, NULL),
(8, 857.683, -1958.85, 29.54, NULL),
(9, 466.075, -1847.81, 27.8526, NULL),
(10, 3664.87, 4607.79, 17.5661, 'récolte éphédrine'),
(11, 2433.66, 4968.99, 42.3476, 'traitement éphédrine'),
(12, 95.2137, -1291.4, 29.2687, 'revente meth'),
(13, -2457.83, 2501.89, 3.02207, 'Récolte coke'),
(15, 1592.36, 3591.7, 38.7665, 'Revente coke'),
(16, 145.862, -2202.52, 4.68802, 'traitement coke'),
(17, -543.145, 5103.37, 115.352, 'récolte bois'),
(18, -501.405, 5280.53, 80.0827, 'traitement du bois'),
(19, 1206.32, -1320.23, 35.227, 'revente bois 1'),
(20, 79.5881, -432.285, 37.553, 'Revente Bois 2'),
(21, 238.198, -2019.95, 18.3071, 'Revente cannabis 2'),
(22, -1336.02, -1164.02, 4.5428, 'Revente meth 2'),
(23, 2339.57, 2569.68, 47.7204, 'revente coke 2\r\n'),
(24, 3273.41, 46.2956, -0.6728, 'Peche tortue'),
(25, -1200.81, -1769.06, 3.38106, 'Découpe tortue'),
(26, -1844.59, -1195.81, 19.1856, 'revente tortue'),
(27, -3249.09, 1005.4, 12.8307, 'Revente tortue 2\r\n'),
(28, 364.891, 3981.78, 30.3177, 'peche moule'),
(29, 1958.33, 3748.03, 32.3438, 'revente moule'),
(30, 2955.37, 2769.23, 38.7368, 'récolte diam'),
(31, 245.504, 369.663, 105.738, 'taille diam'),
(32, -624.382, -231.221, 38.0571, 'revente diam'),
(33, 2815.67, -1467.09, 10.1754, 'récolte feuille de coka'),
(34, 1509.79, -2103.66, 76.5883, 'traitement crack'),
(35, -1418.33, -255.84, 46.445, 'revente crack');

-- --------------------------------------------------------

--
-- Structure de la table `interiors`
--

CREATE TABLE `interiors` (
  `id` int(11) NOT NULL COMMENT 'key id',
  `enter` text NOT NULL COMMENT 'enter coords',
  `exit` text NOT NULL COMMENT 'destination coords',
  `iname` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `interiors`
--

INSERT INTO `interiors` (`id`, `enter`, `exit`, `iname`) VALUES
(1, '{136.139,-761.482,45.752,321.7075}', '{136.148,-761.498,242.152,234.62}', 'Commissariat principal'),
(2, '{-773.739,310.642,85.6981,321.7075}', '{-774.378,331.778,160.001,234.62}', 'Eclipse appartement 9'),
(3, '{3562.82,3691.84,28.1216,321.7075}', '{3540.78,3675.89,20.9918,321.7075}', 'Laboratoire'),
(4, '{-590.441,-1624.09,33.0106,321.7075}', '{-589.957,-1619.57,33.0106,321.7075}', 'Entrepôt'),
(5, '{138.801,-762.509,45.752,321.7075}', '{161.643,-718.064,33.1317,321.7075}', 'Garage du commissariat'),
(6, '{138.347,-764.451,242.152,321.7075}', '{130.326,-761.11,262.829,321.7075}', 'Toit du commissariat');

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `id` int(11) UNSIGNED NOT NULL,
  `libelle` varchar(255) DEFAULT NULL,
  `limitation` int(11) NOT NULL DEFAULT '1',
  `isIllegal` tinyint(4) NOT NULL,
  `value` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `items`
--

INSERT INTO `items` (`id`, `libelle`, `limitation`, `isIllegal`, `value`, `type`) VALUES
(1, 'Cuivre', 30, 0, 0, 0),
(2, 'Fer', 30, 0, 0, 0),
(3, 'Or', 30, 0, 0, 0),
(4, 'Feuilles de cannabis', 30, 0, 0, 0),
(5, 'Pain', 30, 0, 0, 0),
(6, 'Eau', 30, 0, 0, 0),
(7, 'Coca', 30, 0, 0, 0),
(8, 'Pax de cannabis', 30, 1, 0, 0),
(9, 'Lingo de cuivre', 30, 0, 0, 0),
(10, 'Grappe de raisins\r\n', 30, 0, 0, 0),
(11, 'Tonneau de vin', 30, 0, 0, 0),
(12, 'Éphédrine', 30, 0, 0, 0),
(13, 'Cristaux de meth', 30, 1, 0, 0),
(14, 'Feuilles de coca', 30, 0, 0, 0),
(15, 'Paquets de coke', 30, 1, 0, 0),
(16, 'Tronc d\'arbre', 30, 0, 0, 0),
(17, 'Stère de bois', 30, 0, 0, 0),
(18, 'Tortue', 30, 0, 0, 0),
(19, 'Viande de tortue', 30, 1, 0, 0),
(20, 'Seau de moules', 30, 0, 0, 0),
(21, 'Diamant brut', 30, 0, 0, 0),
(22, 'Diamant taillé', 30, 0, 0, 0),
(23, 'Résidu de coka', 70, 1, 0, 0),
(24, 'Paquet de Crack', 70, 1, 0, 0),
(25, 'Soda', 5, 0, 20, 1),
(26, 'Sandwich', 5, 0, 20, 2);

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '500'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `jobs`
--

INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
(1, 'Policier', 75),
(2, 'Chomeur', 0),
(3, 'Mineur', 60),
(4, 'Chauffeur de taxi', 55),
(5, 'Vigneron', 55),
(6, 'Chauffeur poids lourd', 60),
(7, 'Dépanneur', 60),
(8, 'Pecheur', 40),
(9, 'Bucheron', 40),
(10, 'Dealer de Weed', 0),
(11, 'Dealer de Meth', 0),
(12, 'Dealer de Coke', 0),
(13, 'Joaillier', 65),
(14, 'Dealer de Crack', 0),
(15, 'Ambulancier', 0);

-- --------------------------------------------------------

--
-- Structure de la table `outfits`
--

CREATE TABLE `outfits` (
  `identifier` varchar(30) NOT NULL,
  `skin` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'mp_m_freemode_01',
  `face` int(11) NOT NULL DEFAULT '0',
  `face_text` int(11) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '0',
  `hair_text` int(11) NOT NULL DEFAULT '0',
  `pants` int(11) NOT NULL DEFAULT '0',
  `pants_text` int(11) NOT NULL DEFAULT '0',
  `shoes` int(11) NOT NULL DEFAULT '0',
  `shoes_text` int(11) NOT NULL DEFAULT '0',
  `torso` int(11) NOT NULL DEFAULT '0',
  `torso_text` int(11) NOT NULL DEFAULT '0',
  `shirt` int(11) NOT NULL DEFAULT '0',
  `shirt_text` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `police`
--

CREATE TABLE `police` (
  `identifier` varchar(255) NOT NULL,
  `rank` varchar(255) NOT NULL DEFAULT 'Recrue'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `recolt`
--

CREATE TABLE `recolt` (
  `ID` int(11) UNSIGNED NOT NULL,
  `raw_id` int(11) UNSIGNED DEFAULT NULL,
  `treated_id` int(11) UNSIGNED DEFAULT NULL,
  `job_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `field_id` int(10) UNSIGNED DEFAULT NULL,
  `treatment_id` int(10) UNSIGNED DEFAULT NULL,
  `seller_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `recolt`
--

INSERT INTO `recolt` (`ID`, `raw_id`, `treated_id`, `job_id`, `price`, `field_id`, `treatment_id`, `seller_id`) VALUES
(1, 4, 8, 10, 150, 1, 2, 3),
(2, 1, 9, 3, 80, 4, 5, 6),
(3, 10, 11, 5, 90, 7, 8, 9),
(4, 12, 13, 11, 160, 10, 11, 12),
(5, 14, 15, 12, 170, 13, 16, 15),
(6, 16, 17, 9, 110, 17, 18, 19),
(7, 16, 17, 9, 110, 17, 18, 20),
(8, 4, 8, 10, 150, 1, 2, 21),
(9, 12, 13, 11, 160, 10, 11, 22),
(10, 14, 15, 12, 170, 13, 16, 23),
(11, 18, 19, 8, 150, 24, 25, 26),
(12, 18, 19, 8, 150, 24, 25, 27),
(13, 20, 20, 8, 60, 28, 28, 29),
(14, 21, 22, 13, 100, 30, 31, 32),
(15, 23, 24, 14, 110, 33, 34, 35);

-- --------------------------------------------------------

--
-- Structure de la table `user_inventory`
--

CREATE TABLE `user_inventory` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `item_id` int(11) UNSIGNED NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `group` varchar(50) NOT NULL DEFAULT '0',
  `permission_level` int(11) NOT NULL DEFAULT '0',
  `money` double NOT NULL DEFAULT '0',
  `bankbalance` int(32) DEFAULT '0',
  `job` int(11) DEFAULT '1',
  `lastpos` varchar(255) DEFAULT '{234.652,-881.139,30.492}',
  `isFirstConnection` int(11) DEFAULT '1',
  `nom` varchar(128) NOT NULL DEFAULT '',
  `prenom` varchar(128) NOT NULL DEFAULT '',
  `dateNaissance` date DEFAULT '0000-01-01',
  `sexe` varchar(1) NOT NULL DEFAULT 'f',
  `taille` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `enService` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `coordinates`
--
ALTER TABLE `coordinates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `interiors`
--
ALTER TABLE `interiors`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`job_id`);

--
-- Index pour la table `police`
--
ALTER TABLE `police`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `recolt`
--
ALTER TABLE `recolt`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `raw_id` (`raw_id`),
  ADD KEY `treated_id` (`treated_id`),
  ADD KEY `job_id` (`job_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `treatment_id` (`treatment_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Index pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD PRIMARY KEY (`user_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `coordinates`
--
ALTER TABLE `coordinates`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT pour la table `interiors`
--
ALTER TABLE `interiors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'key id', AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT pour la table `recolt`
--
ALTER TABLE `recolt`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `user_inventory`
--
ALTER TABLE `user_inventory`
  ADD CONSTRAINT `user_inventory_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`);
--
-- Base de données :  `gta5_script_carshop`
--
CREATE DATABASE IF NOT EXISTS `gta5_script_carshop` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gta5_script_carshop`;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `owner` varchar(50) CHARACTER SET utf8 NOT NULL,
  `model` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `colour` varchar(50) CHARACTER SET utf8 DEFAULT '0',
  `scolour` varchar(50) CHARACTER SET utf8 DEFAULT '0',
  `plate` varchar(50) CHARACTER SET utf8 DEFAULT '0',
  `wheels` int(11) DEFAULT '0',
  `windows` int(11) DEFAULT '0',
  `platetype` int(11) DEFAULT '0',
  `exhausts` int(11) DEFAULT '0',
  `grills` int(11) DEFAULT '0',
  `spoiler` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD KEY `Index 1` (`plate`);
--
-- Base de données :  `gta5_script_customization`
--
CREATE DATABASE IF NOT EXISTS `gta5_script_customization` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gta5_script_customization`;

-- --------------------------------------------------------

--
-- Structure de la table `outfits`
--

CREATE TABLE `outfits` (
  `identifier` varchar(50) CHARACTER SET utf8 NOT NULL,
  `hair` int(11) DEFAULT NULL,
  `haircolour` int(11) DEFAULT NULL,
  `torso` int(11) DEFAULT NULL,
  `torsotexture` int(11) DEFAULT NULL,
  `torsoextra` int(11) DEFAULT NULL,
  `torsoextratexture` int(11) DEFAULT NULL,
  `pants` int(11) DEFAULT NULL,
  `pantscolour` int(11) DEFAULT NULL,
  `shoes` int(11) DEFAULT NULL,
  `shoescolour` int(11) DEFAULT NULL,
  `bodyaccesoire` int(11) DEFAULT NULL,
  `undershirt` int(11) DEFAULT NULL,
  `armor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Base de données :  `gta5_script_stats`
--
CREATE DATABASE IF NOT EXISTS `gta5_script_stats` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gta5_script_stats`;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(50) CHARACTER SET utf8 NOT NULL,
  `playtime` double DEFAULT NULL,
  `shotsfired` double DEFAULT NULL,
  `kmdriven` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`identifier`, `playtime`, `shotsfired`, `kmdriven`) VALUES
('steam:1100001016a2e39', 1, 0, 0);
--
-- Base de données :  `gta5_script_turfs`
--
CREATE DATABASE IF NOT EXISTS `gta5_script_turfs` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gta5_script_turfs`;

-- --------------------------------------------------------

--
-- Structure de la table `turfs`
--

CREATE TABLE `turfs` (
  `identifier` varchar(50) CHARACTER SET utf8 NOT NULL,
  `SANDY` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
--
-- Base de données :  `gta5_script_weaponshop`
--
CREATE DATABASE IF NOT EXISTS `gta5_script_weaponshop` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gta5_script_weaponshop`;

-- --------------------------------------------------------

--
-- Structure de la table `owned`
--

CREATE TABLE `owned` (
  `identifier` varchar(50) CHARACTER SET utf8 NOT NULL,
  `weapon` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `withdraw_cost` int(10) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
