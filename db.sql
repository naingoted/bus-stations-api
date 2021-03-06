-- -------------------------------------------------------------
-- TablePlus 3.12.4(360)
--
-- https://tableplus.com/
--
-- Database: db
-- Generation Time: 2021-03-06 20:22:47.7860
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `bus_route_stations`;
CREATE TABLE `bus_route_stations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `busRouteId` bigint(20) unsigned NOT NULL,
  `stationId` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bus_route_stations_busrouteid_stationid_unique` (`busRouteId`,`stationId`),
  KEY `bus_route_stations_stationid_foreign` (`stationId`),
  CONSTRAINT `bus_route_stations_busrouteid_foreign` FOREIGN KEY (`busRouteId`) REFERENCES `bus_routes` (`id`),
  CONSTRAINT `bus_route_stations_stationid_foreign` FOREIGN KEY (`stationId`) REFERENCES `stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `bus_routes`;
CREATE TABLE `bus_routes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `routeId` bigint(20) unsigned NOT NULL,
  `busId` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bus_routes_routeid_busid_unique` (`routeId`,`busId`),
  KEY `bus_routes_busid_foreign` (`busId`),
  CONSTRAINT `bus_routes_busid_foreign` FOREIGN KEY (`busId`) REFERENCES `buses` (`id`),
  CONSTRAINT `bus_routes_routeid_foreign` FOREIGN KEY (`routeId`) REFERENCES `routes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `bus_run_timings`;
