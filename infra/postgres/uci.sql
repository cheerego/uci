-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: uci
-- Generation Time: 2022-06-25 17:49:43.6500
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."admin_menu";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_menu_id_seq;

-- Table Definition
CREATE TABLE "public"."admin_menu" (
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

DROP TABLE IF EXISTS "public"."admin_operation_log";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_operation_log_id_seq;

-- Table Definition
CREATE TABLE "public"."admin_operation_log" (
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

DROP TABLE IF EXISTS "public"."admin_permissions";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_permissions_id_seq;

-- Table Definition
CREATE TABLE "public"."admin_permissions" (
    "id" int4 NOT NULL DEFAULT nextval('admin_permissions_id_seq'::regclass),
    "name" varchar(50) NOT NULL,
    "slug" varchar(50) NOT NULL,
    "http_method" varchar(255),
    "http_path" text,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."admin_role_menu";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."admin_role_menu" (
    "role_id" int4 NOT NULL,
    "menu_id" int4 NOT NULL,
    "created_at" timestamp(0),
    "updated_at" timestamp(0)
);

DROP TABLE IF EXISTS "public"."admin_role_permissions";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."admin_role_permissions" (
    "role_id" int4 NOT NULL,
    "permission_id" int4 NOT NULL,
    "created_at" timestamp(0),
    "updated_at" timestamp(0)
);

DROP TABLE IF EXISTS "public"."admin_role_users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."admin_role_users" (
    "role_id" int4 NOT NULL,
    "user_id" int4 NOT NULL,
    "created_at" timestamp(0),
    "updated_at" timestamp(0)
);

DROP TABLE IF EXISTS "public"."admin_roles";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_roles_id_seq;

-- Table Definition
CREATE TABLE "public"."admin_roles" (
    "id" int4 NOT NULL DEFAULT nextval('admin_roles_id_seq'::regclass),
    "name" varchar(50) NOT NULL,
    "slug" varchar(50) NOT NULL,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."admin_user_permissions";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."admin_user_permissions" (
    "user_id" int4 NOT NULL,
    "permission_id" int4 NOT NULL,
    "created_at" timestamp(0),
    "updated_at" timestamp(0)
);

DROP TABLE IF EXISTS "public"."admin_users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admin_users_id_seq;

-- Table Definition
CREATE TABLE "public"."admin_users" (
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

DROP TABLE IF EXISTS "public"."failed_jobs";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS failed_jobs_id_seq;

-- Table Definition
CREATE TABLE "public"."failed_jobs" (
    "id" int8 NOT NULL DEFAULT nextval('failed_jobs_id_seq'::regclass),
    "uuid" varchar(255) NOT NULL,
    "connection" text NOT NULL,
    "queue" text NOT NULL,
    "payload" text NOT NULL,
    "exception" text NOT NULL,
    "failed_at" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."migrations";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS migrations_id_seq;

-- Table Definition
CREATE TABLE "public"."migrations" (
    "id" int4 NOT NULL DEFAULT nextval('migrations_id_seq'::regclass),
    "migration" varchar(255) NOT NULL,
    "batch" int4 NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."password_resets";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."password_resets" (
    "email" varchar(255) NOT NULL,
    "token" varchar(255) NOT NULL,
    "created_at" timestamp(0)
);

DROP TABLE IF EXISTS "public"."personal_access_tokens";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS personal_access_tokens_id_seq;

-- Table Definition
CREATE TABLE "public"."personal_access_tokens" (
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

DROP TABLE IF EXISTS "public"."pipelines";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS pipelines_id_seq2;

-- Table Definition
CREATE TABLE "public"."pipelines" (
    "id" int8 NOT NULL DEFAULT nextval('pipelines_id_seq2'::regclass),
    "workflow_id" int4 NOT NULL,
    "number" int4 NOT NULL DEFAULT 0,
    "uuid" varchar(255) NOT NULL DEFAULT ''::character varying,
    "salt" varchar(255) NOT NULL DEFAULT ''::character varying,
    "yaml" text NOT NULL DEFAULT ''::text,
    "triggered_cause" text NOT NULL DEFAULT ''::text,
    "failed_cause" text NOT NULL DEFAULT ''::text,
    "status" varchar(255) NOT NULL DEFAULT 'BUILD_QUEUING'::character varying,
    "status_message" varchar(255) NOT NULL DEFAULT ''::character varying,
    "envs" json NOT NULL DEFAULT '[]'::json,
    "runner_id" int4 NOT NULL DEFAULT 0,
    "borrow_runner_at" timestamp(0),
    "release_runner_at" timestamp(0),
    "started_at" timestamp(0),
    "closed_at" timestamp(0),
    "duration" int4 NOT NULL DEFAULT 0,
    "raw_log" text NOT NULL DEFAULT ''::text,
    "prepare_log" text NOT NULL DEFAULT ''::text,
    "dispatch_times" int4 NOT NULL DEFAULT 0,
    "first_dispatched_at" timestamp(0),
    "last_dispatched_at" timestamp(0),
    "dispatch_succeed_at" timestamp(0),
    "time_consuming" json,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    "deleted_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."runners";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS runners_id_seq;

-- Table Definition
CREATE TABLE "public"."runners" (
    "id" int8 NOT NULL DEFAULT nextval('runners_id_seq'::regclass),
    "code" varchar(255) NOT NULL DEFAULT ''::character varying,
    "salt" varchar(255) NOT NULL DEFAULT ''::character varying,
    "status" varchar(255) NOT NULL DEFAULT '1'::character varying,
    "last_status_changed_at" timestamp(0),
    "last_dispatched_at" timestamp(0),
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    "deleted_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Table Definition
CREATE TABLE "public"."users" (
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

DROP TABLE IF EXISTS "public"."workflows";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS workflows_id_seq1;

-- Table Definition
CREATE TABLE "public"."workflows" (
    "id" int8 NOT NULL DEFAULT nextval('workflows_id_seq1'::regclass),
    "name" varchar(255) NOT NULL,
    "yaml" text NOT NULL,
    "creator_id" int4 NOT NULL,
    "envs" json NOT NULL DEFAULT '[]'::json,
    "latest_pipeline_id" int4 NOT NULL DEFAULT 0,
    "latest_success_pipeline_id" int4 NOT NULL DEFAULT 0,
    "max_concurrent" int4 NOT NULL DEFAULT 5,
    "build_timeout_second" int4 NOT NULL DEFAULT 1800,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    "deleted_at" timestamp(0),
    PRIMARY KEY ("id")
);

-- Column Comment
COMMENT ON COLUMN "public"."workflows"."latest_pipeline_id" IS '最后一次流水线 ID';
COMMENT ON COLUMN "public"."workflows"."latest_success_pipeline_id" IS '最后一次成功构建流水线 ID';
COMMENT ON COLUMN "public"."workflows"."build_timeout_second" IS '构建超时时间';

INSERT INTO "public"."admin_menu" ("id", "parent_id", "order", "title", "icon", "uri", "permission", "created_at", "updated_at") VALUES
('1', '0', '1', 'Dashboard', 'fa-bar-chart', '/', NULL, NULL, NULL),
('2', '0', '2', 'Admin', 'fa-tasks', '', NULL, NULL, NULL),
('3', '2', '3', 'Users', 'fa-users', 'auth/users', NULL, NULL, NULL),
('4', '2', '4', 'Roles', 'fa-user', 'auth/roles', NULL, NULL, NULL),
('5', '2', '5', 'Permission', 'fa-ban', 'auth/permissions', NULL, NULL, NULL),
('6', '2', '6', 'Menu', 'fa-bars', 'auth/menu', NULL, NULL, NULL),
('7', '2', '7', 'Operation log', 'fa-history', 'auth/logs', NULL, NULL, NULL),
('8', '0', '0', 'Workflow', 'fa-bars', '/workflows', NULL, '2022-05-28 15:13:31', '2022-05-28 15:13:31'),
('9', '0', '0', 'Pipeline', 'fa-bars', '/pipelines', NULL, '2022-05-28 15:13:45', '2022-05-28 15:13:45');

INSERT INTO "public"."admin_operation_log" ("id", "user_id", "path", "method", "ip", "input", "created_at", "updated_at") VALUES
('60', '1', 'admin/workflows/2/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 16:24:59', '2022-06-10 16:24:59'),
('61', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-10 16:25:18', '2022-06-10 16:25:18'),
('62', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 16:25:21', '2022-06-10 16:25:21'),
('63', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 16:25:23', '2022-06-10 16:25:23'),
('64', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '[]', '2022-06-10 16:25:58', '2022-06-10 16:25:58'),
('65', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":null,"envs":{"new_1":{"key":"echo","value":"123","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 16:26:11', '2022-06-10 16:26:11'),
('66', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '[]', '2022-06-10 16:26:11', '2022-06-10 16:26:11'),
('67', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":null,"envs":{"new_1":{"key":"echo","value":"123","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 16:26:26', '2022-06-10 16:26:26'),
('68', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 16:26:26', '2022-06-10 16:26:26'),
('69', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 16:26:56', '2022-06-10 16:26:56'),
('70', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 16:27:05', '2022-06-10 16:27:05'),
('71', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"echo","value":"123","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 16:29:48', '2022-06-10 16:29:48'),
('72', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 16:29:49', '2022-06-10 16:29:49'),
('73', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 16:29:57', '2022-06-10 16:29:57'),
('74', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"echo","value":"123","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 16:29:59', '2022-06-10 16:29:59'),
('75', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 16:30:00', '2022-06-10 16:30:00'),
('76', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 16:30:38', '2022-06-10 16:30:38'),
('77', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 16:30:40', '2022-06-10 16:30:40'),
('78', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"echo","value":"123","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 16:30:43', '2022-06-10 16:30:43'),
('79', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 16:30:43', '2022-06-10 16:30:43'),
('80', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:39:42', '2022-06-10 17:39:42'),
('81', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":[{"key":"echo","value":"123","_remove_":"1"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:39:46', '2022-06-10 17:39:46'),
('82', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:39:46', '2022-06-10 17:39:46'),
('83', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:39:52', '2022-06-10 17:39:52'),
('84', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"\u963f\u65af\u8482\u82ac","value":"\u963f\u65af\u8482\u82ac","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:40:11', '2022-06-10 17:40:11'),
('85', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:40:12', '2022-06-10 17:40:12'),
('86', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:41:32', '2022-06-10 17:41:32'),
('87', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"\u963f\u9053\u592b","value":"\u554a\u4efd","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:41:39', '2022-06-10 17:41:39'),
('88', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:41:40', '2022-06-10 17:41:40'),
('89', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:41:59', '2022-06-10 17:41:59'),
('90', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"asdf","value":"asdf","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:46:08', '2022-06-10 17:46:08'),
('91', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:46:09', '2022-06-10 17:46:09'),
('92', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:46:14', '2022-06-10 17:46:14'),
('93', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"1"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:47:38', '2022-06-10 17:47:38'),
('94', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:47:39', '2022-06-10 17:47:39'),
('95', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:47:43', '2022-06-10 17:47:43'),
('96', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"new_1":{"key":"asdf","value":"asdf","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:47:48', '2022-06-10 17:47:48'),
('97', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:47:49', '2022-06-10 17:47:49'),
('98', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:47:53', '2022-06-10 17:47:53'),
('99', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":"1","envs":{"0":{"key":"asdf","value":"asdf","_remove_":"0"},"new_1":{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 17:48:42', '2022-06-10 17:48:42'),
('100', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:48:43', '2022-06-10 17:48:43'),
('101', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:49:09', '2022-06-10 17:49:09'),
('102', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:49:12', '2022-06-10 17:49:12'),
('103', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:50:05', '2022-06-10 17:50:05'),
('104', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:50:10', '2022-06-10 17:50:10'),
('105', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '[]', '2022-06-10 17:50:28', '2022-06-10 17:50:28'),
('106', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:50:31', '2022-06-10 17:50:31'),
('107', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:50:32', '2022-06-10 17:50:32'),
('108', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:51:24', '2022-06-10 17:51:24'),
('109', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:52:02', '2022-06-10 17:52:02'),
('110', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:52:25', '2022-06-10 17:52:25'),
('111', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-10 17:52:33', '2022-06-10 17:52:33'),
('112', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:52:37', '2022-06-10 17:52:37'),
('113', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:52:52', '2022-06-10 17:52:52'),
('114', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:53:10', '2022-06-10 17:53:10'),
('115', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 17:53:42', '2022-06-10 17:53:42'),
('116', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 17:53:48', '2022-06-10 17:53:48'),
('117', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 17:53:49', '2022-06-10 17:53:49'),
('118', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 17:53:51', '2022-06-10 17:53:51'),
('119', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 17:53:52', '2022-06-10 17:53:52'),
('120', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 17:54:35', '2022-06-10 17:54:35'),
('121', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 17:55:57', '2022-06-10 17:55:57'),
('122', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 17:55:57', '2022-06-10 17:55:57'),
('123', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 17:56:21', '2022-06-10 17:56:21'),
('124', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 17:56:24', '2022-06-10 17:56:24'),
('125', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 17:56:25', '2022-06-10 17:56:25'),
('126', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 17:56:42', '2022-06-10 17:56:42'),
('127', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 17:56:43', '2022-06-10 17:56:43'),
('128', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 18:58:22', '2022-06-10 18:58:22'),
('129', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 18:58:23', '2022-06-10 18:58:23'),
('130', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:33:32', '2022-06-10 19:33:32'),
('131', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:33:33', '2022-06-10 19:33:33'),
('132', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"asdf","value":"asdf","_remove_":"0"},{"key":"asdfasdfasd","value":"asdf","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:34:43', '2022-06-10 19:34:43'),
('133', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:44', '2022-06-10 19:34:44'),
('134', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:45', '2022-06-10 19:34:45'),
('135', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:45', '2022-06-10 19:34:45'),
('136', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:46', '2022-06-10 19:34:46'),
('137', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:46', '2022-06-10 19:34:46'),
('138', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:47', '2022-06-10 19:34:47'),
('139', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:47', '2022-06-10 19:34:47'),
('140', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:48', '2022-06-10 19:34:48'),
('141', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:49', '2022-06-10 19:34:49'),
('142', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:49', '2022-06-10 19:34:49'),
('143', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:50', '2022-06-10 19:34:50'),
('144', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:50', '2022-06-10 19:34:50'),
('145', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:51', '2022-06-10 19:34:51'),
('146', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:53', '2022-06-10 19:34:53'),
('147', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 19:34:55', '2022-06-10 19:34:55'),
('148', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 19:34:58', '2022-06-10 19:34:58'),
('149', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 19:35:09', '2022-06-10 19:35:09'),
('150', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '[]', '2022-06-10 19:35:14', '2022-06-10 19:35:14'),
('151', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-123","yaml":"echo 123","creator_id":null,"envs":{"new_1":{"key":"hekangning1","value":"666","_remove_":"0"},"new_2":{"key":"hekangning2","value":"777","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 19:35:32', '2022-06-10 19:35:32'),
('152', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 19:35:33', '2022-06-10 19:35:33'),
('153', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 19:35:37', '2022-06-10 19:35:37'),
('154', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 19:35:38', '2022-06-10 19:35:38'),
('155', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:35:40', '2022-06-10 19:35:40'),
('156', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:35:40', '2022-06-10 19:35:40'),
('157', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:39:14', '2022-06-10 19:39:14'),
('158', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:39:15', '2022-06-10 19:39:15'),
('159', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:41:38', '2022-06-10 19:41:38'),
('160', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:41:39', '2022-06-10 19:41:39'),
('161', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:41:53', '2022-06-10 19:41:53'),
('162', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:41:54', '2022-06-10 19:41:54'),
('163', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:42:45', '2022-06-10 19:42:45'),
('164', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:42:46', '2022-06-10 19:42:46'),
('165', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:46:45', '2022-06-10 19:46:45'),
('166', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:46:46', '2022-06-10 19:46:46'),
('167', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:51:00', '2022-06-10 19:51:00'),
('168', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:51:01', '2022-06-10 19:51:01'),
('169', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"},{"key":"hekangning2","value":"777","_remove_":"1"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:51:08', '2022-06-10 19:51:08'),
('170', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:51:08', '2022-06-10 19:51:08'),
('171', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning1","value":"666","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:52:15', '2022-06-10 19:52:15'),
('172', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:15', '2022-06-10 19:52:15'),
('173', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:16', '2022-06-10 19:52:16'),
('174', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:17', '2022-06-10 19:52:17'),
('175', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:17', '2022-06-10 19:52:17'),
('176', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:18', '2022-06-10 19:52:18'),
('177', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:18', '2022-06-10 19:52:18'),
('178', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:19', '2022-06-10 19:52:19'),
('179', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:19', '2022-06-10 19:52:19'),
('180', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:20', '2022-06-10 19:52:20'),
('181', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:21', '2022-06-10 19:52:21'),
('182', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:21', '2022-06-10 19:52:21'),
('183', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:22', '2022-06-10 19:52:22'),
('184', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:22', '2022-06-10 19:52:22'),
('185', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:23', '2022-06-10 19:52:23'),
('186', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:24', '2022-06-10 19:52:24'),
('187', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:24', '2022-06-10 19:52:24'),
('188', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:25', '2022-06-10 19:52:25'),
('189', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:25', '2022-06-10 19:52:25'),
('190', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:26', '2022-06-10 19:52:26'),
('191', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:52:26', '2022-06-10 19:52:26'),
('192', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 19:52:47', '2022-06-10 19:52:47'),
('193', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 19:52:49', '2022-06-10 19:52:49'),
('194', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-1","yaml":"echo 123","creator_id":null,"envs":{"new_1":{"key":"hekangning123","value":"123","_remove_":"0"},"new_2":{"key":"hekangning456","value":"456","_remove_":"0"}},"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 19:53:05', '2022-06-10 19:53:05'),
('195', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 19:53:06', '2022-06-10 19:53:06'),
('196', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 19:53:09', '2022-06-10 19:53:09'),
('197', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 19:53:10', '2022-06-10 19:53:10'),
('198', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:53:13', '2022-06-10 19:53:13'),
('199', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:53:13', '2022-06-10 19:53:13'),
('200', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:53:42', '2022-06-10 19:53:42'),
('201', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:53:43', '2022-06-10 19:53:43'),
('202', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 19:58:54', '2022-06-10 19:58:54'),
('203', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 19:58:55', '2022-06-10 19:58:55'),
('204', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:02:57', '2022-06-10 20:02:57'),
('205', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:02:58', '2022-06-10 20:02:58'),
('206', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-10 20:35:44', '2022-06-10 20:35:44'),
('207', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:35:48', '2022-06-10 20:35:48'),
('208', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 20:35:51', '2022-06-10 20:35:51'),
('209', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:35:51', '2022-06-10 20:35:51'),
('210', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:35:54', '2022-06-10 20:35:54'),
('211', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:35:54', '2022-06-10 20:35:54'),
('212', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:38:29', '2022-06-10 20:38:29'),
('213', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:38:30', '2022-06-10 20:38:30'),
('214', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:40:01', '2022-06-10 20:40:01'),
('215', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:46:32', '2022-06-10 20:46:32'),
('216', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:46:41', '2022-06-10 20:46:41'),
('217', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 20:46:46', '2022-06-10 20:46:46'),
('218', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:46:46', '2022-06-10 20:46:46'),
('219', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:47:01', '2022-06-10 20:47:01'),
('220', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:47:04', '2022-06-10 20:47:04'),
('221', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 20:47:10', '2022-06-10 20:47:10'),
('222', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 20:47:10', '2022-06-10 20:47:10'),
('223', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 20:47:14', '2022-06-10 20:47:14'),
('224', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 20:47:14', '2022-06-10 20:47:14'),
('225', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:47:16', '2022-06-10 20:47:16'),
('226', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:47:17', '2022-06-10 20:47:17'),
('227', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:47:50', '2022-06-10 20:47:50'),
('228', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:47:50', '2022-06-10 20:47:50'),
('229', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:48:15', '2022-06-10 20:48:15'),
('230', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:48:15', '2022-06-10 20:48:15'),
('231', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"hekangning 6666","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 20:48:32', '2022-06-10 20:48:32'),
('232', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 20:48:33', '2022-06-10 20:48:33'),
('233', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 21:22:33', '2022-06-10 21:22:33'),
('234', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 21:22:36', '2022-06-10 21:22:36'),
('235', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-10 21:22:47', '2022-06-10 21:22:47'),
('236', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 21:22:47', '2022-06-10 21:22:47'),
('237', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 21:22:51', '2022-06-10 21:22:51'),
('238', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 21:23:01', '2022-06-10 21:23:01'),
('239', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 21:23:01', '2022-06-10 21:23:01'),
('240', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:23:03', '2022-06-10 21:23:03'),
('241', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:23:04', '2022-06-10 21:23:04'),
('242', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:24:18', '2022-06-10 21:24:18'),
('243', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:24:19', '2022-06-10 21:24:19'),
('244', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:24:26', '2022-06-10 21:24:26'),
('245', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:24:26', '2022-06-10 21:24:26'),
('246', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:25:16', '2022-06-10 21:25:16'),
('247', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:25:17', '2022-06-10 21:25:17'),
('248', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:29:12', '2022-06-10 21:29:12'),
('249', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:29:12', '2022-06-10 21:29:12'),
('250', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:30:27', '2022-06-10 21:30:27'),
('251', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:30:27', '2022-06-10 21:30:27'),
('252', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-10 21:39:36', '2022-06-10 21:39:36'),
('253', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-10 21:39:39', '2022-06-10 21:39:39'),
('254', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-10 21:39:43', '2022-06-10 21:39:43'),
('255', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-10 21:39:43', '2022-06-10 21:39:43'),
('256', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:39:45', '2022-06-10 21:39:45'),
('257', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:39:46', '2022-06-10 21:39:46'),
('258', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:40:17', '2022-06-10 21:40:17'),
('259', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:40:18', '2022-06-10 21:40:18'),
('260', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:41:57', '2022-06-10 21:41:57'),
('261', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:41:58', '2022-06-10 21:41:58'),
('262', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:42:29', '2022-06-10 21:42:29'),
('263', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:42:30', '2022-06-10 21:42:30'),
('264', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:51:14', '2022-06-10 21:51:14'),
('265', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:51:14', '2022-06-10 21:51:14'),
('266', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:52:51', '2022-06-10 21:52:51'),
('267', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:52:51', '2022-06-10 21:52:51'),
('268', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:52:56', '2022-06-10 21:52:56'),
('269', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:52:57', '2022-06-10 21:52:57'),
('270', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 21:56:25', '2022-06-10 21:56:25'),
('271', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 21:56:26', '2022-06-10 21:56:26'),
('272', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 23:24:55', '2022-06-10 23:24:55'),
('273', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 23:24:55', '2022-06-10 23:24:55'),
('274', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 23:27:39', '2022-06-10 23:27:39'),
('275', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 23:27:40', '2022-06-10 23:27:40'),
('276', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 23:48:55', '2022-06-10 23:48:55'),
('277', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 23:48:55', '2022-06-10 23:48:55'),
('278', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-10 23:58:31', '2022-06-10 23:58:31'),
('279', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-10 23:58:32', '2022-06-10 23:58:32'),
('280', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:05:51', '2022-06-11 00:05:51'),
('281', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:05:52', '2022-06-11 00:05:52'),
('282', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:06:23', '2022-06-11 00:06:23'),
('283', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:06:24', '2022-06-11 00:06:24'),
('284', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:06:43', '2022-06-11 00:06:43'),
('285', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:06:44', '2022-06-11 00:06:44'),
('286', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:11:01', '2022-06-11 00:11:01'),
('287', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:11:02', '2022-06-11 00:11:02'),
('288', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:13:20', '2022-06-11 00:13:20'),
('289', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:13:20', '2022-06-11 00:13:20'),
('290', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:14:00', '2022-06-11 00:14:00'),
('291', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:14:01', '2022-06-11 00:14:01'),
('292', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:19:56', '2022-06-11 00:19:56'),
('293', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:19:57', '2022-06-11 00:19:57'),
('294', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:20:53', '2022-06-11 00:20:53'),
('295', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:20:56', '2022-06-11 00:20:56'),
('296', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"sleep 6\r\necho $hekangning123\r\nsleep 6\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 00:21:53', '2022-06-11 00:21:53'),
('297', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 00:21:53', '2022-06-11 00:21:53'),
('298', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 00:21:57', '2022-06-11 00:21:57'),
('299', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:21:58', '2022-06-11 00:21:58'),
('300', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:22:00', '2022-06-11 00:22:00'),
('301', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:22:01', '2022-06-11 00:22:01'),
('302', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:22:40', '2022-06-11 00:22:40'),
('303', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:22:42', '2022-06-11 00:22:42'),
('304', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"sleep 6\r\necho $hekangning123\r\nsleep 6\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 00:23:00', '2022-06-11 00:23:00'),
('305', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 00:23:00', '2022-06-11 00:23:00'),
('306', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 00:23:05', '2022-06-11 00:23:05'),
('307', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:23:06', '2022-06-11 00:23:06'),
('308', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:23:08', '2022-06-11 00:23:08'),
('309', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:23:08', '2022-06-11 00:23:08'),
('310', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 00:25:08', '2022-06-11 00:25:08'),
('311', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 00:25:09', '2022-06-11 00:25:09'),
('312', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 00:25:25', '2022-06-11 00:25:25'),
('313', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 01:08:34', '2022-06-11 01:08:34'),
('314', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:08:35', '2022-06-11 01:08:35'),
('315', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:08:37', '2022-06-11 01:08:37'),
('316', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:08:38', '2022-06-11 01:08:38'),
('317', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:10:03', '2022-06-11 01:10:03'),
('318', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:10:04', '2022-06-11 01:10:04'),
('319', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:10:57', '2022-06-11 01:10:57'),
('320', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:10:58', '2022-06-11 01:10:58'),
('321', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:11:42', '2022-06-11 01:11:42'),
('322', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:11:43', '2022-06-11 01:11:43'),
('323', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:12:14', '2022-06-11 01:12:14'),
('324', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:12:15', '2022-06-11 01:12:15'),
('325', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:13:10', '2022-06-11 01:13:10'),
('326', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:13:11', '2022-06-11 01:13:11'),
('327', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:13:22', '2022-06-11 01:13:22'),
('328', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:13:25', '2022-06-11 01:13:25'),
('329', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $hekangning123\r\n\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 01:13:30', '2022-06-11 01:13:30'),
('330', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 01:13:30', '2022-06-11 01:13:30'),
('331', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 01:13:38', '2022-06-11 01:13:38'),
('332', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:13:39', '2022-06-11 01:13:39'),
('333', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:13:43', '2022-06-11 01:13:43'),
('334', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:13:44', '2022-06-11 01:13:44'),
('335', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:16:00', '2022-06-11 01:16:00'),
('336', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:16:00', '2022-06-11 01:16:00'),
('337', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:16:04', '2022-06-11 01:16:04'),
('338', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-11 01:16:06', '2022-06-11 01:16:06'),
('339', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:16:10', '2022-06-11 01:16:10'),
('340', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-11 01:16:11', '2022-06-11 01:16:11'),
('341', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:18:16', '2022-06-11 01:18:16'),
('342', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 01:18:19', '2022-06-11 01:18:19'),
('343', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 01:18:19', '2022-06-11 01:18:19'),
('344', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 01:18:34', '2022-06-11 01:18:34'),
('345', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 01:18:35', '2022-06-11 01:18:35'),
('346', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:13:08', '2022-06-11 02:13:08'),
('347', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:13:08', '2022-06-11 02:13:08'),
('348', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:13:58', '2022-06-11 02:13:58'),
('349', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:13:58', '2022-06-11 02:13:58'),
('350', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:16:41', '2022-06-11 02:16:41'),
('351', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:16:42', '2022-06-11 02:16:42'),
('352', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 02:16:47', '2022-06-11 02:16:47'),
('353', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 02:16:50', '2022-06-11 02:16:50'),
('354', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $hekangning123\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 02:16:55', '2022-06-11 02:16:55'),
('355', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 02:16:56', '2022-06-11 02:16:56'),
('356', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 02:17:24', '2022-06-11 02:17:24'),
('357', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 02:17:25', '2022-06-11 02:17:25'),
('358', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:17:32', '2022-06-11 02:17:32'),
('359', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:17:33', '2022-06-11 02:17:33'),
('360', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:19:10', '2022-06-11 02:19:10'),
('361', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:19:11', '2022-06-11 02:19:11'),
('362', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:19:53', '2022-06-11 02:19:53'),
('363', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:19:54', '2022-06-11 02:19:54'),
('364', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:20:01', '2022-06-11 02:20:01'),
('365', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:20:01', '2022-06-11 02:20:01'),
('366', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:20:08', '2022-06-11 02:20:08'),
('367', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:20:09', '2022-06-11 02:20:09'),
('368', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 02:20:11', '2022-06-11 02:20:11'),
('369', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 02:20:13', '2022-06-11 02:20:13'),
('370', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $hekangning123\r\n\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 02:20:16', '2022-06-11 02:20:16'),
('371', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 02:20:17', '2022-06-11 02:20:17'),
('372', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 02:20:24', '2022-06-11 02:20:24'),
('373', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 02:20:24', '2022-06-11 02:20:24'),
('374', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:20:26', '2022-06-11 02:20:26'),
('375', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:20:27', '2022-06-11 02:20:27'),
('376', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:28:44', '2022-06-11 02:28:44'),
('377', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:28:45', '2022-06-11 02:28:45'),
('378', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:28:56', '2022-06-11 02:28:56'),
('379', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:28:57', '2022-06-11 02:28:57'),
('380', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:29:01', '2022-06-11 02:29:01'),
('381', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:29:02', '2022-06-11 02:29:02'),
('382', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:30:09', '2022-06-11 02:30:09'),
('383', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:30:09', '2022-06-11 02:30:09'),
('384', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:30:27', '2022-06-11 02:30:27'),
('385', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:30:28', '2022-06-11 02:30:28'),
('386', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"BitVplgKrhDowP8Qj3APy8UfiKaRxYGkBey5M01M"}', '2022-06-11 02:32:15', '2022-06-11 02:32:15'),
('387', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 02:32:16', '2022-06-11 02:32:16'),
('388', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 12:40:55', '2022-06-11 12:40:55'),
('389', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:40:58', '2022-06-11 12:40:58'),
('390', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:41:02', '2022-06-11 12:41:02'),
('391', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:41:28', '2022-06-11 12:41:28'),
('392', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"gxzS9rHv9aIw81w8YMKY8S1XOHVKgjz7ZWXuhEya","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 12:41:31', '2022-06-11 12:41:31'),
('393', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:41:31', '2022-06-11 12:41:31'),
('394', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"gxzS9rHv9aIw81w8YMKY8S1XOHVKgjz7ZWXuhEya"}', '2022-06-11 12:41:33', '2022-06-11 12:41:33'),
('395', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 12:41:34', '2022-06-11 12:41:34'),
('396', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:41:41', '2022-06-11 12:41:41'),
('397', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:41:43', '2022-06-11 12:41:43'),
('398', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"sleep 6\r\necho $hekangning123\r\nsleep 6\r\necho $hekangning123","creator_id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"gxzS9rHv9aIw81w8YMKY8S1XOHVKgjz7ZWXuhEya","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 12:42:00', '2022-06-11 12:42:00'),
('399', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 12:42:01', '2022-06-11 12:42:01'),
('400', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"gxzS9rHv9aIw81w8YMKY8S1XOHVKgjz7ZWXuhEya","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 12:42:04', '2022-06-11 12:42:04'),
('401', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 12:42:04', '2022-06-11 12:42:04'),
('402', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hekangning123","value":"123","_remove_":"0"},{"key":"hekangning456","value":"456","_remove_":"0"}],"_token":"gxzS9rHv9aIw81w8YMKY8S1XOHVKgjz7ZWXuhEya"}', '2022-06-11 12:42:06', '2022-06-11 12:42:06'),
('403', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 12:42:07', '2022-06-11 12:42:07'),
('404', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-11 17:20:45', '2022-06-11 17:20:45'),
('405', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 17:20:47', '2022-06-11 17:20:47'),
('406', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 17:20:49', '2022-06-11 17:20:49'),
('407', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 17:20:51', '2022-06-11 17:20:51'),
('408', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"hekangning-test","yaml":"echo 123123123\r\necho $hkn","creator_id":null,"envs":{"new_1":{"key":"hkn","value":"666","_remove_":"0"}},"_token":"VOvc4rizQFQoBEx2nziAn6d4v8Dll8lTYWIHEF02","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-11 17:21:27', '2022-06-11 17:21:27'),
('409', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-11 17:21:27', '2022-06-11 17:21:27'),
('410', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"VOvc4rizQFQoBEx2nziAn6d4v8Dll8lTYWIHEF02","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-11 17:21:30', '2022-06-11 17:21:30'),
('411', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-11 17:21:31', '2022-06-11 17:21:31'),
('412', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"VOvc4rizQFQoBEx2nziAn6d4v8Dll8lTYWIHEF02"}', '2022-06-11 17:21:33', '2022-06-11 17:21:33'),
('413', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-11 17:21:34', '2022-06-11 17:21:34'),
('414', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-12 22:40:46', '2022-06-12 22:40:46'),
('415', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:40:49', '2022-06-12 22:40:49'),
('416', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-12 22:40:51', '2022-06-12 22:40:51'),
('417', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:40:52', '2022-06-12 22:40:52'),
('418', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 22:40:54', '2022-06-12 22:40:54'),
('419', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:40:55', '2022-06-12 22:40:55'),
('420', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:43:56', '2022-06-12 22:43:56'),
('421', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 22:43:59', '2022-06-12 22:43:59'),
('422', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:44:00', '2022-06-12 22:44:00'),
('423', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:45:20', '2022-06-12 22:45:20'),
('424', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 22:45:22', '2022-06-12 22:45:22'),
('425', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:45:23', '2022-06-12 22:45:23'),
('426', '1', 'admin', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:45:44', '2022-06-12 22:45:44'),
('427', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:46:30', '2022-06-12 22:46:30'),
('428', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:46:36', '2022-06-12 22:46:36'),
('429', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-12 22:46:37', '2022-06-12 22:46:37'),
('430', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:47:50', '2022-06-12 22:47:50'),
('431', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-12 22:47:50', '2022-06-12 22:47:50'),
('432', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-12 22:48:01', '2022-06-12 22:48:01'),
('433', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:48:05', '2022-06-12 22:48:05'),
('434', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '[]', '2022-06-12 22:48:17', '2022-06-12 22:48:17'),
('435', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '[]', '2022-06-12 22:48:52', '2022-06-12 22:48:52'),
('436', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '[]', '2022-06-12 22:49:09', '2022-06-12 22:49:09'),
('437', '1', 'admin/workflows/1', 'GET', '172.21.0.8', '[]', '2022-06-12 22:50:35', '2022-06-12 22:50:35'),
('438', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:50:37', '2022-06-12 22:50:37'),
('439', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-12 22:50:42', '2022-06-12 22:50:42'),
('440', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-12 22:50:43', '2022-06-12 22:50:43'),
('441', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 22:50:44', '2022-06-12 22:50:44'),
('442', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:50:45', '2022-06-12 22:50:45'),
('443', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 22:59:13', '2022-06-12 22:59:13'),
('444', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:59:14', '2022-06-12 22:59:14'),
('445', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 22:59:41', '2022-06-12 22:59:41'),
('446', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 22:59:42', '2022-06-12 22:59:42'),
('447', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 23:01:18', '2022-06-12 23:01:18'),
('448', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 23:01:19', '2022-06-12 23:01:19'),
('449', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 23:06:17', '2022-06-12 23:06:17'),
('450', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 23:06:18', '2022-06-12 23:06:18'),
('451', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 23:07:08', '2022-06-12 23:07:08'),
('452', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 23:07:08', '2022-06-12 23:07:08'),
('453', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-12 23:57:51', '2022-06-12 23:57:51'),
('454', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-12 23:57:52', '2022-06-12 23:57:52'),
('455', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Uxjdk3TLYlq7hlJ0u9MR9T7gO9R4wZ4wvFhCsfsF"}', '2022-06-13 00:00:22', '2022-06-13 00:00:22'),
('456', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 00:00:23', '2022-06-13 00:00:23'),
('457', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-13 10:52:17', '2022-06-13 10:52:17'),
('458', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 10:52:21', '2022-06-13 10:52:21'),
('459', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 10:52:24', '2022-06-13 10:52:24'),
('460', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-13 10:59:09', '2022-06-13 10:59:09'),
('461', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 10:59:13', '2022-06-13 10:59:13'),
('462', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 10:59:16', '2022-06-13 10:59:16'),
('463', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 10:59:16', '2022-06-13 10:59:16'),
('464', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 11:41:52', '2022-06-13 11:41:52'),
('465', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 11:41:53', '2022-06-13 11:41:53'),
('466', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 11:42:43', '2022-06-13 11:42:43'),
('467', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 11:42:44', '2022-06-13 11:42:44'),
('468', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 11:43:11', '2022-06-13 11:43:11'),
('469', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 11:43:12', '2022-06-13 11:43:12'),
('470', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 11:43:13', '2022-06-13 11:43:13'),
('471', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 11:43:40', '2022-06-13 11:43:40'),
('472', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 11:43:44', '2022-06-13 11:43:44'),
('473', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 11:43:45', '2022-06-13 11:43:45'),
('474', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:12:49', '2022-06-13 13:12:49'),
('475', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:12:50', '2022-06-13 13:12:50'),
('476', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:12:55', '2022-06-13 13:12:55'),
('477', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:12:56', '2022-06-13 13:12:56'),
('478', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:13:54', '2022-06-13 13:13:54'),
('479', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:13:55', '2022-06-13 13:13:55'),
('480', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"666","_remove_":"0"}],"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:17:11', '2022-06-13 13:17:11'),
('481', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:17:12', '2022-06-13 13:17:12'),
('482', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:27:12', '2022-06-13 13:27:12'),
('483', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:27:34', '2022-06-13 13:27:34'),
('484', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-13 13:27:38', '2022-06-13 13:27:38'),
('485', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:27:41', '2022-06-13 13:27:41'),
('486', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-123","yaml":"echo hekangning","creator_id":null,"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-13 13:27:50', '2022-06-13 13:27:50'),
('487', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-13 13:27:50', '2022-06-13 13:27:50'),
('488', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 13:27:55', '2022-06-13 13:27:55'),
('489', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:27:56', '2022-06-13 13:27:56'),
('490', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:27:58', '2022-06-13 13:27:58'),
('491', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:27:58', '2022-06-13 13:27:58'),
('492', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:28:45', '2022-06-13 13:28:45'),
('493', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:28:46', '2022-06-13 13:28:46'),
('494', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:30:32', '2022-06-13 13:30:32'),
('495', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:30:33', '2022-06-13 13:30:33'),
('496', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:32:05', '2022-06-13 13:32:05'),
('497', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:32:06', '2022-06-13 13:32:06'),
('498', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:35:50', '2022-06-13 13:35:50'),
('499', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-13 13:35:55', '2022-06-13 13:35:55'),
('500', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:35:58', '2022-06-13 13:35:58'),
('501', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-123","yaml":"test-123","creator_id":null,"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-13 13:36:06', '2022-06-13 13:36:06'),
('502', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-13 13:36:07', '2022-06-13 13:36:07'),
('503', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 13:36:11', '2022-06-13 13:36:11'),
('504', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:36:11', '2022-06-13 13:36:11'),
('505', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:36:14', '2022-06-13 13:36:14'),
('506', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:36:14', '2022-06-13 13:36:14'),
('507', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:39:41', '2022-06-13 13:39:41'),
('508', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:39:42', '2022-06-13 13:39:42'),
('509', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:40:26', '2022-06-13 13:40:26'),
('510', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:40:26', '2022-06-13 13:40:26'),
('511', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:40:41', '2022-06-13 13:40:41'),
('512', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:40:42', '2022-06-13 13:40:42'),
('513', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:42:42', '2022-06-13 13:42:42'),
('514', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:42:43', '2022-06-13 13:42:43'),
('515', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:42:45', '2022-06-13 13:42:45'),
('516', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:42:49', '2022-06-13 13:42:49'),
('517', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:43:51', '2022-06-13 13:43:51'),
('518', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 13:43:56', '2022-06-13 13:43:56'),
('519', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:43:57', '2022-06-13 13:43:57'),
('520', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:46:07', '2022-06-13 13:46:07'),
('521', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:46:10', '2022-06-13 13:46:10'),
('522', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-123","yaml":"echo 23424234","creator_id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-13 13:46:15', '2022-06-13 13:46:15'),
('523', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-13 13:46:15', '2022-06-13 13:46:15'),
('524', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 13:46:18', '2022-06-13 13:46:18'),
('525', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 13:46:18', '2022-06-13 13:46:18'),
('526', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 13:46:20', '2022-06-13 13:46:20'),
('527', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 13:46:21', '2022-06-13 13:46:21'),
('528', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 15:02:51', '2022-06-13 15:02:51'),
('529', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 15:02:52', '2022-06-13 15:02:52'),
('530', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:30:55', '2022-06-13 15:30:55'),
('531', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:31:00', '2022-06-13 15:31:00'),
('532', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-1","yaml":"echo 1312313","creator_id":null,"_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-13 15:31:08', '2022-06-13 15:31:08'),
('533', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-13 15:31:08', '2022-06-13 15:31:08'),
('534', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 15:31:12', '2022-06-13 15:31:12'),
('535', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:31:12', '2022-06-13 15:31:12'),
('536', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:31:15', '2022-06-13 15:31:15'),
('537', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-13 15:31:18', '2022-06-13 15:31:18'),
('538', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:31:28', '2022-06-13 15:31:28'),
('539', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 15:31:31', '2022-06-13 15:31:31'),
('540', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:31:32', '2022-06-13 15:31:32'),
('541', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 15:31:34', '2022-06-13 15:31:34'),
('542', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 15:31:35', '2022-06-13 15:31:35'),
('543', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 15:31:47', '2022-06-13 15:31:47'),
('544', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 15:31:48', '2022-06-13 15:31:48'),
('545', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 15:37:35', '2022-06-13 15:37:35'),
('546', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:38:14', '2022-06-13 15:38:14'),
('547', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:38:15', '2022-06-13 15:38:15'),
('548', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:38:26', '2022-06-13 15:38:26'),
('549', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-13 15:38:31', '2022-06-13 15:38:31'),
('550', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-13 15:38:32', '2022-06-13 15:38:32'),
('551', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"Q3eKOB8aJNAY5eAviMsfYuDmZ9hLJdHgBvuq4QIN"}', '2022-06-13 15:38:35', '2022-06-13 15:38:35'),
('552', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-13 15:38:36', '2022-06-13 15:38:36'),
('553', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-14 14:49:24', '2022-06-14 14:49:24'),
('554', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:49:28', '2022-06-14 14:49:28'),
('555', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:49:28', '2022-06-14 14:49:28'),
('556', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"8BhZJkoptxAewXHK4NTBVU83UBtRSXcGO3yEQlGe","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-14 14:49:31', '2022-06-14 14:49:31'),
('557', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:49:32', '2022-06-14 14:49:32'),
('558', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"8BhZJkoptxAewXHK4NTBVU83UBtRSXcGO3yEQlGe"}', '2022-06-14 14:49:52', '2022-06-14 14:49:52'),
('559', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-14 14:49:53', '2022-06-14 14:49:53');

INSERT INTO "public"."admin_operation_log" ("id", "user_id", "path", "method", "ip", "input", "created_at", "updated_at") VALUES
('560', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:50:25', '2022-06-14 14:50:25'),
('561', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:50:43', '2022-06-14 14:50:43'),
('562', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:50:45', '2022-06-14 14:50:45'),
('563', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-14 14:50:46', '2022-06-14 14:50:46'),
('564', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"8BhZJkoptxAewXHK4NTBVU83UBtRSXcGO3yEQlGe"}', '2022-06-14 14:59:44', '2022-06-14 14:59:44'),
('565', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-14 14:59:46', '2022-06-14 14:59:46'),
('566', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-15 13:21:21', '2022-06-15 13:21:21'),
('567', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:21:26', '2022-06-15 13:21:26'),
('568', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-15 13:21:29', '2022-06-15 13:21:29'),
('569', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:21:30', '2022-06-15 13:21:30'),
('570', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:21:35', '2022-06-15 13:21:35'),
('571', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:21:38', '2022-06-15 13:21:38'),
('572', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $czj","creator_id":"1","envs":{"new_1":{"key":"czj","value":"czj6666","_remove_":"0"}},"_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-15 13:21:54', '2022-06-15 13:21:54'),
('573', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-15 13:21:55', '2022-06-15 13:21:55'),
('574', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-15 13:21:57', '2022-06-15 13:21:57'),
('575', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:21:58', '2022-06-15 13:21:58'),
('576', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9"}', '2022-06-15 13:22:01', '2022-06-15 13:22:01'),
('577', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-15 13:22:02', '2022-06-15 13:22:02'),
('578', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:22:25', '2022-06-15 13:22:25'),
('579', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:22:28', '2022-06-15 13:22:28'),
('580', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-1","yaml":"echo $czj\r\necho 123123 > 123.txt","creator_id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-15 13:22:37', '2022-06-15 13:22:37'),
('581', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-15 13:22:38', '2022-06-15 13:22:38'),
('582', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:22:39', '2022-06-15 13:22:39'),
('583', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:22:41', '2022-06-15 13:22:41'),
('584', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-15 13:22:44', '2022-06-15 13:22:44'),
('585', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-15 13:22:45', '2022-06-15 13:22:45'),
('586', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"yHo5HxlU385k11I5ih4KGjnbcI7zplAo7HBwwaE9"}', '2022-06-15 13:22:47', '2022-06-15 13:22:47'),
('587', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-15 13:22:47', '2022-06-15 13:22:47'),
('588', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-20 21:06:51', '2022-06-20 21:06:51'),
('589', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-20 21:06:53', '2022-06-20 21:06:53'),
('590', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"lyslSTb0axKmwKfOkjlsImrGYIpOMW10TQrdI1lT","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-20 21:06:56', '2022-06-20 21:06:56'),
('591', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-20 21:06:57', '2022-06-20 21:06:57'),
('592', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"lyslSTb0axKmwKfOkjlsImrGYIpOMW10TQrdI1lT"}', '2022-06-20 21:06:59', '2022-06-20 21:06:59'),
('593', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-20 21:07:00', '2022-06-20 21:07:00'),
('594', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-20 21:07:02', '2022-06-20 21:07:02'),
('595', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-21 10:29:08', '2022-06-21 10:29:08'),
('596', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-21 10:29:10', '2022-06-21 10:29:10'),
('597', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-21 10:30:17', '2022-06-21 10:30:17'),
('598', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-21 10:30:18', '2022-06-21 10:30:18'),
('599', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY"}', '2022-06-21 10:30:20', '2022-06-21 10:30:20'),
('600', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-21 10:30:21', '2022-06-21 10:30:21'),
('601', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-21 10:30:31', '2022-06-21 10:30:31'),
('602', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-21 11:05:53', '2022-06-21 11:05:53'),
('603', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-21 11:05:56', '2022-06-21 11:05:56'),
('604', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-21 11:05:57', '2022-06-21 11:05:57'),
('605', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY"}', '2022-06-21 11:05:59', '2022-06-21 11:05:59'),
('606', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-21 11:06:00', '2022-06-21 11:06:00'),
('607', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY"}', '2022-06-21 11:07:40', '2022-06-21 11:07:40'),
('608', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-21 11:07:41', '2022-06-21 11:07:41'),
('609', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY"}', '2022-06-21 11:11:20', '2022-06-21 11:11:20'),
('610', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-21 11:11:22', '2022-06-21 11:11:22'),
('611', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"i5A2ZxKPY37yVU4ZeMsayyf8v1crv7hvH11clukY"}', '2022-06-21 11:14:02', '2022-06-21 11:14:02'),
('612', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-21 11:14:03', '2022-06-21 11:14:03'),
('613', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-21 11:14:20', '2022-06-21 11:14:20'),
('614', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-21 11:14:22', '2022-06-21 11:14:22'),
('615', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-22 13:33:53', '2022-06-22 13:33:53'),
('616', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-22 13:34:02', '2022-06-22 13:34:02'),
('617', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 13:34:05', '2022-06-22 13:34:05'),
('618', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 13:34:07', '2022-06-22 13:34:07'),
('619', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-22 13:35:25', '2022-06-22 13:35:25'),
('620', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 13:35:29', '2022-06-22 13:35:29'),
('621', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-22 16:12:11', '2022-06-22 16:12:11'),
('622', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 16:12:14', '2022-06-22 16:12:14'),
('623', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"wi8JtuSc8pGG4ctOVoWh4BWeFvcfmWjczsFzRe3A","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-22 16:12:18', '2022-06-22 16:12:18'),
('624', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 16:12:18', '2022-06-22 16:12:18'),
('625', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"wi8JtuSc8pGG4ctOVoWh4BWeFvcfmWjczsFzRe3A"}', '2022-06-22 16:12:20', '2022-06-22 16:12:20'),
('626', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-22 16:12:21', '2022-06-22 16:12:21'),
('627', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"wi8JtuSc8pGG4ctOVoWh4BWeFvcfmWjczsFzRe3A"}', '2022-06-22 16:14:30', '2022-06-22 16:14:30'),
('628', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-22 16:14:31', '2022-06-22 16:14:31'),
('629', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"wi8JtuSc8pGG4ctOVoWh4BWeFvcfmWjczsFzRe3A"}', '2022-06-22 16:21:39', '2022-06-22 16:21:39'),
('630', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-22 16:21:40', '2022-06-22 16:21:40'),
('631', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-22 19:54:09', '2022-06-22 19:54:09'),
('632', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 19:54:12', '2022-06-22 19:54:12'),
('633', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"q2tq5Ew8ewXmbTKwKV6rc8qdKX5A4bmJR3gl9FXO","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-22 19:56:06', '2022-06-22 19:56:06'),
('634', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-22 19:56:07', '2022-06-22 19:56:07'),
('635', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"q2tq5Ew8ewXmbTKwKV6rc8qdKX5A4bmJR3gl9FXO"}', '2022-06-22 19:56:10', '2022-06-22 19:56:10'),
('636', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-22 19:56:11', '2022-06-22 19:56:11'),
('637', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"q2tq5Ew8ewXmbTKwKV6rc8qdKX5A4bmJR3gl9FXO"}', '2022-06-22 19:58:15', '2022-06-22 19:58:15'),
('638', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-22 19:58:17', '2022-06-22 19:58:17'),
('639', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-23 10:57:19', '2022-06-23 10:57:19'),
('640', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-23 10:58:20', '2022-06-23 10:58:20'),
('641', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"KcUfANnccQz5WIBN57opz0qZVUYtM3BVwyV4kfeR"}', '2022-06-23 10:58:24', '2022-06-23 10:58:24'),
('642', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-23 10:58:25', '2022-06-23 10:58:25'),
('643', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"KcUfANnccQz5WIBN57opz0qZVUYtM3BVwyV4kfeR"}', '2022-06-23 11:00:40', '2022-06-23 11:00:40'),
('644', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-23 11:00:41', '2022-06-23 11:00:41'),
('645', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"KcUfANnccQz5WIBN57opz0qZVUYtM3BVwyV4kfeR"}', '2022-06-23 11:02:16', '2022-06-23 11:02:16'),
('646', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-23 11:02:17', '2022-06-23 11:02:17'),
('647', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-23 11:02:28', '2022-06-23 11:02:28'),
('648', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-24 16:34:30', '2022-06-24 16:34:30'),
('649', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-24 16:34:36', '2022-06-24 16:34:36'),
('650', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"U7xERo3fM5lz4soyfDulOqQLJcb3kzSnWT5C6sb1","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-24 16:34:42', '2022-06-24 16:34:42'),
('651', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-24 16:34:44', '2022-06-24 16:34:44'),
('652', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"czj","value":"czj6666","_remove_":"0"}],"_token":"U7xERo3fM5lz4soyfDulOqQLJcb3kzSnWT5C6sb1"}', '2022-06-24 16:34:49', '2022-06-24 16:34:49'),
('653', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-24 16:34:52', '2022-06-24 16:34:52'),
('654', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-24 16:38:14', '2022-06-24 16:38:14'),
('655', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-24 16:38:28', '2022-06-24 16:38:28'),
('656', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-1","yaml":"echo 123\r\necho $hkn","creator_id":null,"envs":{"new_1":{"key":"hkn","value":"hekangning","_remove_":"0"}},"_token":"U7xERo3fM5lz4soyfDulOqQLJcb3kzSnWT5C6sb1","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-24 16:38:47', '2022-06-24 16:38:47'),
('657', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-24 16:38:48', '2022-06-24 16:38:48'),
('658', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"U7xERo3fM5lz4soyfDulOqQLJcb3kzSnWT5C6sb1","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-24 16:39:10', '2022-06-24 16:39:10'),
('659', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-24 16:39:11', '2022-06-24 16:39:11'),
('660', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"hekangning","_remove_":"0"}],"_token":"U7xERo3fM5lz4soyfDulOqQLJcb3kzSnWT5C6sb1"}', '2022-06-24 16:39:15', '2022-06-24 16:39:15'),
('661', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-24 16:39:17', '2022-06-24 16:39:17'),
('662', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","envs":[{"key":"hkn","value":"hekangning","_remove_":"0"}],"_token":"U7xERo3fM5lz4soyfDulOqQLJcb3kzSnWT5C6sb1"}', '2022-06-24 16:41:12', '2022-06-24 16:41:12'),
('663', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-24 16:41:15', '2022-06-24 16:41:15');

INSERT INTO "public"."admin_permissions" ("id", "name", "slug", "http_method", "http_path", "created_at", "updated_at") VALUES
('1', 'All permission', '*', '', '*', NULL, NULL),
('2', 'Dashboard', 'dashboard', 'GET', '/', NULL, NULL),
('3', 'Login', 'auth.login', '', '/auth/login
/auth/logout', NULL, NULL),
('4', 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', NULL, NULL),
('5', 'Auth management', 'auth.management', '', '/auth/roles
/auth/permissions
/auth/menu
/auth/logs', NULL, NULL);

INSERT INTO "public"."admin_role_menu" ("role_id", "menu_id", "created_at", "updated_at") VALUES
('1', '2', NULL, NULL);

INSERT INTO "public"."admin_role_permissions" ("role_id", "permission_id", "created_at", "updated_at") VALUES
('1', '1', NULL, NULL);

INSERT INTO "public"."admin_role_users" ("role_id", "user_id", "created_at", "updated_at") VALUES
('1', '1', NULL, NULL);

INSERT INTO "public"."admin_roles" ("id", "name", "slug", "created_at", "updated_at") VALUES
('1', 'Administrator', 'administrator', '2022-04-29 07:13:39', '2022-04-29 07:13:39');

INSERT INTO "public"."admin_users" ("id", "username", "password", "name", "avatar", "remember_token", "created_at", "updated_at") VALUES
('1', 'admin', '$2y$10$AntT1paDRQloknWVmYVlbOwVfONtykUpGKD47rFvaWVl59gF2xFze', 'Administrator', NULL, 'glpMT06BrU36BMzpCwjhIuSVwr8zN9kwe47LfGw4oNuCnNqo10nLoBCHlANZ', '2022-04-29 07:13:39', '2022-04-29 07:19:33');

INSERT INTO "public"."migrations" ("id", "migration", "batch") VALUES
('1', '2014_10_12_000000_create_users_table', '1'),
('2', '2014_10_12_100000_create_password_resets_table', '1'),
('3', '2016_01_04_173148_create_admin_tables', '1'),
('4', '2019_08_19_000000_create_failed_jobs_table', '1'),
('5', '2019_12_14_000001_create_personal_access_tokens_table', '1'),
('41', '2022_04_29_075932_create_workflows_table', '2'),
('42', '2022_05_28_020537_create_pipelines_table', '2'),
('43', '2022_06_11_142611_create_runners_table', '2');

INSERT INTO "public"."pipelines" ("id", "workflow_id", "number", "uuid", "salt", "yaml", "triggered_cause", "failed_cause", "status", "status_message", "envs", "runner_id", "borrow_runner_at", "release_runner_at", "started_at", "closed_at", "duration", "raw_log", "prepare_log", "dispatch_times", "first_dispatched_at", "last_dispatched_at", "dispatch_succeed_at", "time_consuming", "created_at", "updated_at", "deleted_at") VALUES
('2', '1', '0', 'ae01cc7e-2453-4999-a8a7-6448ec62e0df', 'ae01cc7e', 'echo 123
echo $hkn', '', '', 'WAIT_FOR_BORROWING', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"2"},{"key":"WORKFLOW_ID","value":"1"},{"key":"hkn","value":"hekangning"},{"key":"hkn","value":"hekangning"}]', '0', NULL, NULL, NULL, NULL, '0', '', '', '0', NULL, NULL, NULL, NULL, '2022-06-24 16:41:13', '2022-06-24 16:41:13', NULL);

INSERT INTO "public"."workflows" ("id", "name", "yaml", "creator_id", "envs", "latest_pipeline_id", "latest_success_pipeline_id", "max_concurrent", "build_timeout_second", "created_at", "updated_at", "deleted_at") VALUES
('1', 'test-1', 'echo 123
echo $hkn', '1', '[{"key":"hkn","value":"hekangning"}]', '0', '0', '5', '1800', '2022-06-24 16:38:47', '2022-06-24 16:38:47', NULL);

