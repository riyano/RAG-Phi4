/*
SQLyog Community v13.3.0 (64 bit)
MySQL - 8.0.30 : Database - chatbot
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`chatbot` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `chatbot`;

/*Table structure for table `chat_histories` */

DROP TABLE IF EXISTS `chat_histories`;

CREATE TABLE `chat_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `sender` enum('user','bot') NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_histories_user_id_foreign` (`user_id`),
  KEY `chat_histories_session_id_index` (`session_id`),
  CONSTRAINT `chat_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `chat_histories` */

insert  into `chat_histories`(`id`,`user_id`,`session_id`,`sender`,`message`,`created_at`,`updated_at`) values 
(1,1,NULL,'user','apakah dataset ada','2025-07-21 02:58:21','2025-07-21 02:58:21'),
(2,1,NULL,'bot','Untuk menjawab pertanyaan tersebut dengan tepat, saya memerlukan konteks tambahan tentang jenis dataset yang Anda maksudkan. \"Apakah dataset ada?\" bisa merujuk pada berbagai hal, seperti dataset tertentu dalam proyek atau basis data yang tersedia untuk penggunaan.\n\nJika Anda merujuk pada dataset spesifik di platform atau proyek tertentu, silakan berikan lebih banyak detail agar saya dapat membantu dengan informasi yang tepat. Jika tidak, secara umum, ada banyak dataset publik yang tersedia di berbagai sumber seperti Kaggle, UCI Machine Learning Repository, dan lainnya.\n\nJika Anda merujuk pada sesuatu yang spesifik dalam konteks pribadi atau profesional, mohon berikan informasi lebih lanjut agar saya dapat memberikan jawaban yang relevan. Jika saya tidak memiliki cukup informasi untuk menjawab dengan pasti, saya mengakui bahwa saya tidak mengetahui jawabannya secara spesifik.\n\nJika ada pertanyaan lain atau detail tambahan yang Anda miliki, jangan ragu untuk memberitahu!','2025-07-21 02:59:31','2025-07-21 02:59:31'),
(3,1,NULL,'user','Apakah dataset ada?','2025-07-21 03:00:04','2025-07-21 03:00:04'),
(4,1,NULL,'bot','Untuk menjawab pertanyaan \"Apakah dataset ada?\" saya memerlukan konteks tambahan, karena pertanyaan ini bisa merujuk pada berbagai situasi. Berikut adalah beberapa kemungkinan interpretasi:\n\n1. **Dataset Spesifik**: Jika Anda mencari informasi tentang keberadaan dataset tertentu (misalnya dataset yang digunakan dalam proyek atau penelitian), mohon berikan nama atau deskripsi lebih lanjut tentang dataset tersebut.\n\n2. **Dataset Umum/Publik**: Secara umum, banyak dataset publik tersedia di berbagai platform seperti Kaggle, UCI Machine Learning Repository, Google Dataset Search, dan lainnya. Jika Anda mencari dataset untuk proyek tertentu atau penggunaan khusus, platform-platform ini bisa menjadi tempat yang baik untuk memulai pencarian.\n\n3. **Dataset dalam Konteks Pribadi/Profesional**: Jika pertanyaan ini berkaitan dengan dataset dalam konteks pribadi atau profesional Anda (misalnya di perusahaan atau proyek tertentu), mohon berikan lebih banyak detail untuk membantu saya memberikan informasi yang relevan.\n\nJika tidak ada konteks tambahan, saya mengakui bahwa saya tidak dapat memberikan jawaban yang tepat. Jika Anda memiliki pertanyaan lain atau informasi lebih lanjut tentang dataset yang Anda maksudkan, jangan ragu untuk bertanya!','2025-07-21 03:01:56','2025-07-21 03:01:56'),
(5,1,NULL,'user','Apakah dataset ada?','2025-07-21 03:05:14','2025-07-21 03:05:14'),
(6,1,NULL,'bot','Tentu saja! Untuk menjawab pertanyaan Anda dengan benar, saya memerlukan konteks atau detail lebih lanjut tentang dataset yang Anda maksudkan. Jika Anda merujuk pada sebuah dataset tertentu dalam proyek, penelitian, atau aplikasi Anda, saya tidak memiliki akses langsung ke database real-time untuk memverifikasi keberadaannya.\n\nJika Anda dapat memberikan nama atau deskripsi lebih lanjut tentang dataset tersebut, mungkin bisa membantu. Sebaliknya, jika ini berkaitan dengan dataset umum yang sering digunakan dalam bidang tertentu (seperti data cuaca, penggunaan media sosial, dll.), saya bisa memberikan informasi umum tentang beberapa dataset populer.\n\nNamun, tanpa konteks tambahan, saya tidak dapat mengonfirmasi keberadaan dataset tersebut. Jika ini berkaitan dengan situasi tertentu atau platform yang Anda gunakan, mungkin lebih baik untuk memeriksa sumber asli atau dokumentasi terkait untuk informasi paling akurat.\n\nJika ada hal lain yang bisa saya bantu, silakan beri tahu!','2025-07-21 03:06:28','2025-07-21 03:06:28'),
(7,1,NULL,'user','apakah ada dataset','2025-07-21 03:13:31','2025-07-21 03:13:31'),
(8,1,NULL,'bot','Tidak ada dataset yang ditemukan. Silakan upload dokumen untuk menambahkan dataset.','2025-07-21 03:13:31','2025-07-21 03:13:31'),
(9,1,NULL,'user','apakah dataset ada','2025-07-21 03:14:11','2025-07-21 03:14:11'),
(10,1,NULL,'bot','Tidak, konteks yang diberikan tidak menyebutkan tentang adanya dataset. Konteks tersebut berfokus pada perjalanan Ardan dan sekutunya dalam sebuah cerita fiksi, tanpa referensi terhadap data atau dataset apapun.','2025-07-21 03:16:05','2025-07-21 03:16:05'),
(11,1,NULL,'user','apakah pada dataset ada data mengenai Ardan?','2025-07-21 03:17:05','2025-07-21 03:17:05'),
(12,1,NULL,'bot','Ya, pada konteks yang disediakan ada informasi mengenai Ardan. Dia memulai perjalanannya melalui hutan terkutuk, gua penuh monster, dan gunung berapi yang mengamuk untuk mencari Pedang Cahaya dan menghentikan Malzar, bahkan jika itu berarti harus mengorbankan nyawanya. Selain itu, dia bertemu dengan dua sekutu baru: Liana, seorang pendekar elf, dan Grom, seorang barbar kuat.','2025-07-21 03:17:40','2025-07-21 03:17:40'),
(13,1,NULL,'user','coba buatkan sebuah quest game berdasarkan konteks','2025-07-21 03:18:37','2025-07-21 03:18:37'),
(14,1,NULL,'bot','Saya tidak dapat membuat sebuah quest game berdasarkan konteks yang diberikan. Konteks ini hanya menyediakan ringkasan cerita dari Bab 3, termasuk karakter dan elemen penting seperti \"Pedang Cahaya\" dan \"Bayangan Malzar\". Untuk merancang sebuah quest game, akan memerlukan lebih banyak detail mengenai mekanisme permainan, misi, tantangan spesifik, dan tujuan akhir. Namun, berdasarkan konteks yang tersedia, saya dapat menyarankan outline dasar untuk quest:\n\n**Nama Quest: Pertempuran Terakhir melawan Malzar**\n\n1. **Tujuan Utama:** Mengalahkan Malzar di bentengnya di Neraka Merah menggunakan Pedang Cahaya.\n\n2. **Persiapan:**\n   - Temukan dan kumpulkan item-item penting seperti Pedang Cahaya dari kuil kuno.\n   - Latih kemampuan karakter Anda untuk siap menghadapi Bayangan Malzar, pasukan elite yang selalu mengintai.\n\n3. **Tantangan Utama:**\n   - Mengatasi berbagai rintangan di perjalanan menuju benteng Neraka Merah.\n   - Menghindari atau mempersiapkan diri terhadap serangan Bayangan Malzar.\n\n4. **Pertempuran Akhir:**\n   - Hadapi Malzar dalam pertarungan sambil menggunakan Pedang Cahaya untuk menentukan hasil.\n\nUntuk membuat quest ini menjadi permainan, akan diperlukan elemen interaktif tambahan dan detail lebih lanjut tentang mekanisme game.','2025-07-21 03:20:47','2025-07-21 03:20:47'),
(15,1,NULL,'user','apa yang dilakukan oleh Ardan dan temannya jika bertemu prajurit dari Malzar?','2025-07-21 03:25:44','2025-07-21 03:25:44'),
(16,1,NULL,'bot','Jika Ardan dan kawan-kawannya bertemu dengan pasukan elite Bayangan Malzar, mereka menghadapi banyak rintangan. Konteks tidak memberikan detail spesifik tentang tindakan langsung yang dilakukan oleh Ardan dan teman-temannya saat bertemu prajurit dari Malzar selain bahwa mereka menyerang benteng Malzar di Neraka Merah setelah menemukan Pedang Cahaya di kuil kuno.','2025-07-21 03:26:13','2025-07-21 03:26:13'),
(17,1,NULL,'user','jika Ardan menemukan pedang cahaya, apakah Malzar dapat dikalahkan?','2025-07-21 03:27:57','2025-07-21 03:27:57'),
(18,1,NULL,'bot','Ya, jika Ardan menemukan Pedang Cahaya, dia dapat menghancurkan jantung kegelapan Malzar dan mengalahkannya. Ini menyebabkan dunia diselamatkan, dan Ardan menjadi pahlawan legendaris.\n\nJika ada pertanyaan lebih lanjut, silakan tanyakan!','2025-07-21 03:28:52','2025-07-21 03:28:52'),
(19,1,NULL,'user','jika Ardan tidak mendapatkan pedang cahaya apakah Malzar dapat dikalahkan?','2025-07-21 03:30:16','2025-07-21 03:30:16'),
(20,1,NULL,'bot','Konteks yang diberikan tidak menyediakan informasi tentang apa yang terjadi jika Ardan tidak memiliki Pedang Cahaya. Oleh karena itu, saya tidak dapat menemukan jawaban untuk pertanyaan tersebut dalam dokumen ini.','2025-07-21 03:30:33','2025-07-21 03:30:33');

/*Table structure for table `datasets` */

DROP TABLE IF EXISTS `datasets`;

CREATE TABLE `datasets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `original_filename` varchar(255) NOT NULL,
  `stored_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `datasets_user_id_original_filename_unique` (`user_id`,`original_filename`),
  UNIQUE KEY `datasets_session_id_original_filename_unique` (`session_id`,`original_filename`),
  CONSTRAINT `datasets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `datasets` */

