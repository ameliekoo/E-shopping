--
-- Base de données :shop
--
CREATE DATABASE IF NOT EXISTS `shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `shop`;

#------------------------------------------------------------
# Table: utilisateur
#------------------------------------------------------------
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `utilisateur`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE IF NOT EXISTS `utilisateur`(
	`u_id` int(11) NOT NULL AUTO_INCREMENT,
	`u_login` varchar(50) NOT NULL,
	`u_mdp` varchar(50) NOT NULL,
	`u_nom` varchar(100) NOT NULL,
	`u_prenom` varchar(100) NOT NULL,
	`u_adresse` varchar(255) NOT NULL,
	`u_telephone` int(11) NOT NULL,
	`u_role_fk` int(11) NOT NULL,
	PRIMARY KEY (`u_id`),
	KEY `u_role_fk` (`u_role_fk`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `utilisateur` (`u_id`, `u_login`, `u_mdp`, `u_nom`, `u_prenom`, `u_adresse`, `u_telephone`, `u_role_fk`) VALUES
(1, 'gg@hotmail.fr', '123456', 'gg', 'amelie', '9, rue Henri Bergson  34500 Beziers', 0123456789,1);





#---------------------------------------------------------
# Table: role
#---------------------------------------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role`(
	`r_id` int(11) NOT NULL AUTO_INCREMENT,
	`r_libelle` varchar(50),
	PRIMARY KEY (`r_id`)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `role`(`r_id`, `r_libelle`) VALUES
(1, 'administrateur'),
(2, 'fournisseur'),
(3, 'client');



#--------------------------------------------------------
# Table: produit
#--------------------------------------------------------
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `produit`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE IF NOT EXISTS `produit` (
	`p_id` int(11) NOT NULL AUTO_INCREMENT,
	`p_nom` varchar(50) NOT NULL,
	`p_marque` varchar(100),
	`p_prix` decimal(6,2) NOT NULL,
	`p_quantite` int(11) NOT NULL,
	`p_description` text,
	`p_categorie_fk` int(11) NOT NULL,
	`p_fournisseur_fk` int(11) NOT NULL,
	PRIMARY KEY (`p_id`),
	KEY `p_categorie_fk` (`p_categorie_fk`),
	KEY `p_fournisseur_fk` (`p_fournisseur_fk`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



#----------------------------------------------------------
# Table: categorie
#----------------------------------------------------------
DROP TABLE IF EXISTS `categorie`;
CREATE TABLE IF NOT EXISTS `categorie` (
	`c_id` int(11) NOT NULL AUTO_INCREMENT,
	`c_libelle` varchar(255) NOT NULL,
	PRIMARY KEY (`c_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;



INSERT INTO `categorie` (`c_id`,`c_libelle`) VALUES
(1, 'cuisine/cuisson/poele'),
(2, 'cuisine/cuisson/casserole'),
(3, 'cuisine/cuisson/autocuiseur'),
(4, 'cuisine/ustensiles/bol'),
(5, 'electromenager/petit apareil/blender'),
(6, 'electromenager/climatisation/ventilateur'),
(7, 'electromenager/gros electromenager/congelateur'),
(8, 'courses/frais/boucherie/veau'),
(9, 'courses/frais/formage/formage au lait de vache'),
(10, 'courses/frais/boulangerie/pain'),
(11, 'courses/frais/poissonnerie/fruits de mer'),
(12, 'meuble/meuble/lit'),
(13, 'meuble/linge de maison/couette'),
(14, 'mode/mode home/chaussure'),
(15, 'mode/bijoux/bijoux femme/collier'),
(16, 'higt-tech/informatique/ordinateur/ordinateur portable'),
(17, 'higt-tech/informatique/ordinateur/ordinateur de bureau'),
(18, 'higt-tech/telephonie/samrtphone'),
(19, 'higt-tech/telephonie/telephonie fixe'),
(20, 'vin, champagne, alcool/vin/vin de Bordeau'),
(21, 'vin, champagne, alcool/vin/vin de Loire'),
(22, 'vin, champagne, alcool/alcool/gin'),
(23, 'vin, champagne, alcool/alcool/liqueur'),
(24, 'vin, champagne, alcool/bieres/bieres blonde'),
(25, 'jardin, bricolage, animalerie/bricolage/outillage/outillage a main'),
(26, 'jardin, bricolage, animalerie/animalerie/chat'),
(27, 'jardin, bricolage, animalerie/animalerie/chien'),
(28, 'jardin, bricolage, animalerie/jardin/piscine'),
(29, 'jardin, bricolage, animalerie/jardin/spa'),
(30, 'jardin, bricolage, animalerie/jardinage, plante, outil/plante,semence,bulbe/plante pour haies'),
(31, 'jardin, bricolage, animalerie/jardinage, plante, outil/plante,semence,bulbe/arbres fruitiers');






#------------------------------------------------------------
# Table: achats
#------------------------------------------------------------
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `achats`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE IF NOT EXISTS `achats` (
	`a_id` int(11) NOT NULL AUTO_INCREMENT,
	`a_prix` decimal(6,2),
	`a_client_fk` int(11) NOT NULL,
	`a_produit_fk` int(11) NOT NULL,
	PRIMARY KEY (`a_id`),
	KEY `a_client_fk` (`a_client_fk`),
	KEY `a_produit_fk` (`a_produit_fk`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;




#-----------------------------------------------------------
# Table: note
#-----------------------------------------------------------
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `note`;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE IF NOT EXISTS `note` (
	`n_id` int(11) NOT NULL AUTO_INCREMENT,
	`n_etoile` int(11) CHECK (`n_etoile`>=0 && `n_etoile`<=5),
	`n_contenu` text,
	`n_client_fk` int(11) NOT NULL,
	`n_produit_fk` int(11) NOT NULL,
	PRIMARY KEY (`n_id`),
	KEY `n_client_fk` (`n_client_fk`),
	KEY `n_produit_fk` (`n_produit_fk`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;




ALTER TABLE `utilisateur`
ADD CONSTRAINT `utilisateur_fk` FOREIGN KEY (`u_role_fk`) REFERENCES `role` (`r_id`) ON UPDATE CASCADE;


ALTER TABLE `produit`
ADD CONSTRAINT `produit_fk1` FOREIGN KEY (`p_categorie_fk`) REFERENCES `categorie` (`c_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `produit_fk2` FOREIGN KEY (`p_fournisseur_fk`) REFERENCES `utilisateur` (`u_id`) ON UPDATE CASCADE;


ALTER TABLE `note`
ADD CONSTRAINT `note_fk1` FOREIGN KEY (`n_client_fk`) REFERENCES `utilisateur` (`u_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `note_fk2` FOREIGN KEY (`n_produit_fk`) REFERENCES `produit` (`p_id`) ON UPDATE CASCADE;


ALTER TABLE `achats`
ADD CONSTRAINT `achats_fk1` FOREIGN KEY (`a_client_fk`) REFERENCES `utilisateur` (`u_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `achats_fk2` FOREIGN KEY (`a_produit_fk`) REFERENCES `produit` (`p_id`) ON UPDATE CASCADE;
