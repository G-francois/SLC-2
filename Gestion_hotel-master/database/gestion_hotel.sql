-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 14 avr. 2022 à 05:34
-- Version du serveur :  5.7.31
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_hotel`
--

-- --------------------------------------------------------

--
-- Structure de la table `accompagnateur`
--

DROP TABLE IF EXISTS `accompagnateur`;
CREATE TABLE IF NOT EXISTS `accompagnateur` (
  `num_acc` int(11) NOT NULL AUTO_INCREMENT,
  `nom_acc` varchar(255) NOT NULL,
  PRIMARY KEY (`num_acc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `chambre`
--

DROP TABLE IF EXISTS `chambre`;
CREATE TABLE IF NOT EXISTS `chambre` (
  `num_chambre` int(11) NOT NULL AUTO_INCREMENT,
  `cod_typ` int(11) NOT NULL,
  `pu` int(11) NOT NULL,
  `lib_typ` varchar(255) NOT NULL,
  PRIMARY KEY (`num_chambre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `num_clt` int(11) NOT NULL AUTO_INCREMENT,
  `nom_clt` varchar(255) NOT NULL,
  PRIMARY KEY (`num_clt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `num_cmd` int(11) NOT NULL AUTO_INCREMENT,
  `dat_cmd` datetime NOT NULL,
  `num_res` int(11) NOT NULL,
  PRIMARY KEY (`num_cmd`),
  KEY `num_res` (`num_res`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `liste`
--

DROP TABLE IF EXISTS `liste`;
CREATE TABLE IF NOT EXISTS `liste` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_res` int(11) NOT NULL,
  `num_acc` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `num_res` (`num_res`),
  KEY `num_acc` (`num_acc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `occupation`
--

DROP TABLE IF EXISTS `occupation`;
CREATE TABLE IF NOT EXISTS `occupation` (
  `num_res` int(11) NOT NULL,
  `num_chambre` int(11) NOT NULL,
  `deb_occ` datetime NOT NULL,
  `fin_occ` datetime NOT NULL,
  KEY `num_res` (`num_res`),
  KEY `num_chambre` (`num_chambre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `quantite`
--

DROP TABLE IF EXISTS `quantite`;
CREATE TABLE IF NOT EXISTS `quantite` (
  `cod_repas` int(11) NOT NULL,
  `num_cmd` int(11) NOT NULL,
  `num_chambre` int(11) NOT NULL,
  KEY `cod_repas` (`cod_repas`),
  KEY `num_cmd` (`num_cmd`),
  KEY `num_chambre` (`num_chambre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `repas`
--

DROP TABLE IF EXISTS `repas`;
CREATE TABLE IF NOT EXISTS `repas` (
  `cod_repas` int(11) NOT NULL AUTO_INCREMENT,
  `nom_repas` varchar(255) NOT NULL,
  `pu_repas` int(11) NOT NULL,
  PRIMARY KEY (`cod_repas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `num_res` int(11) NOT NULL AUTO_INCREMENT,
  `dat_res` datetime NOT NULL,
  `num_clt` int(11) NOT NULL,
  PRIMARY KEY (`num_res`),
  KEY `num_clt` (`num_clt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `sexe` varchar(255) NOT NULL,
  `date_naissance` date NOT NULL,
  `email` varchar(255) NOT NULL,
  `nom_utilisateur` varchar(255) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `est_actif` tinyint(1) NOT NULL DEFAULT '0',
  `est_supprimer` tinyint(1) NOT NULL DEFAULT '0',
  `creer_le` timestamp NOT NULL,
  `mise_a_jour_le` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_reservation_num_res` FOREIGN KEY (`num_cmd`) REFERENCES `reservation` (`num_res`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `liste`
--
ALTER TABLE `liste`
  ADD CONSTRAINT `liste_accompagnateur_num_acc` FOREIGN KEY (`num_acc`) REFERENCES `accompagnateur` (`num_acc`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `liste_reservation_num_res` FOREIGN KEY (`num_res`) REFERENCES `reservation` (`num_res`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `occupation`
--
ALTER TABLE `occupation`
  ADD CONSTRAINT `occupation_chambre_num_chambre` FOREIGN KEY (`num_chambre`) REFERENCES `chambre` (`num_chambre`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `occupation_reservation_num_res` FOREIGN KEY (`num_res`) REFERENCES `reservation` (`num_res`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `quantite`
--
ALTER TABLE `quantite`
  ADD CONSTRAINT `quantite_chambre_num_chambre` FOREIGN KEY (`num_chambre`) REFERENCES `chambre` (`num_chambre`),
  ADD CONSTRAINT `quantite_commande_num_cmd` FOREIGN KEY (`num_cmd`) REFERENCES `commande` (`num_cmd`),
  ADD CONSTRAINT `quantite_repas_cod_repas` FOREIGN KEY (`cod_repas`) REFERENCES `repas` (`cod_repas`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_client_num_clt` FOREIGN KEY (`num_res`) REFERENCES `client` (`num_clt`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
