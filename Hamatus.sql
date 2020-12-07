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
DROP TABLE IF EXISTS `Hamatus`.`Cat_Puestos` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Cat_Puestos` (
  `ID_Cat_Puestos` INT NOT NULL,
  `Puesto` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID_Cat_Puestos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-Nivel-P`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia_Nivel_P` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia_Nivel_P` (
  `ID_Jerarquia_P` INT NOT NULL AUTO_INCREMENT,
  `Nivel` INT NOT NULL,
  `ID_Cat_Puestos` INT NOT NULL,
  PRIMARY KEY (`ID_Jerarquia_P`),
  CONSTRAINT `fk_Jerarquia-Nivel-P_Cat-Puestos1`
    FOREIGN KEY (`ID_Cat_Puestos`)
    REFERENCES `Hamatus`.`Cat_Puestos` (`ID_Cat_Puestos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Jerarquia-Nivel-P_Cat-Puestos1_idx` ON `Hamatus`.`Jerarquia_Nivel_P` (`ID_Cat_Puestos` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-P`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia_P` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia_P` (
  `ID_Jerarquia_P` INT NOT NULL AUTO_INCREMENT,
  `Titulo_Nodo` TINYTEXT NOT NULL,
  `ID_Padre_Nodo` INT NOT NULL,
  `Ruta` MEDIUMTEXT NOT NULL,
  `Numeracion` TEXT(400) NOT NULL,
  `ID_Nivel_P` INT NOT NULL,
  PRIMARY KEY (`ID_Jerarquia_P`),
  CONSTRAINT `fk_Jerarquia-P_Jerarquia-Nivel-P1`
    FOREIGN KEY (`ID_Nivel_P`)
    REFERENCES `Hamatus`.`Jerarquia_Nivel_P` (`ID_Jerarquia_P`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Jerarquia-P_Jerarquia-Nivel-P1_idx` ON `Hamatus`.`Jerarquia_P` (`ID_Nivel_P` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Usuario-Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Usuario_Empleado` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Usuario_Empleado` (
  `ID_Usuario_E` INT NOT NULL auto_increment,
  `Nombre` TINYTEXT NOT NULL,
  `appat` tinytext not null,
  `apmat` tinytext not null,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Correo` TEXT(45) NOT NULL,
  `ID_Jerarquia_P` INT NULL,
  `ID_Nivel_P` INT NULL,
  `pass` TEXT(30) NOT NULL,
  `foto` BLOB NULL,
  PRIMARY KEY (`ID_Usuario_E`),
  CONSTRAINT `fk_Usuario-Empleado_Jerarquia_P`
    FOREIGN KEY (`ID_Jerarquia_P`)
    REFERENCES `Hamatus`.`Jerarquia_P` (`ID_Jerarquia_P`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario-Empleado_Jerarquia-Niv`
    FOREIGN KEY (`ID_Nivel_P`)
    REFERENCES `Hamatus`.`Jerarquia_P` (`ID_Nivel_P`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario-Empleado_Jerarquia-P1_idx` ON `Hamatus`.`Usuario_Empleado` (`ID_Jerarquia_P` ASC);

CREATE INDEX `fk_Usuario-Empleado_Jerarquia-Niv_idx` ON `Hamatus`.`Usuario_Empleado` (`ID_Nivel_P` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-Nivel-D`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia_Nivel_D` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia_Nivel_D` (
  `Jerarquia_Nivel_D` INT NOT NULL,
  `Nivel` INT NOT NULL,
  PRIMARY KEY (`Jerarquia_Nivel_D`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Jerarquia-D`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Jerarquia_D` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Jerarquia_D` (
  `ID_Jerarquia_D` INT NOT NULL AUTO_INCREMENT,
  `Titulo_Nodo` VARCHAR(45) NOT NULL,
  `ID_Padre_Nodo` INT NOT NULL,
  `Ruta` MEDIUMTEXT NOT NULL,
  `Numeracion` TEXT(400) NOT NULL,
  `ID_Nivel_D` INT NOT NULL,
  PRIMARY KEY (`ID_Jerarquia_D`),
  CONSTRAINT `fk_Jerarquia_Jerarquia-Nivel`
    FOREIGN KEY (`ID_Nivel_D`)
    REFERENCES `Hamatus`.`Jerarquia_Nivel_D` (`Jerarquia_Nivel_D`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ID-Jerarquia_UNIQUE` ON `Hamatus`.`Jerarquia_D` (`ID_Jerarquia_D` ASC);

CREATE INDEX `fk_Jerarquia_Jerarquia-Nivel_idx` ON `Hamatus`.`Jerarquia_D` (`ID_Nivel_D` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Empresa` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Empresa` (
  `ID_Empresa` INT NOT NULL AUTO_INCREMENT,
  `Nombre` TINYTEXT NOT NULL,
  `Descripcion` MEDIUMTEXT NOT NULL,
  `Logo` LONGBLOB NULL,
  `Razon_social` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID_Empresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Division` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Division` (
  `ID_Division` INT NOT NULL,
  `Nombre_A` VARCHAR(45) NULL,
  `ID_Jerarquia_D` INT NOT NULL,
  `ID_Empresa` INT NOT NULL,
  PRIMARY KEY (`ID_Division`),
  CONSTRAINT `fk_Division_Jerarquia1`
    FOREIGN KEY (`ID_Jerarquia_D`)
    REFERENCES `Hamatus`.`Jerarquia-D` (`ID_Jerarquia_D`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Division_Empresa1`
    FOREIGN KEY (`ID_Empresa`)
    REFERENCES `Hamatus`.`Empresa` (`ID_Empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Division_Jerarquia1_idx` ON `Hamatus`.`Division` (`ID_Jerarquia_D` ASC);

CREATE INDEX `fk_Division_Empresa1_idx` ON `Hamatus`.`Division` (`ID_Empresa` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Equipo` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Equipo` (
  `ID_Equipo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `ID_Division` INT NOT NULL,
  PRIMARY KEY (`ID_Equipo`),
  CONSTRAINT `fk_Equipo_Division1`
    FOREIGN KEY (`ID_Division`)
    REFERENCES `Hamatus`.`Division` (`ID_Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Equipo_Division1_idx` ON `Hamatus`.`Equipo` (`ID_Division` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Cat-Tipo_tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Cat_Tipo_tablon` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Cat_Tipo_tablon` (
  `ID_Cat_Tablon` INT NOT NULL AUTO_INCREMENT,
  `Nivel_alcance` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID_Cat_Tablon`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`Tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Tablon` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Tablon` (
  `ID_Tablon` INT NOT NULL AUTO_INCREMENT,
  `Titulo_Anuncio` TINYTEXT NOT NULL,
  `Contenido` MEDIUMTEXT NOT NULL,
  `Id_division` INT NOT NULL,
  `id_tipo_tablon` INT NOT NULL,
  PRIMARY KEY (`ID_Tablon`),
  CONSTRAINT `fk_tablon_cat_tipo_tablon`
    FOREIGN KEY (`id_tipo_tablon`)
    REFERENCES `Hamatus`.`Cat_Tipo_tablon` (`ID_Cat_Tablon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tablon_division`
    FOREIGN KEY (`Id_division`)
    REFERENCES `Hamatus`.`Division` (`ID_Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tablon_division_idx` ON `Hamatus`.`Tablon` (`Id_division` ASC);

CREATE INDEX `fk_tablon_cat_tipo_tablon_idx` ON `Hamatus`.`Tablon` (`id_tipo_tablon` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`E-Usuario-Equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`E_Usuario_Equipo` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`E_Usuario_Equipo` (
  `ID_Usuario_Equipo` INT NOT NULL AUTO_INCREMENT,
  `ID_Usuario_Empleado` INT NOT NULL,
  `ID_Equipo` INT NOT NULL,
  PRIMARY KEY (`ID_Usuario_Equipo`),
  CONSTRAINT `fk_Usuario-Equipo_Usuario-Empleado1`
    FOREIGN KEY (`ID_Usuario_Empleado`)
    REFERENCES `Hamatus`.`Usuario_Empleado` (`ID_Usuario_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario-Equipo_Equipo1`
    FOREIGN KEY (`ID_Equipo`)
    REFERENCES `Hamatus`.`Equipo` (`ID_Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuario-Equipo_Usuario-Empleado1_idx` ON `Hamatus`.`E_Usuario_Equipo` (`ID_Usuario_Empleado` ASC);

CREATE INDEX `fk_Usuario-Equipo_Equipo1_idx` ON `Hamatus`.`E_Usuario_Equipo` (`ID_Equipo` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Cat-tipo_acceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Cat_tipo_acceso` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Cat_tipo_acceso` (
  `idC_tipo_acceso` INT NOT NULL,
  `nombre_tipo_acceso` TINYTEXT NOT NULL,
  PRIMARY KEY (`idC_tipo_acceso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hamatus`.`M-Documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`M_Documento` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`M_Documento` (
  `idM_Documento` INT NOT NULL,
  `id_D_DOcumento` INT NOT NULL,
  `id_usuario_P` INT NOT NULL,
  PRIMARY KEY (`idM_Documento`),
  CONSTRAINT `fk_M-Documento_Usuario`
    FOREIGN KEY (`id_usuario_P`)
    REFERENCES `Hamatus`.`Usuario-Empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_M-Documento_Usuario_idx` ON `Hamatus`.`M_Documento` (`id_usuario_P` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`D-Documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`D_Documento` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`D_Documento` (
  `ID_Documento` INT NOT NULL AUTO_INCREMENT,
  `Ruta` TINYTEXT NOT NULL,
  `Nombre` TEXT(50) NOT NULL,
  `Equipo_ID_Equipo` INT NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  `id_tipo_acceso` INT NOT NULL,
  `Folio` VARCHAR(12) NOT NULL,
  `fecha_subida` DATE NULL,
  `hora_subida` TIME NOT NULL,
  `id_MDocumento` INT NOT NULL,
  PRIMARY KEY (`ID_Documento`),
  CONSTRAINT `fk_Documento_Equipo1`
    FOREIGN KEY (`Equipo_ID_Equipo`)
    REFERENCES `Hamatus`.`Equipo` (`ID_Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Documento_cta`
    FOREIGN KEY (`id_tipo_acceso`)
    REFERENCES `Hamatus`.`Cat_tipo_acceso` (`idC_tipo_acceso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_D-doc_M_doc`
    FOREIGN KEY (`id_MDocumento`)
    REFERENCES `Hamatus`.`M-Documento` (`idM_Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Documento_Equipo1_idx` ON `Hamatus`.`D_Documento` (`Equipo_ID_Equipo` ASC);

CREATE INDEX `fk_Documento_cta_idx` ON `Hamatus`.`D_Documento` (`id_tipo_acceso` ASC);

CREATE INDEX `fk_D-doc_M_doc_idx` ON `Hamatus`.`D_Documento` (`id_MDocumento` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Registro-Entrada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Registro_Entrada` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Registro_Entrada` (
  `ID_Registro_Entrada` INT NOT NULL AUTO_INCREMENT,
  `Fecha_entrada` DATE NOT NULL,
  `hora_entrada` TIME NOT NULL,
  `ID_Usuario_Consulta` INT NOT NULL,
  `id_M_Documento` INT NOT NULL,
  PRIMARY KEY (`ID_Registro_Entrada`),
  CONSTRAINT `fk_Registro-Entrada_Usuario-Empleado1`
    FOREIGN KEY (`ID_Usuario_Consulta`)
    REFERENCES `Hamatus`.`Usuario-Empleado` (`ID_Usuario_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registro_Entrada_M_Documento`
    FOREIGN KEY (`id_M_Documento`)
    REFERENCES `Hamatus`.`M_Documento` (`idM_Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Registro-Entrada_Usuario-Empleado1_idx` ON `Hamatus`.`Registro_Entrada` (`ID_Usuario_Consulta` ASC);

CREATE INDEX `fk_Registro_Entrada_M-Documento_idx` ON `Hamatus`.`Registro_Entrada` (`id_M_Documento` ASC);


-- -----------------------------------------------------
-- Table `Hamatus`.`Empresa-Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hamatus`.`Empresa_Empleado` ;

CREATE TABLE IF NOT EXISTS `Hamatus`.`Empresa_Empleado` (
  `ID_Empresa_Empleado` INT NOT NULL AUTO_INCREMENT,
  `ID_Usuario_E` INT NOT NULL,
  `ID_Empresa` INT NOT NULL,
  PRIMARY KEY (`ID_Empresa_Empleado`),
  CONSTRAINT `fk_Empresa-Empleado_Usuario-Empleado1`
    FOREIGN KEY (`ID_Usuario_E`)
    REFERENCES `Hamatus`.`Usuario_Empleado` (`ID_Usuario_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa-Empleado_Empresa1`
    FOREIGN KEY (`ID_Empresa`)
    REFERENCES `Hamatus`.`Empresa` (`ID_Empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Empresa-Empleado_Usuario-Empleado1_idx` ON `Hamatus`.`Empresa_Empleado` (`ID_Usuario_E` ASC);

CREATE INDEX `fk_Empresa-Empleado_Empresa1_idx` ON `Hamatus`.`Empresa_Empleado` (`ID_Empresa` ASC);

DROP procedure IF EXISTS `ingresarUsuario`;

DELIMITER $$
CREATE PROCEDURE `ingresarUsuario` (nombre tinytext, appat tinytext, apmat tinytext,
f_n date, correo text(45), idJP int, idNp int, pass text(30), foto Blob, idE int)
BEGIN
	INSERT INTO `Usuario_Empleado` (`Usuario_Empleado`.Nombre, `Usuario_Empleado`.appat, `Usuario_Empleado`.apmat, `Usuario_Empleado`.Fecha_nacimiento, `Usuario_Empleado`.Correo, `Usuario_Empleado`.pass, `Usuario_Empleado`.ID_Jerarquia_P, `Usuario_Empleado`.ID_Nivel_P, `Usuario_Empleado`.foto)
    values (nombre, appat, apmat, f_n, correo, pass, idJp, idNp, foto);
    Insert into `Empresa_Empleado` (id_usuario_e, id_empresa)
    values ( (Select MAX(ID_Usuario_E) from Usuario_Empleado), idE);
END$$

DELIMITER ;

DROP procedure IF EXISTS `ingresarAdmin`;

DELIMITER $$
CREATE PROCEDURE `ingresarAdmin` (nombre tinytext, appat tinytext, apmat tinytext,
f_n date, correo text(45), pass text(30), foto Blob, idE int)
BEGIN
	INSERT INTO `Usuario_Empleado` (`Usuario_Empleado`.Nombre, `Usuario_Empleado`.appat, `Usuario_Empleado`.apmat, `Usuario_Empleado`.Fecha_nacimiento, `Usuario_Empleado`.Correo, `Usuario_Empleado`.pass, `Usuario_Empleado`.foto)
    values (nombre, appat, apmat, f_n, correo, pass, foto);
    Insert into `Empresa_Empleado` (ID_Usuario_E, id_empresa)
    values ( (Select MAX(ID_Usuario_E) from Usuario_Empleado), idE);
END$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
