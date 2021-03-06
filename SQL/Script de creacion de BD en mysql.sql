-- MySQL Script generated by MySQL Workbench
-- Tue Apr 19 00:29:40 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Matricula_javeriana
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Matricula_javeriana
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Matricula_javeriana` DEFAULT CHARACTER SET utf8 ;
USE `Matricula_javeriana` ;

-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`facultad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`facultad` (
  `idfacultad` INT NOT NULL AUTO_INCREMENT,
  `nombre_facultad` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idfacultad`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`carrera` (
  `idcarrera` INT NOT NULL AUTO_INCREMENT,
  `nombre_carrera` VARCHAR(45) NULL DEFAULT NULL,
  `facultad_idfacultad` INT NOT NULL,
  PRIMARY KEY (`idcarrera`),
  INDEX `fk_carrera_facultad1_idx` (`facultad_idfacultad` ASC) VISIBLE,
  CONSTRAINT `fk_carrera_facultad1`
    FOREIGN KEY (`facultad_idfacultad`)
    REFERENCES `Matricula_javeriana`.`facultad` (`idfacultad`))
ENGINE = InnoDB
AUTO_INCREMENT = 49
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 1501
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`profesor` (
  `id_profesor` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id1` INT NOT NULL,
  PRIMARY KEY (`id_profesor`),
  INDEX `fk_profesor_usuarios1_idx` (`usuarios_id1` ASC) VISIBLE,
  CONSTRAINT `fk_profesor_usuarios1`
    FOREIGN KEY (`usuarios_id1`)
    REFERENCES `Matricula_javeriana`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 301
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`curso` (
  `idcurso` INT NOT NULL AUTO_INCREMENT,
  `nombre_curso` VARCHAR(100) NOT NULL,
  `semestre_curso` INT NOT NULL,
  `capacidad_curso` INT NOT NULL,
  `carrera_idcarrera` INT NOT NULL,
  `profesor_id_profesor` INT NOT NULL,
  PRIMARY KEY (`idcurso`),
  INDEX `fk_curso_carrera1_idx` (`carrera_idcarrera` ASC) INVISIBLE,
  INDEX `fk_curso_profesor1_idx` (`profesor_id_profesor` ASC) VISIBLE,
  CONSTRAINT `fk_curso_carrera1`
    FOREIGN KEY (`carrera_idcarrera`)
    REFERENCES `Matricula_javeriana`.`carrera` (`idcarrera`),
  CONSTRAINT `fk_curso_profesor1`
    FOREIGN KEY (`profesor_id_profesor`)
    REFERENCES `Matricula_javeriana`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 501
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`edificio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`edificio` (
  `id_edificio` INT NOT NULL AUTO_INCREMENT,
  `nombre_edificio` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_edificio`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`estudiante` (
  `id_estudiante` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  INDEX `fk_estudiante_usuarios1_idx` (`usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_estudiante_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `Matricula_javeriana`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 501
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`salon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`salon` (
  `id_salon` INT NOT NULL AUTO_INCREMENT,
  `capacidad_salon` INT NULL DEFAULT NULL,
  `numero_salon` INT NOT NULL,
  `edificio_id_edificio` INT NOT NULL,
  PRIMARY KEY (`id_salon`),
  INDEX `fk_salon_edificio1_idx` (`edificio_id_edificio` ASC) VISIBLE,
  CONSTRAINT `fk_salon_edificio1`
    FOREIGN KEY (`edificio_id_edificio`)
    REFERENCES `Matricula_javeriana`.`edificio` (`id_edificio`))
ENGINE = InnoDB
AUTO_INCREMENT = 551
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`franja_horaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`franja_horaria` (
  `id_franja_horaria` INT NOT NULL AUTO_INCREMENT,
  `hora_inicio` TIME NULL DEFAULT NULL,
  `hora_fin` TIME NULL DEFAULT NULL,
  `dia` VARCHAR(45) NULL DEFAULT NULL,
  `curso_idcurso` INT NOT NULL,
  `salon_numero_salon` INT NOT NULL,
  PRIMARY KEY (`id_franja_horaria`),
  INDEX `fk_franja_horaria_curso1_idx` (`curso_idcurso` ASC) VISIBLE,
  INDEX `fk_franja_horaria_salon1_idx` (`salon_numero_salon` ASC) VISIBLE,
  CONSTRAINT `fk_franja_horaria_curso1`
    FOREIGN KEY (`curso_idcurso`)
    REFERENCES `Matricula_javeriana`.`curso` (`idcurso`),
  CONSTRAINT `fk_franja_horaria_salon1`
    FOREIGN KEY (`salon_numero_salon`)
    REFERENCES `Matricula_javeriana`.`salon` (`id_salon`))
ENGINE = InnoDB
AUTO_INCREMENT = 551
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`matricula` (
  `idmatricula` INT NOT NULL AUTO_INCREMENT,
  `estudiante_id_estudiante` INT NOT NULL,
  PRIMARY KEY (`idmatricula`),
  INDEX `fk_matricula_estudiante1_idx` (`estudiante_id_estudiante` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_estudiante1`
    FOREIGN KEY (`estudiante_id_estudiante`)
    REFERENCES `Matricula_javeriana`.`estudiante` (`id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 401
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `Matricula_javeriana`.`matricula_has_curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Matricula_javeriana`.`matricula_has_curso` (
  `matricula_idmatricula` INT NOT NULL,
  `curso_idcurso` INT NOT NULL,
  INDEX `fk_matricula_has_curso_curso1_idx` (`curso_idcurso` ASC) VISIBLE,
  INDEX `fk_matricula_has_curso_matricula1_idx` (`matricula_idmatricula` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_has_curso_curso1`
    FOREIGN KEY (`curso_idcurso`)
    REFERENCES `Matricula_javeriana`.`curso` (`idcurso`),
  CONSTRAINT `fk_matricula_has_curso_matricula1`
    FOREIGN KEY (`matricula_idmatricula`)
    REFERENCES `Matricula_javeriana`.`matricula` (`idmatricula`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
