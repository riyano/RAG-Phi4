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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `chat_histories` */

insert  into `chat_histories`(`id`,`user_id`,`session_id`,`sender`,`message`,`created_at`,`updated_at`) values 
(1,1,NULL,'user','apakah dataset ada?','2025-07-21 04:02:33','2025-07-21 04:02:33'),
(2,1,NULL,'bot','Mohon maaf, saya hanya bisa menjawab berdasarkan dataset yang Anda unggah. Saat ini tidak ada dataset yang tersedia.','2025-07-21 04:02:33','2025-07-21 04:02:33'),
(3,1,NULL,'user','apakah kamu punya data mengenai Ardan','2025-07-21 04:04:35','2025-07-21 04:04:35'),
(4,1,NULL,'bot','Berdasarkan konteks yang diberikan, saya memiliki informasi berikut tentang Ardan:\n\n- Ardan adalah seorang manusia yang bertarung melawan iblis raksasa bernama Malzar.\n- Dia terlibat dalam pertempuran satu lawan satu di ruang takhta hitam melawan Malzar.\n- Setelah menyaksikan desanya hancur dan orang-orang yang ia kenal terluka atau melarikan diri, Ardan berkomitmen untuk menghentikan Malzar dengan menemukan Pedang Cahaya.\n- Dia meninggalkan desa dan menuju Kuil Cahaya di Pegunungan Argoth untuk mencari senjata tersebut.\n- Dalam perjalanan ke utara, dia menghadapi Penjaga Kabut bernama Ghazul di Hutan Terkutuk. Di sana, ia bertemu dengan seorang elf wanita bernama Liana yang membantu menangani musuh tersebut.\n\nJika Anda memiliki pertanyaan lebih lanjut atau memerlukan informasi tambahan berdasarkan konteks ini, silakan tanyakan!','2025-07-21 04:07:37','2025-07-21 04:07:37'),
(5,1,NULL,'user','buatkan saya sebuah quest game mengenai Ardan','2025-07-21 04:15:06','2025-07-21 04:15:06'),
(6,1,NULL,'bot','Saya tidak dapat membuat quest game baru berdasarkan konteks yang diberikan. Namun, saya bisa merangkum informasi dari konteks untuk membantu Anda memahami perjalanan Ardan dan rekan-rekannya:\n\n1. **Pertemuan Awal**: Ardan dan kawan-kawannya menghadapi Ghazul, seorang musuh yang berhasrat untuk menyakitinya, tetapi berhasil diatasi dengan bantuan Liana, seorang elf wanita.\n\n2. **Rintangan Berikutnya**: Mereka terus melanjutkan petualangannya dan menghadapi Bayangan Malzar, pasukan elite dari penguasa abadi yang selalu mencari mereka.\n\n3. **Pertempuran Terakhir**: Setelah menemukan Pedang Cahaya di kuil kuno, Ardan dan kelompoknya memasuki benteng Malzar di Neraka Merah untuk menghadapi penguasa yang dianggap tidak dapat dikalahkan.\n\nJika Anda ingin merancang quest baru berdasarkan cerita ini, Anda bisa menggunakan elemen-elemen di atas sebagai titik awal atau inspirasi.','2025-07-21 04:17:38','2025-07-21 04:17:38'),
(7,1,NULL,'user','buatkan saya list quest game berdasarkan datanya','2025-07-21 04:19:21','2025-07-21 04:19:21'),
(8,1,NULL,'bot','Saya tidak dapat membuat daftar quest dari konteks yang disediakan. Konteks hanya menyebutkan beberapa elemen cerita, seperti pencarian Pedang Cahaya dan pertempuran terakhir di benteng Malzar, tetapi tidak memberikan detail atau struktur lengkap dari quest-quest tersebut dalam game.','2025-07-21 04:20:22','2025-07-21 04:20:22'),
(9,1,NULL,'user','buatkan saya list quest game/yang harus dilakukan oleh Ardan berdasarkan datanya','2025-07-21 04:21:07','2025-07-21 04:21:07'),
(10,1,NULL,'bot','Berdasarkan konteks yang diberikan, tidak ada daftar misi atau tugas spesifik untuk Ardan. Konteks tersebut hanya menyebutkan bahwa:\n\n1. Ardan dan kawan-kawannya menemukan Pedang Cahaya di kuil kuno.\n2. Mereka menyerang benteng Malzar di Neraka Merah.\n\nJika Anda membutuhkan daftar misi atau tugas yang lebih rinci, saya tidak dapat memberikan informasi tersebut berdasarkan konteks yang tersedia.','2025-07-21 04:21:41','2025-07-21 04:21:41'),
(11,1,NULL,'user','siapa saja nama yang ada di perjalanan Ardan?','2025-07-21 04:23:47','2025-07-21 04:23:47'),
(12,1,NULL,'bot','Berdasarkan konteks yang disediakan, orang-orang yang hadir dalam perjalanan Ardan adalah:\n\n1. Eldros - seorang pertapa bijak.\n2. Liana - menyatakan bahwa dunia ini diselamatkan oleh tiga orang.\n3. Grom - menertawakan dan menggambarkan situasi mereka saat berjalan.\n\nJika ada lebih banyak karakter yang terlibat dalam perjalanan tetapi tidak disebutkan secara eksplisit di konteks yang diberikan, saya tidak dapat menyediakan informasinya karena tidak termuat dalam dokumen tersebut.','2025-07-21 04:25:12','2025-07-21 04:25:12'),
(13,1,NULL,'user','Arda melawan siapa sebelum ke kerajaan Malzar?','2025-07-21 04:26:50','2025-07-21 04:26:50'),
(14,1,NULL,'bot','Ardan melawan Thorgash, iblis raksasa, sebelum mencapai kerajaan Malzar. \n\nJika Anda memiliki pertanyaan lebih lanjut atau memerlukan klarifikasi lebih banyak berdasarkan konteks yang diberikan, silakan tanyakan!','2025-07-21 04:28:05','2025-07-21 04:28:05'),
(15,1,NULL,'user','apakah kamu memiliki data mengenai cerita Ardan?','2025-07-21 04:33:25','2025-07-21 04:33:25'),
(16,1,NULL,'bot','Ya, saya memiliki konteks singkat dari cerita Ardan berikut ini:\n\n- **Bab 1: Permulaan Petualangan**\n  - Lokasi: Desa Harmonia\n  - Kondisi awal desa damai hingga pasukan kegelapan menyerbu.\n  - Ardan, seorang pemuda pemberani dari desa tersebut, berjanji untuk menghentikan Raja Iblis Malzar.\n\n- **Bab 2: Perjalanan Berbahaya**\n  - Ardan meninggalkan desanya dan menuju Kuil Cahaya di Pegunungan Argoth.\n  - **Pertemuan Pertama:** \n    - Lokasi: Hutan Terkutuk\n    - Menghadapi Ghazul, Penjaga Kabut dan pelayan Malzar.\n  \n  - **Pertemuan Kedua:** \n    - Lokasi: Gua di barat hutan\n    - Bertemu dengan Grom, seorang barbar besar yang bertarung melawan pasukan Ghoul Api.\n    - Mereka bergabung dan mengalahkan gerombolan Ghoul. Grom bergabung dengan Ardan dalam perjalanan untuk membunuh Malzar.\n\nJika Anda memiliki pertanyaan lebih lanjut tentang detail atau langkah-langkah tertentu, silakan tanyakan!','2025-07-21 04:36:31','2025-07-21 04:36:31'),
(17,1,NULL,'user','you know about Ardan?','2025-07-21 04:43:48','2025-07-21 04:43:48'),
(18,1,NULL,'bot','- **Motivasi Awal**: Ardan berkomitmen untuk menemukan Sword of Light dan menghentikan Malzar, bahkan jika itu memerlukan pengorbanan nyawanya.\n\n- **Perjalanan yang Mengancam**: \n  - Ardan memulai perjalanannya melintasi hutan terkutuk, gua penuh monster, dan gunung berapi yang menggelegar.\n  - Dia bertemu dengan dua sekutu baru: Liana, seorang pejuang elf, dan Grom, barbar yang kuat.\n\n- **Pendamping dalam Perjalanan**: \n  - Liana menjanjikan dukungan kepada Ardan, menyatakan bahwa dunia tidak boleh jatuh ke tangan Raja Setan.\n  - Bersama-sama, mereka menghadapi berbagai rintangan termasuk Shadow of Malzar, sebuah tentara elit yang selalu bersembunyi.\n\n- **Penemuan dan Pertempuran Akhir**:\n  - Sword of Light ditemukan di kuil kuno oleh Ardan dan teman-temannya.\n  - Mereka menyerang benteng terkuat Malzar di Red Hell.\n  - Pertarungan epik dimulai ketika Ardan mengangkat Sword of Light.\n  - Dengan keberanian dan kekuatan persahabatan, Ardan berhasil menghancurkan hati gelap Malzar.\n\n- **Akhir yang Legendaris**: \n  - Setelah kalah, Malzar menyatakan bahwa dia tidak bisa menang.\n  - Dunia diselamatkan, dan Ardan menjadi pahlawan legendaris.','2025-07-21 04:46:55','2025-07-21 04:46:55'),
(19,1,NULL,'user','you know about Ardan?','2025-07-21 04:59:16','2025-07-21 04:59:16'),
(20,1,NULL,'bot','- **Nama**: Ardan  \n- **Tujuan utama**: Menemukan Pedang Cahaya untuk menghentikan Malzar  \n- **Jalur perjalanan**:\n  - Melintasi hutan terkutuk\n  - Mendaki gua yang dipenuhi monster\n  - Menghadapi gunung berapi gila\n- **Kekuatan baru**: Liana, seorang pejuang elf, dan Grom, seorang barbar kuat\n- **Tantangan**: Faced the Shadow of Malzar, sebuah tentara elit\n- **Pencapaian**:\n  - Menemukan Pedang Cahaya di sebuah kuil kuno\n  - Menggugat benteng Malzar di Red Hell\n- **Kesimpulan perjuangan**: Dengan kekuatan persahabatan dan keberanian, Ardan menghancurkan hati terkutuk Malzar.  \n- **Akhir cerita**: Dunia diselamatkan, dan Ardan menjadi seorang pahlawan legendaris.\n\n**Lokasi utama yang relevan**:\n- Hutan terkutuk\n- Gua dengan monster\n- Gunung berapi gila\n- Kuil kuno\n- Benteng Malzar di Red Hell','2025-07-21 05:02:08','2025-07-21 05:02:08'),
(21,1,NULL,'user','you know about Ardan?','2025-07-21 05:07:51','2025-07-21 05:07:51'),
(22,1,NULL,'bot','- Ardan embarked on a perilous journey to find the Sword of Light and stop Malzar.\n- His journey took him through cursed forests, monster-filled caves, and raging volcanoes.\n- He gained allies in Liana, an elven warrior, and Grom, a powerful barbarian.\n- Together, they faced obstacles including the Shadow of Malzar\'s elite army.\n- Ardan found the Sword of Light in an ancient temple.\n- In Chapter 3: The Final Battle, he attacked Malzar\'s stronghold in Red Hell.\n- With courage and friendship, Ardan destroyed Malzar\'s heart of darkness.\n- After defeating Malzar, Ardan became a legendary hero and saved the world.','2025-07-21 05:10:12','2025-07-21 05:10:12'),
(23,1,NULL,'user','kamu tau Pak Hanny?','2025-07-21 05:17:34','2025-07-21 05:17:34'),
(24,1,NULL,'bot','Tidak, saya tidak menemukan informasi tentang \"Pak Hanny\" dalam dokumen yang diberikan.','2025-07-21 05:20:38','2025-07-21 05:20:38'),
(25,1,NULL,'user','berdasarkan data yang dilakukan oleh Ardan dan temannya jika bertemu dengan pasukan Malzar?','2025-07-21 05:30:11','2025-07-21 05:30:11'),
(26,1,NULL,'bot','Berdasarkan konteks yang diberikan:\n\n- **Pertarungan satu lawan satu:** \n  - Thorgash, iblis raksasa, mencoba menahan Ardan sebelum mencapai Raja Iblis Malzar.\n  - Pertempuran penuh aksi dan sihir terjadi antara Anggota Tim (Ardan dan temannya) dengan pasukan Malzar.\n\n- **Pertemuan Kedua:**\n  - Di sebuah gua di barat hutan, Ardan dan teman-temannya bertemu dengan Grom, seorang barbar besar.\n  - Mereka bersama-sama mengalahkan pasukan Ghoul Api yang sedang bertarung melawan Grom.\n\n- **Pertemuan dengan Malzar:**\n  - Akhirnya, Ardan bertarung satu lawan satu dengan Raja Iblis Malzar di ruang takhta hitam.\n  \nLokasi terkait:\n- Desa Harmonia\n- Gua di barat hutan\n- Ruang Takhta Hitam (di mana pertempuran dengan Malzar berlangsung) \n\nKonteks ini menunjukkan bahwa Ardan dan teman-temannya telah melawan pasukan Malzar beberapa kali, baik dalam pertarungan individu maupun kelompok.','2025-07-21 05:33:30','2025-07-21 05:33:30'),
(27,1,NULL,'user','apa yang terjadi jika Ardan tidak mendapatkan pedang cahaya?','2025-07-21 05:39:11','2025-07-21 05:39:11'),
(28,1,NULL,'bot','Dokumen yang disediakan tidak memberikan informasi tentang apa yang akan terjadi jika Ardan tidak mendapatkan Pedang Cahaya. Oleh karena itu, saya tidak dapat menemukan jawaban untuk pertanyaan tersebut dalam konteks yang diberikan.','2025-07-21 05:41:37','2025-07-21 05:41:37'),
(29,1,NULL,'user','buatkan saya sebuah list game tentang Ardan\'s Journey','2025-07-22 07:08:09','2025-07-22 07:08:09'),
(30,1,NULL,'bot','- **Perjalanan ke Utara**: \n  - Ardan meninggalkan desa yang hancur.\n  - Menapaki jalan menuju Kuil Cahaya di Pegunungan Argoth.\n\n- **Hutan Terkutuk**:\n  - Tempat pertama Ardan menghadapi musuh.\n  \n- **Pertemuan Pertama: Penjaga Kabut (Ghazul)**:\n  - Monster berkepala tiga muncul saat kabut pekat turun.\n  - Eldros, seorang pertapa bijak, memberi nasihat tentang Pedang Cahaya kepada Ardan.\n  - Liana, elf wanita dengan busur bercahaya, bergabung dalam pertempuran melawan Ghazul.\n\n- **Pertemuan Kedua: Gua Rahasia dan Grom**:\n  - Detail spesifik dari pertemuan ini tidak disediakan dalam konteks yang diberikan.','2025-07-22 07:10:54','2025-07-22 07:10:54'),
(31,1,NULL,'user','apa yang dilakukan Ardan jika mendapatkan pedang cahaya?','2025-07-22 13:22:34','2025-07-22 13:22:34'),
(32,1,NULL,'bot','- Pedang Cahaya memancarkan sinar emas.\n- Ardan menebas Malzar di dadanya dengan sinar tersebut.\n- Bayangan hancur, dan neraka runtuh. \n\nLokasi yang relevan adalah saat pertemuan pertama Ardan dengan Penjaga Kabut, Ghazul, yang terjadi setelahnya di Hutan Terkutuk.','2025-07-22 13:24:50','2025-07-22 13:24:50');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `datasets` */

