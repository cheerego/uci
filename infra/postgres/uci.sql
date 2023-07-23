-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: uci
-- Generation Time: 2022-07-30 00:42:12.3820
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
CREATE SEQUENCE IF NOT EXISTS pipelines_id_seq1;

-- Table Definition
CREATE TABLE "public"."pipelines" (
    "id" int8 NOT NULL DEFAULT nextval('pipelines_id_seq1'::regclass),
    "workflow_id" int4 NOT NULL,
    "number" int4 NOT NULL DEFAULT 0,
    "uuid" varchar(255) NOT NULL DEFAULT ''::character varying,
    "salt" varchar(255) NOT NULL DEFAULT ''::character varying,
    "yaml" text NOT NULL DEFAULT ''::text,
    "triggered_cause" text NOT NULL DEFAULT ''::text,
    "failed_cause" text NOT NULL DEFAULT ''::text,
    "status" varchar(255) NOT NULL DEFAULT 'BUILD_QUEUING'::character varying,
    "status_message" varchar(255) NOT NULL DEFAULT ''::character varying,
    "last_status_changed_at" timestamp(0),
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
CREATE SEQUENCE IF NOT EXISTS runners_id_seq1;

-- Table Definition
CREATE TABLE "public"."runners" (
    "id" int8 NOT NULL DEFAULT nextval('runners_id_seq1'::regclass),
    "code" varchar(255) NOT NULL DEFAULT ''::character varying,
    "salt" varchar(255) NOT NULL DEFAULT ''::character varying,
    "status" varchar(255) NOT NULL DEFAULT ''::character varying,
    "last_connected_at" timestamp(0),
    "last_disconnected_at" timestamp(0),
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
CREATE SEQUENCE IF NOT EXISTS workflows_id_seq;

-- Table Definition
CREATE TABLE "public"."workflows" (
    "id" int8 NOT NULL DEFAULT nextval('workflows_id_seq'::regclass),
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
('7', '2', '10', 'Operation z', 'fa-history', 'auth/logs', NULL, NULL, '2022-06-28 19:10:42'),
('8', '0', '1', 'Workflow', 'fa-bars', '/workflows', NULL, '2022-05-28 15:13:31', '2022-06-28 19:10:42'),
('9', '0', '2', 'Pipeline', 'fa-bars', '/pipelines', NULL, '2022-05-28 15:13:45', '2022-06-28 19:10:42'),
('10', '0', '3', 'Runner', 'fa-bars', '/runners', NULL, '2022-06-28 14:39:00', '2022-06-28 19:10:42');

INSERT INTO "public"."admin_operation_log" ("id", "user_id", "path", "method", "ip", "input", "created_at", "updated_at") VALUES
('1', '1', 'admin', 'GET', '172.19.0.5', '[]', '2022-07-30 00:32:12', '2022-07-30 00:32:12'),
('2', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:32:19', '2022-07-30 00:32:19'),
('3', '1', 'admin/workflows/create', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:32:23', '2022-07-30 00:32:23'),
('4', '1', 'admin/workflows', 'POST', '172.19.0.5', '{"name":"1212321312","yaml":"name: hello world\r\non: [ push ]\r\njobs:\r\n  - name: hello world\r\n    runs-on: ubuntu-latest\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo hello world","creator_id":null,"_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-07-30 00:32:38', '2022-07-30 00:32:38'),
('5', '1', 'admin/workflows', 'GET', '172.19.0.5', '[]', '2022-07-30 00:32:39', '2022-07-30 00:32:39'),
('6', '1', 'admin/_handle_action_', 'POST', '172.19.0.5', '{"revision":null,"param_envs":"[]","_key":"1","_model":"App_Models_Workflow","_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_action":"App_Admin_Actions_TriggerWorkflowAction"}', '2022-07-30 00:33:11', '2022-07-30 00:33:11'),
('7', '1', 'admin/workflows', 'GET', '172.19.0.5', '[]', '2022-07-30 00:36:29', '2022-07-30 00:36:29'),
('8', '1', 'admin/workflows/create', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:36:32', '2022-07-30 00:36:32'),
('9', '1', 'admin/workflows', 'POST', '172.19.0.5', '{"name":"123123","yaml":"name: hello world\r\non: [ push ]\r\njobs:\r\n  - name: hello world\r\n\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo hello world\r\n  - name: hello worldif\r\n    if: env.lys.length===3\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo $lys","creator_id":null,"envs":{"new_1":{"key":"lys","value":"666","_remove_":"0"}},"_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-07-30 00:37:33', '2022-07-30 00:37:33'),
('10', '1', 'admin/workflows', 'GET', '172.19.0.5', '[]', '2022-07-30 00:37:34', '2022-07-30 00:37:34'),
('11', '1', 'admin/_handle_action_', 'POST', '172.19.0.5', '{"revision":null,"param_envs":"[{\"key\":\"lys\",\"value\":\"666\"}]","_key":"1","_model":"App_Models_Workflow","_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_action":"App_Admin_Actions_TriggerWorkflowAction"}', '2022-07-30 00:37:38', '2022-07-30 00:37:38'),
('12', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:37:38', '2022-07-30 00:37:38'),
('13', '1', 'admin/runners', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:37:47', '2022-07-30 00:37:47'),
('14', '1', 'admin/runners/create', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:37:49', '2022-07-30 00:37:49'),
('15', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:38:14', '2022-07-30 00:38:14'),
('16', '1', 'admin/pipelines/1', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:38:18', '2022-07-30 00:38:18'),
('17', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:38:27', '2022-07-30 00:38:27'),
('18', '1', 'admin/workflows/1/edit', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:38:30', '2022-07-30 00:38:30'),
('19', '1', 'admin/workflows/1', 'PUT', '172.19.0.5', '{"name":"123123","yaml":"name: hello world\r\non: [ push ]\r\njobs:\r\n  - name: hello world\r\n\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo hello world\r\n  - name: hello worldif\r\n    if: env.lys== \"666\"\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo $lys","creator_id":"1","envs":[{"key":"lys","value":"666","_remove_":"0"}],"_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-07-30 00:38:43', '2022-07-30 00:38:43'),
('20', '1', 'admin/workflows', 'GET', '172.19.0.5', '[]', '2022-07-30 00:38:43', '2022-07-30 00:38:43'),
('21', '1', 'admin/_handle_action_', 'POST', '172.19.0.5', '{"revision":null,"param_envs":"[{\"key\":\"lys\",\"value\":\"666\"}]","_key":"1","_model":"App_Models_Workflow","_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_action":"App_Admin_Actions_TriggerWorkflowAction"}', '2022-07-30 00:38:47', '2022-07-30 00:38:47'),
('22', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:38:48', '2022-07-30 00:38:48'),
('23', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-07-30 00:38:53', '2022-07-30 00:38:53'),
('24', '1', 'admin/pipelines/2', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:38:57', '2022-07-30 00:38:57'),
('25', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:01', '2022-07-30 00:39:01'),
('26', '1', 'admin/workflows/1/edit', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:03', '2022-07-30 00:39:03'),
('27', '1', 'admin/workflows/1', 'PUT', '172.19.0.5', '{"name":"123123","yaml":"name: hello world\r\non: [ push ]\r\njobs:\r\n  - name: hello world\r\n\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo $lys\r\n  - name: hello worldif\r\n    if: env.lys== \"666\"\r\n    defaults:\r\n      run:\r\n        shell: bash\r\n    steps:\r\n      - run: echo $lys","creator_id":"1","envs":[{"key":"lys","value":"666","_remove_":"0"}],"_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_method":"PUT","_previous_":"http:\/\/admin.uci.127.0.0.1.nip.io\/admin\/workflows"}', '2022-07-30 00:39:12', '2022-07-30 00:39:12'),
('28', '1', 'admin/workflows', 'GET', '172.19.0.5', '[]', '2022-07-30 00:39:12', '2022-07-30 00:39:12'),
('29', '1', 'admin/_handle_action_', 'POST', '172.19.0.5', '{"revision":null,"param_envs":"[{\"key\":\"lys\",\"value\":\"666\"}]","_key":"1","_model":"App_Models_Workflow","_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_action":"App_Admin_Actions_TriggerWorkflowAction"}', '2022-07-30 00:39:16', '2022-07-30 00:39:16'),
('30', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:17', '2022-07-30 00:39:17'),
('31', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-07-30 00:39:19', '2022-07-30 00:39:19'),
('32', '1', 'admin/pipelines/3', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:22', '2022-07-30 00:39:22'),
('33', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:34', '2022-07-30 00:39:34'),
('34', '1', 'admin/runners', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:35', '2022-07-30 00:39:35'),
('35', '1', 'admin/runners', 'GET', '172.19.0.5', '[]', '2022-07-30 00:39:40', '2022-07-30 00:39:40'),
('36', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:43', '2022-07-30 00:39:43'),
('37', '1', 'admin/_handle_action_', 'POST', '172.19.0.5', '{"revision":null,"param_envs":"[{\"key\":\"lys\",\"value\":\"666\"}]","_key":"1","_model":"App_Models_Workflow","_token":"HDRRyD5CRor0777fsPw9HVpWzzqqOUc2eo6JwPJI","_action":"App_Admin_Actions_TriggerWorkflowAction"}', '2022-07-30 00:39:46', '2022-07-30 00:39:46'),
('38', '1', 'admin/workflows', 'GET', '172.19.0.5', '{"_pjax":"#pjax-container"}', '2022-07-30 00:39:47', '2022-07-30 00:39:47'),
('39', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-07-30 00:39:48', '2022-07-30 00:39:48'),
('40', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"workflow_id":"1"}', '2022-07-30 00:39:57', '2022-07-30 00:39:57'),
('41', '1', 'admin/pipelines', 'GET', '172.19.0.5', '{"workflow_id":"1","_pjax":"#pjax-container"}', '2022-07-30 00:40:34', '2022-07-30 00:40:34');

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
('6', '2022_04_29_075932_create_workflows_table', '2'),
('7', '2022_05_28_020537_create_pipelines_table', '2'),
('8', '2022_06_11_142611_create_runners_table', '2');

INSERT INTO "public"."pipelines" ("id", "workflow_id", "number", "uuid", "salt", "yaml", "triggered_cause", "failed_cause", "status", "status_message", "last_status_changed_at", "envs", "runner_id", "first_borrow_runner_at", "borrow_runner_succeed_at", "release_runner_at", "started_at", "closed_at", "duration", "raw_log", "prepare_log", "dispatch_times", "first_dispatched_at", "last_dispatched_at", "dispatch_succeed_at", "time_consuming", "created_at", "updated_at", "deleted_at") VALUES
('1', '1', '0', '7a993ee6-bf48-4dcc-9e0d-f621c319c7da', '7a993ee6', 'name: hello world
on: [ push ]
jobs:
  - name: hello world

    defaults:
      run:
        shell: bash
    steps:
      - run: echo hello world
  - name: hello worldif
    if: env.lys.length===3
    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys', '', '', 'BUILD_SUCCEED', '', '2022-07-30 00:38:07', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"1"},{"key":"WORKFLOW_ID","value":"1"},{"key":"lys","value":"666"}]', '1', '2022-07-30 00:37:38', '2022-07-30 00:38:05', NULL, NULL, NULL, '0', 'hello world
', '', '1', '2022-07-30 00:38:05', '2022-07-30 00:38:05', '2022-07-30 00:38:05', NULL, '2022-07-30 00:37:38', '2022-07-30 00:38:07', NULL),
('2', '1', '0', '7222b116-1481-4498-a8be-64be64e99862', '7222b116', 'name: hello world
on: [ push ]
jobs:
  - name: hello world

    defaults:
      run:
        shell: bash
    steps:
      - run: echo hello world
  - name: hello worldif
    if: env.lys== "666"
    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys', '', '', 'BUILD_SUCCEED', '', '2022-07-30 00:38:50', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"2"},{"key":"WORKFLOW_ID","value":"1"},{"key":"lys","value":"666"}]', '1', '2022-07-30 00:38:48', '2022-07-30 00:38:48', NULL, NULL, NULL, '0', 'hello world
', '', '1', '2022-07-30 00:38:48', '2022-07-30 00:38:48', '2022-07-30 00:38:48', NULL, '2022-07-30 00:38:48', '2022-07-30 00:38:50', NULL),
('3', '1', '0', 'e042f2c3-90e1-4225-b4ea-e8b3e54552a5', 'e042f2c3', 'name: hello world
on: [ push ]
jobs:
  - name: hello world

    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys
  - name: hello worldif
    if: env.lys== "666"
    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys', '', '', 'BUILD_SUCCEED', '', '2022-07-30 00:39:19', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"3"},{"key":"WORKFLOW_ID","value":"1"},{"key":"lys","value":"666"}]', '1', '2022-07-30 00:39:17', '2022-07-30 00:39:17', NULL, NULL, NULL, '0', '666
', '', '1', '2022-07-30 00:39:17', '2022-07-30 00:39:17', '2022-07-30 00:39:17', NULL, '2022-07-30 00:39:17', '2022-07-30 00:39:19', NULL),
('4', '1', '0', 'e64685bf-e543-4ea2-8df9-693419044c08', 'e64685bf', 'name: hello world
on: [ push ]
jobs:
  - name: hello world

    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys
  - name: hello worldif
    if: env.lys== "666"
    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys', '', '', 'BUILD_SUCCEED', '', '2022-07-30 00:40:32', '[{"key":"CI","value":"true"},{"key":"PIPELINE_ID","value":"4"},{"key":"WORKFLOW_ID","value":"1"},{"key":"lys","value":"666"}]', '1', '2022-07-30 00:39:47', '2022-07-30 00:40:30', NULL, NULL, NULL, '0', '666
', '', '1', '2022-07-30 00:40:30', '2022-07-30 00:40:30', '2022-07-30 00:40:30', NULL, '2022-07-30 00:39:47', '2022-07-30 00:40:32', NULL);

INSERT INTO "public"."runners" ("id", "code", "salt", "status", "last_connected_at", "last_disconnected_at", "last_dispatched_at", "created_at", "updated_at", "deleted_at") VALUES
('1', '1', '1', 'RUNNING', NULL, NULL, NULL, NULL, '2022-07-30 00:40:27', NULL);

INSERT INTO "public"."workflows" ("id", "name", "yaml", "creator_id", "envs", "latest_pipeline_id", "latest_success_pipeline_id", "max_concurrent", "build_timeout_second", "created_at", "updated_at", "deleted_at") VALUES
('1', '123123', 'name: hello world
on: [ push ]
jobs:
  - name: hello world

    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys
  - name: hello worldif
    if: env.lys== "666"
    defaults:
      run:
        shell: bash
    steps:
      - run: echo $lys', '1', '[{"key":"lys","value":"666"}]', '0', '0', '5', '1800', '2022-07-30 00:37:33', '2022-07-30 00:39:12', NULL);

