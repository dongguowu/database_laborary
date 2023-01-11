-- MySQL Script generated by MySQL Workbench
-- Mon Jan  9 22:58:42 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
SET
	@OLD_UNIQUE_CHECKS = @ @UNIQUE_CHECKS,
	UNIQUE_CHECKS = 0;

SET
	@OLD_FOREIGN_KEY_CHECKS = @ @FOREIGN_KEY_CHECKS,
	FOREIGN_KEY_CHECKS = 0;

SET
	@OLD_SQL_MODE = @ @SQL_MODE,
	SQL_MODE = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Shopping_Project
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Shopping_Project`;

-- -----------------------------------------------------
-- Schema Shopping_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Shopping_Project`;

USE `Shopping_Project`;

SHOW DATABASE LIKE 'shopping_project';

SHOW TABLES LIKE 'addre%';

-- -----------------------------------------------------
-- Table `Shopping_Project`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`address`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`address` (
	`address_id` INT NOT NULL AUTO_INCREMENT,
	`street` VARCHAR(45) NOT NULL,
	`city` VARCHAR(45) NOT NULL,
	`province` VARCHAR(45) NOT NULL,
	`postal_code` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`address_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`payment_method_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`payment_method_categories`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`payment_method_categories` (
	`payment_method_category_id` INT NOT NULL AUTO_INCREMENT,
	`payment_method_category_name` VARCHAR(45) NULL,
	PRIMARY KEY (`payment_method_category_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`payment_methods`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`payment_methods`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`payment_methods` (
	`payment_method_id` INT NOT NULL AUTO_INCREMENT,
	`payment_method_category_id` INT NOT NULL,
	`name_on_card` VARCHAR(45) NOT NULL,
	`card_number` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`payment_method_id`),
	INDEX `fk_payment_methods_payment_method_categories1_idx` (`payment_method_category_id` ASC) VISIBLE,
	CONSTRAINT `fk_payment_methods_payment_method_categories1` FOREIGN KEY (`payment_method_category_id`) REFERENCES `Shopping_Project`.`payment_method_categories` (`payment_method_category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`orders`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`orders` (
	`order_id` INT NOT NULL AUTO_INCREMENT,
	`shipping_address_id` INT NULL,
	`payment_method_id` INT NULL,
	`order_date` DATE NULL,
	PRIMARY KEY (`order_id`),
	INDEX `fk_orders_address1_idx` (`shipping_address_id` ASC) VISIBLE,
	INDEX `fk_shoppings_payment_methods1_idx` (`payment_method_id` ASC) VISIBLE,
	CONSTRAINT `fk_orders_address1` FOREIGN KEY (`shipping_address_id`) REFERENCES `Shopping_Project`.`address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_shoppings_payment_methods1` FOREIGN KEY (`payment_method_id`) REFERENCES `Shopping_Project`.`payment_methods` (`payment_method_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`categories`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`categories` (
	`category_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`category_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`products`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`products` (
	`product_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	`category_id` INT NOT NULL,
	PRIMARY KEY (`product_id`),
	INDEX `fk_product_categories1_idx` (`category_id` ASC) VISIBLE,
	CONSTRAINT `fk_product_categories1` FOREIGN KEY (`category_id`) REFERENCES `Shopping_Project`.`categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`sellers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`sellers`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`sellers` (
	`seller_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(45) NOT NULL,
	PRIMARY KEY (`seller_id`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`items`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`items` (
	`item_id` INT NOT NULL AUTO_INCREMENT,
	`product_id` INT NOT NULL,
	`seller_id` INT NOT NULL,
	`price` DECIMAL(8, 2) NULL,
	`quantity` INT NULL,
	INDEX `fk_items_sellers1_idx` (`seller_id` ASC) VISIBLE,
	INDEX `fk_items_product1_idx` (`product_id` ASC) VISIBLE,
	PRIMARY KEY (`item_id`),
	CONSTRAINT `fk_items_sellers1` FOREIGN KEY (`seller_id`) REFERENCES `Shopping_Project`.`sellers` (`seller_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_items_product1` FOREIGN KEY (`product_id`) REFERENCES `Shopping_Project`.`products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`shopping_cart_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`shopping_cart_lines`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`shopping_cart_lines` (
	`shopping_cart_line_id` INT NOT NULL AUTO_INCREMENT,
	`item_id` INT NOT NULL,
	`quantity` INT NULL,
	PRIMARY KEY (`shopping_cart_line_id`),
	INDEX `fk_shopping_cart_lines_items1_idx` (`item_id` ASC) VISIBLE,
	CONSTRAINT `fk_shopping_cart_lines_items1` FOREIGN KEY (`item_id`) REFERENCES `Shopping_Project`.`items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Shopping_Project`.`shopping_carts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Shopping_Project`.`shopping_carts`;

CREATE TABLE IF NOT EXISTS `Shopping_Project`.`shopping_carts` (
	`order_id` INT NOT NULL,
	`shopping_cart_line_id` INT NOT NULL,
	INDEX `fk_order_details_shopping_cart_lines1_idx` (`shopping_cart_line_id` ASC) VISIBLE,
	PRIMARY KEY (`order_id`, `shopping_cart_line_id`),
	INDEX `fk_shopping_carts_orders1_idx` (`order_id` ASC) VISIBLE,
	CONSTRAINT `fk_order_details_shopping_cart_lines1` FOREIGN KEY (`shopping_cart_line_id`) REFERENCES `Shopping_Project`.`shopping_cart_lines` (`shopping_cart_line_id`) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT `fk_shopping_carts_orders1` FOREIGN KEY (`order_id`) REFERENCES `Shopping_Project`.`orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

SET
	SQL_MODE = @OLD_SQL_MODE;

SET
	FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;

SET
	UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
