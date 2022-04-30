-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: uci
-- Generation Time: 2022-04-30 13:40:04.2340
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_menu_id_seq;

-- Table Definition
CREATE TABLE "uci"."admin_menu" (
                                    "id" int4 NOT NULL DEFAULT nextval('admin_menu_id_seq'::regclass),
                                    "parent_id" int4 NOT NULL DEFAULT 0,
                                    "order" int4 NOT NULL DEFAULT 0,
                                    "title" varchar(50) NOT NULL,
                                    "icon" varchar(50) NOT NULL,
                                    "uri" varchar(255),
                                    "permission" varchar(255),
                                    "created_at" timestamp(0),
                                    "updated_at" timestamp(0),
                                    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_operation_log_id_seq;

-- Table Definition
CREATE TABLE "uci"."admin_operation_log" (
                                             "id" int4 NOT NULL DEFAULT nextval('admin_operation_log_id_seq'::regclass),
                                             "user_id" int4 NOT NULL,
                                             "path" varchar(255) NOT NULL,
                                             "method" varchar(10) NOT NULL,
                                             "ip" varchar(255) NOT NULL,
                                             "input" text NOT NULL,
                                             "created_at" timestamp(0),
                                             "updated_at" timestamp(0),
                                             PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_permissions_id_seq;

-- Table Definition
CREATE TABLE "uci"."admin_permissions" (
                                           "id" int4 NOT NULL DEFAULT nextval('admin_permissions_id_seq'::regclass),
                                           "name" varchar(50) NOT NULL,
                                           "slug" varchar(50) NOT NULL,
                                           "http_method" varchar(255),
                                           "http_path" text,
                                           "created_at" timestamp(0),
                                           "updated_at" timestamp(0),
                                           PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "uci"."admin_role_menu" (
                                         "role_id" int4 NOT NULL,
                                         "menu_id" int4 NOT NULL,
                                         "created_at" timestamp(0),
                                         "updated_at" timestamp(0)
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "uci"."admin_role_permissions" (
                                                "role_id" int4 NOT NULL,
                                                "permission_id" int4 NOT NULL,
                                                "created_at" timestamp(0),
                                                "updated_at" timestamp(0)
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "uci"."admin_role_users" (
                                          "role_id" int4 NOT NULL,
                                          "user_id" int4 NOT NULL,
                                          "created_at" timestamp(0),
                                          "updated_at" timestamp(0)
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_roles_id_seq;

-- Table Definition
CREATE TABLE "uci"."admin_roles" (
                                     "id" int4 NOT NULL DEFAULT nextval('admin_roles_id_seq'::regclass),
                                     "name" varchar(50) NOT NULL,
                                     "slug" varchar(50) NOT NULL,
                                     "created_at" timestamp(0),
                                     "updated_at" timestamp(0),
                                     PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "uci"."admin_user_permissions" (
                                                "user_id" int4 NOT NULL,
                                                "permission_id" int4 NOT NULL,
                                                "created_at" timestamp(0),
                                                "updated_at" timestamp(0)
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_users_id_seq;

-- Table Definition
CREATE TABLE "uci"."admin_users" (
                                     "id" int4 NOT NULL DEFAULT nextval('admin_users_id_seq'::regclass),
                                     "username" varchar(190) NOT NULL,
                                     "password" varchar(60) NOT NULL,
                                     "name" varchar(255) NOT NULL,
                                     "avatar" varchar(255),
                                     "remember_token" varchar(100),
                                     "created_at" timestamp(0),
                                     "updated_at" timestamp(0),
                                     PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS failed_jobs_id_seq;

-- Table Definition
CREATE TABLE "uci"."failed_jobs" (
                                     "id" int8 NOT NULL DEFAULT nextval('failed_jobs_id_seq'::regclass),
                                     "uuid" varchar(255) NOT NULL,
                                     "connection" text NOT NULL,
                                     "queue" text NOT NULL,
                                     "payload" text NOT NULL,
                                     "exception" text NOT NULL,
                                     "failed_at" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS migrations_id_seq;

-- Table Definition
CREATE TABLE "uci"."migrations" (
                                    "id" int4 NOT NULL DEFAULT nextval('migrations_id_seq'::regclass),
                                    "migration" varchar(255) NOT NULL,
                                    "batch" int4 NOT NULL,
                                    PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "uci"."password_resets" (
                                         "email" varchar(255) NOT NULL,
                                         "token" varchar(255) NOT NULL,
                                         "created_at" timestamp(0)
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS personal_access_tokens_id_seq;

-- Table Definition
CREATE TABLE "uci"."personal_access_tokens" (
                                                "id" int8 NOT NULL DEFAULT nextval('personal_access_tokens_id_seq'::regclass),
                                                "tokenable_type" varchar(255) NOT NULL,
                                                "tokenable_id" int8 NOT NULL,
                                                "name" varchar(255) NOT NULL,
                                                "token" varchar(64) NOT NULL,
                                                "abilities" text,
                                                "last_used_at" timestamp(0),
                                                "created_at" timestamp(0),
                                                "updated_at" timestamp(0),
                                                PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS pipelines_id_seq;

-- Table Definition
CREATE TABLE "uci"."pipelines" (
                                   "id" int8 NOT NULL DEFAULT nextval('pipelines_id_seq'::regclass),
                                   "name" varchar(255) NOT NULL,
                                   "content" text NOT NULL,
                                   "created_at" timestamp(0),
                                   "updated_at" timestamp(0),
                                   "deleted_at" timestamp(0),
                                   PRIMARY KEY ("id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Table Definition
CREATE TABLE "uci"."users" (
                               "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
                               "name" varchar(255) NOT NULL,
                               "email" varchar(255) NOT NULL,
                               "email_verified_at" timestamp(0),
                               "password" varchar(255) NOT NULL,
                               "remember_token" varchar(100),
                               "created_at" timestamp(0),
                               "updated_at" timestamp(0),
                               PRIMARY KEY ("id")
);

INSERT INTO "uci"."admin_menu" ("id", "parent_id", "order", "title", "icon", "uri", "permission", "created_at", "updated_at") VALUES
                                                                                                                                  ('1', '0', '1', 'Dashboard', 'fa-bar-chart', '/', NULL, NULL, NULL),
                                                                                                                                  ('2', '0', '2', 'Admin', 'fa-tasks', '', NULL, NULL, NULL),
                                                                                                                                  ('3', '2', '3', 'Users', 'fa-users', 'auth/users', NULL, NULL, NULL),
                                                                                                                                  ('4', '2', '4', 'Roles', 'fa-user', 'auth/roles', NULL, NULL, NULL),
                                                                                                                                  ('5', '2', '5', 'Permission', 'fa-ban', 'auth/permissions', NULL, NULL, NULL),
                                                                                                                                  ('6', '2', '6', 'Menu', 'fa-bars', 'auth/menu', NULL, NULL, NULL),
                                                                                                                                  ('7', '2', '7', 'Operation log', 'fa-history', 'auth/logs', NULL, NULL, NULL);

INSERT INTO "uci"."admin_operation_log" ("id", "user_id", "path", "method", "ip", "input", "created_at", "updated_at") VALUES
                                                                                                                           ('1', '1', 'admin', 'GET', '172.20.0.5', '[]', '2022-04-29 07:19:43', '2022-04-29 07:19:43'),
                                                                                                                           ('2', '1', 'admin', 'GET', '172.20.0.5', '{"_pjax":"#pjax-container"}', '2022-04-29 07:39:43', '2022-04-29 07:39:43'),
                                                                                                                           ('3', '1', 'admin', 'GET', '172.20.0.5', '[]', '2022-04-29 07:40:11', '2022-04-29 07:40:11'),
                                                                                                                           ('4', '1', 'admin', 'GET', '172.20.0.5', '[]', '2022-04-29 07:40:23', '2022-04-29 07:40:23'),
                                                                                                                           ('5', '1', 'admin', 'GET', '172.20.0.5', '[]', '2022-04-29 07:40:34', '2022-04-29 07:40:34'),
                                                                                                                           ('6', '1', 'admin', 'GET', '172.20.0.5', '[]', '2022-04-29 07:40:46', '2022-04-29 07:40:46'),
                                                                                                                           ('7', '1', 'admin', 'GET', '172.20.0.5', '{"_pjax":"#pjax-container"}', '2022-04-29 07:42:15', '2022-04-29 07:42:15'),
                                                                                                                           ('8', '1', 'admin', 'GET', '172.20.0.5', '{"_pjax":"#pjax-container"}', '2022-04-29 07:42:15', '2022-04-29 07:42:15'),
                                                                                                                           ('9', '1', 'admin/pipeline', 'GET', '172.20.0.5', '[]', '2022-04-29 07:48:21', '2022-04-29 07:48:21'),
                                                                                                                           ('10', '1', 'admin/pipeline', 'GET', '172.20.0.5', '[]', '2022-04-29 07:49:40', '2022-04-29 07:49:40'),
                                                                                                                           ('11', '1', 'admin/pipeline', 'GET', '172.20.0.5', '[]', '2022-04-29 09:29:01', '2022-04-29 09:29:01'),
                                                                                                                           ('12', '1', 'admin/pipeline', 'GET', '172.20.0.5', '[]', '2022-04-29 09:32:52', '2022-04-29 09:32:52'),
                                                                                                                           ('13', '1', 'admin/pipeline', 'GET', '172.20.0.5', '[]', '2022-04-29 09:34:07', '2022-04-29 09:34:07'),
                                                                                                                           ('14', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 02:45:31', '2022-04-30 02:45:31'),
                                                                                                                           ('15', '1', 'admin/pipeline/create', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 02:45:36', '2022-04-30 02:45:36'),
                                                                                                                           ('16', '1', 'admin/pipeline/create', 'GET', '172.20.0.7', '[]', '2022-04-30 02:48:30', '2022-04-30 02:48:30'),
                                                                                                                           ('17', '1', 'admin/pipeline/create', 'GET', '172.20.0.7', '[]', '2022-04-30 02:49:17', '2022-04-30 02:49:17'),
                                                                                                                           ('18', '1', 'admin/pipeline', 'POST', '172.20.0.7', '{"name":"test","content":"echo 123","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08"}', '2022-04-30 02:49:26', '2022-04-30 02:49:26'),
                                                                                                                           ('19', '1', 'admin/pipeline/create', 'GET', '172.20.0.7', '[]', '2022-04-30 02:49:27', '2022-04-30 02:49:27'),
                                                                                                                           ('20', '1', 'admin/pipeline/create', 'GET', '172.20.0.7', '[]', '2022-04-30 02:50:43', '2022-04-30 02:50:43'),
                                                                                                                           ('21', '1', 'admin/pipeline', 'POST', '172.20.0.7', '{"name":"123","content":"123","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08"}', '2022-04-30 02:50:47', '2022-04-30 02:50:47'),
                                                                                                                           ('22', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 02:50:47', '2022-04-30 02:50:47'),
                                                                                                                           ('23', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 02:59:25', '2022-04-30 02:59:25'),
                                                                                                                           ('24', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 02:59:30', '2022-04-30 02:59:30'),
                                                                                                                           ('25', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 02:59:31', '2022-04-30 02:59:31'),
                                                                                                                           ('26', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 02:59:47', '2022-04-30 02:59:47'),
                                                                                                                           ('27', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 02:59:48', '2022-04-30 02:59:48'),
                                                                                                                           ('28', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:00:25', '2022-04-30 03:00:25'),
                                                                                                                           ('29', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:00:50', '2022-04-30 03:00:50'),
                                                                                                                           ('30', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '[]', '2022-04-30 03:00:51', '2022-04-30 03:00:51'),
                                                                                                                           ('31', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '[]', '2022-04-30 03:02:25', '2022-04-30 03:02:25'),
                                                                                                                           ('32', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:02:32', '2022-04-30 03:02:32'),
                                                                                                                           ('33', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '[]', '2022-04-30 03:02:33', '2022-04-30 03:02:33'),
                                                                                                                           ('34', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '[]', '2022-04-30 03:03:52', '2022-04-30 03:03:52'),
                                                                                                                           ('35', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:03:57', '2022-04-30 03:03:57'),
                                                                                                                           ('36', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '[]', '2022-04-30 03:04:06', '2022-04-30 03:04:06'),
                                                                                                                           ('37', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:04:10', '2022-04-30 03:04:10'),
                                                                                                                           ('38', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:04:12', '2022-04-30 03:04:12'),
                                                                                                                           ('39', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 03:05:25', '2022-04-30 03:05:25'),
                                                                                                                           ('40', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:05:29', '2022-04-30 03:05:29'),
                                                                                                                           ('41', '1', 'admin/pipeline/1/edit', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:05:32', '2022-04-30 03:05:32'),
                                                                                                                           ('42', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 03:05:39', '2022-04-30 03:05:39'),
                                                                                                                           ('43', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '[]', '2022-04-30 11:06:44', '2022-04-30 11:06:44'),
                                                                                                                           ('44', '1', 'admin', 'GET', '172.20.0.7', '[]', '2022-04-30 11:16:07', '2022-04-30 11:16:07'),
                                                                                                                           ('45', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:16:12', '2022-04-30 11:16:12'),
                                                                                                                           ('46', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:16:40', '2022-04-30 11:16:40'),
                                                                                                                           ('47', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:18:12', '2022-04-30 11:18:12'),
                                                                                                                           ('48', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:20:58', '2022-04-30 11:20:58'),
                                                                                                                           ('49', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:21:31', '2022-04-30 11:21:31'),
                                                                                                                           ('50', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:21:35', '2022-04-30 11:21:35'),
                                                                                                                           ('51', '1', 'admin/pipeline/1', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:21:37', '2022-04-30 11:21:37'),
                                                                                                                           ('52', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:21:40', '2022-04-30 11:21:40'),
                                                                                                                           ('53', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:21:46', '2022-04-30 11:21:46'),
                                                                                                                           ('54', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:21:49', '2022-04-30 11:21:49'),
                                                                                                                           ('55', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:22:10', '2022-04-30 11:22:10'),
                                                                                                                           ('56', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:22:48', '2022-04-30 11:22:48'),
                                                                                                                           ('57', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:38:16', '2022-04-30 11:38:16'),
                                                                                                                           ('58', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:40:16', '2022-04-30 11:40:16'),
                                                                                                                           ('59', '1', 'admin/_handle_action_', 'POST', '172.20.0.7', '{"_key":"1","_model":"App_Models_Pipeline","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08","_action":"App_Admin_Actions_Pipeline_Trigger"}', '2022-04-30 11:40:19', '2022-04-30 11:40:19'),
                                                                                                                           ('60', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:40:19', '2022-04-30 11:40:19'),
                                                                                                                           ('61', '1', 'admin/_handle_action_', 'POST', '172.20.0.7', '{"_key":"1","_model":"App_Models_Pipeline","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08","_action":"App_Admin_Actions_Pipeline_Trigger"}', '2022-04-30 11:40:22', '2022-04-30 11:40:22'),
                                                                                                                           ('62', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 11:40:23', '2022-04-30 11:40:23'),
                                                                                                                           ('63', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:42:03', '2022-04-30 11:42:03'),
                                                                                                                           ('64', '1', 'admin/_handle_action_', 'POST', '172.20.0.7', '{"_key":"1","_model":"App_Models_Pipeline","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08","_action":"App_Admin_Actions_Pipeline_Trigger"}', '2022-04-30 11:42:06', '2022-04-30 11:42:06'),
                                                                                                                           ('65', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 11:42:22', '2022-04-30 11:42:22'),
                                                                                                                           ('66', '1', 'admin/_handle_action_', 'POST', '172.20.0.7', '{"_key":"1","_model":"App_Models_Pipeline","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08","_action":"App_Admin_Actions_Pipeline_Trigger"}', '2022-04-30 11:42:26', '2022-04-30 11:42:26'),
                                                                                                                           ('67', '1', 'admin/_handle_action_', 'POST', '172.20.0.7', '{"_key":"1","_model":"App_Models_Pipeline","_token":"1srdvX94Yhg434mjcHjZsG1cLmAEBx6qoTNulI08","_action":"App_Admin_Actions_Pipeline_Trigger"}', '2022-04-30 11:42:40', '2022-04-30 11:42:40'),
                                                                                                                           ('68', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:19:05', '2022-04-30 12:19:05'),
                                                                                                                           ('69', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:31:11', '2022-04-30 12:31:11'),
                                                                                                                           ('70', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:31:15', '2022-04-30 12:31:15'),
                                                                                                                           ('71', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:31:27', '2022-04-30 12:31:27'),
                                                                                                                           ('72', '1', 'admin/pipeline', 'GET', '172.20.0.7', '{"_pjax":"#pjax-container"}', '2022-04-30 12:31:45', '2022-04-30 12:31:45'),
                                                                                                                           ('73', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:31:46', '2022-04-30 12:31:46'),
                                                                                                                           ('74', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:32:27', '2022-04-30 12:32:27'),
                                                                                                                           ('75', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:32:37', '2022-04-30 12:32:37'),
                                                                                                                           ('76', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:32:56', '2022-04-30 12:32:56'),
                                                                                                                           ('77', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:33:10', '2022-04-30 12:33:10'),
                                                                                                                           ('78', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:33:30', '2022-04-30 12:33:30'),
                                                                                                                           ('79', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:33:34', '2022-04-30 12:33:34'),
                                                                                                                           ('80', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:33:41', '2022-04-30 12:33:41'),
                                                                                                                           ('81', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:33:55', '2022-04-30 12:33:55'),
                                                                                                                           ('82', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:34:03', '2022-04-30 12:34:03'),
                                                                                                                           ('83', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:34:26', '2022-04-30 12:34:26'),
                                                                                                                           ('84', '1', 'admin/pipeline', 'GET', '172.20.0.7', '[]', '2022-04-30 12:34:39', '2022-04-30 12:34:39');

INSERT INTO "uci"."admin_permissions" ("id", "name", "slug", "http_method", "http_path", "created_at", "updated_at") VALUES
                                                                                                                         ('1', 'All permission', '*', '', '*', NULL, NULL),
                                                                                                                         ('2', 'Dashboard', 'dashboard', 'GET', '/', NULL, NULL),
                                                                                                                         ('3', 'Login', 'auth.login', '', '/auth/login
/auth/logout', NULL, NULL),
                                                                                                                         ('4', 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', NULL, NULL),
                                                                                                                         ('5', 'Auth management', 'auth.management', '', '/auth/roles
/auth/permissions
/auth/menu
/auth/logs', NULL, NULL);

INSERT INTO "uci"."admin_role_menu" ("role_id", "menu_id", "created_at", "updated_at") VALUES
    ('1', '2', NULL, NULL);

INSERT INTO "uci"."admin_role_permissions" ("role_id", "permission_id", "created_at", "updated_at") VALUES
    ('1', '1', NULL, NULL);

INSERT INTO "uci"."admin_role_users" ("role_id", "user_id", "created_at", "updated_at") VALUES
    ('1', '1', NULL, NULL);

INSERT INTO "uci"."admin_roles" ("id", "name", "slug", "created_at", "updated_at") VALUES
    ('1', 'Administrator', 'administrator', '2022-04-29 07:13:39', '2022-04-29 07:13:39');

INSERT INTO "uci"."admin_users" ("id", "username", "password", "name", "avatar", "remember_token", "created_at", "updated_at") VALUES
    ('1', 'admin', '$2y$10$AntT1paDRQloknWVmYVlbOwVfONtykUpGKD47rFvaWVl59gF2xFze', 'Administrator', NULL, 'glpMT06BrU36BMzpCwjhIuSVwr8zN9kwe47LfGw4oNuCnNqo10nLoBCHlANZ', '2022-04-29 07:13:39', '2022-04-29 07:19:33');

INSERT INTO "uci"."migrations" ("id", "migration", "batch") VALUES
                                                                ('1', '2014_10_12_000000_create_users_table', '1'),
                                                                ('2', '2014_10_12_100000_create_password_resets_table', '1'),
                                                                ('3', '2016_01_04_173148_create_admin_tables', '1'),
                                                                ('4', '2019_08_19_000000_create_failed_jobs_table', '1'),
                                                                ('5', '2019_12_14_000001_create_personal_access_tokens_table', '1'),
                                                                ('7', '2022_04_29_075932_create_pipelines_table', '2');

INSERT INTO "uci"."pipelines" ("id", "name", "content", "created_at", "updated_at", "deleted_at") VALUES
    ('1', '123', '123', '2022-04-30 02:50:47', '2022-04-30 02:50:47', NULL);

