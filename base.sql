-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.5.38-log - MySQL Community Server (GPL)
-- ОС Сервера:                   Win32
-- HeidiSQL Версия:              8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных car
DROP DATABASE IF EXISTS `car`;
CREATE DATABASE IF NOT EXISTS `car` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `car`;


-- Дамп структуры для таблица car.auto_make
DROP TABLE IF EXISTS `auto_make`;
CREATE TABLE IF NOT EXISTS `auto_make` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `idMake` int(11) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `make_uid` varchar(50) DEFAULT NULL,
  `certified` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='производитель автомобилей';

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица car.auto_model
DROP TABLE IF EXISTS `auto_model`;
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

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица car.auto_param
DROP TABLE IF EXISTS `auto_param`;
CREATE TABLE IF NOT EXISTS `auto_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_id_url` int(11) DEFAULT NULL,
  `model_make_id` int(10) unsigned DEFAULT NULL,
  `model_id` int(10) unsigned DEFAULT NULL,
  `model_year` int(10) unsigned DEFAULT NULL,
  `model_trim` varchar(255) DEFAULT NULL,
  `model_body` varchar(255) DEFAULT NULL COMMENT 'Тип кузова',
  `model_engine_position` varchar(255) DEFAULT NULL COMMENT 'Расположение двигателя',
  `model_engine_cc` int(11) DEFAULT NULL COMMENT 'Двигателя (куб)',
  `model_engine_cyl` int(11) DEFAULT NULL COMMENT 'Цилиндров',
  `model_engine_type` varchar(50) DEFAULT NULL COMMENT 'Тип двигателя',
  `model_engine_valves_per_cyl` tinyint(2) DEFAULT NULL COMMENT 'Двигатель Количество клапанов на цилиндр',
  `model_engine_power_ps` int(11) DEFAULT NULL COMMENT 'Объем двигателя (кубических дюймов)',
  `model_engine_power_rpm` int(11) DEFAULT NULL COMMENT 'Двигатель Максимальная мощность RPM',
  `model_engine_torque_nm` int(11) DEFAULT NULL COMMENT 'Максимальный крутящий момент двигателя (Нм)',
  `model_engine_torque_rpm` int(11) DEFAULT NULL COMMENT 'Максимальный крутящий момент двигателя RPM',
  `model_engine_ci` int(11) DEFAULT NULL COMMENT 'Двигатель Максимальная мощность (л.с.)',
  `model_engine_l` float DEFAULT NULL COMMENT 'Двигателя (л)',
  `model_engine_bore_mm` float DEFAULT NULL COMMENT 'Диаметр двигателя (мм)',
  `model_engine_stroke_mm` float DEFAULT NULL COMMENT 'Ход двигателя (мм)',
  `model_engine_compression` varchar(50) DEFAULT NULL COMMENT 'Двигатель сжатия',
  `model_engine_fuel` varchar(255) DEFAULT NULL COMMENT 'Двигатель Тип топлива',
  `model_engine_power_kw` int(11) DEFAULT NULL COMMENT 'Двигатель Максимальная мощность (кВт)',
  `model_engine_valves` int(11) DEFAULT NULL COMMENT 'Двигатель Клапаны',
  `model_engine_torque_kgm` int(11) DEFAULT NULL COMMENT 'Максимальный крутящий момент двигателя (кгс-м)',
  `model_top_speed_kph` int(11) DEFAULT NULL COMMENT 'Максимальная скорость (км в час)',
  `model_0_to_100_kph` float DEFAULT NULL COMMENT '0-100 км в час (0-62mph)',
  `model_drive` varchar(50) DEFAULT NULL COMMENT 'Привод',
  `model_transmission_type` varchar(50) DEFAULT NULL COMMENT 'Вид коробки передач',
  `model_seats` int(11) DEFAULT NULL COMMENT 'Количество мест',
  `model_doors` int(11) DEFAULT NULL COMMENT 'Двери',
  `model_weight_kg` int(11) DEFAULT NULL COMMENT 'Вес (кг)',
  `model_length_mm` int(11) DEFAULT NULL COMMENT 'Длина (мм)',
  `model_width_mm` int(11) DEFAULT NULL COMMENT 'Ширина (мм)',
  `model_height_mm` int(11) DEFAULT NULL COMMENT 'Высота (мм)',
  `model_wheelbase_mm` int(11) DEFAULT NULL COMMENT 'Колесная база (мм)',
  `model_fuel_cap_g` float DEFAULT NULL COMMENT 'Объем топливного бака (г)',
  `model_fuel_cap_l` float DEFAULT NULL COMMENT 'Объем топливного бака (л)',
  `model_lkm_hwy` float DEFAULT NULL COMMENT 'Расход топлива за городом',
  `model_lkm_city` float DEFAULT NULL COMMENT 'Расход топлива по городу',
  `model_lkm_mixed` float DEFAULT NULL COMMENT 'Расход топлива смешаный',
  `region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_auto_param_auto_make` (`model_make_id`),
  KEY `FK_auto_param_auto_model` (`model_id`),
  KEY `FK_auto_param_auto_year` (`model_year`),
  CONSTRAINT `FK_auto_param_auto_make` FOREIGN KEY (`model_make_id`) REFERENCES `auto_make` (`id`),
  CONSTRAINT `FK_auto_param_auto_model` FOREIGN KEY (`model_id`) REFERENCES `auto_model` (`id`),
  CONSTRAINT `FK_auto_param_auto_year` FOREIGN KEY (`model_year`) REFERENCES `auto_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица car.auto_vin
DROP TABLE IF EXISTS `auto_vin`;
CREATE TABLE IF NOT EXISTS `auto_vin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(17) DEFAULT NULL,
  `idYear` int(10) unsigned DEFAULT NULL,
  `idMake` int(11) unsigned DEFAULT NULL,
  `idModel` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_auto_vin_auto_year` (`idYear`),
  KEY `FK_auto_vin_auto_make` (`idMake`),
  KEY `FK_auto_vin_auto_model` (`idModel`),
  CONSTRAINT `FK_auto_vin_auto_make` FOREIGN KEY (`idMake`) REFERENCES `auto_make` (`id`),
  CONSTRAINT `FK_auto_vin_auto_model` FOREIGN KEY (`idModel`) REFERENCES `auto_model` (`id`),
  CONSTRAINT `FK_auto_vin_auto_year` FOREIGN KEY (`idYear`) REFERENCES `auto_year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица car.auto_year