insert  into `datasets`(`id`,`user_id`,`session_id`,`original_filename`,`stored_path`,`created_at`,`updated_at`) values 
(1,1,NULL,'CeritaHero.docx','persistent_db','2025-07-21 03:13:52','2025-07-21 03:13:52');

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'0001_01_01_000000_create_session_table',1),
(2,'0001_01_01_000000_create_users_table copy',1),
(3,'2025_07_18_021523_create_datasets_table',1),
(4,'2025_07_18_113642_create_chat_histories_table',1),
(5,'2025_07_18_114205_add_session_id_to_datasets_table',1),
(6,'2025_07_19_133724_add_unique_constraint_to_datasets_table',1),
(7,'2025_07_20_092050_create_softdeletes_table',1);

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sessions` */

insert  into `sessions`(`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) values 
('FVe7UdZwnPj7m0FZLsI2lgt8XzOyBNwGFlNm3Xka',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoibFVOV0JIenZ2b0lRM0h3dHRiRXB5OTNLYjBaR2FiT0dUemdsc0FtMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMS9jaGF0Ym90Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1753068633);

/*Table structure for table `softdeletes` */

DROP TABLE IF EXISTS `softdeletes`;

CREATE TABLE `softdeletes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `original_filename` varchar(255) NOT NULL,
  `stored_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `softdeletes` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`) values 
(1,'RGaming','hebatitubaik@gmail.com',NULL,'$2y$12$fgefLnffFw5Zq5Wolwi1FuuPIOVRWhdinp7nPfZgpQ44I8TGZIAp6',NULL,'2025-07-21 02:58:07','2025-07-21 02:58:07');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
