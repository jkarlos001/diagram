-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for diagram
DROP DATABASE IF EXISTS `diagram`;
CREATE DATABASE IF NOT EXISTS `diagram` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `diagram`;

-- Dumping structure for table diagram.album_clientes
DROP TABLE IF EXISTS `album_clientes`;
CREATE TABLE IF NOT EXISTS `album_clientes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_album` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `portada` varchar(255) NOT NULL,
  `aprobado` varchar(255) DEFAULT NULL,
  `id_cliente` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `album_clientes_id_cliente_foreign` (`id_cliente`),
  CONSTRAINT `album_clientes_id_cliente_foreign` FOREIGN KEY (`id_cliente`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.album_clientes: ~0 rows (approximately)
DELETE FROM `album_clientes`;

-- Dumping structure for table diagram.album_eventos
DROP TABLE IF EXISTS `album_eventos`;
CREATE TABLE IF NOT EXISTS `album_eventos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_album` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `portada` varchar(255) NOT NULL,
  `estado` char(1) DEFAULT '0',
  `id_evento` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `album_eventos_id_evento_foreign` (`id_evento`),
  CONSTRAINT `album_eventos_id_evento_foreign` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.album_eventos: ~0 rows (approximately)
DELETE FROM `album_eventos`;

-- Dumping structure for table diagram.atributos
DROP TABLE IF EXISTS `atributos`;
CREATE TABLE IF NOT EXISTS `atributos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `tipo_id` bigint(20) unsigned DEFAULT NULL,
  `clase_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `atributos_tipo_id_foreign` (`tipo_id`),
  KEY `atributos_clase_id_foreign` (`clase_id`),
  CONSTRAINT `atributos_clase_id_foreign` FOREIGN KEY (`clase_id`) REFERENCES `clases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `atributos_tipo_id_foreign` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_datos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.atributos: ~7 rows (approximately)
DELETE FROM `atributos`;
INSERT INTO `atributos` (`id`, `name`, `tipo_id`, `clase_id`, `created_at`, `updated_at`) VALUES
	(16, 'id', 4, 13, '2023-06-26 18:13:50', '2023-06-26 18:13:50'),
	(20, 'id', 4, 16, '2023-06-26 19:50:22', '2023-06-26 19:50:22'),
	(21, 'id', 4, 17, '2023-06-26 19:50:23', '2023-06-26 19:50:23');

-- Dumping structure for table diagram.clases
DROP TABLE IF EXISTS `clases`;
CREATE TABLE IF NOT EXISTS `clases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `id_diagrama` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clases_id_diagrama_foreign` (`id_diagrama`),
  CONSTRAINT `clases_id_diagrama_foreign` FOREIGN KEY (`id_diagrama`) REFERENCES `diagramas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.clases: ~10 rows (approximately)
DELETE FROM `clases`;
INSERT INTO `clases` (`id`, `name`, `id_diagrama`, `created_at`, `updated_at`) VALUES
	(13, 'usuario', 1, '2023-06-26 18:13:50', '2023-06-26 19:50:35'),
	(16, 'paciente', 1, '2023-06-26 19:50:22', '2023-06-26 20:01:23'),
	(17, 'personal', 1, '2023-06-26 19:50:23', '2023-06-26 20:08:05');

-- Dumping structure for table diagram.detalle_album_clientes
DROP TABLE IF EXISTS `detalle_album_clientes`;
CREATE TABLE IF NOT EXISTS `detalle_album_clientes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_foto` bigint(20) unsigned NOT NULL,
  `id_album_cliente` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detalle_album_clientes_id_foto_foreign` (`id_foto`),
  KEY `detalle_album_clientes_id_album_cliente_foreign` (`id_album_cliente`),
  CONSTRAINT `detalle_album_clientes_id_album_cliente_foreign` FOREIGN KEY (`id_album_cliente`) REFERENCES `album_clientes` (`id`),
  CONSTRAINT `detalle_album_clientes_id_foto_foreign` FOREIGN KEY (`id_foto`) REFERENCES `fotos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.detalle_album_clientes: ~0 rows (approximately)
DELETE FROM `detalle_album_clientes`;

-- Dumping structure for table diagram.detalle_album_eventos
DROP TABLE IF EXISTS `detalle_album_eventos`;
CREATE TABLE IF NOT EXISTS `detalle_album_eventos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_foto` bigint(20) unsigned NOT NULL,
  `id_album_evento` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detalle_album_eventos_id_foto_foreign` (`id_foto`),
  KEY `detalle_album_eventos_id_album_evento_foreign` (`id_album_evento`),
  CONSTRAINT `detalle_album_eventos_id_album_evento_foreign` FOREIGN KEY (`id_album_evento`) REFERENCES `album_eventos` (`id`),
  CONSTRAINT `detalle_album_eventos_id_foto_foreign` FOREIGN KEY (`id_foto`) REFERENCES `fotos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.detalle_album_eventos: ~0 rows (approximately)
DELETE FROM `detalle_album_eventos`;

-- Dumping structure for table diagram.detalle_ventas
DROP TABLE IF EXISTS `detalle_ventas`;
CREATE TABLE IF NOT EXISTS `detalle_ventas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(8,2) NOT NULL,
  `formato` varchar(255) NOT NULL,
  `id_venta` bigint(20) unsigned NOT NULL,
  `id_foto` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `detalle_ventas_id_venta_foreign` (`id_venta`),
  KEY `detalle_ventas_id_foto_foreign` (`id_foto`),
  CONSTRAINT `detalle_ventas_id_foto_foreign` FOREIGN KEY (`id_foto`) REFERENCES `fotos` (`id`),
  CONSTRAINT `detalle_ventas_id_venta_foreign` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.detalle_ventas: ~0 rows (approximately)
DELETE FROM `detalle_ventas`;

-- Dumping structure for table diagram.diagramas
DROP TABLE IF EXISTS `diagramas`;
CREATE TABLE IF NOT EXISTS `diagramas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_propietario` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `diagramas_id_propietario_foreign` (`id_propietario`),
  CONSTRAINT `diagramas_id_propietario_foreign` FOREIGN KEY (`id_propietario`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.diagramas: ~0 rows (approximately)
DELETE FROM `diagramas`;
INSERT INTO `diagramas` (`id`, `titulo`, `id_propietario`, `created_at`, `updated_at`) VALUES
	(1, 'hospital', 1, '2023-06-22 20:07:07', '2023-06-22 20:07:07');

-- Dumping structure for table diagram.eventos
DROP TABLE IF EXISTS `eventos`;
CREATE TABLE IF NOT EXISTS `eventos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `evento_name` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `horafin` time NOT NULL,
  `lugar` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `estado` char(1) DEFAULT '0',
  `id_organizador` bigint(20) unsigned DEFAULT NULL,
  `id_fotoestudio` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eventos_id_organizador_foreign` (`id_organizador`),
  KEY `eventos_id_fotoestudio_foreign` (`id_fotoestudio`),
  CONSTRAINT `eventos_id_fotoestudio_foreign` FOREIGN KEY (`id_fotoestudio`) REFERENCES `users` (`id`),
  CONSTRAINT `eventos_id_organizador_foreign` FOREIGN KEY (`id_organizador`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.eventos: ~0 rows (approximately)
DELETE FROM `eventos`;

-- Dumping structure for table diagram.failed_jobs
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.failed_jobs: ~0 rows (approximately)
DELETE FROM `failed_jobs`;

-- Dumping structure for table diagram.formatos
DROP TABLE IF EXISTS `formatos`;
CREATE TABLE IF NOT EXISTS `formatos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.formatos: ~2 rows (approximately)
DELETE FROM `formatos`;
INSERT INTO `formatos` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'SQL SERVER', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(2, 'POSTGRESQL', '2023-06-21 19:40:04', '2023-06-21 19:40:04');

-- Dumping structure for table diagram.fotos
DROP TABLE IF EXISTS `fotos`;
CREATE TABLE IF NOT EXISTS `fotos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `foto_original` varchar(255) NOT NULL,
  `foto_renderizada` varchar(255) NOT NULL,
  `estado` varchar(255) DEFAULT '0',
  `id_fotoestudio` bigint(20) unsigned NOT NULL,
  `id_evento` bigint(20) unsigned NOT NULL,
  `id_album_evento` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fotos_id_fotoestudio_foreign` (`id_fotoestudio`),
  KEY `fotos_id_evento_foreign` (`id_evento`),
  KEY `fotos_id_album_evento_foreign` (`id_album_evento`),
  CONSTRAINT `fotos_id_album_evento_foreign` FOREIGN KEY (`id_album_evento`) REFERENCES `album_eventos` (`id`),
  CONSTRAINT `fotos_id_evento_foreign` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id`),
  CONSTRAINT `fotos_id_fotoestudio_foreign` FOREIGN KEY (`id_fotoestudio`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.fotos: ~0 rows (approximately)
DELETE FROM `fotos`;

-- Dumping structure for table diagram.invitacion_eventos
DROP TABLE IF EXISTS `invitacion_eventos`;
CREATE TABLE IF NOT EXISTS `invitacion_eventos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entrada_qr` varchar(255) NOT NULL,
  `id_cliente` bigint(20) unsigned NOT NULL,
  `id_evento` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invitacion_eventos_id_cliente_foreign` (`id_cliente`),
  KEY `invitacion_eventos_id_evento_foreign` (`id_evento`),
  CONSTRAINT `invitacion_eventos_id_cliente_foreign` FOREIGN KEY (`id_cliente`) REFERENCES `users` (`id`),
  CONSTRAINT `invitacion_eventos_id_evento_foreign` FOREIGN KEY (`id_evento`) REFERENCES `eventos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.invitacion_eventos: ~0 rows (approximately)
DELETE FROM `invitacion_eventos`;

-- Dumping structure for table diagram.invitados
DROP TABLE IF EXISTS `invitados`;
CREATE TABLE IF NOT EXISTS `invitados` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) NOT NULL,
  `id_diagrama` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invitados_id_diagrama_foreign` (`id_diagrama`),
  CONSTRAINT `invitados_id_diagrama_foreign` FOREIGN KEY (`id_diagrama`) REFERENCES `diagramas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.invitados: ~3 rows (approximately)
DELETE FROM `invitados`;
INSERT INTO `invitados` (`id`, `user_email`, `id_diagrama`, `created_at`, `updated_at`) VALUES
	(1, 'jc.ulloa@jkarlos.info', 1, '2023-06-23 14:09:19', '2023-06-23 14:09:19'),
	(2, 'helper@appscore.ml', 1, '2023-06-23 14:09:19', '2023-06-23 14:09:19'),
	(3, 'sergio@appscore.ml', 1, '2023-06-23 14:09:19', '2023-06-23 14:09:19');

-- Dumping structure for table diagram.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.migrations: ~27 rows (approximately)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_05_03_000001_create_customer_columns', 1),
	(4, '2019_05_03_000002_create_subscriptions_table', 1),
	(5, '2019_05_03_000003_create_subscription_items_table', 1),
	(6, '2019_08_19_000000_create_failed_jobs_table', 1),
	(7, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(8, '2023_04_23_043545_create_planes_table', 1),
	(9, '2023_04_24_002851_create_eventos_table', 1),
	(10, '2023_04_24_002908_create_ventas_table', 1),
	(11, '2023_04_24_033352_create_album_eventos_table', 1),
	(12, '2023_04_24_043707_create_fotos_table', 1),
	(13, '2023_04_25_002909_create_detalle_ventas_table', 1),
	(14, '2023_04_25_043506_create_invitacion_eventos_table', 1),
	(15, '2023_05_07_085405_create_permission_tables', 1),
	(16, '2023_05_09_094522_create_album_clientes_table', 1),
	(17, '2023_05_09_095610_create_detalle_album_clientes_table', 1),
	(18, '2023_05_09_100503_create_detalle_album_eventos_table', 1),
	(19, '2023_05_21_081141_create_similituds_table', 1),
	(20, '2023_05_28_053117_create_diagramas_table', 1),
	(21, '2023_05_28_092216_create_clases_table', 1),
	(22, '2023_06_03_090322_create_tipo_datos_table', 1),
	(23, '2023_06_04_090200_create_atributos_table', 1),
	(24, '2023_06_04_090300_create_formatos_table', 1),
	(25, '2023_06_04_090347_create_relation_tipos_table', 1),
	(26, '2023_06_04_090351_create_relations_table', 1),
	(27, '2023_06_08_071725_create_invitados_table', 1);

-- Dumping structure for table diagram.model_has_permissions
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.model_has_permissions: ~0 rows (approximately)
DELETE FROM `model_has_permissions`;

-- Dumping structure for table diagram.model_has_roles
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.model_has_roles: ~4 rows (approximately)
DELETE FROM `model_has_roles`;
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1),
	(3, 'App\\Models\\User', 2),
	(4, 'App\\Models\\User', 3),
	(4, 'App\\Models\\User', 4);

-- Dumping structure for table diagram.password_reset_tokens
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.password_reset_tokens: ~0 rows (approximately)
DELETE FROM `password_reset_tokens`;

-- Dumping structure for table diagram.permissions
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.permissions: ~30 rows (approximately)
DELETE FROM `permissions`;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(2, 'roles.index', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(3, 'roles.creatit', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(4, 'roles.destroy', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(5, 'roles.edte', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(6, 'fotoestudio.index', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(7, 'fotoestudio.create', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(8, 'fotoestudio.edit', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(9, 'fotoestudio.destroy', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(10, 'fotoestudio.foto', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(11, 'organizador.index', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(12, 'organizador.create', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(13, 'organizador.edit', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(14, 'organizador.destroy', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(15, 'organizador.evento', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(16, 'cliente.index', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(17, 'cliente.album', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(18, 'cliente.invitacion', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(19, 'cliente.create', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(20, 'cliente.edit', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(21, 'cliente.destroy', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(22, 'cliente.suscripcion', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(23, 'dashboard.index', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(24, 'dashboard2', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(25, 'dashboard.ventas', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(26, 'dashboard.pagos', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(27, 'dashboard.cobros', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(28, 'reportes.index', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(29, 'suscripcion', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(30, 'pago', 'web', '2023-06-21 19:40:04', '2023-06-21 19:40:04');

-- Dumping structure for table diagram.personal_access_tokens
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.personal_access_tokens: ~0 rows (approximately)
DELETE FROM `personal_access_tokens`;

-- Dumping structure for table diagram.planes
DROP TABLE IF EXISTS `planes`;
CREATE TABLE IF NOT EXISTS `planes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tipo_plan` varchar(255) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `id_cliente` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `planes_id_cliente_foreign` (`id_cliente`),
  CONSTRAINT `planes_id_cliente_foreign` FOREIGN KEY (`id_cliente`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.planes: ~0 rows (approximately)
DELETE FROM `planes`;

-- Dumping structure for table diagram.relations
DROP TABLE IF EXISTS `relations`;
CREATE TABLE IF NOT EXISTS `relations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clase_origen` bigint(20) unsigned DEFAULT NULL,
  `clase_destino` bigint(20) unsigned DEFAULT NULL,
  `tipo_relacion` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `relations_clase_origen_foreign` (`clase_origen`),
  KEY `relations_clase_destino_foreign` (`clase_destino`),
  KEY `relations_tipo_relacion_foreign` (`tipo_relacion`),
  CONSTRAINT `relations_clase_destino_foreign` FOREIGN KEY (`clase_destino`) REFERENCES `clases` (`id`),
  CONSTRAINT `relations_clase_origen_foreign` FOREIGN KEY (`clase_origen`) REFERENCES `clases` (`id`),
  CONSTRAINT `relations_tipo_relacion_foreign` FOREIGN KEY (`tipo_relacion`) REFERENCES `relation_tipos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.relations: ~2 rows (approximately)
DELETE FROM `relations`;
INSERT INTO `relations` (`id`, `clase_origen`, `clase_destino`, `tipo_relacion`, `created_at`, `updated_at`) VALUES
	(16, 16, 13, 2, '2023-06-28 19:26:07', '2023-06-28 19:26:07');

-- Dumping structure for table diagram.relation_tipos
DROP TABLE IF EXISTS `relation_tipos`;
CREATE TABLE IF NOT EXISTS `relation_tipos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.relation_tipos: ~4 rows (approximately)
DELETE FROM `relation_tipos`;
INSERT INTO `relation_tipos` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'generalization', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(2, 'aggregation', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(3, 'composition', '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(4, 'association', '2023-06-21 19:40:04', '2023-06-21 19:40:04');

-- Dumping structure for table diagram.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.roles: ~6 rows (approximately)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'dev', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(2, 'cliente', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(3, 'organizador', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(4, 'fotoestudio', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(5, 'suscripcion', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03'),
	(6, 'pago', 'web', '2023-06-21 19:40:03', '2023-06-21 19:40:03');

-- Dumping structure for table diagram.role_has_permissions
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.role_has_permissions: ~57 rows (approximately)
DELETE FROM `role_has_permissions`;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(6, 4),
	(7, 1),
	(7, 4),
	(8, 1),
	(8, 4),
	(9, 1),
	(9, 4),
	(10, 1),
	(10, 4),
	(11, 1),
	(11, 3),
	(12, 1),
	(12, 3),
	(13, 1),
	(13, 3),
	(14, 1),
	(14, 3),
	(15, 1),
	(15, 3),
	(16, 1),
	(16, 2),
	(16, 3),
	(16, 4),
	(17, 1),
	(17, 2),
	(17, 3),
	(17, 4),
	(18, 1),
	(18, 2),
	(18, 3),
	(18, 4),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(22, 2),
	(23, 1),
	(23, 2),
	(23, 3),
	(23, 4),
	(24, 1),
	(24, 3),
	(24, 4),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(29, 5),
	(30, 1),
	(30, 6);

-- Dumping structure for table diagram.similituds
DROP TABLE IF EXISTS `similituds`;
CREATE TABLE IF NOT EXISTS `similituds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` varchar(255) DEFAULT NULL,
  `id_foto` varchar(255) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.similituds: ~0 rows (approximately)
DELETE FROM `similituds`;

-- Dumping structure for table diagram.subscriptions
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_status` varchar(255) NOT NULL,
  `stripe_price` varchar(255) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscriptions_stripe_id_unique` (`stripe_id`),
  KEY `subscriptions_user_id_stripe_status_index` (`user_id`,`stripe_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.subscriptions: ~0 rows (approximately)
DELETE FROM `subscriptions`;

-- Dumping structure for table diagram.subscription_items
DROP TABLE IF EXISTS `subscription_items`;
CREATE TABLE IF NOT EXISTS `subscription_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint(20) unsigned NOT NULL,
  `stripe_id` varchar(255) NOT NULL,
  `stripe_product` varchar(255) NOT NULL,
  `stripe_price` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscription_items_subscription_id_stripe_price_unique` (`subscription_id`,`stripe_price`),
  UNIQUE KEY `subscription_items_stripe_id_unique` (`stripe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.subscription_items: ~0 rows (approximately)
DELETE FROM `subscription_items`;

-- Dumping structure for table diagram.tipo_datos
DROP TABLE IF EXISTS `tipo_datos`;
CREATE TABLE IF NOT EXISTS `tipo_datos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `size` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.tipo_datos: ~5 rows (approximately)
DELETE FROM `tipo_datos`;
INSERT INTO `tipo_datos` (`id`, `name`, `size`, `created_at`, `updated_at`) VALUES
	(1, 'Numerico', NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(2, 'Texto', NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(3, 'Fecha', NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(4, 'Llave primaria', NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04'),
	(5, 'Llave Foranea', NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04');

-- Dumping structure for table diagram.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` char(1) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `nit` varchar(255) DEFAULT NULL,
  `puntuacion` varchar(255) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_photo_path` varchar(2048) DEFAULT 'img/default.png',
  `portada_photo_path` varchar(2048) DEFAULT 'img/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stripe_id` varchar(255) DEFAULT NULL,
  `pm_type` varchar(255) DEFAULT NULL,
  `pm_last_four` varchar(4) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_stripe_id_index` (`stripe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.users: ~5 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `name`, `email`, `fecha_nacimiento`, `genero`, `telefono`, `razon_social`, `nit`, `puntuacion`, `estado`, `password`, `profile_photo_path`, `portada_photo_path`, `email_verified_at`, `remember_token`, `created_at`, `updated_at`, `stripe_id`, `pm_type`, `pm_last_four`, `trial_ends_at`) VALUES
	(1, 'Juan', 'underbolivia@gmail.com', '1994-05-07', 'M', NULL, NULL, NULL, NULL, '0', '$2y$10$48aS6Q0pnMP1.X/caDrIMOvFChOJKOafHqKOkuUTotynHuNfdQTBe', 'img/default.png', 'img/default.png', NULL, NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04', NULL, NULL, NULL, NULL),
	(2, 'Sergio', 'sergio@appscore.ml', '2001-03-09', 'M', NULL, NULL, NULL, NULL, '0', '$2y$10$iSiVBWHdDXUHTCT3IZAk9Oo7oaVyGxKv3it5h35iGOQNofUjw5FpC', 'img/default.png', 'img/default.png', NULL, NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04', NULL, NULL, NULL, NULL),
	(3, 'Mauricio', 'mauricio@appscore.ml', '1995-11-21', 'M', NULL, NULL, NULL, NULL, '1', '$2y$10$/r9yIuu/xc5PzQmsQj0t7uufwEAsOjs/FmnZCe5fwOtphkslmv5lK', 'img/default.png', 'img/default.png', NULL, NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04', NULL, NULL, NULL, NULL),
	(4, 'Helper', 'helper@appscore.ml', '1997-08-05', 'M', NULL, NULL, NULL, NULL, '0', '$2y$10$76V.EGO4IvLrhPbcCP4ETeldm8YgQpKfW4F3Z.BHkuxD6nmx74DBS', 'img/default.png', 'img/default.png', NULL, NULL, '2023-06-21 19:40:04', '2023-06-21 19:40:04', NULL, NULL, NULL, NULL),
	(5, 'Desarrollador 2', 'jc.ulloa@jkarlos.info', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '$2y$10$Wj6U4BwIKnQTe72yVS0QSOqvAVsxjkBTQx7o8Z0R6fnLheESuwFfK', 'img/default.png', 'img/default.png', NULL, 'SNe1k79UI02cRlJXEDlME7Kaam7WYryup31jsjoYYM0LM6IcqCrZZfadvmy5', '2023-06-23 14:29:37', '2023-06-23 14:29:40', 'cus_O8RtYipBbAZ63e', NULL, NULL, NULL);

-- Dumping structure for table diagram.ventas
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `precio_total` decimal(8,2) NOT NULL,
  `forma_pago` varchar(255) NOT NULL,
  `id_cliente` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ventas_id_cliente_foreign` (`id_cliente`),
  CONSTRAINT `ventas_id_cliente_foreign` FOREIGN KEY (`id_cliente`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table diagram.ventas: ~0 rows (approximately)
DELETE FROM `ventas`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
