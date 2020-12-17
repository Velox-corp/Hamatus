-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bn0u7lmchdieamnqsf74
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bn0u7lmchdieamnqsf74` ;

-- -----------------------------------------------------
-- Schema bn0u7lmchdieamnqsf74
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bn0u7lmchdieamnqsf74` DEFAULT CHARACTER SET utf8 ;
USE `bn0u7lmchdieamnqsf74` ;

-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`cat_tipo_acceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`cat_tipo_acceso` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`cat_tipo_acceso` (
  `idC_tipo_acceso` INT(11) NOT NULL,
  `nombre_tipo_acceso` TINYTEXT NOT NULL,
  PRIMARY KEY (`idC_tipo_acceso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`empresa` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`empresa` (
  `ID_Empresa` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` TINYTEXT NOT NULL,
  `Descripcion` MEDIUMTEXT NOT NULL,
  `Logo` LONGBLOB NULL DEFAULT NULL,
  `Razon_social` TINYTEXT NOT NULL,
  PRIMARY KEY (`ID_Empresa`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`Cat_jerarquía`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`Cat_jerarquía` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`Cat_jerarquía` (
  `id_jerarquia` INT NOT NULL AUTO_INCREMENT,
  `detalle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_jerarquia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`division` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`division` (
  `ID_Division` INT(11) NOT NULL,
  `Nombre_A` VARCHAR(45) NULL DEFAULT NULL,
  `ID_Jerarquia` INT(11) NOT NULL,
  `ID_Empresa` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Division`),
  CONSTRAINT `fk_Division_Empresa1`
    FOREIGN KEY (`ID_Empresa`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`empresa` (`ID_Empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_division_jerarquia`
    FOREIGN KEY (`ID_Jerarquia`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`Cat_jerarquía` (`id_jerarquia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Division_Empresa1_idx` ON `bn0u7lmchdieamnqsf74`.`division` (`ID_Empresa` ASC) ;

CREATE INDEX `fk_division_jerarquia_idx` ON `bn0u7lmchdieamnqsf74`.`division` (`ID_Jerarquia` ASC) ;


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`privilegios_jerarquia_u`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`privilegios_jerarquia_u` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`privilegios_jerarquia_u` (
  `idprivilegio` INT NOT NULL AUTO_INCREMENT,
  `tit_permiso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprivilegio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`usuario_empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`usuario_empleado` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`usuario_empleado` (
  `ID_Usuario_E` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` TINYTEXT NOT NULL,
  `appat` TINYTEXT NOT NULL,
  `apmat` TINYTEXT NOT NULL,
  `Fecha_Nacimiento` DATE NOT NULL,
  `Correo` TINYTEXT NOT NULL,
  `ID_Division` INT(11) NOT NULL,
  `id_cat_privilegios` INT NOT NULL,
  `pass` TINYTEXT NOT NULL,
  `foto` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Usuario_E`),
  CONSTRAINT `fk_empleado_division`
    FOREIGN KEY (`ID_Division`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`division` (`ID_Division`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_priv`
    FOREIGN KEY (`id_cat_privilegios`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`privilegios_jerarquia_u` (`idprivilegio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_empleado_division_idx` ON `bn0u7lmchdieamnqsf74`.`usuario_empleado` (`ID_Division` ASC);

CREATE INDEX `fk_empleado_priv_idx` ON `bn0u7lmchdieamnqsf74`.`usuario_empleado` (`id_cat_privilegios` ASC);


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`m_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`m_documento` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`m_documento` (
  `idM_Documento` INT(11) NOT NULL,
  `id_D_DOcumento` INT(11) NOT NULL,
  `id_usuario_P` INT(11) NOT NULL,
  PRIMARY KEY (`idM_Documento`),
  CONSTRAINT `fk_M-Documento_Usuario`
    FOREIGN KEY (`id_usuario_P`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_M-Documento_Usuario_idx` ON `bn0u7lmchdieamnqsf74`.`m_documento` (`id_usuario_P` ASC);


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`equipo` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`equipo` (
  `ID_Equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `ID_Division` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Equipo`),
  CONSTRAINT `fk_Equipo_Division1`
    FOREIGN KEY (`ID_Division`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`division` (`ID_Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Equipo_Division1_idx` ON `bn0u7lmchdieamnqsf74`.`equipo` (`ID_Division` ASC);


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`d_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`d_documento` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`d_documento` (
  `ID_Documento` INT(11) NOT NULL AUTO_INCREMENT,
  `Ruta` TINYTEXT NOT NULL,
  `Nombre` TINYTEXT NOT NULL,
  `Equipo_ID_Equipo` INT(11) NOT NULL,
  `Password` VARCHAR(20) NOT NULL,
  `id_tipo_acceso` INT(11) NOT NULL,
  `Folio` VARCHAR(12) NOT NULL,
  `fecha_subida` DATE NULL DEFAULT NULL,
  `hora_subida` TIME NOT NULL,
  `id_MDocumento` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Documento`),
  CONSTRAINT `fk_D-doc_M_doc`
    FOREIGN KEY (`id_MDocumento`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`m_documento` (`idM_Documento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Documento_Equipo1`
    FOREIGN KEY (`Equipo_ID_Equipo`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`equipo` (`ID_Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Documento_cta`
    FOREIGN KEY (`id_tipo_acceso`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`cat_tipo_acceso` (`idC_tipo_acceso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Documento_Equipo1_idx` ON `bn0u7lmchdieamnqsf74`.`d_documento` (`Equipo_ID_Equipo` ASC);

CREATE INDEX `fk_Documento_cta_idx` ON `bn0u7lmchdieamnqsf74`.`d_documento` (`id_tipo_acceso` ASC);

CREATE INDEX `fk_D-doc_M_doc_idx` ON `bn0u7lmchdieamnqsf74`.`d_documento` (`id_MDocumento` ASC);


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`e_usuario_equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`e_usuario_equipo` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`e_usuario_equipo` (
  `ID_Usuario_Equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_Usuario_Empleado` INT(11) NOT NULL,
  `ID_Equipo` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Usuario_Equipo`),
  CONSTRAINT `fk_Usuario-Equipo_Equipo1`
    FOREIGN KEY (`ID_Equipo`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`equipo` (`ID_Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario-Equipo_Usuario-Empleado1`
    FOREIGN KEY (`ID_Usuario_Empleado`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Usuario-Equipo_Usuario-Empleado1_idx` ON `bn0u7lmchdieamnqsf74`.`e_usuario_equipo` (`ID_Usuario_Empleado` ASC);

CREATE INDEX `fk_Usuario-Equipo_Equipo1_idx` ON `bn0u7lmchdieamnqsf74`.`e_usuario_equipo` (`ID_Equipo` ASC);


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`registro_entrada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`registro_entrada` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`registro_entrada` (
  `ID_Registro_Entrada` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha_entrada` DATE NOT NULL,
  `hora_entrada` TIME NOT NULL,
  `ID_Usuario_Consulta` INT(11) NOT NULL,
  `id_M_Documento` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Registro_Entrada`),
  CONSTRAINT `fk_Registro_Entrada_M_Documento`
    FOREIGN KEY (`id_M_Documento`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`m_documento` (`idM_Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_usuario`
    FOREIGN KEY (`ID_Usuario_Consulta`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Registro_Entrada_M-Documento_idx` ON `bn0u7lmchdieamnqsf74`.`registro_entrada` (`id_M_Documento` ASC) ;

CREATE INDEX `fk_registro_usuario_idx` ON `bn0u7lmchdieamnqsf74`.`registro_entrada` (`ID_Usuario_Consulta` ASC) ;


-- -----------------------------------------------------
-- Table `bn0u7lmchdieamnqsf74`.`tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bn0u7lmchdieamnqsf74`.`tablon` ;

CREATE TABLE IF NOT EXISTS `bn0u7lmchdieamnqsf74`.`tablon` (
  `ID_Tablon` INT(11) NOT NULL AUTO_INCREMENT,
  `Titulo_Anuncio` TINYTEXT NOT NULL,
  `Contenido` MEDIUMTEXT NOT NULL,
  `Id_division` INT(11) NOT NULL,
  `fecha_publicacion` DATETIME NOT NULL,
  PRIMARY KEY (`ID_Tablon`),
  CONSTRAINT `fk_tablon_division`
    FOREIGN KEY (`Id_division`)
    REFERENCES `bn0u7lmchdieamnqsf74`.`division` (`ID_Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_tablon_division_idx` ON `bn0u7lmchdieamnqsf74`.`tablon` (`Id_division` ASC);

USE `bn0u7lmchdieamnqsf74` ;

-- -----------------------------------------------------
-- procedure ingresarAdmin
-- -----------------------------------------------------

USE `bn0u7lmchdieamnqsf74`;
DROP procedure IF EXISTS `bn0u7lmchdieamnqsf74`.`ingresarAdmin`;

DELIMITER $$
USE `bn0u7lmchdieamnqsf74`$$
CREATE PROCEDURE `ingresarAdmin`(nombre tinytext, appat tinytext, apmat tinytext,
f_n date, correo text(45), pass text(30), foto Blob, idE int)
BEGIN
	INSERT INTO `Usuario_Empleado` (`Usuario_Empleado`.Nombre, `Usuario_Empleado`.appat, `Usuario_Empleado`.apmat, `Usuario_Empleado`.Fecha_nacimiento, `Usuario_Empleado`.Correo, `Usuario_Empleado`.pass, `Usuario_Empleado`.foto)
    values (nombre, appat, apmat, f_n, correo, pass, foto);
    Insert into `Empresa_Empleado` (ID_Usuario_E, id_empresa)
    values ( (Select MAX(ID_Usuario_E) from Usuario_Empleado), idE);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ingresarUsuario
-- -----------------------------------------------------

USE `bn0u7lmchdieamnqsf74`;
DROP procedure IF EXISTS `bn0u7lmchdieamnqsf74`.`ingresarUsuario`;

DELIMITER $$
USE `bn0u7lmchdieamnqsf74`$$
CREATE PROCEDURE `ingresarUsuario`(nombre tinytext, appat tinytext, apmat tinytext,
f_n date, correo text(45), idJP int, idNp int, pass text(30), foto Blob, idE int)
BEGIN
	INSERT INTO `Usuario_Empleado` (`Usuario_Empleado`.Nombre, `Usuario_Empleado`.appat, `Usuario_Empleado`.apmat, `Usuario_Empleado`.Fecha_nacimiento, `Usuario_Empleado`.Correo, `Usuario_Empleado`.pass, `Usuario_Empleado`.ID_Jerarquia_P, `Usuario_Empleado`.ID_Nivel_P, `Usuario_Empleado`.foto)
    values (nombre, appat, apmat, f_n, correo, pass, idJp, idNp, foto);
    Insert into `Empresa_Empleado` (id_usuario_e, id_empresa)
    values ( (Select MAX(ID_Usuario_E) from Usuario_Empleado), idE);
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
