BEGIN;
--
-- Create model BudgetCode
--
CREATE TABLE "claims_budgetcode" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "code" varchar(50) NOT NULL UNIQUE, "description" varchar(255) NOT NULL, "is_active" bool NOT NULL);
--
-- Create model Division
--
CREATE TABLE "claims_division" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "name" varchar(150) NOT NULL UNIQUE);
--
-- Create model Employee
--
CREATE TABLE "claims_employee" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "employee_code" varchar(30) NOT NULL UNIQUE, "name" varchar(150) NOT NULL, "job_title" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "bank_account_number" varchar(50) NOT NULL, "bank_name" varchar(150) NOT NULL, "approver_first_id" bigint NULL REFERENCES "claims_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "approver_second_id" bigint NULL REFERENCES "claims_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "division_id" bigint NOT NULL REFERENCES "claims_division" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model ExpenseClaim
--
CREATE TABLE "claims_expenseclaim" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "document_id" varchar(30) NOT NULL UNIQUE, "submission_date" date NOT NULL, "currency" varchar(10) NOT NULL, "advance_received" decimal NOT NULL, "notes" text NOT NULL, "status" varchar(20) NOT NULL, "budget_code_id" bigint NOT NULL REFERENCES "claims_budgetcode" ("id") DEFERRABLE INITIALLY DEFERRED, "employee_id" bigint NOT NULL REFERENCES "claims_employee" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model ClaimAttachment
--
CREATE TABLE "claims_claimattachment" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "title" varchar(100) NOT NULL, "attachment" varchar(100) NOT NULL, "attachment_date" date NULL, "claim_id" bigint NOT NULL REFERENCES "claims_expenseclaim" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model ApprovalHistory
--
CREATE TABLE "claims_approvalhistory" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "level" smallint unsigned NOT NULL CHECK ("level" >= 0), "action" varchar(20) NOT NULL, "comment" text NOT NULL, "acted_at" datetime NOT NULL, "approver_id" bigint NOT NULL REFERENCES "claims_employee" ("id") DEFERRABLE INITIALLY DEFERRED, "claim_id" bigint NOT NULL REFERENCES "claims_expenseclaim" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model ExpenseItem
--
CREATE TABLE "claims_expenseitem" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "date" date NOT NULL, "odometer_start" integer unsigned NOT NULL CHECK ("odometer_start" >= 0), "odometer_end" integer unsigned NOT NULL CHECK ("odometer_end" >= 0), "purpose" varchar(255) NOT NULL, "transport_cost" decimal NOT NULL, "parking_cost" decimal NOT NULL, "toll_cost" decimal NOT NULL, "fuel_misc_cost" decimal NOT NULL, "receipt" varchar(100) NULL, "claim_id" bigint NOT NULL REFERENCES "claims_expenseclaim" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Create model Vehicle
--
CREATE TABLE "claims_vehicle" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "brand" varchar(100) NOT NULL, "model" varchar(100) NOT NULL, "registration_number" varchar(40) NOT NULL, "employee_id" bigint NOT NULL REFERENCES "claims_employee" ("id") DEFERRABLE INITIALLY DEFERRED);
--
-- Add field vehicle to expenseclaim
--
ALTER TABLE "claims_expenseclaim" ADD COLUMN "vehicle_id" bigint NULL REFERENCES "claims_vehicle" ("id") DEFERRABLE INITIALLY DEFERRED;
CREATE INDEX "claims_employee_approver_first_id_eb4bbd58" ON "claims_employee" ("approver_first_id");
CREATE INDEX "claims_employee_approver_second_id_fe97bcad" ON "claims_employee" ("approver_second_id");
CREATE INDEX "claims_employee_division_id_2ca5239a" ON "claims_employee" ("division_id");
CREATE INDEX "claims_expenseclaim_budget_code_id_68e12149" ON "claims_expenseclaim" ("budget_code_id");
CREATE INDEX "claims_expenseclaim_employee_id_18176052" ON "claims_expenseclaim" ("employee_id");
CREATE INDEX "claims_claimattachment_claim_id_8d31dcb5" ON "claims_claimattachment" ("claim_id");
CREATE INDEX "claims_approvalhistory_approver_id_b8df8453" ON "claims_approvalhistory" ("approver_id");
CREATE INDEX "claims_approvalhistory_claim_id_238b5d70" ON "claims_approvalhistory" ("claim_id");
CREATE INDEX "claims_expenseitem_claim_id_f2d8973a" ON "claims_expenseitem" ("claim_id");
CREATE UNIQUE INDEX "claims_vehicle_employee_id_registration_number_94a499df_uniq" ON "claims_vehicle" ("employee_id", "registration_number");
CREATE INDEX "claims_vehicle_employee_id_2be72ccd" ON "claims_vehicle" ("employee_id");
CREATE INDEX "claims_expenseclaim_vehicle_id_f89509ea" ON "claims_expenseclaim" ("vehicle_id");
COMMIT;
