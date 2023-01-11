-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OnlineShopping
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OnlineShopping
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OnlineShopping` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema employees
-- -----------------------------------------------------
USE `OnlineShopping` ;

-- -----------------------------------------------------
-- Table `OnlineShopping`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`province` (
  `id` INT NOT NULL,
  `province_name` VARCHAR(45) NULL,
  `province_code` VARCHAR(4) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`address` (
  `id` INT NOT NULL,
  `stree_no` VARCHAR(8) NULL,
  `stree_name` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `postcode` VARCHAR(45) NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_province1_idx` (`province_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `OnlineShopping`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`payment_methods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`payment_methods` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `payment_name` VARCHAR(10) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`tax_rate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`tax_rate` (
  `id` INT NOT NULL,
  `tax_rate` DECIMAL(5,2) NOT NULL,
  `province_id` INT NOT NULL,
  INDEX `fk_tax_rate_province1_idx` (`province_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tax_rate_province1`
    FOREIGN KEY (`province_id`)
    REFERENCES `OnlineShopping`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `purchase_date` DATETIME NOT NULL,
  `order_amount` DECIMAL(18,2) NULL,
  `shipping_address_id` INT NOT NULL,
  `payment_methods_id` INT NOT NULL,
  `tax` DECIMAL(18,2) NULL,
  `total_payment` DECIMAL(18,2) NULL,
  `tax_rate_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_address_idx` (`shipping_address_id` ASC) VISIBLE,
  INDEX `fk_orders_payment_methods1_idx` (`payment_methods_id` ASC) VISIBLE,
  INDEX `fk_orders_tax_rate1_idx` (`tax_rate_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_address`
    FOREIGN KEY (`shipping_address_id`)
    REFERENCES `OnlineShopping`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_payment_methods1`
    FOREIGN KEY (`payment_methods_id`)
    REFERENCES `OnlineShopping`.`payment_methods` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_tax_rate1`
    FOREIGN KEY (`tax_rate_id`)
    REFERENCES `OnlineShopping`.`tax_rate` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `usernamer` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phoneNo` BIGINT NULL,
  `primary_address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `usernamer_UNIQUE` (`usernamer` ASC) VISIBLE,
  INDEX `fk_customers_address1_idx` (`primary_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`primary_address_id`)
    REFERENCES `OnlineShopping`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`Cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`Cart` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `item_count` INT NULL DEFAULT 0,
  `amount` DECIMAL(18,2) NULL,
  `customers_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Cart_customers1_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cart_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `OnlineShopping`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`Cart_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`Cart_items` (
  `id` INT NOT NULL,
  `qty` INT NULL,
  `Cart_id` INT NOT NULL,
  PRIMARY KEY (`Cart_id`),
  CONSTRAINT `fk_Cart_items_Cart1`
    FOREIGN KEY (`Cart_id`)
    REFERENCES `OnlineShopping`.`Cart` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `itemt_name` VARCHAR(45) NOT NULL,
  `decription` VARCHAR(45) NULL,
  `price` DECIMAL(18,2) NOT NULL,
  `warranty` INT NULL,
  `category_id` INT NOT NULL,
  `Cart_items_Cart_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_items_Cart_items1_idx` (`Cart_items_Cart_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `OnlineShopping`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_Cart_items1`
    FOREIGN KEY (`Cart_items_Cart_id`)
    REFERENCES `OnlineShopping`.`Cart_items` (`Cart_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`order_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qty` INT NOT NULL,
  `orders_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`id`, `orders_id`),
  INDEX `fk_order_detail_orders1_idx` (`orders_id` ASC) VISIBLE,
  INDEX `fk_order_detail_products1_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_detail_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `OnlineShopping`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_detail_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `OnlineShopping`.`items` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OnlineShopping`.`customers_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OnlineShopping`.`customers_has_address` (
  `customers_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`customers_id`, `address_id`),
  INDEX `fk_customers_has_address_address1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_customers_has_address_customers1_idx` (`customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_has_address_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `OnlineShopping`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_has_address_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `OnlineShopping`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
