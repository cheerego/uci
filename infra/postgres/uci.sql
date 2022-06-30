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
CREATE SEQUENCE IF NOT EXISTS pipelines_id_seq;

-- Table Definition
CREATE TABLE "public"."pipelines" (
                                      "id" int8 NOT NULL DEFAULT nextval('pipelines_id_seq'::regclass),
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


INSERT INTO "public"."runners" ("id", "code", "salt", "status", "last_status_changed_at", "last_dispatched_at", "created_at", "updated_at", "deleted_at") VALUES
    ('1', '1', '1', 'FAKE_RUNNING', NULL, NULL, NULL, '2022-06-29 00:19:25', NULL);

