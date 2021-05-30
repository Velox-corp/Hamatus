-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema heroku_9ad0f74b62bb348
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `heroku_9ad0f74b62bb348` ;

-- -----------------------------------------------------
-- Schema heroku_9ad0f74b62bb348
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `heroku_9ad0f74b62bb348` DEFAULT CHARACTER SET utf8 ;
USE `heroku_9ad0f74b62bb348` ;

-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`cat_jerarquia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`cat_jerarquia` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`cat_jerarquia` (
  `id_jerarquia` INT(11) NOT NULL AUTO_INCREMENT,
  `detalle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_jerarquia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

LOCK TABLES `cat_jerarquia` WRITE;
/*!40000 ALTER TABLE `cat_jerarquia` DISABLE KEYS */;
INSERT INTO `cat_jerarquia` (`id_jerarquia`, `detalle`) VALUES (1,'División Padre'),(2,'Departamento subordinado');
/*!40000 ALTER TABLE `cat_jerarquia` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`cat_tipo_acceso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`cat_tipo_acceso` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`cat_tipo_acceso` (
  `idC_tipo_acceso` INT(11) NOT NULL,
  `nombre_tipo_acceso` TINYTEXT NOT NULL,
  PRIMARY KEY (`idC_tipo_acceso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

LOCK TABLES `cat_tipo_acceso` WRITE;
/*!40000 ALTER TABLE `cat_tipo_acceso` DISABLE KEYS */;
INSERT INTO `cat_tipo_acceso` (`idC_tipo_acceso`, `nombre_tipo_acceso`) VALUES (1,'jefe de equipo'),(2,'Empleados generales');
/*!40000 ALTER TABLE `cat_tipo_acceso` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`empresa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`empresa` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`empresa` (
  `ID_Empresa` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARBINARY(128) NOT NULL,
  `Descripcion` VARBINARY(256) NOT NULL,
  `Logo` LONGBLOB NULL DEFAULT NULL,
  `Razon_social` VARBINARY(128) NOT NULL,
  PRIMARY KEY (`ID_Empresa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`division`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`division` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`division` (
  `ID_Division` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre_A` VARBINARY(128) NOT NULL,
  `ID_Jerarquia` INT(11) NOT NULL,
  `ID_Empresa` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Division`),
  CONSTRAINT `fk_Division_Empresa1`
    FOREIGN KEY (`ID_Empresa`)
    REFERENCES `heroku_9ad0f74b62bb348`.`empresa` (`ID_Empresa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_division_jerarquia`
    FOREIGN KEY (`ID_Jerarquia`)
    REFERENCES `heroku_9ad0f74b62bb348`.`cat_jerarquia` (`id_jerarquia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Division_Empresa1_idx` ON `heroku_9ad0f74b62bb348`.`division` (`ID_Empresa` ASC);

CREATE INDEX `fk_division_jerarquia_idx` ON `heroku_9ad0f74b62bb348`.`division` (`ID_Jerarquia` ASC) ;


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`privilegios_jerarquia_u`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`privilegios_jerarquia_u` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`privilegios_jerarquia_u` (
  `idprivilegio` INT(11) NOT NULL AUTO_INCREMENT,
  `tit_permiso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idprivilegio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

LOCK TABLES `privilegios_jerarquia_u` WRITE;
/*!40000 ALTER TABLE `privilegios_jerarquia_u` DISABLE KEYS */;
INSERT INTO `privilegios_jerarquia_u` (`idprivilegio`, `tit_permiso`) VALUES (1,'Administrador'),(2,'Directivo'),(3,'Jefe de Área'),(4,'Empleado general');
/*!40000 ALTER TABLE `privilegios_jerarquia_u` ENABLE KEYS */;
UNLOCK TABLES;


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`usuario_empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`usuario_empleado` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`usuario_empleado` (
  `ID_Usuario_E` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARBINARY(128) NOT NULL,
  `appat` VARBINARY(128) NOT NULL,
  `apmat` VARBINARY(128) NOT NULL,
  `Fecha_Nacimiento` VARBINARY(128) NOT NULL,
  `Correo` VARBINARY(128) NOT NULL,
  `ID_Division` INT(11) NOT NULL,
  `id_cat_privilegios` INT(11) NOT NULL,
  `pass` VARBINARY(128) NOT NULL,
  `foto` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Usuario_E`),
  CONSTRAINT `fk_empleado_division`
    FOREIGN KEY (`ID_Division`)
    REFERENCES `heroku_9ad0f74b62bb348`.`division` (`ID_Division`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_empleado_priv`
    FOREIGN KEY (`id_cat_privilegios`)
    REFERENCES `heroku_9ad0f74b62bb348`.`privilegios_jerarquia_u` (`idprivilegio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_empleado_division_idx` ON `heroku_9ad0f74b62bb348`.`usuario_empleado` (`ID_Division` ASC);

CREATE INDEX `fk_empleado_priv_idx` ON `heroku_9ad0f74b62bb348`.`usuario_empleado` (`id_cat_privilegios` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`m_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`m_documento` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`m_documento` (
  `idM_Documento` INT(11) NOT NULL AUTO_INCREMENT,
  `id_D_DOcumento` INT(11) NOT NULL,
  `id_usuario_P` INT(11) NOT NULL,
  PRIMARY KEY (`idM_Documento`),
  CONSTRAINT `fk_M-Documento_Usuario`
    FOREIGN KEY (`id_usuario_P`)
    REFERENCES `heroku_9ad0f74b62bb348`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_M-Documento_Usuario_idx` ON `heroku_9ad0f74b62bb348`.`m_documento` (`id_usuario_P` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`equipo` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`equipo` (
  `ID_Equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARBINARY(128) NOT NULL,
  `ID_Division` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Equipo`),
  CONSTRAINT `fk_Equipo_Division1`
    FOREIGN KEY (`ID_Division`)
    REFERENCES `heroku_9ad0f74b62bb348`.`division` (`ID_Division`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Equipo_Division1_idx` ON `heroku_9ad0f74b62bb348`.`equipo` (`ID_Division` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`cat_clasificacion_doc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`cat_clasificacion_doc` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`cat_clasificacion_doc` (
  `idcat_clasificacion_doc` INT NOT NULL AUTO_INCREMENT,
  `clasificacion` TINYTEXT NOT NULL,
  PRIMARY KEY (`idcat_clasificacion_doc`))
ENGINE = InnoDB;

LOCK TABLES `cat_clasificacion_doc` WRITE;
/*!40000 ALTER TABLE `cat_clasificacion_doc` DISABLE KEYS */;
INSERT INTO `cat_clasificacion_doc` (`idcat_clasificacion_doc`, `clasificacion`) VALUES (1,'Regular'),(2,'Favorito'),(3, 'Basura');
/*!40000 ALTER TABLE `cat_clasificacion_doc` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`d_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`d_documento` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`d_documento` (
  `ID_Documento` INT(11) NOT NULL AUTO_INCREMENT,
  `Ruta` VARBINARY(128) NOT NULL,
  `Nombre` VARBINARY(128) NOT NULL,
  `Equipo_ID_Equipo` INT(11) NOT NULL,
  `Password` VARBINARY(128) NOT NULL,
  `id_tipo_acceso` INT(11) NOT NULL,
  `Folio` VARBINARY(128) NOT NULL,
  `fecha_subida` VARBINARY(128) NULL DEFAULT NULL,
  `hora_subida` VARBINARY(128) NOT NULL,
  `id_MDocumento` INT(11) NOT NULL,
  `es_evidencia_flujo` TINYINT NOT NULL,
  `id_cat_clasif_doc` INT NOT NULL,
  PRIMARY KEY (`ID_Documento`),
  CONSTRAINT `fk_D-doc_M_doc`
    FOREIGN KEY (`id_MDocumento`)
    REFERENCES `heroku_9ad0f74b62bb348`.`m_documento` (`idM_Documento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Documento_Equipo1`
    FOREIGN KEY (`Equipo_ID_Equipo`)
    REFERENCES `heroku_9ad0f74b62bb348`.`equipo` (`ID_Equipo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Documento_cta`
    FOREIGN KEY (`id_tipo_acceso`)
    REFERENCES `heroku_9ad0f74b62bb348`.`cat_tipo_acceso` (`idC_tipo_acceso`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Documento_clasifiacion`
    FOREIGN KEY (`id_cat_clasif_doc`)
    REFERENCES `heroku_9ad0f74b62bb348`.`cat_clasificacion_doc` (`idcat_clasificacion_doc`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Documento_Equipo1_idx` ON `heroku_9ad0f74b62bb348`.`d_documento` (`Equipo_ID_Equipo` ASC) ;

CREATE INDEX `fk_Documento_cta_idx` ON `heroku_9ad0f74b62bb348`.`d_documento` (`id_tipo_acceso` ASC);

CREATE INDEX `fk_D-doc_M_doc_idx` ON `heroku_9ad0f74b62bb348`.`d_documento` (`id_MDocumento` ASC);

CREATE INDEX `fk_Documento_clasifiacion_idx` ON `heroku_9ad0f74b62bb348`.`d_documento` (`id_cat_clasif_doc` ASC) ;


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`e_usuario_equipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`e_usuario_equipo` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`e_usuario_equipo` (
  `ID_Usuario_Equipo` INT(11) NOT NULL AUTO_INCREMENT,
  `ID_Usuario_Empleado` INT(11) NOT NULL,
  `ID_Equipo` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Usuario_Equipo`),
  CONSTRAINT `fk_Usuario-Equipo_Equipo1`
    FOREIGN KEY (`ID_Equipo`)
    REFERENCES `heroku_9ad0f74b62bb348`.`equipo` (`ID_Equipo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario-Equipo_Usuario-Empleado1`
    FOREIGN KEY (`ID_Usuario_Empleado`)
    REFERENCES `heroku_9ad0f74b62bb348`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Usuario-Equipo_Usuario-Empleado1_idx` ON `heroku_9ad0f74b62bb348`.`e_usuario_equipo` (`ID_Usuario_Empleado` ASC);

CREATE INDEX `fk_Usuario-Equipo_Equipo1_idx` ON `heroku_9ad0f74b62bb348`.`e_usuario_equipo` (`ID_Equipo` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`registro_entrada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`registro_entrada` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`registro_entrada` (
  `ID_Registro_Entrada` INT(11) NOT NULL AUTO_INCREMENT,
  `Fecha_entrada` VARBINARY(128) NOT NULL,
  `hora_entrada` VARBINARY(128) NOT NULL,
  `ID_Usuario_Consulta` INT(11) NOT NULL,
  `id_M_Documento` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Registro_Entrada`),
  CONSTRAINT `fk_Registro_Entrada_M_Documento`
    FOREIGN KEY (`id_M_Documento`)
    REFERENCES `heroku_9ad0f74b62bb348`.`m_documento` (`idM_Documento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_registro_usuario`
    FOREIGN KEY (`ID_Usuario_Consulta`)
    REFERENCES `heroku_9ad0f74b62bb348`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_Registro_Entrada_M-Documento_idx` ON `heroku_9ad0f74b62bb348`.`registro_entrada` (`id_M_Documento` ASC);

CREATE INDEX `fk_registro_usuario_idx` ON `heroku_9ad0f74b62bb348`.`registro_entrada` (`ID_Usuario_Consulta` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`tablon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`tablon` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`tablon` (
  `ID_Tablon` INT(11) NOT NULL AUTO_INCREMENT,
  `Titulo_Anuncio` VARBINARY(128) NOT NULL,
  `Contenido` VARBINARY(1024) NOT NULL,
  `Id_division` INT(11) NOT NULL,
  `fecha_publicacion` VARBINARY(128) NOT NULL,
  PRIMARY KEY (`ID_Tablon`),
  CONSTRAINT `fk_tablon_division`
    FOREIGN KEY (`Id_division`)
    REFERENCES `heroku_9ad0f74b62bb348`.`division` (`ID_Division`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_tablon_division_idx` ON `heroku_9ad0f74b62bb348`.`tablon` (`Id_division` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`Flujo de trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`Flujo_de_trabajo` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`Flujo_de_trabajo` (
  `idFlujo_de_trabajo` INT NOT NULL AUTO_INCREMENT,
  `titulo_flujo` VARBINARY(128) NOT NULL,
  `descripcion_flujo` VARBINARY(256) NOT NULL,
  `id_equipo` INT NOT NULL,
  `fecha_limite` VARBINARY(128) NOT NULL,
  `hora_limite` VARBINARY(128) NOT NULL,
  `entregado` TINYINT NOT NULL,
  PRIMARY KEY (`idFlujo_de_trabajo`),
  CONSTRAINT `fk_flujo_equipo`
    FOREIGN KEY (`id_equipo`)
    REFERENCES `heroku_9ad0f74b62bb348`.`equipo` (`ID_Equipo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_flujo_equipo_idx` ON `heroku_9ad0f74b62bb348`.`Flujo_de_trabajo` (`id_equipo` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`catalogo_tipo_sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`catalogo_tipo_sala` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`catalogo_tipo_sala` (
  `idtipo_sala` INT NOT NULL AUTO_INCREMENT,
  `descripcion` TINYTEXT NOT NULL,
  PRIMARY KEY (`idtipo_sala`))
ENGINE = InnoDB;

LOCK TABLES `catalogo_tipo_sala` WRITE;
/*!40000 ALTER TABLE `catalogo_tipo_sala` DISABLE KEYS */;
INSERT INTO `catalogo_tipo_sala` (`idtipo_sala`, `descripcion`) VALUES (1,'Privada'),(2,'Grupal');
/*!40000 ALTER TABLE `catalogo_tipo_sala` ENABLE KEYS */;
UNLOCK TABLES;

-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`Sala_chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`Sala_chat` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`Sala_chat` (
  `idSala_chat` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_sala` INT NOT NULL,
  PRIMARY KEY (`idSala_chat`),
  CONSTRAINT `fk_sala_cat_ts`
    FOREIGN KEY (`id_tipo_sala`)
    REFERENCES `heroku_9ad0f74b62bb348`.`catalogo_tipo_sala` (`idtipo_sala`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_sala_cat_ts_idx` ON `heroku_9ad0f74b62bb348`.`Sala_chat` (`id_tipo_sala` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`Mensaje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`Mensaje` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`Mensaje` (
  `idMensaje` INT NOT NULL AUTO_INCREMENT,
  `contenido` VARBINARY(200) NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_sala` INT NOT NULL,
  `fecha_envio` DATETIME NOT NULL,
  PRIMARY KEY (`idMensaje`),
  CONSTRAINT `fk_mensaje_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `heroku_9ad0f74b62bb348`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_mensaje_sala`
    FOREIGN KEY (`id_sala`)
    REFERENCES `heroku_9ad0f74b62bb348`.`Sala_chat` (`idSala_chat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_mensaje_usuario_idx` ON `heroku_9ad0f74b62bb348`.`Mensaje` (`id_usuario` ASC);

CREATE INDEX `fk_mensaje_sala_idx` ON `heroku_9ad0f74b62bb348`.`Mensaje` (`id_sala` ASC);


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`E_flujo_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`E_flujo_documento` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`E_flujo_documento` (
  `idE_flujo_documento` INT NOT NULL AUTO_INCREMENT,
  `id_flujo` INT NOT NULL,
  `id_d_doc` INT NOT NULL,
  PRIMARY KEY (`idE_flujo_documento`),
  CONSTRAINT `fk_efdd_f`
    FOREIGN KEY (`id_flujo`)
    REFERENCES `heroku_9ad0f74b62bb348`.`Flujo_de_trabajo` (`idFlujo_de_trabajo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_efdd_dd`
    FOREIGN KEY (`id_d_doc`)
    REFERENCES `heroku_9ad0f74b62bb348`.`d_documento` (`ID_Documento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_efdd_f_idx` ON `heroku_9ad0f74b62bb348`.`E_flujo_documento` (`id_flujo` ASC);

CREATE INDEX `fk_efdd_dd_idx` ON `heroku_9ad0f74b62bb348`.`E_flujo_documento` (`id_d_doc` ASC) ;


-- -----------------------------------------------------
-- Table `heroku_9ad0f74b62bb348`.`e_usuario_sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `heroku_9ad0f74b62bb348`.`e_usuario_sala` ;

CREATE TABLE IF NOT EXISTS `heroku_9ad0f74b62bb348`.`e_usuario_sala` (
  `ide_usuario_sala` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `id_sala` INT NOT NULL,
  PRIMARY KEY (`ide_usuario_sala`),
  CONSTRAINT `fk_eus_u`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `heroku_9ad0f74b62bb348`.`usuario_empleado` (`ID_Usuario_E`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_eus_s`
    FOREIGN KEY (`id_sala`)
    REFERENCES `heroku_9ad0f74b62bb348`.`Sala_chat` (`idSala_chat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_eus_u_idx` ON `heroku_9ad0f74b62bb348`.`e_usuario_sala` (`id_usuario` ASC);

CREATE INDEX `fk_eus_s_idx` ON `heroku_9ad0f74b62bb348`.`e_usuario_sala` (`id_sala` ASC);

USE `heroku_9ad0f74b62bb348` ;

-- -----------------------------------------------------
-- procedure ingresarAdmin
-- -----------------------------------------------------

USE `heroku_9ad0f74b62bb348`;
DROP procedure IF EXISTS `heroku_9ad0f74b62bb348`.`ingresarAdmin`;

DELIMITER $$
USE `heroku_9ad0f74b62bb348`$$
CREATE PROCEDURE `ingresarAdmin`(nombre VARBINARY(128), appat VARBINARY(128), apmat VARBINARY(128),
f_n VARBINARY(128), correo VARBINARY(128), pass VARBINARY(128), foto Blob, idE int)
BEGIN
	insert into division (Nombre_A, id_jerarquia, id_empresa)
    values (aes_encrypt("Direccion general","vckfnclfmzbcfhmd") , 1, idE);
	INSERT INTO `Usuario_Empleado` (`Usuario_Empleado`.Nombre, `Usuario_Empleado`.appat, `Usuario_Empleado`.apmat, `Usuario_Empleado`.Fecha_nacimiento, `Usuario_Empleado`.Correo, `Usuario_Empleado`.pass, `Usuario_Empleado`.ID_Division, `Usuario_Empleado`.id_cat_privilegios, `Usuario_Empleado`.foto)
    values (nombre, appat, apmat, f_n, correo, pass, (select `division`.ID_Division from division where ID_empresa = idE limit 1), 1, foto);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure obtenerAnuncios
-- -----------------------------------------------------

USE `heroku_9ad0f74b62bb348`;
DROP procedure IF EXISTS `heroku_9ad0f74b62bb348`.`obtenerAnuncios`;

DELIMITER $$
USE `heroku_9ad0f74b62bb348`$$
CREATE PROCEDURE `obtenerAnuncios`(idE int, idDiv int)
BEGIN
	select 
	case 
		when division.ID_Jerarquia = 1 and division.ID_Empresa = idE then "general"
        when division.ID_Jerarquia = 2 and division.ID_Empresa = idE  and division.ID_Division = idDiv then "particular"
	end, tablon.*
    from tablon join division on tablon.Id_division = division.ID_Division
    where 
		(division.ID_Jerarquia = 1 and division.ID_Empresa = idE) or
        (division.ID_Jerarquia = 2 and division.ID_Empresa = idE and division.ID_Division = idDiv)
	order by aes_decrypt(tablon.fecha_publicacion, "sjcnmfoeuahkckdi") DESC;
END$$

DELIMITER ;

DELIMITER $$
USE `heroku_9ad0f74b62bb348`$$
CREATE PROCEDURE `subida_evidencia`(idM_doc int, idF int)
BEGIN
	INSERT INTO e_flujo_documento (id_flujo, id_d_doc) values (idF, 
    (select  d_documento.ID_Documento from d_documento where id_MDocumento = idM_doc));
    
    update flujo_de_trabajo set entregado = 1 where idFlujo_de_trabajo = idF;
END$$

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE `crearEquipo` (nombre varbinary(128), idD int)
BEGIN
	INSERT INTO Equipo (equipo.nombre, equipo.ID_Division) values(nombre,idD);
    INSERT INTO sala_chat (sala_chat.id_tipo_sala) values (2);
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `addEmpleadoEquipo` (idU int, idE int, idS int)
BEGIN
	INSERT INTO e_usuario_equipo (ID_Usuario_Empleado, ID_Equipo) values (idU,idE);
    INSERT INTO e_usuario_sala (id_usuario, id_sala) values (idU,idS);
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `removeEmpleadoEquipo` (idUE int)
BEGIN
	DELETE FROM e_usuario_equipo WHERE ID_Usuario_Empleado = idUE;
    DELETE FROM e_usuario_sala where id_usuario = idUE AND
    id_sala IN (select id_sala from sala_chat where id_tipo_sala = 2);
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `deleteEquipo` (idE int, idS int)
BEGIN
	DELETE FROM equipo where ID_Equipo = idE;
    DELETE FROM sala_chat where idSala_chat =idS;
END$$

DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `addLiderDiv` (idU int, idDiv int)
BEGIN
	update usuario_empleado set ID_Division= idDiv, id_cat_privilegios = 3 where ID_Usuario_E = idU;
	INSERT INTO e_usuario_sala (id_usuario, id_sala)
    select usuario_empleado.ID_Usuario_E, sala_chat.idSala_chat from usuario_empleado inner join sala_chat
	where ID_Usuario_E = idU and idSala_chat in (
	select sala_chat.idSala_chat from sala_chat join e_usuario_sala on idSala_chat = id_sala
	where id_usuario IN (select ID_Usuario_Empleado from e_usuario_equipo 
		where ID_Equipo IN (select ID_Equipo from equipo where ID_Division = idDiv))
	);
END$$

DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
