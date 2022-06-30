-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: uci
-- Generation Time: 2022-06-29 13:53:51.1110
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
                                      "first_borrow_runner_at" timestamp(0),
                                      "borrow_runner_succeed_at" timestamp(0),
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
                                                                                                                                     ('1', '0', '4', 'Dashboard', 'fa-bar-chart', '/', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('2', '0', '5', 'Admin', 'fa-tasks', '', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('3', '2', '6', 'Users', 'fa-users', 'auth/users', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('4', '2', '7', 'Roles', 'fa-user', 'auth/roles', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('5', '2', '8', 'Permission', 'fa-ban', 'auth/permissions', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('6', '2', '9', 'Menu', 'fa-bars', 'auth/menu', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('7', '2', '10', 'Operation log', 'fa-history', 'auth/logs', NULL, NULL, '2022-06-28 19:10:42'),
                                                                                                                                     ('8', '0', '1', 'Workflow', 'fa-bars', '/workflows', NULL, '2022-05-28 15:13:31', '2022-06-28 19:10:42'),
                                                                                                                                     ('9', '0', '2', 'Pipeline', 'fa-bars', '/pipelines', NULL, '2022-05-28 15:13:45', '2022-06-28 19:10:42'),
                                                                                                                                     ('10', '0', '3', 'Runner', 'fa-bars', '/runners', NULL, '2022-06-28 14:39:00', '2022-06-28 19:10:42');

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
                                                                                                                              ('663', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-24 16:41:15', '2022-06-24 16:41:15'),
                                                                                                                              ('664', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-27 13:59:55', '2022-06-27 13:59:55'),
                                                                                                                              ('665', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-27 13:59:55', '2022-06-27 13:59:55'),
                                                                                                                              ('666', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-27 15:36:14', '2022-06-27 15:36:14'),
                                                                                                                              ('667', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-27 16:30:30', '2022-06-27 16:30:30'),
                                                                                                                              ('668', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-27 16:30:30', '2022-06-27 16:30:30'),
                                                                                                                              ('669', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 16:30:34', '2022-06-27 16:30:34'),
                                                                                                                              ('670', '1', 'admin/workflows/create', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 16:30:36', '2022-06-27 16:30:36'),
                                                                                                                              ('671', '1', 'admin/workflows', 'POST', '172.21.0.8', '{"name":"test-12313","yaml":"echo 12323","creator_id":null,"_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-27 16:30:44', '2022-06-27 16:30:44'),
                                                                                                                              ('672', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-27 16:30:45', '2022-06-27 16:30:45'),
                                                                                                                              ('673', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 16:30:48', '2022-06-27 16:30:48'),
                                                                                                                              ('674', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 16:30:49', '2022-06-27 16:30:49'),
                                                                                                                              ('675', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 16:31:01', '2022-06-27 16:31:01'),
                                                                                                                              ('676', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 16:31:01', '2022-06-27 16:31:01'),
                                                                                                                              ('677', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-27 17:47:05', '2022-06-27 17:47:05'),
                                                                                                                              ('678', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 17:47:12', '2022-06-27 17:47:12'),
                                                                                                                              ('679', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 17:47:15', '2022-06-27 17:47:15'),
                                                                                                                              ('680', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 17:47:20', '2022-06-27 17:47:20'),
                                                                                                                              ('681', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 17:47:21', '2022-06-27 17:47:21'),
                                                                                                                              ('682', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 17:47:23', '2022-06-27 17:47:23'),
                                                                                                                              ('683', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 17:47:24', '2022-06-27 17:47:24'),
                                                                                                                              ('684', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 18:50:20', '2022-06-27 18:50:20'),
                                                                                                                              ('685', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 18:50:22', '2022-06-27 18:50:22'),
                                                                                                                              ('686', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 18:59:16', '2022-06-27 18:59:16'),
                                                                                                                              ('687', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 18:59:17', '2022-06-27 18:59:17'),
                                                                                                                              ('688', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 19:00:22', '2022-06-27 19:00:22'),
                                                                                                                              ('689', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 19:00:23', '2022-06-27 19:00:23'),
                                                                                                                              ('690', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 19:00:32', '2022-06-27 19:00:32'),
                                                                                                                              ('691', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-27 20:24:42', '2022-06-27 20:24:42'),
                                                                                                                              ('692', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-27 20:24:42', '2022-06-27 20:24:42'),
                                                                                                                              ('693', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-27 20:24:46', '2022-06-27 20:24:46'),
                                                                                                                              ('694', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:06', '2022-06-27 20:25:06'),
                                                                                                                              ('695', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:08', '2022-06-27 20:25:08'),
                                                                                                                              ('696', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:35', '2022-06-27 20:25:35'),
                                                                                                                              ('697', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:37', '2022-06-27 20:25:37'),
                                                                                                                              ('698', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:38', '2022-06-27 20:25:38'),
                                                                                                                              ('699', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:39', '2022-06-27 20:25:39'),
                                                                                                                              ('700', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:25:39', '2022-06-27 20:25:39'),
                                                                                                                              ('701', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:28:50', '2022-06-27 20:28:50'),
                                                                                                                              ('702', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:28:51', '2022-06-27 20:28:51'),
                                                                                                                              ('703', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:42:42', '2022-06-27 20:42:42'),
                                                                                                                              ('704', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 20:43:13', '2022-06-27 20:43:13'),
                                                                                                                              ('705', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 20:43:15', '2022-06-27 20:43:15'),
                                                                                                                              ('706', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 20:43:17', '2022-06-27 20:43:17'),
                                                                                                                              ('707', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 20:43:18', '2022-06-27 20:43:18'),
                                                                                                                              ('708', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:05:23', '2022-06-27 21:05:23'),
                                                                                                                              ('709', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:05:25', '2022-06-27 21:05:25'),
                                                                                                                              ('710', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:06:27', '2022-06-27 21:06:27'),
                                                                                                                              ('711', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:06:29', '2022-06-27 21:06:29'),
                                                                                                                              ('712', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:06:40', '2022-06-27 21:06:40'),
                                                                                                                              ('713', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:18:08', '2022-06-27 21:18:08'),
                                                                                                                              ('714', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 21:18:11', '2022-06-27 21:18:11'),
                                                                                                                              ('715', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:18:12', '2022-06-27 21:18:12'),
                                                                                                                              ('716', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:18:15', '2022-06-27 21:18:15'),
                                                                                                                              ('717', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:18:16', '2022-06-27 21:18:16'),
                                                                                                                              ('718', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:18:25', '2022-06-27 21:18:25'),
                                                                                                                              ('719', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:18:26', '2022-06-27 21:18:26'),
                                                                                                                              ('720', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:20:39', '2022-06-27 21:20:39'),
                                                                                                                              ('721', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:20:40', '2022-06-27 21:20:40'),
                                                                                                                              ('722', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:21:49', '2022-06-27 21:21:49'),
                                                                                                                              ('723', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:21:50', '2022-06-27 21:21:50'),
                                                                                                                              ('724', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:21:53', '2022-06-27 21:21:53'),
                                                                                                                              ('725', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:21:55', '2022-06-27 21:21:55'),
                                                                                                                              ('726', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:23:59', '2022-06-27 21:23:59'),
                                                                                                                              ('727', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 21:24:02', '2022-06-27 21:24:02'),
                                                                                                                              ('728', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:24:03', '2022-06-27 21:24:03'),
                                                                                                                              ('729', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 21:24:15', '2022-06-27 21:24:15'),
                                                                                                                              ('730', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 21:24:16', '2022-06-27 21:24:16'),
                                                                                                                              ('731', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:43:32', '2022-06-27 21:43:32'),
                                                                                                                              ('732', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 21:56:37', '2022-06-27 21:56:37'),
                                                                                                                              ('733', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:00:31', '2022-06-27 22:00:31'),
                                                                                                                              ('734', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:00:35', '2022-06-27 22:00:35'),
                                                                                                                              ('735', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:01:46', '2022-06-27 22:01:46'),
                                                                                                                              ('736', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 22:01:48', '2022-06-27 22:01:48'),
                                                                                                                              ('737', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:01:49', '2022-06-27 22:01:49'),
                                                                                                                              ('738', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:01:51', '2022-06-27 22:01:51'),
                                                                                                                              ('739', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:01:52', '2022-06-27 22:01:52'),
                                                                                                                              ('740', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:01:59', '2022-06-27 22:01:59'),
                                                                                                                              ('741', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:02:07', '2022-06-27 22:02:07'),
                                                                                                                              ('742', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-27 22:05:42', '2022-06-27 22:05:42'),
                                                                                                                              ('743', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:05:48', '2022-06-27 22:05:48'),
                                                                                                                              ('744', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:05:50', '2022-06-27 22:05:50'),
                                                                                                                              ('745', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-27 22:05:53', '2022-06-27 22:05:53'),
                                                                                                                              ('746', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1"}', '2022-06-27 22:06:44', '2022-06-27 22:06:44'),
                                                                                                                              ('747', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1"}', '2022-06-27 22:07:05', '2022-06-27 22:07:05'),
                                                                                                                              ('748', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1"}', '2022-06-27 22:07:39', '2022-06-27 22:07:39'),
                                                                                                                              ('749', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1"}', '2022-06-27 22:08:36', '2022-06-27 22:08:36'),
                                                                                                                              ('750', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1"}', '2022-06-27 22:10:02', '2022-06-27 22:10:02'),
                                                                                                                              ('751', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1"}', '2022-06-27 22:13:14', '2022-06-27 22:13:14'),
                                                                                                                              ('752', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:28:26', '2022-06-27 22:28:26'),
                                                                                                                              ('753', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 22:28:30', '2022-06-27 22:28:30'),
                                                                                                                              ('754', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:28:31', '2022-06-27 22:28:31'),
                                                                                                                              ('755', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:28:33', '2022-06-27 22:28:33'),
                                                                                                                              ('756', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:28:34', '2022-06-27 22:28:34'),
                                                                                                                              ('757', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:32:05', '2022-06-27 22:32:05'),
                                                                                                                              ('758', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:32:06', '2022-06-27 22:32:06'),
                                                                                                                              ('759', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:33:42', '2022-06-27 22:33:42'),
                                                                                                                              ('760', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:33:43', '2022-06-27 22:33:43'),
                                                                                                                              ('761', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:34:27', '2022-06-27 22:34:27'),
                                                                                                                              ('762', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:34:28', '2022-06-27 22:34:28'),
                                                                                                                              ('763', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:35:36', '2022-06-27 22:35:36'),
                                                                                                                              ('764', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:35:37', '2022-06-27 22:35:37'),
                                                                                                                              ('765', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:36:03', '2022-06-27 22:36:03'),
                                                                                                                              ('766', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:36:04', '2022-06-27 22:36:04'),
                                                                                                                              ('767', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:36:30', '2022-06-27 22:36:30'),
                                                                                                                              ('768', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:36:31', '2022-06-27 22:36:31'),
                                                                                                                              ('769', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:40:00', '2022-06-27 22:40:00'),
                                                                                                                              ('770', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:40:02', '2022-06-27 22:40:02'),
                                                                                                                              ('771', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:42:26', '2022-06-27 22:42:26'),
                                                                                                                              ('772', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:42:27', '2022-06-27 22:42:27'),
                                                                                                                              ('773', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:42:40', '2022-06-27 22:42:40'),
                                                                                                                              ('774', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-27 22:42:46', '2022-06-27 22:42:46'),
                                                                                                                              ('775', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:59:08', '2022-06-27 22:59:08'),
                                                                                                                              ('776', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:59:09', '2022-06-27 22:59:09'),
                                                                                                                              ('777', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 22:59:12', '2022-06-27 22:59:12'),
                                                                                                                              ('778', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 22:59:12', '2022-06-27 22:59:12'),
                                                                                                                              ('779', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 22:59:15', '2022-06-27 22:59:15'),
                                                                                                                              ('780', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 22:59:15', '2022-06-27 22:59:15'),
                                                                                                                              ('781', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:32:14', '2022-06-27 23:32:14'),
                                                                                                                              ('782', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:32:15', '2022-06-27 23:32:15'),
                                                                                                                              ('783', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:32:28', '2022-06-27 23:32:28'),
                                                                                                                              ('784', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:37:51', '2022-06-27 23:37:51'),
                                                                                                                              ('785', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 23:37:55', '2022-06-27 23:37:55'),
                                                                                                                              ('786', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:37:56', '2022-06-27 23:37:56'),
                                                                                                                              ('787', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:37:59', '2022-06-27 23:37:59'),
                                                                                                                              ('788', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:38:00', '2022-06-27 23:38:00'),
                                                                                                                              ('789', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-27 23:38:21', '2022-06-27 23:38:21'),
                                                                                                                              ('790', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:38:29', '2022-06-27 23:38:29'),
                                                                                                                              ('791', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:38:32', '2022-06-27 23:38:32'),
                                                                                                                              ('792', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"echo 12323\r\n123123","creator_id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-27 23:38:35', '2022-06-27 23:38:35'),
                                                                                                                              ('793', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-27 23:38:35', '2022-06-27 23:38:35'),
                                                                                                                              ('794', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 23:38:39', '2022-06-27 23:38:39'),
                                                                                                                              ('795', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:38:40', '2022-06-27 23:38:40'),
                                                                                                                              ('796', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:38:42', '2022-06-27 23:38:42'),
                                                                                                                              ('797', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:38:43', '2022-06-27 23:38:43'),
                                                                                                                              ('798', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:39:19', '2022-06-27 23:39:19'),
                                                                                                                              ('799', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:39:20', '2022-06-27 23:39:20'),
                                                                                                                              ('800', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:39:24', '2022-06-27 23:39:24'),
                                                                                                                              ('801', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:47:22', '2022-06-27 23:47:22'),
                                                                                                                              ('802', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 23:47:26', '2022-06-27 23:47:26'),
                                                                                                                              ('803', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:47:27', '2022-06-27 23:47:27'),
                                                                                                                              ('804', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:47:29', '2022-06-27 23:47:29'),
                                                                                                                              ('805', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:47:31', '2022-06-27 23:47:31'),
                                                                                                                              ('806', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:47:35', '2022-06-27 23:47:35'),
                                                                                                                              ('807', '1', 'admin/pipelines/29', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:47:41', '2022-06-27 23:47:41'),
                                                                                                                              ('808', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:48:03', '2022-06-27 23:48:03'),
                                                                                                                              ('809', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:48:06', '2022-06-27 23:48:06'),
                                                                                                                              ('810', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"echo 12323","creator_id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-27 23:48:10', '2022-06-27 23:48:10'),
                                                                                                                              ('811', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-27 23:48:11', '2022-06-27 23:48:11'),
                                                                                                                              ('812', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-27 23:48:15', '2022-06-27 23:48:15'),
                                                                                                                              ('813', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-27 23:48:15', '2022-06-27 23:48:15'),
                                                                                                                              ('814', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:48:17', '2022-06-27 23:48:17'),
                                                                                                                              ('815', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:48:18', '2022-06-27 23:48:18'),
                                                                                                                              ('816', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-27 23:57:33', '2022-06-27 23:57:33'),
                                                                                                                              ('817', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-27 23:57:34', '2022-06-27 23:57:34'),
                                                                                                                              ('818', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:00:38', '2022-06-28 00:00:38'),
                                                                                                                              ('819', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:00:39', '2022-06-28 00:00:39'),
                                                                                                                              ('820', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:00:56', '2022-06-28 00:00:56'),
                                                                                                                              ('821', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:00:57', '2022-06-28 00:00:57'),
                                                                                                                              ('822', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:02:55', '2022-06-28 00:02:55'),
                                                                                                                              ('823', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:02:57', '2022-06-28 00:02:57'),
                                                                                                                              ('824', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:20:46', '2022-06-28 00:20:46'),
                                                                                                                              ('825', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:20:47', '2022-06-28 00:20:47'),
                                                                                                                              ('826', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:20:51', '2022-06-28 00:20:51'),
                                                                                                                              ('827', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:20:51', '2022-06-28 00:20:51'),
                                                                                                                              ('828', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:23:40', '2022-06-28 00:23:40'),
                                                                                                                              ('829', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:23:41', '2022-06-28 00:23:41'),
                                                                                                                              ('830', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:31:31', '2022-06-28 00:31:31'),
                                                                                                                              ('831', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:31:32', '2022-06-28 00:31:32'),
                                                                                                                              ('832', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 00:31:51', '2022-06-28 00:31:51'),
                                                                                                                              ('833', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"QGHY7HSAWamb1mGArziSsT6KY46SYHFzLADML2ct"}', '2022-06-28 00:35:10', '2022-06-28 00:35:10'),
                                                                                                                              ('834', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 00:35:10', '2022-06-28 00:35:10'),
                                                                                                                              ('835', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 00:36:44', '2022-06-28 00:36:44'),
                                                                                                                              ('836', '1', 'admin/pipelines/38', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 00:36:49', '2022-06-28 00:36:49'),
                                                                                                                              ('837', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 00:39:12', '2022-06-28 00:39:12'),
                                                                                                                              ('838', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 00:40:17', '2022-06-28 00:40:17'),
                                                                                                                              ('839', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:42:24', '2022-06-28 00:42:24'),
                                                                                                                              ('840', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:42:46', '2022-06-28 00:42:46'),
                                                                                                                              ('841', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:43:42', '2022-06-28 00:43:42'),
                                                                                                                              ('842', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:46:44', '2022-06-28 00:46:44'),
                                                                                                                              ('843', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:47:20', '2022-06-28 00:47:20'),
                                                                                                                              ('844', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:47:38', '2022-06-28 00:47:38'),
                                                                                                                              ('845', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:47:57', '2022-06-28 00:47:57'),
                                                                                                                              ('846', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 00:48:26', '2022-06-28 00:48:26'),
                                                                                                                              ('847', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-28 13:18:16', '2022-06-28 13:18:16'),
                                                                                                                              ('848', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-28 13:18:17', '2022-06-28 13:18:17'),
                                                                                                                              ('849', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:18:22', '2022-06-28 13:18:22'),
                                                                                                                              ('850', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 13:18:25', '2022-06-28 13:18:25'),
                                                                                                                              ('851', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:18:26', '2022-06-28 13:18:26'),
                                                                                                                              ('852', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:18:28', '2022-06-28 13:18:28'),
                                                                                                                              ('853', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:18:29', '2022-06-28 13:18:29'),
                                                                                                                              ('854', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:20:27', '2022-06-28 13:20:27'),
                                                                                                                              ('855', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:20:28', '2022-06-28 13:20:28'),
                                                                                                                              ('856', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:21:04', '2022-06-28 13:21:04'),
                                                                                                                              ('857', '1', 'admin/pipelines/40', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:21:09', '2022-06-28 13:21:09'),
                                                                                                                              ('858', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:26:15', '2022-06-28 13:26:15'),
                                                                                                                              ('859', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 13:26:17', '2022-06-28 13:26:17'),
                                                                                                                              ('860', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:26:18', '2022-06-28 13:26:18'),
                                                                                                                              ('861', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:26:20', '2022-06-28 13:26:20'),
                                                                                                                              ('862', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:26:21', '2022-06-28 13:26:21'),
                                                                                                                              ('863', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:28:52', '2022-06-28 13:28:52'),
                                                                                                                              ('864', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:28:53', '2022-06-28 13:28:53'),
                                                                                                                              ('865', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:31:43', '2022-06-28 13:31:43'),
                                                                                                                              ('866', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:31:45', '2022-06-28 13:31:45'),
                                                                                                                              ('867', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:31:56', '2022-06-28 13:31:56'),
                                                                                                                              ('868', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:31:57', '2022-06-28 13:31:57'),
                                                                                                                              ('869', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:32:32', '2022-06-28 13:32:32'),
                                                                                                                              ('870', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:32:35', '2022-06-28 13:32:35'),
                                                                                                                              ('871', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"echo 1\r\nsleep 7\r\necho 2","creator_id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-28 13:32:49', '2022-06-28 13:32:49'),
                                                                                                                              ('872', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 13:32:50', '2022-06-28 13:32:50'),
                                                                                                                              ('873', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 13:32:53', '2022-06-28 13:32:53'),
                                                                                                                              ('874', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:32:54', '2022-06-28 13:32:54'),
                                                                                                                              ('875', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:32:56', '2022-06-28 13:32:56'),
                                                                                                                              ('876', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:32:57', '2022-06-28 13:32:57'),
                                                                                                                              ('877', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:34:56', '2022-06-28 13:34:56'),
                                                                                                                              ('878', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:34:56', '2022-06-28 13:34:56'),
                                                                                                                              ('879', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:35:43', '2022-06-28 13:35:43'),
                                                                                                                              ('880', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:35:44', '2022-06-28 13:35:44'),
                                                                                                                              ('881', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:37:06', '2022-06-28 13:37:06'),
                                                                                                                              ('882', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:37:07', '2022-06-28 13:37:07'),
                                                                                                                              ('883', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:38:40', '2022-06-28 13:38:40'),
                                                                                                                              ('884', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:38:41', '2022-06-28 13:38:41'),
                                                                                                                              ('885', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:39:49', '2022-06-28 13:39:49'),
                                                                                                                              ('886', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:39:50', '2022-06-28 13:39:50'),
                                                                                                                              ('887', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:41:54', '2022-06-28 13:41:54'),
                                                                                                                              ('888', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:41:55', '2022-06-28 13:41:55'),
                                                                                                                              ('889', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:43:23', '2022-06-28 13:43:23'),
                                                                                                                              ('890', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:43:24', '2022-06-28 13:43:24'),
                                                                                                                              ('891', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:46:34', '2022-06-28 13:46:34'),
                                                                                                                              ('892', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:46:34', '2022-06-28 13:46:34'),
                                                                                                                              ('893', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:50:42', '2022-06-28 13:50:42'),
                                                                                                                              ('894', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:50:46', '2022-06-28 13:50:46'),
                                                                                                                              ('895', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-28 13:51:00', '2022-06-28 13:51:00'),
                                                                                                                              ('896', '1', 'admin/pipelines/53', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:51:04', '2022-06-28 13:51:04'),
                                                                                                                              ('897', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:51:18', '2022-06-28 13:51:18'),
                                                                                                                              ('898', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:51:22', '2022-06-28 13:51:22'),
                                                                                                                              ('899', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"docker rmi nginx || true\r\ndocker pull nginx\r\n\r\necho 1\r\nsleep 7\r\necho 2","creator_id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-28 13:51:36', '2022-06-28 13:51:36'),
                                                                                                                              ('900', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 13:51:38', '2022-06-28 13:51:38'),
                                                                                                                              ('901', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-28 13:51:51', '2022-06-28 13:51:51'),
                                                                                                                              ('902', '1', 'admin/pipelines/53', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:51:57', '2022-06-28 13:51:57'),
                                                                                                                              ('903', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:52:15', '2022-06-28 13:52:15'),
                                                                                                                              ('904', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 13:52:19', '2022-06-28 13:52:19'),
                                                                                                                              ('905', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 13:52:21', '2022-06-28 13:52:21'),
                                                                                                                              ('906', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:52:24', '2022-06-28 13:52:24'),
                                                                                                                              ('907', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:52:26', '2022-06-28 13:52:26'),
                                                                                                                              ('908', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:53:59', '2022-06-28 13:53:59'),
                                                                                                                              ('909', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:54:02', '2022-06-28 13:54:02'),
                                                                                                                              ('910', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 13:55:01', '2022-06-28 13:55:01'),
                                                                                                                              ('911', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 13:55:05', '2022-06-28 13:55:05'),
                                                                                                                              ('912', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:08:56', '2022-06-28 14:08:56'),
                                                                                                                              ('913', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 14:08:57', '2022-06-28 14:08:57'),
                                                                                                                              ('914', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:09:17', '2022-06-28 14:09:17'),
                                                                                                                              ('915', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 14:09:19', '2022-06-28 14:09:19'),
                                                                                                                              ('916', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:10:29', '2022-06-28 14:10:29'),
                                                                                                                              ('917', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 14:10:31', '2022-06-28 14:10:31'),
                                                                                                                              ('918', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:12:45', '2022-06-28 14:12:45'),
                                                                                                                              ('919', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 14:12:47', '2022-06-28 14:12:47'),
                                                                                                                              ('920', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:17:45', '2022-06-28 14:17:45'),
                                                                                                                              ('921', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 14:17:48', '2022-06-28 14:17:48'),
                                                                                                                              ('922', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:19:50', '2022-06-28 14:19:50'),
                                                                                                                              ('923', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 14:19:51', '2022-06-28 14:19:51'),
                                                                                                                              ('924', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 14:21:44', '2022-06-28 14:21:44'),
                                                                                                                              ('925', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 14:21:50', '2022-06-28 14:21:50'),
                                                                                                                              ('926', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:25:13', '2022-06-28 14:25:13'),
                                                                                                                              ('927', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:26:21', '2022-06-28 14:26:21'),
                                                                                                                              ('928', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:27:22', '2022-06-28 14:27:22'),
                                                                                                                              ('929', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:28:23', '2022-06-28 14:28:23'),
                                                                                                                              ('930', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:28:41', '2022-06-28 14:28:41'),
                                                                                                                              ('931', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:29:08', '2022-06-28 14:29:08'),
                                                                                                                              ('932', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:29:23', '2022-06-28 14:29:23'),
                                                                                                                              ('933', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:29:48', '2022-06-28 14:29:48'),
                                                                                                                              ('934', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:31:15', '2022-06-28 14:31:15'),
                                                                                                                              ('935', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:31:46', '2022-06-28 14:31:46'),
                                                                                                                              ('936', '1', 'admin/pipelines/62', 'GET', '172.21.0.8', '[]', '2022-06-28 14:32:19', '2022-06-28 14:32:19'),
                                                                                                                              ('937', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 14:38:18', '2022-06-28 14:38:18'),
                                                                                                                              ('938', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:31', '2022-06-28 14:38:31'),
                                                                                                                              ('939', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:32', '2022-06-28 14:38:32'),
                                                                                                                              ('940', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:38', '2022-06-28 14:38:38'),
                                                                                                                              ('941', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:39', '2022-06-28 14:38:39'),
                                                                                                                              ('942', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:41', '2022-06-28 14:38:41'),
                                                                                                                              ('943', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:42', '2022-06-28 14:38:42'),
                                                                                                                              ('944', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:43', '2022-06-28 14:38:43'),
                                                                                                                              ('945', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:44', '2022-06-28 14:38:44'),
                                                                                                                              ('946', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:46', '2022-06-28 14:38:46'),
                                                                                                                              ('947', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:47', '2022-06-28 14:38:47'),
                                                                                                                              ('948', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:48', '2022-06-28 14:38:48'),
                                                                                                                              ('949', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:49', '2022-06-28 14:38:49'),
                                                                                                                              ('950', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:51', '2022-06-28 14:38:51'),
                                                                                                                              ('951', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:52', '2022-06-28 14:38:52'),
                                                                                                                              ('952', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:54', '2022-06-28 14:38:54'),
                                                                                                                              ('953', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:55', '2022-06-28 14:38:55'),
                                                                                                                              ('954', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:38:57', '2022-06-28 14:38:57'),
                                                                                                                              ('955', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:38:58', '2022-06-28 14:38:58'),
                                                                                                                              ('956', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"parent_id":"0","title":"Runner","icon":"fa-bars","uri":"\/runners","roles":[null],"permission":null,"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 14:39:00', '2022-06-28 14:39:00'),
                                                                                                                              ('957', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:39:01', '2022-06-28 14:39:01'),
                                                                                                                              ('958', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '[]', '2022-06-28 14:42:11', '2022-06-28 14:42:11'),
                                                                                                                              ('959', '1', 'admin/runners', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 14:42:15', '2022-06-28 14:42:15'),
                                                                                                                              ('960', '1', 'admin/runners', 'GET', '172.21.0.8', '[]', '2022-06-28 15:39:33', '2022-06-28 15:39:33'),
                                                                                                                              ('961', '1', 'admin/runners', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 15:45:53', '2022-06-28 15:45:53'),
                                                                                                                              ('962', '1', 'admin/runners', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 15:46:14', '2022-06-28 15:46:14'),
                                                                                                                              ('963', '1', 'admin/runners', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 15:46:30', '2022-06-28 15:46:30'),
                                                                                                                              ('964', '1', 'admin/runners', 'GET', '172.21.0.8', '[]', '2022-06-28 17:16:29', '2022-06-28 17:16:29'),
                                                                                                                              ('965', '1', 'admin/runners', 'GET', '172.21.0.8', '[]', '2022-06-28 17:16:29', '2022-06-28 17:16:29'),
                                                                                                                              ('966', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:16:38', '2022-06-28 17:16:38'),
                                                                                                                              ('967', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:16:43', '2022-06-28 17:16:43'),
                                                                                                                              ('968', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"docker rmi nginx || true\r\ndocker pull nginx\r\n\r\ncd \/ && ls -l","creator_id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-28 17:17:21', '2022-06-28 17:17:21'),
                                                                                                                              ('969', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 17:17:23', '2022-06-28 17:17:23'),
                                                                                                                              ('970', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 17:17:28', '2022-06-28 17:17:28'),
                                                                                                                              ('971', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:17:30', '2022-06-28 17:17:30'),
                                                                                                                              ('972', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 17:17:34', '2022-06-28 17:17:34'),
                                                                                                                              ('973', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 17:17:38', '2022-06-28 17:17:38'),
                                                                                                                              ('974', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 17:18:00', '2022-06-28 17:18:00'),
                                                                                                                              ('975', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 17:19:00', '2022-06-28 17:19:00'),
                                                                                                                              ('976', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 17:19:04', '2022-06-28 17:19:04'),
                                                                                                                              ('977', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 17:25:15', '2022-06-28 17:25:15'),
                                                                                                                              ('978', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 17:25:16', '2022-06-28 17:25:16'),
                                                                                                                              ('979', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:25:19', '2022-06-28 17:25:19'),
                                                                                                                              ('980', '1', 'admin/runners', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:27:54', '2022-06-28 17:27:54'),
                                                                                                                              ('981', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:28:01', '2022-06-28 17:28:01'),
                                                                                                                              ('982', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 17:28:07', '2022-06-28 17:28:07'),
                                                                                                                              ('983', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 17:28:10', '2022-06-28 17:28:10'),
                                                                                                                              ('984', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 17:28:33', '2022-06-28 17:28:33'),
                                                                                                                              ('985', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 17:28:36', '2022-06-28 17:28:36'),
                                                                                                                              ('986', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 19:10:15', '2022-06-28 19:10:15'),
                                                                                                                              ('987', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:10:31', '2022-06-28 19:10:31'),
                                                                                                                              ('988', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:10:35', '2022-06-28 19:10:35'),
                                                                                                                              ('989', '1', 'admin/auth/menu', 'POST', '172.21.0.8', '{"_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_order":"[{\"id\":8},{\"id\":9},{\"id\":10},{\"id\":1},{\"id\":2,\"children\":[{\"id\":3},{\"id\":4},{\"id\":5},{\"id\":6},{\"id\":7}]}]"}', '2022-06-28 19:10:42', '2022-06-28 19:10:42'),
                                                                                                                              ('990', '1', 'admin/auth/menu', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:10:42', '2022-06-28 19:10:42'),
                                                                                                                              ('991', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-28 19:22:41', '2022-06-28 19:22:41'),
                                                                                                                              ('992', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:22:46', '2022-06-28 19:22:46'),
                                                                                                                              ('993', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 19:57:58', '2022-06-28 19:57:58'),
                                                                                                                              ('994', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 19:57:58', '2022-06-28 19:57:58'),
                                                                                                                              ('995', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"page":"2","_pjax":"#pjax-container"}', '2022-06-28 19:58:25', '2022-06-28 19:58:25'),
                                                                                                                              ('996', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:58:30', '2022-06-28 19:58:30'),
                                                                                                                              ('997', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 19:58:39', '2022-06-28 19:58:39'),
                                                                                                                              ('998', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:58:39', '2022-06-28 19:58:39'),
                                                                                                                              ('999', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 19:58:46', '2022-06-28 19:58:46'),
                                                                                                                              ('1000', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 19:58:47', '2022-06-28 19:58:47'),
                                                                                                                              ('1001', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 19:58:49', '2022-06-28 19:58:49'),
                                                                                                                              ('1002', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 19:58:50', '2022-06-28 19:58:50'),
                                                                                                                              ('1003', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:58:52', '2022-06-28 19:58:52'),
                                                                                                                              ('1004', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:59:02', '2022-06-28 19:59:02'),
                                                                                                                              ('1005', '1', 'admin/pipelines/49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68', 'DELETE', '172.21.0.8', '{"_method":"delete","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 19:59:24', '2022-06-28 19:59:24'),
                                                                                                                              ('1006', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:59:25', '2022-06-28 19:59:25'),
                                                                                                                              ('1007', '1', 'admin/pipelines/29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48', 'DELETE', '172.21.0.8', '{"_method":"delete","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 19:59:46', '2022-06-28 19:59:46'),
                                                                                                                              ('1008', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:59:46', '2022-06-28 19:59:46'),
                                                                                                                              ('1009', '1', 'admin/pipelines/9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28', 'DELETE', '172.21.0.8', '{"_method":"delete","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 19:59:53', '2022-06-28 19:59:53'),
                                                                                                                              ('1010', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 19:59:54', '2022-06-28 19:59:54'),
                                                                                                                              ('1011', '1', 'admin/pipelines/1,2,3,4,5,6,7,8', 'DELETE', '172.21.0.8', '{"_method":"delete","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 19:59:59', '2022-06-28 19:59:59'),
                                                                                                                              ('1012', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 20:00:00', '2022-06-28 20:00:00'),
                                                                                                                              ('1013', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 20:00:02', '2022-06-28 20:00:02'),
                                                                                                                              ('1014', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 20:00:06', '2022-06-28 20:00:06'),
                                                                                                                              ('1015', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 20:00:07', '2022-06-28 20:00:07'),
                                                                                                                              ('1016', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 20:00:09', '2022-06-28 20:00:09'),
                                                                                                                              ('1017', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 20:00:10', '2022-06-28 20:00:10'),
                                                                                                                              ('1018', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 20:00:11', '2022-06-28 20:00:11'),
                                                                                                                              ('1019', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 20:00:12', '2022-06-28 20:00:12'),
                                                                                                                              ('1020', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 20:00:13', '2022-06-28 20:00:13'),
                                                                                                                              ('1021', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 20:00:14', '2022-06-28 20:00:14'),
                                                                                                                              ('1022', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 20:00:17', '2022-06-28 20:00:17'),
                                                                                                                              ('1023', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 20:00:17', '2022-06-28 20:00:17'),
                                                                                                                              ('1024', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 20:00:19', '2022-06-28 20:00:19'),
                                                                                                                              ('1025', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 20:00:20', '2022-06-28 20:00:20'),
                                                                                                                              ('1026', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 20:00:22', '2022-06-28 20:00:22'),
                                                                                                                              ('1027', '1', 'admin/pipelines/73', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 20:00:29', '2022-06-28 20:00:29'),
                                                                                                                              ('1028', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 20:00:37', '2022-06-28 20:00:37'),
                                                                                                                              ('1029', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 20:14:31', '2022-06-28 20:14:31'),
                                                                                                                              ('1030', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-28 21:01:46', '2022-06-28 21:01:46'),
                                                                                                                              ('1031', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:01:50', '2022-06-28 21:01:50'),
                                                                                                                              ('1032', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:01:55', '2022-06-28 21:01:55'),
                                                                                                                              ('1033', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"docker rmi nginx || true\r\ndocker pull nginx\r\n\r\ncd \/ && ls -l","creator_id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-28 21:02:04', '2022-06-28 21:02:04'),
                                                                                                                              ('1034', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 21:02:04', '2022-06-28 21:02:04'),
                                                                                                                              ('1035', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 21:02:07', '2022-06-28 21:02:07'),
                                                                                                                              ('1036', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:02:08', '2022-06-28 21:02:08'),
                                                                                                                              ('1037', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 21:02:10', '2022-06-28 21:02:10'),
                                                                                                                              ('1038', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 21:02:10', '2022-06-28 21:02:10'),
                                                                                                                              ('1039', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:02:13', '2022-06-28 21:02:13'),
                                                                                                                              ('1040', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:02:21', '2022-06-28 21:02:21'),
                                                                                                                              ('1041', '1', 'admin/pipelines/74', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:02:27', '2022-06-28 21:02:27'),
                                                                                                                              ('1042', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:08:42', '2022-06-28 21:08:42'),
                                                                                                                              ('1043', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-06-28 21:10:47', '2022-06-28 21:10:47'),
                                                                                                                              ('1044', '1', 'admin/pipelines/74', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:11:23', '2022-06-28 21:11:23'),
                                                                                                                              ('1045', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:11:30', '2022-06-28 21:11:30'),
                                                                                                                              ('1046', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:11:31', '2022-06-28 21:11:31'),
                                                                                                                              ('1047', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:11:34', '2022-06-28 21:11:34'),
                                                                                                                              ('1048', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:24', '2022-06-28 21:14:24'),
                                                                                                                              ('1049', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 21:14:30', '2022-06-28 21:14:30'),
                                                                                                                              ('1050', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:30', '2022-06-28 21:14:30'),
                                                                                                                              ('1051', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 21:14:32', '2022-06-28 21:14:32'),
                                                                                                                              ('1052', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 21:14:33', '2022-06-28 21:14:33'),
                                                                                                                              ('1053', '1', 'admin/pipelines', 'GET', '172.21.0.8', '[]', '2022-06-28 21:14:38', '2022-06-28 21:14:38'),
                                                                                                                              ('1054', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:42', '2022-06-28 21:14:42'),
                                                                                                                              ('1055', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:44', '2022-06-28 21:14:44'),
                                                                                                                              ('1056', '1', 'admin/pipelines/75', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:46', '2022-06-28 21:14:46'),
                                                                                                                              ('1057', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:52', '2022-06-28 21:14:52'),
                                                                                                                              ('1058', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:54', '2022-06-28 21:14:54'),
                                                                                                                              ('1059', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:14:57', '2022-06-28 21:14:57');

INSERT INTO "public"."admin_operation_log" ("id", "user_id", "path", "method", "ip", "input", "created_at", "updated_at") VALUES
                                                                                                                              ('1060', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"docker pull nginx\r\n\r\ncd \/ && ls -l","creator_id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-28 21:15:03', '2022-06-28 21:15:03'),
                                                                                                                              ('1061', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 21:15:04', '2022-06-28 21:15:04'),
                                                                                                                              ('1062', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 21:15:07', '2022-06-28 21:15:07'),
                                                                                                                              ('1063', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 21:15:08', '2022-06-28 21:15:08'),
                                                                                                                              ('1064', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 21:15:10', '2022-06-28 21:15:10'),
                                                                                                                              ('1065', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 21:15:11', '2022-06-28 21:15:11'),
                                                                                                                              ('1066', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:15:13', '2022-06-28 21:15:13'),
                                                                                                                              ('1067', '1', 'admin/workflows/1/edit', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:23:24', '2022-06-28 21:23:24'),
                                                                                                                              ('1068', '1', 'admin/workflows/1', 'PUT', '172.21.0.8', '{"name":"test-12313","yaml":"docker pull nginx\r\n\r\ncd \/ && ls -l","creator_id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-06-28 21:23:44', '2022-06-28 21:23:44'),
                                                                                                                              ('1069', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 21:23:44', '2022-06-28 21:23:44'),
                                                                                                                              ('1070', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 21:23:48', '2022-06-28 21:23:48'),
                                                                                                                              ('1071', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:23:49', '2022-06-28 21:23:49'),
                                                                                                                              ('1072', '1', 'admin/workflows/1/trigger', 'POST', '172.21.0.8', '{"id":"1","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr"}', '2022-06-28 21:23:52', '2022-06-28 21:23:52'),
                                                                                                                              ('1073', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 21:23:53', '2022-06-28 21:23:53'),
                                                                                                                              ('1074', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:23:56', '2022-06-28 21:23:56'),
                                                                                                                              ('1075', '1', 'admin/pipelines', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:24:01', '2022-06-28 21:24:01'),
                                                                                                                              ('1076', '1', 'admin/pipelines/78', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 21:24:04', '2022-06-28 21:24:04'),
                                                                                                                              ('1077', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 22:18:56', '2022-06-28 22:18:56'),
                                                                                                                              ('1078', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 22:18:56', '2022-06-28 22:18:56'),
                                                                                                                              ('1079', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 22:19:14', '2022-06-28 22:19:14'),
                                                                                                                              ('1080', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 22:19:30', '2022-06-28 22:19:30'),
                                                                                                                              ('1081', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-28 22:28:55', '2022-06-28 22:28:55'),
                                                                                                                              ('1082', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:35:44', '2022-06-28 22:35:44'),
                                                                                                                              ('1083', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:36:04', '2022-06-28 22:36:04'),
                                                                                                                              ('1084', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:36:24', '2022-06-28 22:36:24'),
                                                                                                                              ('1085', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:36:44', '2022-06-28 22:36:44'),
                                                                                                                              ('1086', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:36:59', '2022-06-28 22:36:59'),
                                                                                                                              ('1087', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:38:34', '2022-06-28 22:38:34'),
                                                                                                                              ('1088', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:38:45', '2022-06-28 22:38:45'),
                                                                                                                              ('1089', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:39:25', '2022-06-28 22:39:25'),
                                                                                                                              ('1090', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:40:56', '2022-06-28 22:40:56'),
                                                                                                                              ('1091', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:41:04', '2022-06-28 22:41:04'),
                                                                                                                              ('1092', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:42:23', '2022-06-28 22:42:23'),
                                                                                                                              ('1093', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:43:48', '2022-06-28 22:43:48'),
                                                                                                                              ('1094', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:44:01', '2022-06-28 22:44:01'),
                                                                                                                              ('1095', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:44:52', '2022-06-28 22:44:52'),
                                                                                                                              ('1096', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:44:59', '2022-06-28 22:44:59'),
                                                                                                                              ('1097', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:45:03', '2022-06-28 22:45:03'),
                                                                                                                              ('1098', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 22:45:04', '2022-06-28 22:45:04'),
                                                                                                                              ('1099', '1', 'admin/workflows/1/trigger', 'GET', '172.21.0.8', '[]', '2022-06-28 22:46:27', '2022-06-28 22:46:27'),
                                                                                                                              ('1100', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 22:46:29', '2022-06-28 22:46:29'),
                                                                                                                              ('1101', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:46:33', '2022-06-28 22:46:33'),
                                                                                                                              ('1102', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:46:41', '2022-06-28 22:46:41'),
                                                                                                                              ('1103', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:47:44', '2022-06-28 22:47:44'),
                                                                                                                              ('1104', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:47:46', '2022-06-28 22:47:46'),
                                                                                                                              ('1105', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:47:55', '2022-06-28 22:47:55'),
                                                                                                                              ('1106', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:48:34', '2022-06-28 22:48:34'),
                                                                                                                              ('1107', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:48:37', '2022-06-28 22:48:37'),
                                                                                                                              ('1108', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:48:57', '2022-06-28 22:48:57'),
                                                                                                                              ('1109', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:49:29', '2022-06-28 22:49:29'),
                                                                                                                              ('1110', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:49:34', '2022-06-28 22:49:34'),
                                                                                                                              ('1111', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"yaml":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:49:44', '2022-06-28 22:49:44'),
                                                                                                                              ('1112', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 22:49:45', '2022-06-28 22:49:45'),
                                                                                                                              ('1113', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 22:50:18', '2022-06-28 22:50:18'),
                                                                                                                              ('1114', '1', 'admin/_handle_action_', 'POST', '172.21.0.8', '{"revision":null,"_key":"1","_model":"App_Models_Workflow","_token":"rGA1irlhKSc4zRPGDVSZP9PMEB0POytOM3qL0iRr","_action":"App_Admin_Actions_Pipeline_TriggerWorkflowPage"}', '2022-06-28 22:50:23', '2022-06-28 22:50:23'),
                                                                                                                              ('1115', '1', 'admin/workflows', 'GET', '172.21.0.8', '{"_pjax":"#pjax-container"}', '2022-06-28 22:50:24', '2022-06-28 22:50:24'),
                                                                                                                              ('1116', '1', 'admin', 'GET', '172.21.0.8', '[]', '2022-06-28 22:54:12', '2022-06-28 22:54:12'),
                                                                                                                              ('1117', '1', 'admin/workflows', 'GET', '172.21.0.8', '[]', '2022-06-28 23:58:34', '2022-06-28 23:58:34');

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
                                                                   ('44', '2022_04_29_075932_create_workflows_table', '2'),
                                                                   ('45', '2022_05_28_020537_create_pipelines_table', '2'),
                                                                   ('46', '2022_06_11_142611_create_runners_table', '2');

INSERT INTO "public"."pipelines" ("id", "workflow_id", "number", "uuid", "salt", "yaml", "triggered_cause", "failed_cause", "status", "status_message", "envs", "runner_id", "first_borrow_runner_at", "borrow_runner_succeed_at", "release_runner_at", "started_at", "closed_at", "duration", "raw_log", "prepare_log", "dispatch_times", "first_dispatched_at", "last_dispatched_at", "dispatch_succeed_at", "time_consuming", "created_at", "updated_at", "deleted_at") VALUES
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('69', '1', '0', '09064f00-8c62-4a70-b03f-ce385220f5db', '09064f00', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"69"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 20:00:10', '2022-06-28 20:00:10', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 20:00:10', '2022-06-28 20:00:10', '2022-06-28 20:00:10', NULL, '2022-06-28 20:00:10', '2022-06-28 20:00:16', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('70', '1', '0', '1849a836-cfa4-4553-ada2-8b48ac81f7ec', '1849a836', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"70"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 20:00:12', '2022-06-28 20:00:12', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 20:00:12', '2022-06-28 20:00:12', '2022-06-28 20:00:12', NULL, '2022-06-28 20:00:12', '2022-06-28 20:00:18', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('71', '1', '0', '21323a94-be2c-4f41-bc60-8c9dae29beb8', '21323a94', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"71"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 20:00:14', '2022-06-28 20:00:14', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 20:00:14', '2022-06-28 20:00:14', '2022-06-28 20:00:14', NULL, '2022-06-28 20:00:14', '2022-06-28 20:00:20', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('72', '1', '0', 'e571ab70-1f46-4eaf-a63f-33d134de6205', 'e571ab70', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"72"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 20:00:17', '2022-06-28 20:00:17', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 20:00:17', '2022-06-28 20:00:17', '2022-06-28 20:00:17', NULL, '2022-06-28 20:00:17', '2022-06-28 20:00:23', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('73', '1', '0', '5fd7e934-f6b1-4240-8b61-6031aa92251d', '5fd7e934', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"73"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 20:00:20', '2022-06-28 20:00:20', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 20:00:20', '2022-06-28 20:00:20', '2022-06-28 20:00:20', NULL, '2022-06-28 20:00:20', '2022-06-28 20:00:26', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('74', '1', '0', '2123db18-0554-4218-93c6-551c9197c41e', '2123db18', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"74"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 21:02:10', '2022-06-28 21:02:10', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 21:02:10', '2022-06-28 21:02:10', '2022-06-28 21:02:10', NULL, '2022-06-28 21:02:10', '2022-06-28 21:02:16', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('75', '1', '0', 'ad5905e9-e9ad-4e60-90bd-c7007f53583b', 'ad5905e9', 'docker rmi nginx || true
docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"75"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 21:14:33', '2022-06-28 21:14:33', NULL, NULL, NULL, '0', 'Error response from daemon: conflict: unable to remove repository reference "nginx" (must force) - container d3988da799a0 is using its referenced image 55f4b40fe486
Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 21:14:33', '2022-06-28 21:14:33', '2022-06-28 21:14:33', NULL, '2022-06-28 21:14:33', '2022-06-28 21:14:39', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('76', '1', '0', 'aa2cfb00-7384-4da8-b0e6-49acd3be81a2', 'aa2cfb00', 'docker pull nginx

cd / && ls -l', '', '', 'BORROW_RUNNER_TIMEOUTED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"76"},{"key":"WORKFLOW_ID","value":"1"}]', '0', '2022-06-28 21:15:08', NULL, NULL, NULL, NULL, '0', '', '', '0', NULL, NULL, NULL, NULL, '2022-06-28 21:15:08', '2022-06-28 21:15:08', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('77', '1', '0', 'cbf212a0-5580-4cc8-9b99-1812b1a2a3a4', 'cbf212a0', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"77"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 21:15:11', '2022-06-28 21:15:11', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 21:15:11', '2022-06-28 21:15:11', '2022-06-28 21:15:11', NULL, '2022-06-28 21:15:11', '2022-06-28 21:15:17', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('78', '1', '0', '9d7d0ae0-6ec0-4812-b0ee-b74fdb1740d7', '9d7d0ae0', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"78"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 21:23:53', '2022-06-28 21:23:53', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 21:23:53', '2022-06-28 21:23:53', '2022-06-28 21:23:53', NULL, '2022-06-28 21:23:53', '2022-06-28 21:23:59', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('79', '1', '0', '2c9d40ea-d1b4-4cf0-a172-ad5e2778323f', '2c9d40ea', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"79"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:46:33', '2022-06-28 22:46:33', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 22:46:33', '2022-06-28 22:46:33', '2022-06-28 22:46:33', NULL, '2022-06-28 22:46:33', '2022-06-28 22:46:40', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('80', '1', '0', '6fb2f27c-518a-4be2-bf96-222f6d04fbb7', '6fb2f27c', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"80"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:46:42', '2022-06-28 22:46:42', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 22:46:42', '2022-06-28 22:46:42', '2022-06-28 22:46:42', NULL, '2022-06-28 22:46:42', '2022-06-28 22:46:48', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('81', '1', '0', '5c194527-c4a1-45cf-bf67-4f3040077e72', '5c194527', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_FAILED', 'exit status 1', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"81"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:47:44', '2022-06-28 22:47:44', NULL, NULL, NULL, '0', 'Using default tag: latest
Error response from daemon: Head "https://registry-1.docker.io/v2/library/nginx/manifests/latest": EOF
', '', '1', '2022-06-28 22:47:44', '2022-06-28 22:47:44', '2022-06-28 22:47:44', NULL, '2022-06-28 22:47:44', '2022-06-28 22:47:56', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('82', '1', '0', 'b9c0f476-d4e7-4c20-8d46-ed1dc284f87f', 'b9c0f476', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"82"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:47:56', '2022-06-28 22:47:56', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 22:47:56', '2022-06-28 22:47:56', '2022-06-28 22:47:56', NULL, '2022-06-28 22:47:56', '2022-06-28 22:48:01', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('83', '1', '0', 'fdae4f8e-3848-4f59-a8c9-8c0459a88fd7', 'fdae4f8e', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"83"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:48:38', '2022-06-28 22:48:38', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 22:48:38', '2022-06-28 22:48:38', '2022-06-28 22:48:38', NULL, '2022-06-28 22:48:38', '2022-06-28 22:48:45', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('84', '1', '0', '02cef47d-4dfc-41aa-a01d-7dae17883652', '02cef47d', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"84"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:49:45', '2022-06-28 22:49:45', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 22:49:45', '2022-06-28 22:49:45', '2022-06-28 22:49:45', NULL, '2022-06-28 22:49:45', '2022-06-28 22:49:51', NULL),
                                                                                                                                                                                                                                                                                                                                                                                                                                                                               ('85', '1', '0', '758b95c4-bbcf-43f3-9518-7f212238f13d', '758b95c4', 'docker pull nginx

cd / && ls -l', '', '', 'BUILD_SUCCEED', '', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"85"},{"key":"WORKFLOW_ID","value":"1"}]', '1', '2022-06-28 22:50:24', '2022-06-28 22:50:24', NULL, NULL, NULL, '0', 'Using default tag: latest
latest: Pulling from library/nginx
Digest: sha256:10f14ffa93f8dedf1057897b745e5ac72ac5655c299dade0aa434c71557697ea
Status: Image is up to date for nginx:latest
docker.io/library/nginx:latest
total 10
drwxrwxr-x  44 root  admin  1408 Jun 24 17:01 Applications
drwxr-xr-x  68 root  wheel  2176 May 17 19:53 Library
drwxr-xr-x@  9 root  wheel   288 Mar 26 15:21 System
drwxr-xr-x   6 root  admin   192 May 12 17:54 Users
drwxr-xr-x   4 root  wheel   128 Jun 21 11:18 Volumes
drwxr-xr-x@ 38 root  wheel  1216 Mar 26 15:21 bin
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 cores
dr-xr-xr-x   3 root  wheel  4624 Jun 20 10:21 dev
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 etc -> private/etc
lrwxr-xr-x   1 root  wheel    25 Jun 20 10:21 home -> /System/Volumes/Data/home
drwxr-xr-x   2 root  wheel    64 Mar 26 15:21 opt
drwxr-xr-x   6 root  wheel   192 Jun 20 10:21 private
drwxr-xr-x@ 65 root  wheel  2080 Mar 26 15:21 sbin
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 tmp -> private/tmp
drwxr-xr-x@ 11 root  wheel   352 Mar 26 15:21 usr
lrwxr-xr-x@  1 root  wheel    11 Mar 26 15:21 var -> private/var
', '', '1', '2022-06-28 22:50:24', '2022-06-28 22:50:24', '2022-06-28 22:50:24', NULL, '2022-06-28 22:50:24', '2022-06-28 22:50:32', NULL);

INSERT INTO "public"."runners" ("id", "code", "salt", "status", "last_status_changed_at", "last_dispatched_at", "created_at", "updated_at", "deleted_at") VALUES
    ('1', '1', '1', 'FAKE_RUNNING', NULL, NULL, NULL, '2022-06-29 00:19:25', NULL);

INSERT INTO "public"."workflows" ("id", "name", "yaml", "creator_id", "envs", "latest_pipeline_id", "latest_success_pipeline_id", "max_concurrent", "build_timeout_second", "created_at", "updated_at", "deleted_at") VALUES
    ('1', 'test-12313', 'docker pull nginx

cd / && ls -l', '1', '[]', '0', '0', '5', '1800', '2022-06-27 16:30:44', '2022-06-28 21:15:03', NULL);

