-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Museum
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Museum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Museum` DEFAULT CHARACTER SET utf8 ;
USE `Museum` ;

-- -----------------------------------------------------
-- Table `Museum`.`Epochs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Epochs` (
  `Name` VARCHAR(45) NOT NULL,
  `Century` INT(2) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Exhibits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Exhibits` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(50) NOT NULL,
  `Year_creation` INT(4) NULL,
  `Technique` VARCHAR(45) NOT NULL,
  `Epochs_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Exhibits_Epochs_idx` (`Epochs_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Exhibits_Epochs`
    FOREIGN KEY (`Epochs_Name`)
    REFERENCES `Museum`.`Epochs` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Artists` (
  `Full_Name` VARCHAR(45) NOT NULL,
  `School_of_painting` VARCHAR(45) NULL,
  PRIMARY KEY (`Full_Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Exhibitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Exhibitions` (
  `Name` VARCHAR(45) NOT NULL,
  `Start_date` DATE NOT NULL,
  `End_date` DATE NOT NULL,
  `Ticket_price` INT NOT NULL,
  `Count_halls` INT(2) NOT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Halls`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Halls` (
  `Number` INT NOT NULL,
  `Area` DECIMAL(3,2) NOT NULL,
  `Floor_number` INT(1) NOT NULL,
  `Exhibitions_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Number`),
  INDEX `fk_Halls_Exhibitions1_idx` (`Exhibitions_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Halls_Exhibitions1`
    FOREIGN KEY (`Exhibitions_Name`)
    REFERENCES `Museum`.`Exhibitions` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Exhibits_has_Artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Exhibits_has_Artists` (
  `Exhibits_ID_Exhibits` INT NOT NULL,
  `Artists_Full_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Exhibits_ID_Exhibits`, `Artists_Full_Name`),
  INDEX `fk_Exhibits_has_Artists_Artists1_idx` (`Artists_Full_Name` ASC) VISIBLE,
  INDEX `fk_Exhibits_has_Artists_Exhibits1_idx` (`Exhibits_ID_Exhibits` ASC) VISIBLE,
  CONSTRAINT `fk_Exhibits_has_Artists_Exhibits1`
    FOREIGN KEY (`Exhibits_ID_Exhibits`)
    REFERENCES `Museum`.`Exhibits` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Exhibits_has_Artists_Artists1`
    FOREIGN KEY (`Artists_Full_Name`)
    REFERENCES `Museum`.`Artists` (`Full_Name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Halls_has_Exhibits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Halls_has_Exhibits` (
  `Halls_Number` INT NOT NULL,
  `Exhibits_ID` INT NOT NULL,
  PRIMARY KEY (`Halls_Number`, `Exhibits_ID`),
  INDEX `fk_Halls_has_Exhibits_Exhibits1_idx` (`Exhibits_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Halls_has_Exhibits_Halls1`
    FOREIGN KEY (`Halls_Number`)
    REFERENCES `Museum`.`Halls` (`Number`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Halls_has_Exhibits_Exhibits1`
    FOREIGN KEY (`Exhibits_ID`)
    REFERENCES `Museum`.`Exhibits` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Museum`.`Epochs_has_Artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Museum`.`Epochs_has_Artists` (
  `Epochs_Name` VARCHAR(45) NOT NULL,
  `Artists_Full_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Epochs_Name`, `Artists_Full_Name`),
  INDEX `fk_Epochs_has_Artists_Artists1_idx` (`Artists_Full_Name` ASC) VISIBLE,
  INDEX `fk_Epochs_has_Artists_Epochs1_idx` (`Epochs_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Epochs_has_Artists_Epochs1`
    FOREIGN KEY (`Epochs_Name`)
    REFERENCES `Museum`.`Epochs` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Epochs_has_Artists_Artists1`
    FOREIGN KEY (`Artists_Full_Name`)
    REFERENCES `Museum`.`Artists` (`Full_Name`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
