create database if not exists `uci`;


CREATE TABLE `uci`.`admin_menu` (
                              `id` int unsigned NOT NULL AUTO_INCREMENT,
                              `parent_id` int NOT NULL DEFAULT '0',
                              `order` int NOT NULL DEFAULT '0',
                              `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `permission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_menu` (`id`, `parent_id`, `order`, `title`, `icon`, `uri`, `permission`, `created_at`, `updated_at`)
VALUES
    (1,0,1,'Dashboard','fa-bar-chart','/',NULL,NULL,NULL),
    (2,0,2,'Admin','fa-tasks','',NULL,NULL,NULL),
    (3,2,3,'Users','fa-users','auth/users',NULL,NULL,NULL),
    (4,2,4,'Roles','fa-user','auth/roles',NULL,NULL,NULL),
    (5,2,5,'Permission','fa-ban','auth/permissions',NULL,NULL,NULL),
    (6,2,6,'Menu','fa-bars','auth/menu',NULL,NULL,NULL),
    (7,2,7,'Operation log','fa-history','auth/logs',NULL,NULL,NULL),
    (8,0,0,'Workflow','fa-bars','/workflows',NULL,'2023-03-10 23:45:45','2023-03-10 23:45:45'),
    (9,0,0,'Pipeline','fa-bars','/pipelines',NULL,'2023-03-10 23:45:56','2023-03-10 23:46:21');



CREATE TABLE `uci`.`admin_operation_log` (
                                       `id` int unsigned NOT NULL AUTO_INCREMENT,
                                       `user_id` int NOT NULL,
                                       `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL,
                                       PRIMARY KEY (`id`),
                                       KEY `admin_operation_log_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_operation_log` (`id`, `user_id`, `path`, `method`, `ip`, `input`, `created_at`, `updated_at`)
VALUES
    (1,2,'admin','GET','172.20.0.7','[]','2023-03-10 23:44:04','2023-03-10 23:44:04'),
    (2,2,'admin','GET','172.20.0.7','[]','2023-03-10 23:44:26','2023-03-10 23:44:26'),
    (3,2,'admin','GET','172.20.0.7','[]','2023-03-10 23:45:11','2023-03-10 23:45:11'),
    (4,2,'admin/auth/menu','GET','172.20.0.7','{\"_pjax\":\"#pjax-container\"}','2023-03-10 23:45:28','2023-03-10 23:45:28'),
    (5,2,'admin/auth/menu','POST','172.20.0.7','{\"parent_id\":\"0\",\"title\":\"Workflow\",\"icon\":\"fa-bars\",\"uri\":\"\\/workflows\",\"roles\":[null],\"permission\":null,\"_token\":\"AiN8huhfH6sPzEf6Zyuo4PfS2HqpHOAb4xoo65rG\"}','2023-03-10 23:45:45','2023-03-10 23:45:45'),
    (6,2,'admin/auth/menu','GET','172.20.0.7','[]','2023-03-10 23:45:45','2023-03-10 23:45:45'),
    (7,2,'admin/auth/menu','POST','172.20.0.7','{\"parent_id\":\"0\",\"title\":\"Pipeline\",\"icon\":\"fa-bars\",\"uri\":\"\\/pipeline\",\"roles\":[null],\"permission\":null,\"_token\":\"AiN8huhfH6sPzEf6Zyuo4PfS2HqpHOAb4xoo65rG\"}','2023-03-10 23:45:56','2023-03-10 23:45:56'),
    (8,2,'admin/auth/menu','GET','172.20.0.7','[]','2023-03-10 23:45:57','2023-03-10 23:45:57'),
    (9,2,'admin/auth/menu','GET','172.20.0.7','[]','2023-03-10 23:45:59','2023-03-10 23:45:59'),
    (10,2,'admin/workflows','GET','172.20.0.7','{\"_pjax\":\"#pjax-container\"}','2023-03-10 23:46:01','2023-03-10 23:46:01'),
    (11,2,'admin/workflows','GET','172.20.0.7','[]','2023-03-10 23:46:06','2023-03-10 23:46:06'),
    (12,2,'admin/auth/menu','GET','172.20.0.7','{\"_pjax\":\"#pjax-container\"}','2023-03-10 23:46:09','2023-03-10 23:46:09'),
    (13,2,'admin/auth/menu/9/edit','GET','172.20.0.7','{\"_pjax\":\"#pjax-container\"}','2023-03-10 23:46:18','2023-03-10 23:46:18'),
    (14,2,'admin/auth/menu/9','PUT','172.20.0.7','{\"parent_id\":\"0\",\"title\":\"Pipeline\",\"icon\":\"fa-bars\",\"uri\":\"\\/pipelines\",\"roles\":[null],\"permission\":null,\"_token\":\"AiN8huhfH6sPzEf6Zyuo4PfS2HqpHOAb4xoo65rG\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/admin.127.0.0.1.nip.io\\/admin\\/auth\\/menu\"}','2023-03-10 23:46:21','2023-03-10 23:46:21'),
    (15,2,'admin/auth/menu','GET','172.20.0.7','[]','2023-03-10 23:46:22','2023-03-10 23:46:22'),
    (16,2,'admin/workflows','GET','172.20.0.7','{\"_pjax\":\"#pjax-container\"}','2023-03-10 23:46:23','2023-03-10 23:46:23');

# 转储表 admin_permissions
# ------------------------------------------------------------

CREATE TABLE `uci`.`admin_permissions` (
                                     `id` int unsigned NOT NULL AUTO_INCREMENT,
                                     `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                                     `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                                     `http_path` text COLLATE utf8mb4_unicode_ci,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     UNIQUE KEY `admin_permissions_name_unique` (`name`),
                                     UNIQUE KEY `admin_permissions_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_permissions` (`id`, `name`, `slug`, `http_method`, `http_path`, `created_at`, `updated_at`)
VALUES
    (1,'All permission','*','','*',NULL,NULL),
    (2,'Dashboard','dashboard','GET','/',NULL,NULL),
    (3,'Login','auth.login','','/auth/login\r\n/auth/logout',NULL,NULL),
    (4,'User setting','auth.setting','GET,PUT','/auth/setting',NULL,NULL),
    (5,'Auth management','auth.management','','/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs',NULL,NULL);


# 转储表 admin_role_menu
# ------------------------------------------------------------

CREATE TABLE `uci`.`admin_role_menu` (
                                   `role_id` int NOT NULL,
                                   `menu_id` int NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL,
                                   KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_role_menu` (`role_id`, `menu_id`, `created_at`, `updated_at`)
VALUES
    (1,2,NULL,NULL);


# 转储表 admin_role_permissions
# ------------------------------------------------------------


CREATE TABLE `uci`.`admin_role_permissions` (
                                          `role_id` int NOT NULL,
                                          `permission_id` int NOT NULL,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `uci`.`admin_role_permissions` (`role_id`, `permission_id`, `created_at`, `updated_at`)
VALUES
    (1,1,NULL,NULL);


# 转储表 admin_role_users
# ------------------------------------------------------------


CREATE TABLE `uci`.`admin_role_users` (
                                    `role_id` int NOT NULL,
                                    `user_id` int NOT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL,
                                    KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_role_users` (`role_id`, `user_id`, `created_at`, `updated_at`)
VALUES
    (1,1,NULL,NULL),
    (1,2,NULL,NULL);


# 转储表 admin_roles
# ------------------------------------------------------------


CREATE TABLE `uci`.`admin_roles` (
                               `id` int unsigned NOT NULL AUTO_INCREMENT,
                               `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `admin_roles_name_unique` (`name`),
                               UNIQUE KEY `admin_roles_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_roles` (`id`, `name`, `slug`, `created_at`, `updated_at`)
VALUES
    (1,'Administrator','administrator','2023-03-10 23:36:32','2023-03-10 23:36:32');


# 转储表 admin_user_permissions
# ------------------------------------------------------------


CREATE TABLE `uci`.`admin_user_permissions` (
                                          `user_id` int NOT NULL,
                                          `permission_id` int NOT NULL,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 admin_users
# ------------------------------------------------------------


CREATE TABLE `uci`.`admin_users` (
                               `id` int unsigned NOT NULL AUTO_INCREMENT,
                               `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`admin_users` (`id`, `username`, `password`, `name`, `avatar`, `remember_token`, `created_at`, `updated_at`)
VALUES
    (1,'admin','$2y$10$YPqZSmC.Z2ZQSbiJYgzJ0ubNqOmzRNI9hSA74wPSb6GE5FUBZVjem','Administrator',NULL,NULL,'2023-03-10 23:36:32','2023-03-10 23:36:32'),
    (2,'uci','$2y$10$a6q9SkievcHppu00mqKx6eqQ9RxQbz5jgf0l7lq7YtiUSET99x4Iu','UCI',NULL,'1ZDe7c4WVtHgA6b41zEkc1CTCBPiR8eHc4tl4d4pUpfImU0xr2eQCZvsdpCd','2023-03-10 23:36:43','2023-03-10 23:36:43');


# 转储表 failed_jobs
# ------------------------------------------------------------


CREATE TABLE `uci`.`failed_jobs` (
                               `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                               `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
                               `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
                               `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
                               `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
                               `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 migrations
# ------------------------------------------------------------


CREATE TABLE `uci`.`migrations` (
                              `id` int unsigned NOT NULL AUTO_INCREMENT,
                              `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `batch` int NOT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `uci`.`migrations` (`id`, `migration`, `batch`)
VALUES
    (1,'2014_10_12_000000_create_users_table',1),
    (2,'2014_10_12_100000_create_password_resets_table',1),
    (3,'2016_01_04_173148_create_admin_tables',1),
    (4,'2019_08_19_000000_create_failed_jobs_table',1),
    (5,'2019_12_14_000001_create_personal_access_tokens_table',1),
    (6,'2022_04_29_075932_create_workflows_table',2),
    (7,'2022_05_28_020537_create_pipelines_table',3),
    (8,'2022_06_11_142611_create_runners_table',3);


# 转储表 password_resets
# ------------------------------------------------------------


CREATE TABLE `uci`.`password_resets` (
                                   `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 personal_access_tokens
# ------------------------------------------------------------


CREATE TABLE `uci`.`personal_access_tokens` (
                                          `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                          `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `tokenable_id` bigint unsigned NOT NULL,
                                          `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `abilities` text COLLATE utf8mb4_unicode_ci,
                                          `last_used_at` timestamp NULL DEFAULT NULL,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          PRIMARY KEY (`id`),
                                          UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
                                          KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 pipelines
# ------------------------------------------------------------


CREATE TABLE `uci`.`pipelines` (
                             `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                             `workflow_id` int NOT NULL,
                             `number` int NOT NULL DEFAULT '0',
                             `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
                             `salt` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
                             `yaml` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `triggered_cause` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `failed_cause` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BUILD_QUEUING',
                             `status_message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
                             `last_status_changed_at` timestamp NULL DEFAULT NULL,
                             `envs` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `runner_id` int NOT NULL DEFAULT '0',
                             `first_borrow_runner_at` timestamp NULL DEFAULT NULL,
                             `borrow_runner_succeed_at` timestamp NULL DEFAULT NULL,
                             `release_runner_at` timestamp NULL DEFAULT NULL,
                             `started_at` timestamp NULL DEFAULT NULL,
                             `closed_at` timestamp NULL DEFAULT NULL,
                             `duration` int NOT NULL DEFAULT '0',
                             `raw_log` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `prepare_log` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `dispatch_times` int NOT NULL DEFAULT '0',
                             `first_dispatched_at` timestamp NULL DEFAULT NULL,
                             `last_dispatched_at` timestamp NULL DEFAULT NULL,
                             `dispatch_succeed_at` timestamp NULL DEFAULT NULL,
                             `time_consuming` json DEFAULT NULL,
                             `created_at` timestamp NULL DEFAULT NULL,
                             `updated_at` timestamp NULL DEFAULT NULL,
                             `deleted_at` timestamp NULL DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 runners
# ------------------------------------------------------------

CREATE TABLE `uci`.`runners` (
                           `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                           `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
                           `salt` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
                           `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
                           `last_connected_at` timestamp NULL DEFAULT NULL,
                           `last_disconnected_at` timestamp NULL DEFAULT NULL,
                           `last_dispatched_at` timestamp NULL DEFAULT NULL,
                           `created_at` timestamp NULL DEFAULT NULL,
                           `updated_at` timestamp NULL DEFAULT NULL,
                           `deleted_at` timestamp NULL DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# 转储表 users
# ------------------------------------------------------------


CREATE TABLE `uci`.`users` (
                         `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                         `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `email_verified_at` timestamp NULL DEFAULT NULL,
                         `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

# 转储表 workflows
# ------------------------------------------------------------

CREATE TABLE `uci`.`workflows` (
                             `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                             `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `yaml` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `creator_id` int NOT NULL,
                             `envs` text COLLATE utf8mb4_unicode_ci NOT NULL,
                             `latest_pipeline_id` int NOT NULL DEFAULT '0' COMMENT '最后一次流水线 ID',
                             `latest_success_pipeline_id` int NOT NULL DEFAULT '0' COMMENT '最后一次成功构建流水线 ID',
                             `max_concurrent` int NOT NULL DEFAULT '5',
                             `build_timeout_second` int NOT NULL DEFAULT '1800' COMMENT '构建超时时间',
                             `created_at` timestamp NULL DEFAULT NULL,
                             `updated_at` timestamp NULL DEFAULT NULL,
                             `deleted_at` timestamp NULL DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
