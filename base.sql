-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.17-log - MySQL Community Server (GPL)
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
  `idMake` int(11) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `make_uid` varchar(50) DEFAULT NULL,
  `certified` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COMMENT='производитель автомобилей';

-- Дамп данных таблицы car.auto_make: ~138 rows (приблизительно)
/*!40000 ALTER TABLE `auto_make` DISABLE KEYS */;
INSERT IGNORE INTO `auto_make` (`id`, `name`, `idMake`, `country`, `make_uid`, `certified`) VALUES
	(1, 'AM General', 200347864, 'USA', 'am-general', 1),
	(2, 'Acura', 200002038, 'USA', 'acura', 1),
	(3, 'Audi', 200000001, 'Germany', 'audi', 1),
	(4, 'BMW', 200000081, 'Germany', 'bmw', 1),
	(5, 'Bentley', 200005848, 'UK', 'bentley', 1),
	(6, 'Bugatti', 200030397, 'Italy', 'bugatti', 1),
	(7, 'Alfa Romeo', 200464140, 'Italy', 'alfa-romeo', 1),
	(8, 'Cadillac', 200001663, 'USA', 'cadillac', 1),
	(9, 'Chevrolet', 200000404, 'USA', 'chevrolet', 1),
	(10, 'Aston Martin', 200001769, 'UK', 'aston-martin', 1),
	(11, 'Buick', 200006659, 'USA', 'buick', 1),
	(12, 'Chrysler', 200003644, 'USA', 'chrysler', 1),
	(13, 'Daewoo', 200312185, 'South Korea', 'daewoo', 1),
	(14, 'Dodge', 200009788, 'USA', 'dodge', 1),
	(15, 'Eagle', 200347865, 'USA', 'eagle', 1),
	(16, 'FIAT', 200033022, 'Italy', 'fiat', 1),
	(17, 'Ferrari', 200006023, 'Italy', 'ferrari', 1),
	(18, 'Ford', 200005143, 'USA', 'ford', 1),
	(19, 'GMC', 200007302, 'USA', 'gmc', 1),
	(20, 'Geo', 200347866, 'USA', 'geo', 1),
	(21, 'HUMMER', 200004021, 'USA', 'hummer', 1),
	(22, 'Honda', 200001444, 'Japan', 'honda', 1),
	(23, 'Hyundai', 200001398, 'South Korea', 'hyundai', 1),
	(24, 'Infiniti', 200000089, 'Japan', 'infiniti', 1),
	(25, 'Isuzu', 200110731, 'Japan', 'isuzu', 1),
	(26, 'Jaguar', 200003196, 'UK', 'jaguar', 1),
	(27, 'Kia', 200003063, 'South Korea', 'kia', 1),
	(28, 'Jeep', 200001510, 'USA', 'jeep', 1),
	(29, 'Land Rover', 200006582, 'UK', 'land-rover', 1),
	(30, 'Lamborghini', 200005922, 'Italy', 'lamborghini', 1),
	(31, 'Lexus', 200001623, 'Japan', 'lexus', 1),
	(32, 'Lincoln', 200001777, 'USA', 'lincoln', 1),
	(33, 'Lotus', 200006242, 'UK', 'lotus', 1),
	(34, 'MINI', 200002305, 'UK', 'mini', 1),
	(35, 'Maserati', 200028029, 'Italy', 'maserati', 1),
	(36, 'McLaren', 200051397, 'UK', 'mclaren', 1),
	(37, 'Mercedes-Benz', 200000130, 'Germany', 'mercedes-benz', 1),
	(38, 'Mercury', 200007711, 'USA', 'mercury', 1),
	(39, 'Mazda', 200004100, 'Japan', 'mazda', 1),
	(40, 'Mitsubishi', 200002915, 'Japan', 'mitsubishi', 1),
	(41, 'Nissan', 200000201, 'Japan', 'nissan', 1),
	(42, 'Oldsmobile', 200249342, 'USA', 'oldsmobile', 1),
	(43, 'Pontiac', 200002634, 'USA', 'pontiac', 1),
	(44, 'Plymouth', 200339126, 'USA', 'plymouth', 1),
	(45, 'Rolls-Royce', 200005044, 'UK', 'rolls-royce', 1),
	(46, 'Porsche', 200000886, 'Germany', 'porsche', 1),
	(47, 'Ram', 200393150, NULL, NULL, 1),
	(48, 'Saab', 200074504, 'Sweden', 'saab', 1),
	(49, 'Saturn', 200004446, 'USA', 'saturn', 1),
	(50, 'Scion', 200006515, 'Japan', 'scion', 1),
	(51, 'Spyker', 200046567, 'Netherlands', 'spyker', 1),
	(52, 'Subaru', 200004491, 'Japan', 'subaru', 1),
	(53, 'Suzuki', 200001853, 'Japan', 'suzuki', 1),
	(54, 'Tesla', 200018920, 'USA', 'tesla', 1),
	(55, 'Toyota', 200003381, 'Japan', 'toyota', 1),
	(56, 'Volkswagen', 200000238, 'Germany', 'volkswagen', 1),
	(57, 'Volvo', 200010382, 'Sweden', 'volvo', 1),
	(58, 'smart', 200038885, 'France', 'smart', 1),
	(59, 'Austin', NULL, 'UK', 'austin', 1),
	(60, 'Citroen', NULL, 'France', 'citroen', 1),
	(61, 'DKW', NULL, 'Germany', 'dkw', 1),
	(62, 'GAZ', NULL, 'Russia', 'gaz', 1),
	(63, 'Lancia', NULL, 'Italy', 'lancia', 1),
	(64, 'Maybach', NULL, 'Germany', 'maybach', 1),
	(65, 'Opel', NULL, 'Germany', 'opel', 1),
	(66, 'Packard', NULL, 'USA', 'packard', 1),
	(67, 'Morris', NULL, 'UK', 'morris', 1),
	(68, 'Peugeot', NULL, 'France', 'peugeot', 1),
	(69, 'Renault', NULL, 'France', 'renault', 1),
	(70, 'Rover', NULL, 'UK', 'rover', 1),
	(71, 'Simca', NULL, 'France', 'simca', 1),
	(72, 'Skoda', NULL, 'Czech Republic', 'skoda', 1),
	(73, 'Steyr', NULL, 'Austria', 'steyr', 1),
	(74, 'Sunbeam', NULL, 'UK', 'sunbeam', 1),
	(75, 'Tatra', NULL, 'Czech Republic', 'tatra', 1),
	(76, 'Willys-Overland', NULL, 'USA', 'willys-overland', 1),
	(77, 'Alvis', NULL, 'UK', 'alvis', 1),
	(78, 'Armstrong Siddeley', NULL, 'UK', 'armstrong-siddeley', 1),
	(79, 'Riley', NULL, 'UK', 'riley', 1),
	(80, 'Alpina', NULL, 'UK', 'alpina', 1),
	(81, 'Alpine', NULL, 'Germany', 'alpine', 1),
	(82, 'Auverland', NULL, 'France', 'auverland', 1),
	(83, 'Bristol', NULL, 'UK', 'bristol', 1),
	(84, 'Beijing', NULL, 'China', 'beijing', 1),
	(85, 'Caterham', NULL, 'UK', 'caterham', 1),
	(86, 'Ascari', NULL, 'UK', 'ascari', 1),
	(87, 'De Tomaso', NULL, 'Italy', 'de-tomaso', 1),
	(88, 'Donkervoort', NULL, 'Netherlands', 'donkervoort', 1),
	(89, 'Daihatsu', NULL, 'Japan', 'daihatsu', 1),
	(90, 'Ginetta', NULL, 'UK', 'ginetta', 1),
	(91, 'Holden', NULL, 'Australia', 'holden', 1),
	(92, 'Innocenti', NULL, 'Italy', 'innocenti', 1),
	(93, 'Italdesign', NULL, 'Italy', 'italdesign', 1),
	(94, 'Jensen', NULL, 'UK', 'jensen', 1),
	(95, 'Lada', NULL, 'Russia', 'lada', 1),
	(96, 'Lotec', NULL, 'Germany', 'lotec', 1),
	(97, 'Mahindra', NULL, 'India', 'mahindra', 1),
	(98, 'Marcos', NULL, 'UK', 'marcos', 1),
	(99, 'MG', NULL, 'UK', 'mg', 1),
	(100, 'Monteverdi', NULL, 'Switzerland', 'monteverdi', 1),
	(101, 'Morgan', NULL, 'UK', 'morgan', 1),
	(102, 'Proton', NULL, 'Malaysia', 'proton', 1),
	(103, 'Seat', NULL, 'Spain', 'seat', 1),
	(104, 'Tata', NULL, 'India', 'tata', 1),
	(105, 'TVR', NULL, 'UK', 'tvr', 1),
	(106, 'Vauxhall', NULL, 'Germany', 'vauxhall', 1),
	(107, 'Westfield', NULL, 'UK', 'westfield', 1),
	(108, 'Zastava', NULL, 'Serbia', 'zastava', 1),
	(109, 'Venturi', NULL, 'France', 'venturi', 1),
	(110, 'Zagato', NULL, 'Italy', 'zagato', 1),
	(111, 'Xedos', NULL, 'Japan', 'xedos', 1),
	(112, 'Reliant', NULL, 'UK', 'reliant', 1),
	(113, 'ZAZ', NULL, 'Ukraine', 'zaz', 1),
	(114, 'AC', NULL, 'UK', 'ac', 1),
	(115, 'Pininfarina', NULL, 'Italy', 'pininfarina', 1),
	(116, 'SsangYong', NULL, 'South Korea', 'ssangyong', 1),
	(117, 'Vector', NULL, 'Japan', 'vector', 1),
	(118, 'MCC', NULL, 'Germany', 'mcc', 1),
	(119, 'Panoz', NULL, 'USA', 'panoz', 1),
	(120, 'Bizzarrini', NULL, 'Italy', 'bizzarrini', 1),
	(121, 'Noble', NULL, 'UK', 'noble', 1),
	(122, 'Pagani', NULL, 'Italy', 'pagani', 1),
	(123, 'Samsung', NULL, 'South Korea', 'samsung', 1),
	(124, 'Ariel', NULL, 'UK', 'ariel', 1),
	(125, 'Matra-Simca', NULL, 'France', 'matra-simca', 1),
	(126, 'Saleen', NULL, 'USA', 'saleen', 1),
	(127, 'Dacia', NULL, 'Romania', 'dacia', 1),
	(128, 'Koenigsegg', NULL, 'Sweden', 'koenigsegg', 1),
	(129, 'Avanti', NULL, 'USA', 'avanti', 1),
	(130, 'Studebaker', NULL, 'USA', 'studebaker', 1),
	(131, 'Daimler', NULL, 'UK', 'daimler', 1),
	(132, 'SSC', NULL, 'USA', 'ssc', 1),
	(133, 'Abarth', NULL, 'Italy', 'abarth', 1),
	(134, 'Geely', NULL, 'China', 'geely', 1),
	(135, 'Brilliance', NULL, 'China', 'brilliance', 1),
	(136, 'Luxgen', NULL, 'Taiwan', 'luxgen', 1),
	(137, 'Zenvo', NULL, 'Denmark', 'zenvo', 1),
	(138, 'Fisker', NULL, 'USA', 'fisker', 1);