DROP TABLE IF EXISTS `auto_year`;
CREATE TABLE IF NOT EXISTS `auto_year` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Индекс 2` (`id`),
  UNIQUE KEY `Индекс 4` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='год выпуска';

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица car.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fio` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.


-- Дамп структуры для таблица car.user_car
DROP TABLE IF EXISTS `user_car`;
CREATE TABLE IF NOT EXISTS `user_car` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `make_id` int(11) unsigned DEFAULT NULL,
  `model_id` int(11) unsigned DEFAULT NULL,
  `position` int(11) unsigned DEFAULT NULL,
  `vinCode` varchar(17) DEFAULT NULL,
  `make_name` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `model_trim` varchar(255) DEFAULT NULL,
  `model_year` int(4) DEFAULT NULL,
  `model_transmission_type` varchar(255) DEFAULT NULL,
  `model_transmission_type_check` tinyint(4) DEFAULT NULL,
  `model_body` varchar(255) DEFAULT NULL,
  `model_body_check` tinyint(4) DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  `region_check` tinyint(4) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `country_check` tinyint(4) DEFAULT NULL,
  `model_drive` varchar(255) DEFAULT NULL,
  `model_drive_check` tinyint(4) DEFAULT NULL,
  `model_engine_type` varchar(255) DEFAULT NULL,
  `model_engine_type_check` tinyint(4) DEFAULT NULL,
  `model_engine_position` varchar(255) DEFAULT NULL,
  `model_engine_position_check` tinyint(4) DEFAULT NULL,
  `model_engine_cyl` varchar(255) DEFAULT NULL,
  `model_engine_cyl_check` tinyint(4) DEFAULT NULL,
  `model_engine_cc` varchar(255) DEFAULT NULL,
  `model_engine_cc_check` tinyint(4) DEFAULT NULL,
  `model_engine_valves_per_cyl` varchar(255) DEFAULT NULL,
  `model_engine_valves_per_cyl_check` tinyint(4) DEFAULT NULL,
  `model_engine_ci` varchar(255) DEFAULT NULL,
  `model_engine_ci_check` tinyint(4) DEFAULT NULL,
  `model_engine_torque_rpm` varchar(255) DEFAULT NULL,
  `model_engine_torque_rpm_check` tinyint(4) DEFAULT NULL,
  `model_engine_fuel` varchar(255) DEFAULT NULL,
  `model_engine_fuel_check` tinyint(4) DEFAULT NULL,
  `model_lkm_hwy` varchar(255) DEFAULT NULL,
  `model_lkm_hwy_check` tinyint(4) DEFAULT NULL,
  `model_lkm_city` varchar(255) DEFAULT NULL,
  `model_lkm_city_check` tinyint(4) DEFAULT NULL,
  `model_fuel_cap_l` varchar(255) DEFAULT NULL,
  `model_fuel_cap_l_check` tinyint(4) DEFAULT NULL,
  `model_length_mm` varchar(255) DEFAULT NULL,
  `model_length_mm_check` tinyint(4) DEFAULT NULL,
  `model_width_mm` varchar(255) DEFAULT NULL,
  `model_width_mm_check` tinyint(4) DEFAULT NULL,
  `model_height_mm` varchar(255) DEFAULT NULL,
  `model_height_mm_check` tinyint(4) DEFAULT NULL,
  `model_weight_kg` varchar(255) DEFAULT NULL,
  `model_weight_kg_check` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_car_users` (`user_id`),
  KEY `FK_user_car_auto_make` (`make_id`),
  KEY `FK_user_car_auto_model` (`model_id`),
  CONSTRAINT `FK_user_car_auto_make` FOREIGN KEY (`make_id`) REFERENCES `auto_make` (`id`),
  CONSTRAINT `FK_user_car_auto_model` FOREIGN KEY (`model_id`) REFERENCES `auto_model` (`id`),
  CONSTRAINT `FK_user_car_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Экспортируемые данные не выделены.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