CREATE TABLE `bus_run_timings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `busRouteStationId` bigint(20) unsigned NOT NULL,
  `eta` time NOT NULL,
  `etd` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bus_run_timings_busroutestationid_foreign` (`busRouteStationId`),
  CONSTRAINT `bus_run_timings_busroutestationid_foreign` FOREIGN KEY (`busRouteStationId`) REFERENCES `bus_route_stations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `buses`;
CREATE TABLE `buses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `busCode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `routes`;
CREATE TABLE `routes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `stations`;
CREATE TABLE `stations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `stationCode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `bus_route_stations` (`id`, `busRouteId`, `stationId`, `status`, `created_at`, `updated_at`) VALUES
('1', '5', '9', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('2', '2', '9', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('3', '4', '19', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('4', '1', '19', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('5', '10', '19', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('6', '3', '16', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('7', '1', '16', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('8', '3', '9', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('9', '9', '9', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('10', '8', '16', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38');

INSERT INTO `bus_routes` (`id`, `routeId`, `busId`, `created_at`, `updated_at`) VALUES
('1', '1', '6', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('2', '6', '5', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('3', '10', '3', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('4', '4', '2', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('5', '8', '6', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('6', '10', '10', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('7', '2', '9', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('8', '2', '3', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('9', '9', '9', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('10', '10', '9', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('11', '5', '10', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('12', '6', '10', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('13', '8', '4', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('14', '5', '7', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('15', '9', '5', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('16', '7', '7', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('17', '4', '10', '2021-03-04 11:06:21', '2021-03-04 11:06:21');

INSERT INTO `bus_run_timings` (`id`, `busRouteStationId`, `eta`, `etd`, `created_at`, `updated_at`) VALUES
('3', '9', '02:57:29', '02:50:43', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('4', '9', '02:56:27', '02:49:22', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('5', '2', '02:58:38', '02:48:09', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('6', '10', '02:48:34', '02:49:07', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('7', '2', '02:58:23', '02:49:12', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('8', '7', '02:50:15', '02:49:31', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('9', '7', '02:48:51', '02:50:47', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('10', '8', '02:57:56', '02:51:35', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('11', '10', '02:48:30', '02:49:05', '2021-03-05 02:46:43', '2021-03-05 02:46:43'),
('12', '10', '02:55:00', '02:48:14', '2021-03-05 02:46:43', '2021-03-05 02:46:43');

INSERT INTO `buses` (`id`, `busCode`, `status`, `created_at`, `updated_at`) VALUES
('1', '127', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('2', '149', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('3', '136', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('4', '105', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('5', '122', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('6', '106', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('7', '142', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('8', '138', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('9', '147', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('10', '121', '1', '2021-03-04 04:31:31', '2021-03-04 04:31:31'),
('11', '144', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('12', '150', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('13', '146', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('14', '117', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('15', '134', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('16', '127', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('17', '124', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('18', '112', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('19', '148', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('20', '107', '1', '2021-03-04 10:58:26', '2021-03-04 10:58:26'),
('21', '134', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('22', '107', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('23', '132', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('24', '108', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('25', '124', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('26', '135', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('27', '120', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('28', '143', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('29', '136', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('30', '103', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('31', '127', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('32', '104', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('33', '149', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('34', '140', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('35', '141', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('36', '109', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('37', '115', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('38', '111', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('39', '120', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('40', '136', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('41', '135', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('42', '131', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('43', '125', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('44', '141', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('45', '102', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('46', '128', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('47', '146', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('48', '147', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('49', '134', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('50', '150', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21');

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
('1', '2014_10_12_000000_create_users_table', '1'),
('2', '2014_10_12_100000_create_password_resets_table', '1'),
('3', '2016_06_01_000001_create_oauth_auth_codes_table', '1'),
('4', '2016_06_01_000002_create_oauth_access_tokens_table', '1'),
('5', '2016_06_01_000003_create_oauth_refresh_tokens_table', '1'),
('6', '2016_06_01_000004_create_oauth_clients_table', '1'),
('7', '2016_06_01_000005_create_oauth_personal_access_clients_table', '1'),
('8', '2019_08_19_000000_create_failed_jobs_table', '1'),
('9', '2021_02_21_003313_create_buses_table', '1'),
('10', '2021_02_21_004747_create_stations_table', '1'),
('11', '2021_02_21_004846_create_routes_table', '1'),
('12', '2021_02_22_004846_create_bus_routes_table', '1'),
('13', '2021_02_23_004918_create_bus_route_stations_table', '1'),
('14', '2021_03_02_194731_create_bus_run_timings_table', '1');

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('013039f8a954aa970d5aa63e5291cd76808f4282c65d5239a17eff0049952f6766adf33cf6ef3c13', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-03 18:46:07', '2021-03-03 18:46:07', '2021-03-04 18:46:06'),
('16c2dc05d6073a6b546c7b430cbfc3acad0a5742c49ac87bb9f05d9348168f1794f79f98b157ab64', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:04:47', '2021-03-04 20:04:47', '2021-03-05 20:04:47'),
('21982961c4867288eb0531e80e03184a02ea32c8831043ad25e9a82f1570cf6ea14e738bbbc68d3a', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-02 20:26:25', '2021-03-02 20:26:25', '2021-03-03 20:26:25'),
('3d54012d8c76cf3cfcbef3ade99d717f625e4c5c9ad518e130adee82c5da6b443cde50b8072c22c0', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:22:14', '2021-03-04 20:22:14', '2021-03-05 20:22:14'),
('3f4c7c54a84fddba5e33bb563a887abbe7ead1de01855771e657d2c059ecfecf024c49d628ea0eb2', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:17:20', '2021-03-04 20:17:20', '2021-03-05 20:17:20'),
('422b96b6005bbce0a5dbf0d8f7b62694a35d7188630d63a2e0c75a30dd4c685375715b8600a9f402', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:27:14', '2021-03-04 20:27:14', '2021-03-05 20:27:14'),
('485ca84c95459bb1369907ab998d24b20b4d04a77e89504ad867ba092f1479900c8023308a4a979a', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:23:29', '2021-03-04 20:23:29', '2021-03-05 20:23:29'),
('65fc6c728c6c2f0beed81273341713594abdaf7632bb7f0937fc10f6df476c8bd9cba9af74572d98', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:19:54', '2021-03-04 20:19:54', '2021-03-05 20:19:54'),
('72e3fd716e13ffebd6156a7dc3b3d338ea2cf9fe003961623e0560e90dab59a1bac0e0cf30849ff3', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:25:14', '2021-03-04 20:25:14', '2021-03-05 20:25:14'),
('828c1515052b47571c6aa1a217cc257b27aead9dec95e2048c8854cefb4a75447bed8c63458461a3', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:48:53', '2021-03-04 20:48:53', '2021-03-05 20:48:53'),
('87a7014cce07c0b4391cd2dde84f658a0d58c22b7ee280796b33e35da98b94b105e764cc206f8fc8', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-03 18:52:31', '2021-03-03 18:52:31', '2021-03-04 18:52:31'),
('8813a072f0feffa978a5d8ef32b91a12285f97f9ed700ba432437b81e24816330c426a74d46305bf', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:19:21', '2021-03-04 20:19:21', '2021-03-05 20:19:21'),
('8b7164329356ef758940a3865e80ae9477a5471929e9e4cf055b7497f85214d758408836e7465425', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:07:56', '2021-03-04 20:07:56', '2021-03-05 20:07:56'),
('9ec718e2b43ec06e64c320fad02b8dd51ea34d81d2ca923651c78e59f4b0ecb9d834696d7c77e8ca', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 19:55:40', '2021-03-04 19:55:40', '2021-03-05 19:55:40'),
('bab6a8fe1c057dcd06c6e395f5bb41c932b645232492a3cdd1af43b40ad7bb0d820c591ea15b5f83', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:40:07', '2021-03-04 20:40:07', '2021-03-05 20:40:06'),
('bc1032f50eae6f54b21c662fb1f6e57ab2c9042dd12cb21307b08c36a1bfea539d00fdb567bf779e', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:24:14', '2021-03-04 20:24:14', '2021-03-05 20:24:13'),
('cb30097cdf0f76deb38d2d7eb1eb3bf972236d32831487037946775a9e74d8d515ab8dca977d276c', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 23:36:54', '2021-03-04 23:36:54', '2021-03-05 23:36:54'),
('cfbde93929311789d7b5a33e255e9884d69357ca6a734090f19e308ea0634023b47cedd8dc53e3b8', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-04 20:16:23', '2021-03-04 20:16:23', '2021-03-05 20:16:23'),
('d9b063706a168f3def0a038085bffaa9f9c5a231914944169ab54cdacb45ad987776a19b45014116', '1', '1', 'Laravel Password Grant Client', '[]', '0', '2021-03-03 18:49:33', '2021-03-03 18:49:33', '2021-03-04 18:49:33');

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
('1', NULL, 'Laravel Personal Access Client', 'LfsuK6mLcV5hi2Nw01r62X14J57b1saLyiunpXEw', NULL, 'http://localhost', '1', '0', '0', '2021-03-02 20:25:50', '2021-03-02 20:25:50'),
('2', NULL, 'Laravel Password Grant Client', 'zXZsFY3GEBel2KXnHkmtlG2cilTrKwcxpy5fJ2YU', 'users', 'http://localhost', '0', '1', '0', '2021-03-02 20:25:50', '2021-03-02 20:25:50');

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
('1', '1', '2021-03-02 20:25:50', '2021-03-02 20:25:50');

INSERT INTO `routes` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
('1', 'McClure Pine', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('2', 'Maggio Motorway', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('3', 'D\'Amore Avenue', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('4', 'Schumm Station', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('5', 'Meggie Manors', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('6', 'Jeramie Mount', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('7', 'General Mountain', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('8', 'Clarabelle Park', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('9', 'Yundt Divide', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('10', 'Frami Passage', '1', '2021-03-04 11:03:58', '2021-03-04 11:03:58'),
('11', 'Graham Circles', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('12', 'Lelia Summit', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('13', 'DuBuque Wall', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('14', 'Mertz Haven', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('15', 'Corkery Hollow', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('16', 'Nader Point', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('17', 'Paris Loaf', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('18', 'Kailee Dale', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('19', 'Oberbrunner Fall', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('20', 'Davis Cove', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('21', 'Jody Spurs', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('22', 'Kemmer Wall', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('23', 'Greg Club', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('24', 'Kris Junctions', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('25', 'Ana Walk', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('26', 'Orville Stream', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('27', 'Evie Tunnel', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('28', 'Breitenberg Gardens', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('29', 'Littel Roads', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21'),
('30', 'Carmel Lane', '1', '2021-03-04 11:06:21', '2021-03-04 11:06:21');

INSERT INTO `stations` (`id`, `stationCode`, `name`, `lat`, `lon`, `status`, `created_at`, `updated_at`) VALUES
('1', '47498', 'Grimes Pine', '1.381783', '103.840203', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('2', '05214', 'Mohr Turnpike', '1.369176', '103.84568', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('3', '23076', 'Nico Port', '1.327531', '103.834303', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('4', '35990', 'Rau Radial', '1.299732', '103.842848', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('5', '47805', 'Kaia Vista', '1.392428', '103.845908', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('6', '48878-4862', 'Labadie Way', '1.335932', '103.839915', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('7', '77405-0712', 'Joshua Stravenue', '1.368789', '103.847558', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('8', '38793', 'Breitenberg Well', '1.362293', '103.836636', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('9', '59974', 'Esmeralda Crescent', '1.428006', '103.833399', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('10', '20141-6725', 'Hessel Mill', '1.408652', '103.839795', '1', '2021-03-04 11:04:54', '2021-03-04 11:04:54'),
('11', '71341-5610', 'Valentine Court', '1.419188', '103.823425', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('12', '62078', 'Edwina Trace', '1.341304', '103.826993', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('13', '91880-3587', 'Kshlerin Loop', '1.360859', '103.841243', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('14', '68358', 'McCullough Plain', '1.309181', '103.824013', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('15', '25933-0541', 'Favian Rapids', '1.326356', '103.836217', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('16', '40354', 'Katlynn Isle', '1.421901', '103.836124', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('17', '50571-7876', 'Russel Stream', '1.325507', '103.847247', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('18', '14449', 'Goodwin Causeway', '1.408735', '103.821976', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('19', '42274-5366', 'Jeffery Park', '1.414301', '103.842941', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('20', '31416-9650', 'Okuneva Bypass', '1.352248', '103.846714', '1', '2021-03-05 02:34:26', '2021-03-05 02:34:26'),
('21', '44535-0820', 'Burdette Radial', '1.343882', '103.83814', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('22', '75922-0147', 'Frami Divide', '1.301273', '103.825389', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('23', '90627-2293', 'Clifton Causeway', '1.345779', '103.832665', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('24', '26200-0992', 'Macejkovic Unions', '1.370084', '103.842647', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('25', '67471', 'Johns Trail', '1.308976', '103.834422', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('26', '24768-0137', 'Purdy Highway', '1.379484', '103.835972', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('27', '58736-3194', 'Austen Burg', '1.333546', '103.821003', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('28', '50992', 'Weber Creek', '1.356354', '103.848476', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('29', '98181-9164', 'Walker Vista', '1.39639', '103.832714', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('30', '17618', 'Juliana Squares', '1.42876', '103.824124', '1', '2021-03-05 02:40:46', '2021-03-05 02:40:46'),
('31', '92447', 'Franz Drive', '1.419147', '103.84661', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('32', '88743-4133', 'Beer Ports', '1.407011', '103.824676', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('33', '83509', 'Terry Ferry', '1.293014', '103.82258', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('34', '48178', 'Halvorson Fort', '1.32791', '103.845681', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('35', '00546', 'Jermaine Rue', '1.380151', '103.847189', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('36', '62621-9556', 'Tyra Lakes', '1.439421', '103.82358', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('37', '29877', 'Cristopher Mountain', '1.310504', '103.830981', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('38', '63364', 'Dach Route', '1.385791', '103.828212', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('39', '05681-2104', 'Kris Prairie', '1.330658', '103.841515', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38'),
('40', '57669', 'Buster Forks', '1.403676', '103.821064', '1', '2021-03-05 02:44:38', '2021-03-05 02:44:38');

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
('1', 'Raymond Ratke', 'bradly.vandervort@example.com', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Y6wtvjAt4F', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('2', 'Alexis Ward', 'flossie.johns@example.net', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'hHblKRv6uW', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('3', 'Adele Smitham', 'savanah40@example.com', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'w8UTclvSDR', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('4', 'Julien Sipes', 'bettie75@example.net', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'yYHZZRSUot', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('5', 'Rico Goodwin', 'lowe.gaston@example.net', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '83Tc6RBy3U', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('6', 'Prof. Jean Klein IV', 'rebekah86@example.com', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'YefIEEvM2s', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('7', 'Trevion Altenwerth', 'omoen@example.com', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Mq2mX7J0Jn', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('8', 'Daisha Steuber', 'rcarroll@example.org', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'uMd1FRZnu2', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('9', 'Kattie Conn', 'kieran49@example.net', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'FeGMlCcMN3', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('10', 'Estevan Legros', 'hbotsford@example.com', '2021-03-02 20:25:42', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'eOv4OZSUDh', '2021-03-02 20:25:42', '2021-03-02 20:25:42'),
('11', 'Dr. Prudence Christiansen', 'metz.nat@example.org', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ihRUU0nEFJ', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('12', 'Chasity Grant', 'felicita15@example.com', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'PqYFn0ETZ1', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('13', 'Mossie Larkin', 'gleichner.adell@example.com', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'NfTDqAwZ6G', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('14', 'Dr. Sheldon Murazik MD', 'patience.kris@example.net', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'olWV8BbS5h', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('15', 'Mr. Jonatan Bailey III', 'osinski.kolby@example.org', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'yC4DLNFbNM', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('16', 'Skye Walker Jr.', 'alberto.howe@example.com', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'euu12EXr8A', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('17', 'Jessyca Purdy DDS', 'mohr.kara@example.org', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'kDwdIBJC1Z', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('18', 'Gillian Watsica', 'johnny06@example.com', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'NhGZq7c3wy', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('19', 'Prof. Allen Pfannerstill', 'leuschke.keven@example.net', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '1ch3UIyYbS', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('20', 'Prof. Maxime Wisoky DDS', 'xratke@example.net', '2021-03-04 04:29:57', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'LqjmzxzBGT', '2021-03-04 04:29:57', '2021-03-04 04:29:57'),
('21', 'Ms. Lilian Anderson I', 'bcrist@example.org', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'bUzinwSlNl', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('22', 'Cordie Altenwerth', 'ynikolaus@example.net', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'kcCkDGIx5E', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('23', 'Tamara Terry', 'sarai75@example.org', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'MQcUZoxvMe', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('24', 'Alisha O\'Connell Jr.', 'little.vincent@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'mC5fhYutmj', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('25', 'Madalyn Block', 'mraz.crawford@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'v8A1umax7T', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('26', 'Kyla Rath', 'elmore.douglas@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'wPikHbJE5u', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('27', 'Antonette Howell DVM', 'easter21@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'iiXpMRBgif', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('28', 'Clifton Kertzmann', 'luis.anderson@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'kVUKcdDu8C', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('29', 'Prof. Rosalee Ryan', 'francis.frami@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'vEws2bsXC2', '2021-03-04 11:07:15', '2021-03-04 11:07:15'),
('30', 'Brenda Corkery', 'catherine99@example.com', '2021-03-04 11:07:15', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Tix6rPK7eV', '2021-03-04 11:07:15', '2021-03-04 11:07:15');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;