/*!40000 ALTER TABLE `auto_make` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_model
CREATE TABLE IF NOT EXISTS `auto_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_make` int(10) unsigned NOT NULL,
  `idYear` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `certified` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `Make Name` (`id_make`),
  KEY `FK_auto_model_auto_year` (`idYear`),
  CONSTRAINT `FK_auto_model_auto_year` FOREIGN KEY (`idYear`) REFERENCES `auto_year` (`id`),
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
  `modelYearId` int(10) unsigned NOT NULL COMMENT 'Айди года на сайте',
  `transmissionType` int(1) unsigned NOT NULL COMMENT 'тип трансмисии',
  `engineType` int(1) unsigned NOT NULL COMMENT 'тип топлива',
  `engineCompressorType` int(1) unsigned NOT NULL COMMENT 'тип компресора двигателя',
  `engineFuelType` int(1) unsigned NOT NULL COMMENT 'тип вприскывания ???',
  `engineCylinder` int(1) unsigned NOT NULL COMMENT 'кол. цилиндров',
  `engineSize` int(10) unsigned NOT NULL COMMENT 'объем двигателя',
  `style` int(1) unsigned NOT NULL COMMENT 'тип автомобиля(седан)',
  PRIMARY KEY (`id`),
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
  CONSTRAINT `FK_auto_vin_auto_engineCompressorType` FOREIGN KEY (`engineCompressorType`) REFERENCES `auto_engineCompressorType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineCylinder` FOREIGN KEY (`engineCylinder`) REFERENCES `auto_engineCylinder` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineFuelType` FOREIGN KEY (`engineFuelType`) REFERENCES `auto_engineFuelType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineSize` FOREIGN KEY (`engineSize`) REFERENCES `auto_engineSize` (`id`),
  CONSTRAINT `FK_auto_vin_auto_engineType` FOREIGN KEY (`engineType`) REFERENCES `auto_engineType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_make` FOREIGN KEY (`makeName`) REFERENCES `auto_make` (`id`),
  CONSTRAINT `FK_auto_vin_auto_model` FOREIGN KEY (`modelName`) REFERENCES `auto_model` (`id`),
  CONSTRAINT `FK_auto_vin_auto_style` FOREIGN KEY (`style`) REFERENCES `auto_style` (`id`),
  CONSTRAINT `FK_auto_vin_auto_transmissionType` FOREIGN KEY (`transmissionType`) REFERENCES `auto_transmissionType` (`id`),
  CONSTRAINT `FK_auto_vin_auto_year` FOREIGN KEY (`modelYearId`) REFERENCES `auto_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='база вин кодов и характеристик';

-- Дамп данных таблицы car.auto_vin: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `auto_vin` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_vin` ENABLE KEYS */;


