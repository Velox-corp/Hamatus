-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hamatus
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Hamatus` ;

-- -----------------------------------------------------
-- Schema Hamatus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hamatus` DEFAULT CHARACTER SET utf8 ;
USE `Hamatus` ;

-- -----------------------------------------------------
-- Table `Hamatus`.`Cat-Puestos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Cat-Puestos` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Cat-Puestos` (
  `ID-Cat-Puestos` INT NOT NULL,
  `Puesto` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID-Cat-Puestos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-Nivel-P`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia-Nivel-P` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia-Nivel-P` (
  `ID-Jerarquia-P` INT NOT NULL AUTO_INCREMENT,
  `Nivel` INT NOT NULL,
  `ID-Cat-Puestos` INT NOT NULL,
  PRIMARY KEY (`ID-Jerarquia-P`),
  CONSTRAINT `fk_Jerarquia-Nivel-P_Cat-Puestos1`
    FOREIGN KEY (`ID-Cat-Puestos`)
    REFERENCES `Hamatus`.`Cat-Puestos` (`ID-Cat-Puestos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Jerarquia-Nivel-P_Cat-Puestos1_idx` ON `Hamatus`.`Jerarquia-Nivel-P` (`ID-Cat-Puestos` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-P`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia-P` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia-P` (
  `ID-Jerarquia-P` INT NOT NULL AUTO_INCREMENT,
  `Titulo-Nodo` TINYTEXT NOT NULL,
  `ID-Padre-Nodo` INT NOT NULL,
  `Ruta` MEDIUMTEXT NOT NULL,
  `Numeracion` TEXT(400) NOT NULL,
  `ID-Nivel-P` INT NOT NULL,
  PRIMARY KEY (`ID-Jerarquia-P`),
  CONSTRAINT `fk_Jerarquia-P_Jerarquia-Nivel-P1`
    FOREIGN KEY (`ID-Nivel-P`)
    REFERENCES `Hamatus`.`Jerarquia-Nivel-P` (`ID-Jerarquia-P`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Jerarquia-P_Jerarquia-Nivel-P1_idx` ON `Hamatus`.`Jerarquia-P` (`ID-Nivel-P` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Usuario-Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Usuario-Empleado` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Usuario-Empleado` (
  `ID-Usuario-E` INT NOT NULL,
  `Nombre` TINYTEXT NOT NULL,
  `Fecha-Nacimiento` DATE NOT NULL,
  `Correo` TEXT(45) NOT NULL,
  `ID-Jerarquia-P` INT NOT NULL,
  `ID-Nivel-P` INT NOT NULL,
  `Password` TEXT(30) NOT NULL,
  `Foto` BLOB NOT NULL,
  PRIMARY KEY (`ID-Usuario-E`),
  CONSTRAINT `fk_Usuario-Empleado_Jerarquia-P`
    FOREIGN KEY (`ID-Jerarquia-P`)
    REFERENCES `Hamatus`.`Jerarquia-P` (`ID-Jerarquia-P`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario-Empleado_Jerarquia-Niv`
    FOREIGN KEY (`ID-Nivel-P`)
    REFERENCES `Hamatus`.`Jerarquia-P` (`ID-Nivel-P`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario-Empleado_Jerarquia-P1_idx` ON `Hamatus`.`Usuario-Empleado` (`ID-Jerarquia-P` ASC);

CREATE INDEX `fk_Usuario-Empleado_Jerarquia-Niv_idx` ON `Hamatus`.`Usuario-Empleado` (`ID-Nivel-P` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-Nivel-D`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia-Nivel-D` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia-Nivel-D` (
  `Jerarquia-Nivel-D` INT NOT NULL,
  `Nivel` INT NOT NULL,
  PRIMARY KEY (`Jerarquia-Nivel-D`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-D`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia-D` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia-D` (
  `ID-Jerarquia-D` INT NOT NULL AUTO_INCREMENT,
  `Titulo-Nodo` VARCHAR(45) NOT NULL,
  `ID-Padre-Nodo` INT NOT NULL,
  `Ruta` MEDIUMTEXT NOT NULL,
  `Numeracion` TEXT(400) NOT NULL,
  `ID-Nivel-D` INT NOT NULL,
  PRIMARY KEY (`ID-Jerarquia-D`),
  CONSTRAINT `fk_Jerarquia_Jerarquia-Nivel`
    FOREIGN KEY (`ID-Nivel-D`)
    REFERENCES `Hamatus`.`Jerarquia-Nivel-D` (`Jerarquia-Nivel-D`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ID-Jerarquia_UNIQUE` ON `Hamatus`.`Jerarquia-D` (`ID-Jerarquia-D` ASC);

CREATE INDEX `fk_Jerarquia_Jerarquia-Nivel_idx` ON `Hamatus`.`Jerarquia-D` (`ID-Nivel-D` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Empresa` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Empresa` (
  `ID-Empresa` INT NOT NULL AUTO_INCREMENT,
  `Nombre` TINYTEXT NOT NULL,
  `Descripcion` MEDIUMTEXT NOT NULL,
  `Logo` BLOB NULL,
  `Razón social` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID-Empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Division` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Division` (
  `ID-Division` INT NOT NULL,
  `Nombre-A` VARCHAR(45) NULL,
  `ID-Jerarquia-D` INT NOT NULL,
  `ID-Empresa` INT NOT NULL,
  PRIMARY KEY (`ID-Division`),
  CONSTRAINT `fk_Division_Jerarquia1`
    FOREIGN KEY (`ID-Jerarquia-D`)
    REFERENCES `Hamatus`.`Jerarquia-D` (`ID-Jerarquia-D`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Division_Empresa1`
    FOREIGN KEY (`ID-Empresa`)
    REFERENCES `Hamatus`.`Empresa` (`ID-Empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Division_Jerarquia1_idx` ON `Hamatus`.`Division` (`ID-Jerarquia-D` ASC);

CREATE INDEX `fk_Division_Empresa1_idx` ON `Hamatus`.`Division` (`ID-Empresa` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Equipo` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Equipo` (
  `ID-Equipo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `ID-Division` INT NOT NULL,
  PRIMARY KEY (`ID-Equipo`),
  CONSTRAINT `fk_Equipo_Division1`
    FOREIGN KEY (`ID-Division`)
    REFERENCES `Hamatus`.`Division` (`ID-Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Equipo_Division1_idx` ON `Hamatus`.`Equipo` (`ID-Division` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Cat-Tipo_tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Cat-Tipo_tablon` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Cat-Tipo_tablon` (
  `ID-Cat-Tablon` INT NOT NULL AUTO_INCREMENT,
  `Nivel_alcance` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID-Cat-Tablon`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Tablon` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Tablon` (
  `ID-Tablon` INT NOT NULL AUTO_INCREMENT,
  `Titulo-Anuncio` TINYTEXT NOT NULL,
  `Contenido` MEDIUMTEXT NOT NULL,
  `Id_division` INT NOT NULL,
  `id_tipo_tablon` INT NOT NULL,
  PRIMARY KEY (`ID-Tablon`),
  CONSTRAINT `fk_tablon_cat_tipo_tablon`
    FOREIGN KEY (`id_tipo_tablon`)
    REFERENCES `Hamatus`.`Cat-Tipo_tablon` (`ID-Cat-Tablon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tablon_division`
    FOREIGN KEY (`Id_division`)
    REFERENCES `Hamatus`.`Division` (`ID-Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tablon_division_idx` ON `Hamatus`.`Tablon` (`Id_division` ASC);

CREATE INDEX `fk_tablon_cat_tipo_tablon_idx` ON `Hamatus`.`Tablon` (`id_tipo_tablon` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`E-Usuario-Equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`E-Usuario-Equipo` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`E-Usuario-Equipo` (
  `ID-Usuario-Equipo` INT NOT NULL AUTO_INCREMENT,
  `ID-Usuario-Empleado` INT NOT NULL,
  `ID-Equipo` INT NOT NULL,
  PRIMARY KEY (`ID-Usuario-Equipo`),
  CONSTRAINT `fk_Usuario-Equipo_Usuario-Empleado1`
    FOREIGN KEY (`ID-Usuario-Empleado`)
    REFERENCES `Hamatus`.`Usuario-Empleado` (`ID-Usuario-E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario-Equipo_Equipo1`
    FOREIGN KEY (`ID-Equipo`)
    REFERENCES `Hamatus`.`Equipo` (`ID-Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario-Equipo_Usuario-Empleado1_idx` ON `Hamatus`.`E-Usuario-Equipo` (`ID-Usuario-Empleado` ASC);

CREATE INDEX `fk_Usuario-Equipo_Equipo1_idx` ON `Hamatus`.`E-Usuario-Equipo` (`ID-Equipo` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Cat-tipo_acceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Cat-tipo_acceso` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Cat-tipo_acceso` (
  `idC-tipo_acceso` INT NOT NULL,
  `nombre_tipo_acceso` TINYTEXT NOT NULL,
  PRIMARY KEY (`idC-tipo_acceso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`M-Documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`M-Documento` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`M-Documento` (
  `idM-Documento` INT NOT NULL,
  `id_D_DOcumento` INT NOT NULL,
  `id_usuario_P` INT NOT NULL,
  PRIMARY KEY (`idM-Documento`),
  CONSTRAINT `fk_M-Documento_Usuario`
    FOREIGN KEY (`id_usuario_P`)
    REFERENCES `Hamatus`.`Usuario-Empleado` (`ID-Usuario-E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_M-Documento_Usuario_idx` ON `Hamatus`.`M-Documento` (`id_usuario_P` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`D-Documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`D-Documento` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`D-Documento` (
  `ID-Documento` INT NOT NULL AUTO_INCREMENT,
  `Ruta` TINYTEXT NOT NULL,
  `Nombre` TEXT(50) NOT NULL,
  `Equipo_ID-Equipo` INT NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  `id_tipo_acceso` INT NOT NULL,
  `Folio` VARCHAR(12) NOT NULL,
  `fecha_subida` DATE NULL,
  `hora_subida` TIME NOT NULL,
  `id_MDocumento` INT NOT NULL,
  PRIMARY KEY (`ID-Documento`),
  CONSTRAINT `fk_Documento_Equipo1`
    FOREIGN KEY (`Equipo_ID-Equipo`)
    REFERENCES `Hamatus`.`Equipo` (`ID-Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Documento_cta`
    FOREIGN KEY (`id_tipo_acceso`)
    REFERENCES `Hamatus`.`Cat-tipo_acceso` (`idC-tipo_acceso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_D-doc_M_doc`
    FOREIGN KEY (`id_MDocumento`)
    REFERENCES `Hamatus`.`M-Documento` (`idM-Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Documento_Equipo1_idx` ON `Hamatus`.`D-Documento` (`Equipo_ID-Equipo` ASC);

CREATE INDEX `fk_Documento_cta_idx` ON `Hamatus`.`D-Documento` (`id_tipo_acceso` ASC);

CREATE INDEX `fk_D-doc_M_doc_idx` ON `Hamatus`.`D-Documento` (`id_MDocumento` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Registro-Entrada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Registro-Entrada` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Registro-Entrada` (
  `ID-Registro-Entrada` INT NOT NULL AUTO_INCREMENT,
  `Fecha_entrada` DATE NOT NULL,
  `hora_entrada` TIME NOT NULL,
  `ID-Usuario-Consulta` INT NOT NULL,
  `id_M-Documento` INT NOT NULL,
  PRIMARY KEY (`ID-Registro-Entrada`),
  CONSTRAINT `fk_Registro-Entrada_Usuario-Empleado1`
    FOREIGN KEY (`ID-Usuario-Consulta`)
    REFERENCES `Hamatus`.`Usuario-Empleado` (`ID-Usuario-E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registro_Entrada_M-Documento`
    FOREIGN KEY (`id_M-Documento`)
    REFERENCES `Hamatus`.`M-Documento` (`idM-Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Registro-Entrada_Usuario-Empleado1_idx` ON `Hamatus`.`Registro-Entrada` (`ID-Usuario-Consulta` ASC);

CREATE INDEX `fk_Registro_Entrada_M-Documento_idx` ON `Hamatus`.`Registro-Entrada` (`id_M-Documento` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Empresa-Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Empresa-Empleado` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Empresa-Empleado` (
  `ID-Empresa-Empleado` INT NOT NULL AUTO_INCREMENT,
  `ID-Usuario-E` INT NOT NULL,
  `ID-Empresa` INT NOT NULL,
  PRIMARY KEY (`ID-Empresa-Empleado`),
  CONSTRAINT `fk_Empresa-Empleado_Usuario-Empleado1`
    FOREIGN KEY (`ID-Usuario-E`)
    REFERENCES `Hamatus`.`Usuario-Empleado` (`ID-Usuario-E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa-Empleado_Empresa1`
    FOREIGN KEY (`ID-Empresa`)
    REFERENCES `Hamatus`.`Empresa` (`ID-Empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Empresa-Empleado_Usuario-Empleado1_idx` ON `Hamatus`.`Empresa-Empleado` (`ID-Usuario-E` ASC);

CREATE INDEX `fk_Empresa-Empleado_Empresa1_idx` ON `Hamatus`.`Empresa-Empleado` (`ID-Empresa` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
