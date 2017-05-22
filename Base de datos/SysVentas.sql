-- MySQL Script generated by MySQL Workbench
-- Sun May 21 22:34:03 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema SysVentas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SysVentas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SysVentas` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `SysVentas` ;

-- -----------------------------------------------------
-- Table `SysVentas`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`categoria` (
  `idcategoria` BIGINT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(256) NULL,
  `condicion` BOOLEAN NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SysVentas`.`articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`articulo` (
  `idarticulo` BIGINT NOT NULL,
  `idcategoria` BIGINT NOT NULL,
  `codigo` VARCHAR(50) NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `stock` BIGINT NOT NULL,
  `descripcion` VARCHAR(512) NULL,
  `imagen` VARCHAR(50) NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idarticulo`),
  INDEX `fk_articulo_categoria_idx` (`idcategoria` ASC),
  CONSTRAINT `fk_articulo_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `SysVentas`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SysVentas`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`persona` (
  `idpersona` BIGINT NOT NULL AUTO_INCREMENT,
  `tipo_persona` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `tipo_documento` VARCHAR(20) NULL,
  `num_documento` VARCHAR(20) NULL,
  `direccion` VARCHAR(100) NULL,
  `telefono` VARCHAR(20) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`idpersona`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SysVentas`.`ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`ingreso` (
  `idingreso` BIGINT NOT NULL,
  `idproveedor` BIGINT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(10) NULL,
  `num_comprobante` VARCHAR(10) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idingreso`),
  INDEX `fk_ingreso_persona_idx` (`idproveedor` ASC),
  CONSTRAINT `fk_ingreso_persona`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `SysVentas`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SysVentas`.`detalle_ingreso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`detalle_ingreso` (
  `iddetalle_ingreso` BIGINT NOT NULL AUTO_INCREMENT,
  `idingreso` BIGINT NOT NULL,
  `idarticulo` BIGINT NOT NULL,
  `cantidad` BIGINT NOT NULL,
  `precio_compra` DECIMAL(11,2) NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`iddetalle_ingreso`),
  INDEX `fk_detalle_ingreso_idx` (`idingreso` ASC),
  INDEX `fk_detalle_ingreso_articulo_idx` (`idarticulo` ASC),
  CONSTRAINT `fk_detalle_ingreso`
    FOREIGN KEY (`idingreso`)
    REFERENCES `SysVentas`.`ingreso` (`idingreso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_ingreso_articulo`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `SysVentas`.`articulo` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SysVentas`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`venta` (
  `idventa` BIGINT NOT NULL,
  `idcliente` BIGINT NOT NULL,
  `tipo_comprobante` VARCHAR(20) NOT NULL,
  `serie_comprobante` VARCHAR(10) NOT NULL,
  `num_comprobante` VARCHAR(10) NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  `impuesto` DECIMAL(4,2) NOT NULL,
  `total_venta` DECIMAL(11,2) NOT NULL,
  `estado_venta` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idventa`),
  INDEX `fk_venta_cliente_idx` (`idcliente` ASC),
  CONSTRAINT `fk_venta_cliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `SysVentas`.`persona` (`idpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SysVentas`.`detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SysVentas`.`detalle_venta` (
  `iddetalle_venta` BIGINT NOT NULL,
  `idventa` BIGINT NOT NULL,
  `idarticulo` BIGINT NOT NULL,
  `cantidad` BIGINT NOT NULL,
  `precio_venta` DECIMAL(11,2) NOT NULL,
  `descuento` DECIMAL(11,2) NOT NULL,
  PRIMARY KEY (`iddetalle_venta`),
  INDEX `fk_detalle_venta_articulo_idx` (`idarticulo` ASC),
  INDEX `fk_detalle_venta_idx` (`idventa` ASC),
  CONSTRAINT `fk_detalle_venta_articulo`
    FOREIGN KEY (`idarticulo`)
    REFERENCES `SysVentas`.`articulo` (`idarticulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_venta`
    FOREIGN KEY (`idventa`)
    REFERENCES `SysVentas`.`venta` (`idventa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;