-- Дамп структуры для таблица car.auto_year
CREATE TABLE IF NOT EXISTS `auto_year` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`id`),
  UNIQUE KEY `Индекс 4` (`year`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='год выпуска';

-- Дамп данных таблицы car.auto_year: ~76 rows (приблизительно)
/*!40000 ALTER TABLE `auto_year` DISABLE KEYS */;
INSERT IGNORE INTO `auto_year` (`id`, `year`) VALUES
	(1, 1940),
	(2, 1941),
	(3, 1942),
	(4, 1943),
	(5, 1944),
	(7, 1945),
	(9, 1946),
	(6, 1947),
	(8, 1948),
	(10, 1949),
	(11, 1950),
	(12, 1951),
	(15, 1952),
	(13, 1953),
	(16, 1954),
	(14, 1955),
	(17, 1956),
	(18, 1957),
	(19, 1958),
	(20, 1959),
	(21, 1960),
	(22, 1961),
	(23, 1962),
	(24, 1963),
	(25, 1964),
	(27, 1965),
	(26, 1966),
	(28, 1967),
	(29, 1968),
	(32, 1969),
	(30, 1970),
	(31, 1971),
	(33, 1972),
	(34, 1973),
	(35, 1974),
	(36, 1975),
	(37, 1976),
	(38, 1977),
	(40, 1978),
	(41, 1979),
	(39, 1980),
	(42, 1981),
	(43, 1982),
	(44, 1983),
	(45, 1984),
	(46, 1985),
	(48, 1986),
	(47, 1987),
	(50, 1988),
	(49, 1989),
	(51, 1990),
	(52, 1991),
	(53, 1992),
	(54, 1993),
	(55, 1994),
	(56, 1995),
	(58, 1996),
	(57, 1997),
	(59, 1998),
	(60, 1999),
	(62, 2000),
	(61, 2001),
	(63, 2002),
	(64, 2003),
	(65, 2004),
	(66, 2005),
	(68, 2006),
	(67, 2007),
	(69, 2008),
	(70, 2009),
	(71, 2010),
	(72, 2011),
	(73, 2012),
	(74, 2013),
	(75, 2014),
	(76, 2015);
/*!40000 ALTER TABLE `auto_year` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