insert  into `datasets`(`id`,`user_id`,`session_id`,`original_filename`,`stored_path`,`created_at`,`updated_at`) values 
(1,1,NULL,'CeritaHero.docx','persistent_db','2025-07-21 04:04:20','2025-07-21 04:04:20'),
(2,1,NULL,'StoryHero.docx','persistent_db','2025-07-21 04:43:03','2025-07-21 04:43:03');

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
('0JMCdrfXvl7WNopjbeL8AFObFBzpOT2c1093QC0t',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTXdmVVpuZ3EwVXkzVGNuSjBFb1l0SnVQbEJWM3NMRWNaOU1oT3FiTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMS9jaGF0Ym90Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1753168254),
('4GZAcH1sCTrCP0JRfXqlX0dSihZypFQxVARjfV6P',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiem82a3V5T0VDR2o5WXhEVFRGdThHdWh5OWpjZjZ2bnhLSzJxYW1KWSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMS9jaGF0Ym90Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1753076497),
('4RRa0k2XkXDe5qdIu67Cu9VwywZhp5YIueQCNDeG',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoidEdURHNacnJDMUcycUxBR0hyR1JEeEJ0SGVXUFo1NzBieWRuMTJyciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMS9jaGF0Ym90Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9',1753190691),
('EZTiEMLsnXXn6bUc1WyM5yPAuQhD5AmWECOYTNj7',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2JRZWRFQkFsc0hGQUszUWp1OTVTOWxLcHBFQnhEdzRveWhsZENtcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1753144692);

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
(1,'RGaming','hebatitubaik@gmail.com',NULL,'$2y$12$YAfPMaq0wIAsNj73WFCNy.wbWzA0S6LJ2uTOyNxFxKUJMZtg5k8GK',NULL,'2025-07-21 04:02:21','2025-07-21 04:02:21');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
