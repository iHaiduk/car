-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.19-log - MySQL Community Server (GPL)
-- ОС Сервера:                   Win32
-- HeidiSQL Версия:              8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных car
CREATE DATABASE IF NOT EXISTS `car` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `car`;


-- Дамп структуры для таблица car.auto_engineCompressorType
CREATE TABLE IF NOT EXISTS `auto_engineCompressorType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`name`),
  KEY `FK_auto_engineCompressorType_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_engineCompressorType_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='engineCompressorType';

-- Дамп данных таблицы car.auto_engineCompressorType: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_engineCompressorType` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_engineCompressorType` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_engineCylinder
CREATE TABLE IF NOT EXISTS `auto_engineCylinder` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `count` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`count`),
  KEY `FK_auto_engineCylinder_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_engineCylinder_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='engineCompressorType';

-- Дамп данных таблицы car.auto_engineCylinder: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_engineCylinder` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_engineCylinder` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_engineFuelType
CREATE TABLE IF NOT EXISTS `auto_engineFuelType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`name`),
  KEY `FK_auto_engineFuelType_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_engineFuelType_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='engineCompressorType';

-- Дамп данных таблицы car.auto_engineFuelType: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_engineFuelType` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_engineFuelType` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_engineSize
CREATE TABLE IF NOT EXISTS `auto_engineSize` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `count` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`count`),
  KEY `FK_auto_engineSize_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_engineSize_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='engineCompressorType';

-- Дамп данных таблицы car.auto_engineSize: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_engineSize` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_engineSize` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_engineType
CREATE TABLE IF NOT EXISTS `auto_engineType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`name`),
  KEY `FK_auto_engineType_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_engineType_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы car.auto_engineType: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_engineType` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_engineType` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_make
CREATE TABLE IF NOT EXISTS `auto_make` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='производитель автомобилей';

-- Дамп данных таблицы car.auto_make: ~1 rows (приблизительно)
/*!40000 ALTER TABLE `auto_make` DISABLE KEYS */;
INSERT IGNORE INTO `auto_make` (`id`, `name`) VALUES
	(1, 'test');
/*!40000 ALTER TABLE `auto_make` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_model
CREATE TABLE IF NOT EXISTS `auto_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_make` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`name`),
  KEY `Make Name` (`id_make`),
  CONSTRAINT `FK__auto_make` FOREIGN KEY (`id_make`) REFERENCES `auto_make` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='модели автомобилей';

-- Дамп данных таблицы car.auto_model: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_model` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_style
CREATE TABLE IF NOT EXISTS `auto_style` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`name`),
  KEY `FK_auto_style_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_style_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='тип автомобиля: седан, кроссовер ...';

-- Дамп данных таблицы car.auto_style: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_style` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_style` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_transmissionType
CREATE TABLE IF NOT EXISTS `auto_transmissionType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idModel` int(10) unsigned NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 3` (`name`),
  KEY `FK_auto_transmissionType_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_transmissionType_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='тип трансмисии';

-- Дамп данных таблицы car.auto_transmissionType: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_transmissionType` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_transmissionType` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_vin
CREATE TABLE IF NOT EXISTS `auto_vin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'индентификатор',
  `vin` varchar(17) NOT NULL COMMENT 'vin код',
  `makeId` int(11) unsigned NOT NULL COMMENT 'айди на сайте deloper.edmunds.com',
  `makeName` int(1) unsigned NOT NULL COMMENT 'Марка авто',
  `modelName` int(1) unsigned NOT NULL COMMENT 'Модель авто',
  `modelYearId` int(11) unsigned NOT NULL COMMENT 'Айди года на сайте',
  `transmissionType` int(1) unsigned NOT NULL COMMENT 'тип трансмисии',
  `engineType` int(1) unsigned NOT NULL COMMENT 'тип топлива',
  `engineCompressorType` int(1) unsigned NOT NULL COMMENT 'тип компресора двигателя',
  `engineFuelType` int(1) unsigned NOT NULL COMMENT 'тип вприскывания ???',
  `engineCylinder` int(1) unsigned NOT NULL COMMENT 'кол. цилиндров',
  `engineSize` int(10) unsigned NOT NULL COMMENT 'объем двигателя',
  `style` int(1) unsigned NOT NULL COMMENT 'тип автомобиля(седан)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 12` (`vin`),
  KEY `FK_auto_vin_auto_make` (`makeName`),
  KEY `FK_auto_vin_auto_model` (`modelName`),
  KEY `FK_auto_vin_auto_year` (`modelYearId`),
  KEY `FK_auto_vin_auto_transmissionType` (`transmissionType`),
  KEY `FK_auto_vin_auto_engineType` (`engineType`),
  KEY `FK_auto_vin_auto_engineCompressorType` (`engineCompressorType`),
  KEY `FK_auto_vin_auto_engineCylinder` (`engineCylinder`),
  KEY `FK_auto_vin_auto_engineSize` (`engineSize`),
  KEY `FK_auto_vin_auto_style` (`style`),
  KEY `FK_auto_vin_auto_engineFuelType` (`engineFuelType`),
  CONSTRAINT `FK_auto_vin_auto_transmissionType` FOREIGN KEY (`transmissionType`) REFERENCES `auto_transmissionType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineType` FOREIGN KEY (`engineType`) REFERENCES `auto_engineType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineCompressorType` FOREIGN KEY (`engineCompressorType`) REFERENCES `auto_engineCompressorType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineCylinder` FOREIGN KEY (`engineCylinder`) REFERENCES `auto_engineCylinder` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineSize` FOREIGN KEY (`engineSize`) REFERENCES `auto_engineSize` (`id`),
  CONSTRAINT `FK_auto_vin_auto_style` FOREIGN KEY (`style`) REFERENCES `auto_style` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineFuelType` FOREIGN KEY (`engineFuelType`) REFERENCES `auto_engineFuelType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_make` FOREIGN KEY (`makeName`) REFERENCES `auto_make` (`id`),
  CONSTRAINT `FK_auto_vin_auto_model` FOREIGN KEY (`modelName`) REFERENCES `auto_model` (`id`),
  CONSTRAINT `FK_auto_vin_auto_year` FOREIGN KEY (`modelYearId`) REFERENCES `auto_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='база вин кодов и характеристик';

-- Дамп данных таблицы car.auto_vin: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_vin` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_vin` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_year
CREATE TABLE IF NOT EXISTS `auto_year` (
  `id` int(10) unsigned NOT NULL,
  `idModel` int(10) unsigned NOT NULL,
  `year` int(4) DEFAULT NULL,
  UNIQUE KEY `Индекс 2` (`id`),
  UNIQUE KEY `Индекс 3` (`year`),
  KEY `Индекс 1` (`idModel`),
  CONSTRAINT `FK__auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='год выпуска';

-- Дамп данных таблицы car.auto_year: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_year` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_year` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
