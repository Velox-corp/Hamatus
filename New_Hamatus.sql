-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hamatus
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hamatus` ;

-- -----------------------------------------------------
-- Schema hamatus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hamatus` DEFAULT CHARACTER SET utf8 ;
USE `hamatus` ;

-- -----------------------------------------------------
-- Table `hamatus`.`cat_tipo_acceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`cat_tipo_acceso` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`cat_tipo_acceso` (
  `idC_tipo_acceso` INT(11) NOT NULL,
  `nombre_tipo_acceso` TINYTEXT NOT NULL,
  PRIMARY KEY (`idC_tipo_acceso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hamatus`.`empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`empresa` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`empresa` (
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
-- Table `hamatus`.`Cat_jerarquía`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`Cat_jerarquía` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`Cat_jerarquía` (
  `id_jerarquia` INT NOT NULL AUTO_INCREMENT,
  `detalle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_jerarquia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hamatus`.`division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`division` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`division` (
  `ID_Division` INT(11) NOT NULL,
  `Nombre_A` VARCHAR(45) NULL DEFAULT NULL,
  `ID_Jerarquia` INT(11) NOT NULL,
  `ID_Empresa` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Division`),
  CONSTRAINT `fk_Division_Empresa1`
    FOREIGN KEY (`ID_Empresa`)
    REFERENCES `hamatus`.`empresa` (`ID_Empresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_division_jerarquia`
    FOREIGN KEY (`ID_Jerarquia`)
    REFERENCES `hamatus`.`Cat_jerarquía` (`id_jerarquia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Division_Empresa1_idx` ON `hamatus`.`division` (`ID_Empresa` ASC) ;

CREATE INDEX `fk_division_jerarquia_idx` ON `hamatus`.`division` (`ID_Jerarquia` ASC) ;


-- -----------------------------------------------------
-- Table `hamatus`.`privilegios_jerarquia_u`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`privilegios_jerarquia_u` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`privilegios_jerarquia_u` (
  `idprivilegio` INT NOT NULL AUTO_INCREMENT,
  `tit_permiso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprivilegio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hamatus`.`usuario_empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`usuario_empleado` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`usuario_empleado` (
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
    REFERENCES `hamatus`.`division` (`ID_Division`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_priv`
    FOREIGN KEY (`id_cat_privilegios`)
    REFERENCES `hamatus`.`privilegios_jerarquia_u` (`idprivilegio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_empleado_division_idx` ON `hamatus`.`usuario_empleado` (`ID_Division` ASC);

CREATE INDEX `fk_empleado_priv_idx` ON `hamatus`.`usuario_empleado` (`id_cat_privilegios` ASC);


-- -----------------------------------------------------
-- Table `hamatus`.`m_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`m_documento` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`m_documento` (
  `idM_Documento` INT(11) NOT NULL,
  `id_D_DOcumento` INT(11) NOT NULL,
  `id_usuario_P` INT(11) NOT NULL,
  PRIMARY KEY (`idM_Documento`),
  CONSTRAINT `fk_M-Documento_Usuario`
    FOREIGN KEY (`id_usuario_P`)
    REFERENCES `hamatus`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_M-Documento_Usuario_idx` ON `hamatus`.`m_documento` (`id_usuario_P` ASC);


-- -----------------------------------------------------
-- Table `hamatus`.`equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`equipo` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`equipo` (
  `ID_Equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `ID_Division` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Equipo`),
  CONSTRAINT `fk_Equipo_Division1`
    FOREIGN KEY (`ID_Division`)
    REFERENCES `hamatus`.`division` (`ID_Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Equipo_Division1_idx` ON `hamatus`.`equipo` (`ID_Division` ASC);


-- -----------------------------------------------------
-- Table `hamatus`.`d_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`d_documento` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`d_documento` (
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
    REFERENCES `hamatus`.`m_documento` (`idM_Documento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Documento_Equipo1`
    FOREIGN KEY (`Equipo_ID_Equipo`)
    REFERENCES `hamatus`.`equipo` (`ID_Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Documento_cta`
    FOREIGN KEY (`id_tipo_acceso`)
    REFERENCES `hamatus`.`cat_tipo_acceso` (`idC_tipo_acceso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Documento_Equipo1_idx` ON `hamatus`.`d_documento` (`Equipo_ID_Equipo` ASC);

CREATE INDEX `fk_Documento_cta_idx` ON `hamatus`.`d_documento` (`id_tipo_acceso` ASC);

CREATE INDEX `fk_D-doc_M_doc_idx` ON `hamatus`.`d_documento` (`id_MDocumento` ASC);


-- -----------------------------------------------------
-- Table `hamatus`.`e_usuario_equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`e_usuario_equipo` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`e_usuario_equipo` (
  `ID_Usuario_Equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_Usuario_Empleado` INT(11) NOT NULL,
  `ID_Equipo` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Usuario_Equipo`),
  CONSTRAINT `fk_Usuario-Equipo_Equipo1`
    FOREIGN KEY (`ID_Equipo`)
    REFERENCES `hamatus`.`equipo` (`ID_Equipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario-Equipo_Usuario-Empleado1`
    FOREIGN KEY (`ID_Usuario_Empleado`)
    REFERENCES `hamatus`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Usuario-Equipo_Usuario-Empleado1_idx` ON `hamatus`.`e_usuario_equipo` (`ID_Usuario_Empleado` ASC);

CREATE INDEX `fk_Usuario-Equipo_Equipo1_idx` ON `hamatus`.`e_usuario_equipo` (`ID_Equipo` ASC);


-- -----------------------------------------------------
-- Table `hamatus`.`registro_entrada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`registro_entrada` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`registro_entrada` (
  `ID_Registro_Entrada` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha_entrada` DATE NOT NULL,
  `hora_entrada` TIME NOT NULL,
  `ID_Usuario_Consulta` INT(11) NOT NULL,
  `id_M_Documento` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Registro_Entrada`),
  CONSTRAINT `fk_Registro_Entrada_M_Documento`
    FOREIGN KEY (`id_M_Documento`)
    REFERENCES `hamatus`.`m_documento` (`idM_Documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_usuario`
    FOREIGN KEY (`ID_Usuario_Consulta`)
    REFERENCES `hamatus`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Registro_Entrada_M-Documento_idx` ON `hamatus`.`registro_entrada` (`id_M_Documento` ASC) ;

CREATE INDEX `fk_registro_usuario_idx` ON `hamatus`.`registro_entrada` (`ID_Usuario_Consulta` ASC) ;


-- -----------------------------------------------------
-- Table `hamatus`.`tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hamatus`.`tablon` ;

CREATE TABLE IF NOT EXISTS `hamatus`.`tablon` (
  `ID_Tablon` INT(11) NOT NULL AUTO_INCREMENT,
  `Titulo_Anuncio` TINYTEXT NOT NULL,
  `Contenido` MEDIUMTEXT NOT NULL,
  `Id_division` INT(11) NOT NULL,
  `fecha_publicacion` DATETIME NOT NULL,
  PRIMARY KEY (`ID_Tablon`),
  CONSTRAINT `fk_tablon_division`
    FOREIGN KEY (`Id_division`)
    REFERENCES `hamatus`.`division` (`ID_Division`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_tablon_division_idx` ON `hamatus`.`tablon` (`Id_division` ASC);

USE `hamatus` ;

-- -----------------------------------------------------
-- procedure ingresarAdmin
-- -----------------------------------------------------

USE `hamatus`;
DROP procedure IF EXISTS `hamatus`.`ingresarAdmin`;

DELIMITER $$
USE `hamatus`$$
CREATE DEFINER=`Armando`@`%` PROCEDURE `ingresarAdmin`(nombre tinytext, appat tinytext, apmat tinytext,
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

USE `hamatus`;
DROP procedure IF EXISTS `hamatus`.`ingresarUsuario`;

DELIMITER $$
USE `hamatus`$$
CREATE DEFINER=`Armando`@`%` PROCEDURE `ingresarUsuario`(nombre tinytext, appat tinytext, apmat tinytext,
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
