-- Isolated demo schema (public DDL only, no row data).
-- Reviewed: no production emails, domains, project refs, or cron jobs.

-- Demo schema dump (public only, schema-only, no row data)
-- Generated for the isolated MPS demo. Not a production backup.
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

CREATE TABLE IF NOT EXISTS "ads_campaign_tags" (
  "tag_id" uuid NOT NULL,
  "platform" text NOT NULL,
  "campaign_row_id" text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "ads_campaign_tags_platform_check" CHECK ((platform = ANY (ARRAY['google'::text, 'facebook'::text]))),
  CONSTRAINT "ads_campaign_tags_pkey" PRIMARY KEY (tag_id, platform, campaign_row_id)
);
ALTER TABLE "ads_campaign_tags" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ads_discovered_domains" (
  "normalized_domain" text NOT NULL,
  "sample_url" text,
  "sources" text[] DEFAULT '{}'::text[] NOT NULL,
  "first_seen_at" timestamp with time zone DEFAULT now() NOT NULL,
  "last_seen_at" timestamp with time zone DEFAULT now() NOT NULL,
  "website_profile_id" text,
  "status" text DEFAULT 'unmatched'::text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "source_refs" jsonb DEFAULT '[]'::jsonb NOT NULL,
  CONSTRAINT "ads_discovered_domains_pkey" PRIMARY KEY (normalized_domain)
);
ALTER TABLE "ads_discovered_domains" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ads_tags" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "name" text NOT NULL,
  "color" text,
  "sort_order" integer DEFAULT 0 NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "ads_tags_pkey" PRIMARY KEY (id)
);
ALTER TABLE "ads_tags" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "artist_apply" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "invite_token" text,
  "application_no" text,
  "application_date" date,
  "status" text DEFAULT 'submitted'::text NOT NULL,
  "status_note" text,
  "submitted_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "name_zh" text,
  "name_en" text,
  "display_name" text,
  "gender" text,
  "birth_date" date,
  "age" text,
  "id_last_four" text,
  "nationality" text,
  "residence" text,
  "residence_other" text,
  "phone" text,
  "whatsapp" text,
  "email" text,
  "emergency_name" text,
  "emergency_relation" text,
  "emergency_phone" text,
  "categories" text[] DEFAULT '{}'::text[] NOT NULL,
  "category_other" text,
  "height" text,
  "weight" text,
  "shoe_size" text,
  "clothing_size" text,
  "hair_color" text,
  "languages" text[] DEFAULT '{}'::text[] NOT NULL,
  "language_other" text,
  "language_fluency" text,
  "read_script_ability" text,
  "adlib_ability" text,
  "outdoor_shooting" text,
  "studio_shooting" text,
  "live_streaming" text,
  "travel_availability" text[] DEFAULT '{}'::text[] NOT NULL,
  "early_night_shift" text,
  "weekend_holiday_work" text,
  "license_or_qualification" text,
  "special_talents" text,
  "instagram_account" text,
  "instagram_followers" text,
  "xiaohongshu_account" text,
  "xiaohongshu_followers" text,
  "youtube_account" text,
  "youtube_followers" text,
  "facebook_account" text,
  "facebook_followers" text,
  "tiktok_account" text,
  "tiktok_followers" text,
  "other_platform" text,
  "write_content_ability" text,
  "shoot_edit_ability" text,
  "live_commerce_experience" text,
  "live_commerce_details" text,
  "portfolio_links" text,
  "signed_company_before" text,
  "contract_status" text,
  "agency_company_name" text,
  "contract_period" text,
  "need_agency_consent" text,
  "previous_brands" text,
  "shooting_types" text[] DEFAULT '{}'::text[] NOT NULL,
  "representative_works" text,
  "pricing_modes" text[] DEFAULT '{}'::text[] NOT NULL,
  "price_range_from" text,
  "price_range_to" text,
  "reimbursable_expenses" text,
  "image_positioning" text[] DEFAULT '{}'::text[] NOT NULL,
  "development_focus" text,
  "unacceptable_jobs" text,
  "dream_brands" text,
  "company_support_directions" text[] DEFAULT '{}'::text[] NOT NULL,
  "company_support_other" text,
  "submitted_files" text[] DEFAULT '{}'::text[] NOT NULL,
  "other_file_note" text,
  "uploaded_file_names" text[] DEFAULT '{}'::text[] NOT NULL,
  "applicant_sign_date" date,
  "guardian_name" text,
  "guardian_signature_text" text,
  "guardian_sign_date" date,
  "raw_payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "interviewed" boolean DEFAULT false NOT NULL,
  "interview_rating" jsonb,
  "interview_overall" numeric(3,1),
  "interview_notes" text,
  "interview_scheduled_at" timestamp with time zone,
  "audition_media_urls" text[] DEFAULT '{}'::text[] NOT NULL,
  "report_hours" numeric(4,1),
  CONSTRAINT "artist_apply_pkey" PRIMARY KEY (id)
);
ALTER TABLE "artist_apply" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "artist_apply_photo" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "artist_apply_id" uuid NOT NULL,
  "file_role" text NOT NULL,
  "file_kind" text DEFAULT 'image'::text NOT NULL,
  "bucket" text DEFAULT 'artist-apply'::text NOT NULL,
  "storage_path" text,
  "public_url" text,
  "data_url" text,
  "external_url" text,
  "original_file_name" text,
  "mime_type" text,
  "file_size" bigint,
  "width" integer,
  "height" integer,
  "sort_order" integer DEFAULT 0 NOT NULL,
  "description" text,
  "metadata" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "artist_apply_photo_has_reference" CHECK (((storage_path IS NOT NULL) OR (data_url IS NOT NULL) OR (external_url IS NOT NULL) OR (original_file_name IS NOT NULL))),
  CONSTRAINT "artist_apply_photo_pkey" PRIMARY KEY (id)
);
ALTER TABLE "artist_apply_photo" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "asana_pitching_projects" (
  "project_gid" text NOT NULL,
  "project_name" text DEFAULT ''::text NOT NULL,
  "workspace_gid" text,
  "project_types" text[] DEFAULT '{}'::text[] NOT NULL,
  "enabled" boolean DEFAULT true NOT NULL,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "sync_year" integer,
  "status_field_name" text,
  "sync_year_from" integer,
  "sync_default_status" text,
  "sync_date_mode" text,
  "sync_section_name" text,
  "sync_project_types_only" boolean DEFAULT false NOT NULL,
  CONSTRAINT "asana_pitching_projects_sync_date_mode_check" CHECK (((sync_date_mode IS NULL) OR (sync_date_mode = ANY (ARRAY['created_exact'::text, 'created_from'::text, 'active_deal'::text, 'all'::text, 'pipeline'::text])))),
  CONSTRAINT "asana_pitching_projects_sync_default_status_check" CHECK (((sync_default_status IS NULL) OR (sync_default_status = ANY (ARRAY['initial'::text, 'following_up'::text, 'confirmed'::text, 'closed'::text])))),
  CONSTRAINT "asana_pitching_projects_pkey" PRIMARY KEY (project_gid)
);
ALTER TABLE "asana_pitching_projects" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "asana_pitching_sync_runs" (
  "id" text NOT NULL,
  "status" text DEFAULT 'running'::text NOT NULL,
  "tasks_fetched" integer DEFAULT 0 NOT NULL,
  "records_upserted" integer DEFAULT 0 NOT NULL,
  "projects_synced" integer DEFAULT 0 NOT NULL,
  "error_message" text,
  "started_at" timestamp with time zone DEFAULT now() NOT NULL,
  "finished_at" timestamp with time zone,
  "duration_ms" integer,
  "tasks_skipped" integer DEFAULT 0 NOT NULL,
  CONSTRAINT "asana_pitching_sync_runs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "asana_pitching_sync_runs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "asana_synced_tasks" (
  "asana_task_gid" text NOT NULL,
  "asana_project_gid" text,
  "asana_project_name" text,
  "asana_section_name" text,
  "display_name" text NOT NULL,
  "client_name" text,
  "inquiry_date" date NOT NULL,
  "description" text,
  "project_types" text[] DEFAULT '{}'::text[] NOT NULL,
  "assigned_pm" text,
  "assigned_pm_name" text DEFAULT ''::text NOT NULL,
  "mapped_status" text DEFAULT 'initial'::text NOT NULL,
  "asana_link" text,
  "synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "case_closed_reason" text,
  CONSTRAINT "asana_synced_tasks_mapped_status_check" CHECK ((mapped_status = ANY (ARRAY['initial'::text, 'following_up'::text, 'confirmed'::text, 'closed'::text]))),
  CONSTRAINT "asana_synced_tasks_pkey" PRIMARY KEY (asana_task_gid)
);
ALTER TABLE "asana_synced_tasks" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "backlink_purchases" (
  "id" text NOT NULL,
  "website_profile_id" text,
  "web_supplier_id" text NOT NULL,
  "cost" numeric DEFAULT 0 NOT NULL,
  "currency" text DEFAULT 'USD'::text NOT NULL,
  "purchase_date" date NOT NULL,
  "quantity" integer DEFAULT 1 NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "google_ads_customer_id" text,
  "source_domain" text,
  "excel_sheet" text,
  "google_ads_account_name" text,
  CONSTRAINT "backlink_purchases_currency_check" CHECK ((currency = ANY (ARRAY['USD'::text, 'HKD'::text]))),
  CONSTRAINT "backlink_purchases_pkey" PRIMARY KEY (id)
);
ALTER TABLE "backlink_purchases" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "brand_list" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "company_id" uuid NOT NULL,
  "brand_code" text NOT NULL,
  "display_name" text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "otc_id" uuid,
  CONSTRAINT "brand_list_pkey" PRIMARY KEY (id),
  CONSTRAINT "brand_list_brand_code_unique" UNIQUE (brand_code)
);
ALTER TABLE "brand_list" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "brand_list_legacy_20260807" (
  "id" text,
  "company_id" text,
  "brand_code" text,
  "brand_name_zh" text,
  "brand_name_en" text,
  "industry" text,
  "logo_url" text,
  "primary_color" text,
  "description" text,
  "is_active" boolean,
  "created_at" timestamp with time zone,
  "updated_at" timestamp with time zone,
  "company_code" text,
  "company_name" text,
  "official_url" text
);
ALTER TABLE "brand_list_legacy_20260807" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "company_list" (
  "id" text NOT NULL,
  "company_code" text NOT NULL,
  "company_name_zh" text NOT NULL,
  "company_name_en" text NOT NULL,
  "br_no" text DEFAULT ''::text NOT NULL,
  "bank_name" text DEFAULT ''::text NOT NULL,
  "bank_account" text DEFAULT ''::text NOT NULL,
  "address" text DEFAULT ''::text NOT NULL,
  "contact_person" text DEFAULT ''::text NOT NULL,
  "contact_phone" text DEFAULT ''::text NOT NULL,
  "contact_email" text DEFAULT ''::text NOT NULL,
  "logo_url" text,
  "is_active" boolean DEFAULT true NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "uuid" uuid DEFAULT gen_random_uuid() NOT NULL UNIQUE,
  "chop_url" text,
  "bank_notes" text,
  CONSTRAINT "company_list_pkey" PRIMARY KEY (id)
);
ALTER TABLE "company_list" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "confirmed_artist" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "source_form_id" uuid,
  "invite_token" text,
  "name_zh" text,
  "name_en" text,
  "gender" text,
  "age" text,
  "phone" text,
  "wechat" text,
  "height" text,
  "weight" text,
  "region" text,
  "photo_url" text,
  "categories" text[] DEFAULT '{}'::text[] NOT NULL,
  "rating" jsonb,
  "overall_rating" numeric(3,1),
  "interview_notes" text,
  "payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "signature_image" text,
  "source" text DEFAULT 'direct'::text NOT NULL,
  "confirmed_at" timestamp with time zone DEFAULT now() NOT NULL,
  "artist_apply_id" uuid,
  "cooperation_stage" text DEFAULT 'stage3'::text NOT NULL,
  CONSTRAINT "confirmed_artist_cooperation_stage_check" CHECK ((cooperation_stage = ANY (ARRAY['stage1'::text, 'stage2'::text, 'stage3'::text, 'stage4'::text, 'stage5'::text]))),
  CONSTRAINT "confirmed_artist_pkey" PRIMARY KEY (id)
);
ALTER TABLE "confirmed_artist" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "credit_cards" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "company_list_id" uuid NOT NULL,
  "last_four" text NOT NULL,
  "bank" text NOT NULL,
  "purpose" text DEFAULT ''::text NOT NULL,
  "holder" text DEFAULT ''::text NOT NULL,
  "custodian_id" uuid,
  "expiry" text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "label" text DEFAULT ''::text NOT NULL,
  "brand_list_id" uuid NOT NULL,
  CONSTRAINT "credit_cards_expiry_check" CHECK ((expiry ~ '^\d{4}-(0[1-9]|1[0-2])$'::text)),
  CONSTRAINT "credit_cards_last_four_check" CHECK ((last_four ~ '^\d{4}$'::text)),
  CONSTRAINT "credit_cards_pkey" PRIMARY KEY (id)
);
ALTER TABLE "credit_cards" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "day_report_entries" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "day_report_id" uuid NOT NULL,
  "category" text NOT NULL,
  "related_id" text,
  "related_name" text,
  "title" text DEFAULT ''::text NOT NULL,
  "hours" numeric(4,1) DEFAULT 0 NOT NULL,
  "outcome_type" text,
  "outcome_url" text,
  "outcome_images" jsonb,
  "growth_experience" text,
  "is_ai_assisted" boolean DEFAULT false NOT NULL,
  "ai_tools" jsonb,
  "sort_order" integer DEFAULT 0 NOT NULL,
  "created_at" timestamp with time zone DEFAULT now(),
  "ai_tools_v2" jsonb,
  "staff_id" uuid NOT NULL,
  CONSTRAINT "day_report_entries_pkey" PRIMARY KEY (id)
);
ALTER TABLE "day_report_entries" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "day_report_type" (
  "id" text NOT NULL,
  "label" text NOT NULL,
  "icon" text DEFAULT '📋'::text NOT NULL,
  "color" text DEFAULT 'text-blue-700'::text NOT NULL,
  "bg" text DEFAULT 'bg-blue-100'::text NOT NULL,
  "relation_type" text DEFAULT 'project_website'::text NOT NULL,
  "description" text DEFAULT ''::text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "sort_order" integer DEFAULT 0 NOT NULL,
  "associated_modules" text[] DEFAULT '{}'::text[] NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "day_report_type_pkey" PRIMARY KEY (id)
);
ALTER TABLE "day_report_type" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "day_reports" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "report_date" date NOT NULL,
  "total_hours" numeric(4,1) DEFAULT 0 NOT NULL,
  "target_hours" numeric(4,1) DEFAULT 8 NOT NULL,
  "ot_hours" numeric(4,1) DEFAULT 0 NOT NULL,
  "is_leave" boolean DEFAULT false NOT NULL,
  "is_half_day" boolean DEFAULT false NOT NULL,
  "leave_type" text,
  "office_location" text DEFAULT 'hk'::text NOT NULL,
  "is_holiday" boolean DEFAULT false NOT NULL,
  "is_weekend" boolean DEFAULT false NOT NULL,
  "under_hours_reason" text,
  "status" text DEFAULT 'submitted'::text NOT NULL,
  "submitted_at" timestamp with time zone DEFAULT now(),
  "reviewed_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now(),
  "staff_id" uuid NOT NULL,
  "reviewer_id" uuid,
  CONSTRAINT "day_reports_pkey" PRIMARY KEY (id),
  CONSTRAINT "day_reports_staff_id_report_date_key" UNIQUE (staff_id, report_date)
);
ALTER TABLE "day_reports" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "expenses" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "related_type" text DEFAULT 'project'::text NOT NULL,
  "related_id" uuid NOT NULL,
  "supplier_types_id" uuid NOT NULL,
  "supplier_id" text NOT NULL,
  "installment_number" integer,
  "billed_amount" numeric(14,2) DEFAULT 0 NOT NULL,
  "due_date" date,
  "payment_amount" numeric(14,2) DEFAULT 0 NOT NULL,
  "payment_date" date,
  "payment_method" text,
  "payment_status" text,
  "bad_debt" numeric(14,2) DEFAULT 0 NOT NULL,
  "outstanding" numeric(14,2) DEFAULT 0,
  "remarks" text,
  "payment_record_file_name" text,
  "payment_record_file_url" text,
  "payment_record_storage_path" text,
  "payment_record_file_size" bigint,
  "payment_record_mime_type" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "credit_card_id" uuid,
  "recurring_expense_id" uuid,
  "currency" text DEFAULT 'HKD'::text NOT NULL,
  CONSTRAINT "expenses_bad_debt_check" CHECK ((bad_debt >= (0)::numeric)),
  CONSTRAINT "expenses_billed_amount_check" CHECK ((billed_amount >= (0)::numeric)),
  CONSTRAINT "expenses_credit_card_required_check" CHECK ((((payment_method = 'Credit Card'::text) AND (credit_card_id IS NOT NULL)) OR ((payment_method IS DISTINCT FROM 'Credit Card'::text) AND (credit_card_id IS NULL)))),
  CONSTRAINT "expenses_currency_check" CHECK ((currency = ANY (ARRAY['HKD'::text, 'RMB'::text, 'USD'::text]))),
  CONSTRAINT "expenses_installment_number_check" CHECK (((installment_number IS NULL) OR (installment_number >= 1))),
  CONSTRAINT "expenses_payment_amount_check" CHECK ((payment_amount >= (0)::numeric)),
  CONSTRAINT "expenses_payment_method_check" CHECK (((payment_method IS NULL) OR (payment_method = ANY (ARRAY['Transfer'::text, 'Cash'::text, 'Cheque'::text, 'Credit Card'::text])))),
  CONSTRAINT "expenses_payment_status_check" CHECK (((payment_status IS NULL) OR (payment_status = ANY (ARRAY['Pending Check'::text, 'Paid'::text, 'Not Paid'::text])))),
  CONSTRAINT "expenses_related_type_check" CHECK ((related_type = 'project'::text)),
  CONSTRAINT "expenses_pkey" PRIMARY KEY (id)
);
ALTER TABLE "expenses" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "facebook_ads_accounts" (
  "ad_account_id" text NOT NULL,
  "account_name" text DEFAULT ''::text NOT NULL,
  "currency_code" text,
  "time_zone" text,
  "status" text DEFAULT 'UNKNOWN'::text NOT NULL,
  "account_status" integer,
  "business_key" text DEFAULT ''::text NOT NULL,
  "business_name" text DEFAULT ''::text NOT NULL,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "facebook_ads_accounts_pkey" PRIMARY KEY (ad_account_id)
);
ALTER TABLE "facebook_ads_accounts" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "facebook_ads_backfill_jobs" (
  "id" text NOT NULL,
  "status" text DEFAULT 'pending'::text NOT NULL,
  "history_start_date" date NOT NULL,
  "history_end_date" date NOT NULL,
  "cursor_month" date NOT NULL,
  "total_months" integer DEFAULT 0 NOT NULL,
  "completed_months" integer DEFAULT 0 NOT NULL,
  "rows_upserted" bigint DEFAULT 0 NOT NULL,
  "accounts_targeted" integer DEFAULT 0 NOT NULL,
  "error_count" integer DEFAULT 0 NOT NULL,
  "last_error" text,
  "started_at" timestamp with time zone,
  "finished_at" timestamp with time zone,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "meta" jsonb,
  CONSTRAINT "facebook_ads_backfill_jobs_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'running'::text, 'paused'::text, 'completed'::text, 'failed'::text, 'cancelled'::text]))),
  CONSTRAINT "facebook_ads_backfill_jobs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "facebook_ads_backfill_jobs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "facebook_ads_campaign_daily_metrics" (
  "ad_account_id" text NOT NULL,
  "campaign_id" text NOT NULL,
  "metric_date" date NOT NULL,
  "impressions" bigint DEFAULT 0 NOT NULL,
  "clicks" bigint DEFAULT 0 NOT NULL,
  "spend_micros" bigint DEFAULT 0 NOT NULL,
  "conversions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "average_cpc_micros" bigint,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "action_breakdown" jsonb DEFAULT '{}'::jsonb NOT NULL,
  CONSTRAINT "facebook_ads_campaign_daily_metrics_pkey" PRIMARY KEY (ad_account_id, campaign_id, metric_date)
);
ALTER TABLE "facebook_ads_campaign_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "facebook_ads_campaigns" (
  "id" text NOT NULL,
  "ad_account_id" text NOT NULL,
  "campaign_id" text NOT NULL,
  "campaign_name" text DEFAULT ''::text NOT NULL,
  "status" text DEFAULT 'UNKNOWN'::text NOT NULL,
  "objective" text,
  "impressions" bigint DEFAULT 0 NOT NULL,
  "clicks" bigint DEFAULT 0 NOT NULL,
  "spend_micros" bigint DEFAULT 0 NOT NULL,
  "conversions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "average_cpc_micros" bigint,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "brand_list_id" uuid,
  CONSTRAINT "facebook_ads_campaigns_pkey" PRIMARY KEY (id),
  CONSTRAINT "facebook_ads_campaigns_ad_account_id_campaign_id_key" UNIQUE (ad_account_id, campaign_id)
);
ALTER TABLE "facebook_ads_campaigns" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "facebook_ads_sync_runs" (
  "id" text NOT NULL,
  "started_at" timestamp with time zone DEFAULT now() NOT NULL,
  "finished_at" timestamp with time zone,
  "status" text DEFAULT 'running'::text NOT NULL,
  "accounts_synced" integer DEFAULT 0 NOT NULL,
  "campaigns_synced" integer DEFAULT 0 NOT NULL,
  "error_message" text,
  "meta" jsonb,
  CONSTRAINT "facebook_ads_sync_runs_status_check" CHECK ((status = ANY (ARRAY['running'::text, 'success'::text, 'error'::text]))),
  CONSTRAINT "facebook_ads_sync_runs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "facebook_ads_sync_runs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ga4_backfill_jobs" (
  "id" text NOT NULL,
  "status" text DEFAULT 'pending'::text NOT NULL,
  "history_start_date" date NOT NULL,
  "history_end_date" date NOT NULL,
  "cursor_month" date NOT NULL,
  "total_months" integer DEFAULT 0 NOT NULL,
  "completed_months" integer DEFAULT 0 NOT NULL,
  "rows_upserted" bigint DEFAULT 0 NOT NULL,
  "accounts_targeted" integer DEFAULT 0 NOT NULL,
  "error_count" integer DEFAULT 0 NOT NULL,
  "last_error" text,
  "started_at" timestamp with time zone,
  "finished_at" timestamp with time zone,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "meta" jsonb,
  CONSTRAINT "ga4_backfill_jobs_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'running'::text, 'paused'::text, 'completed'::text, 'failed'::text, 'cancelled'::text]))),
  CONSTRAINT "ga4_backfill_jobs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "ga4_backfill_jobs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ga4_channel_daily_metrics" (
  "property_id" text NOT NULL,
  "metric_date" date NOT NULL,
  "channel" text NOT NULL,
  "sessions" numeric DEFAULT 0 NOT NULL,
  "users" numeric DEFAULT 0 NOT NULL,
  "pageviews" numeric DEFAULT 0 NOT NULL,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "ga4_channel_daily_metrics_pkey" PRIMARY KEY (property_id, metric_date, channel)
);
ALTER TABLE "ga4_channel_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ga4_properties" (
  "property_id" text NOT NULL,
  "account_id" text,
  "account_name" text,
  "display_name" text,
  "stream_uri" text,
  "measurement_id" text,
  "website_profile_id" text,
  "matched_domain" text,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "ga4_properties_pkey" PRIMARY KEY (property_id)
);
ALTER TABLE "ga4_properties" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ga4_property_daily_metrics" (
  "property_id" text NOT NULL,
  "metric_date" date NOT NULL,
  "users" numeric DEFAULT 0 NOT NULL,
  "new_users" numeric DEFAULT 0 NOT NULL,
  "sessions" numeric DEFAULT 0 NOT NULL,
  "pageviews" numeric DEFAULT 0 NOT NULL,
  "engaged_sessions" numeric DEFAULT 0 NOT NULL,
  "conversions" numeric DEFAULT 0 NOT NULL,
  "avg_session_duration" numeric DEFAULT 0 NOT NULL,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "ga4_property_daily_metrics_pkey" PRIMARY KEY (property_id, metric_date)
);
ALTER TABLE "ga4_property_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "ga4_sync_runs" (
  "id" text NOT NULL,
  "status" text DEFAULT 'running'::text NOT NULL,
  "started_at" timestamp with time zone DEFAULT now() NOT NULL,
  "finished_at" timestamp with time zone,
  "properties_synced" integer DEFAULT 0 NOT NULL,
  "rows_upserted" integer DEFAULT 0 NOT NULL,
  "error_message" text,
  "meta" jsonb,
  CONSTRAINT "ga4_sync_runs_status_check" CHECK ((status = ANY (ARRAY['running'::text, 'success'::text, 'error'::text]))),
  CONSTRAINT "ga4_sync_runs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "ga4_sync_runs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_ads_accounts" (
  "customer_id" text NOT NULL,
  "descriptive_name" text DEFAULT ''::text NOT NULL,
  "currency_code" text,
  "time_zone" text,
  "status" text DEFAULT 'UNKNOWN'::text NOT NULL,
  "is_manager" boolean DEFAULT false NOT NULL,
  "level" integer DEFAULT 0 NOT NULL,
  "manager_customer_id" text,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "google_ads_accounts_pkey" PRIMARY KEY (customer_id)
);
ALTER TABLE "google_ads_accounts" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_ads_backfill_jobs" (
  "id" text NOT NULL,
  "status" text DEFAULT 'pending'::text NOT NULL,
  "history_start_date" date NOT NULL,
  "history_end_date" date NOT NULL,
  "cursor_month" date NOT NULL,
  "total_months" integer DEFAULT 0 NOT NULL,
  "completed_months" integer DEFAULT 0 NOT NULL,
  "rows_upserted" bigint DEFAULT 0 NOT NULL,
  "accounts_targeted" integer DEFAULT 0 NOT NULL,
  "error_count" integer DEFAULT 0 NOT NULL,
  "last_error" text,
  "started_at" timestamp with time zone,
  "finished_at" timestamp with time zone,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "meta" jsonb,
  CONSTRAINT "google_ads_backfill_jobs_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'running'::text, 'paused'::text, 'completed'::text, 'failed'::text, 'cancelled'::text]))),
  CONSTRAINT "google_ads_backfill_jobs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "google_ads_backfill_jobs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_ads_campaign_daily_metrics" (
  "customer_id" text NOT NULL,
  "campaign_id" text NOT NULL,
  "metric_date" date NOT NULL,
  "impressions" bigint DEFAULT 0 NOT NULL,
  "clicks" bigint DEFAULT 0 NOT NULL,
  "cost_micros" bigint DEFAULT 0 NOT NULL,
  "conversions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "average_cpc_micros" bigint,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "google_ads_campaign_daily_metrics_pkey" PRIMARY KEY (customer_id, campaign_id, metric_date)
);
ALTER TABLE "google_ads_campaign_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_ads_campaign_websites" (
  "customer_id" text NOT NULL,
  "campaign_id" text NOT NULL,
  "website_profile_id" text NOT NULL,
  "campaign_row_id" text NOT NULL,
  "matched_domain" text DEFAULT ''::text NOT NULL,
  "sample_final_url" text,
  "match_source" text DEFAULT 'final_url'::text NOT NULL,
  "last_seen_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "google_ads_campaign_websites_pkey" PRIMARY KEY (customer_id, campaign_id, website_profile_id)
);
ALTER TABLE "google_ads_campaign_websites" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_ads_campaigns" (
  "id" text NOT NULL,
  "customer_id" text NOT NULL,
  "campaign_id" text NOT NULL,
  "campaign_name" text DEFAULT ''::text NOT NULL,
  "status" text DEFAULT 'UNKNOWN'::text NOT NULL,
  "advertising_channel_type" text,
  "impressions" bigint DEFAULT 0 NOT NULL,
  "clicks" bigint DEFAULT 0 NOT NULL,
  "cost_micros" bigint DEFAULT 0 NOT NULL,
  "conversions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "average_cpc_micros" bigint,
  "metrics_start_date" date,
  "metrics_end_date" date,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "objectives" text[] DEFAULT '{}'::text[] NOT NULL,
  CONSTRAINT "google_ads_campaigns_pkey" PRIMARY KEY (id),
  CONSTRAINT "google_ads_campaigns_customer_id_campaign_id_key" UNIQUE (customer_id, campaign_id)
);
ALTER TABLE "google_ads_campaigns" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_ads_sync_runs" (
  "id" text NOT NULL,
  "started_at" timestamp with time zone DEFAULT now() NOT NULL,
  "finished_at" timestamp with time zone,
  "status" text DEFAULT 'running'::text NOT NULL,
  "accounts_synced" integer DEFAULT 0 NOT NULL,
  "campaigns_synced" integer DEFAULT 0 NOT NULL,
  "error_message" text,
  "meta" jsonb,
  CONSTRAINT "google_ads_sync_runs_status_check" CHECK ((status = ANY (ARRAY['running'::text, 'success'::text, 'error'::text]))),
  CONSTRAINT "google_ads_sync_runs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "google_ads_sync_runs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_business_registrations" (
  "id" text NOT NULL,
  "website_profile_id" text,
  "url" text NOT NULL,
  "registered_at" date NOT NULL,
  "content" text DEFAULT ''::text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "google_business_registrations_pkey" PRIMARY KEY (id)
);
ALTER TABLE "google_business_registrations" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "google_oauth_tokens" (
  "provider" text NOT NULL,
  "refresh_token" text NOT NULL,
  "last_used_at" timestamp with time zone,
  "last_rotated_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "google_oauth_tokens_pkey" PRIMARY KEY (provider)
);
ALTER TABLE "google_oauth_tokens" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "gsc_page_daily_metrics" (
  "site_url" text NOT NULL,
  "page" text NOT NULL,
  "metric_date" date NOT NULL,
  "clicks" numeric DEFAULT 0 NOT NULL,
  "impressions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "position" numeric,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "gsc_page_daily_metrics_pkey" PRIMARY KEY (site_url, page, metric_date)
);
ALTER TABLE "gsc_page_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "gsc_query_daily_metrics" (
  "site_url" text NOT NULL,
  "query" text NOT NULL,
  "metric_date" date NOT NULL,
  "clicks" numeric DEFAULT 0 NOT NULL,
  "impressions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "position" numeric,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "gsc_query_daily_metrics_pkey" PRIMARY KEY (site_url, query, metric_date)
);
ALTER TABLE "gsc_query_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "gsc_site_daily_metrics" (
  "site_url" text NOT NULL,
  "metric_date" date NOT NULL,
  "clicks" numeric DEFAULT 0 NOT NULL,
  "impressions" numeric DEFAULT 0 NOT NULL,
  "ctr" numeric,
  "position" numeric,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "gsc_site_daily_metrics_pkey" PRIMARY KEY (site_url, metric_date)
);
ALTER TABLE "gsc_site_daily_metrics" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "gsc_sites" (
  "site_url" text NOT NULL,
  "permission_level" text,
  "website_profile_id" text,
  "matched_domain" text,
  "last_synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "gsc_sites_pkey" PRIMARY KEY (site_url)
);
ALTER TABLE "gsc_sites" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "gsc_sync_runs" (
  "id" text NOT NULL,
  "started_at" timestamp with time zone DEFAULT now() NOT NULL,
  "finished_at" timestamp with time zone,
  "status" text DEFAULT 'running'::text NOT NULL,
  "sites_synced" integer DEFAULT 0 NOT NULL,
  "rows_upserted" bigint DEFAULT 0 NOT NULL,
  "keywords_upserted" integer DEFAULT 0 NOT NULL,
  "error_message" text,
  "meta" jsonb,
  CONSTRAINT "gsc_sync_runs_status_check" CHECK ((status = ANY (ARRAY['running'::text, 'success'::text, 'error'::text]))),
  CONSTRAINT "gsc_sync_runs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "gsc_sync_runs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "incomes" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "quotation_client_project_id" text NOT NULL,
  "type" text NOT NULL,
  "installment_number" integer,
  "billed_amount" numeric(14,2) DEFAULT 0 NOT NULL,
  "due_date" date,
  "payment_amount" numeric(14,2) DEFAULT 0 NOT NULL,
  "payment_method" text,
  "payment_status" text,
  "bad_debt" numeric(14,2) DEFAULT 0 NOT NULL,
  "outstanding" numeric(14,2) DEFAULT 0,
  "remarks" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "payment_record_file_name" text,
  "payment_record_file_url" text,
  "payment_record_storage_path" text,
  "payment_record_file_size" bigint,
  "payment_record_mime_type" text,
  "payment_date" date,
  "currency" text DEFAULT 'HKD'::text NOT NULL,
  CONSTRAINT "incomes_bad_debt_check" CHECK ((bad_debt >= (0)::numeric)),
  CONSTRAINT "incomes_billed_amount_check" CHECK ((billed_amount >= (0)::numeric)),
  CONSTRAINT "incomes_currency_check" CHECK ((currency = ANY (ARRAY['HKD'::text, 'RMB'::text, 'USD'::text]))),
  CONSTRAINT "incomes_installment_number_check" CHECK (((installment_number IS NULL) OR (installment_number >= 1))),
  CONSTRAINT "incomes_payment_amount_check" CHECK ((payment_amount >= (0)::numeric)),
  CONSTRAINT "incomes_payment_method_check" CHECK (((payment_method IS NULL) OR (payment_method = ANY (ARRAY['Transfer'::text, 'Cash'::text, 'Cheque'::text])))),
  CONSTRAINT "incomes_payment_status_check" CHECK (((payment_status IS NULL) OR (payment_status = ANY (ARRAY['Pending Check'::text, 'Received'::text, 'Not Received'::text])))),
  CONSTRAINT "incomes_type_check" CHECK ((type = ANY (ARRAY['主要收入'::text, '後加項目'::text, '代付項目'::text]))),
  CONSTRAINT "incomes_pkey" PRIMARY KEY (id)
);
ALTER TABLE "incomes" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "invoice_line_items" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "invoice_id" uuid NOT NULL,
  "item_name" text,
  "quantity" numeric(10,2),
  "price" numeric(12,2),
  "amount" numeric(12,2),
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "invoice_line_items_pkey" PRIMARY KEY (id)
);
ALTER TABLE "invoice_line_items" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "invoices" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "income_id" uuid NOT NULL,
  "invoice_no" text,
  "invoice_date" date,
  "due_date" date,
  "bill_to_name" text,
  "project_name" text,
  "main_item_name" text,
  "main_item_qty" numeric(10,2),
  "main_item_price" numeric(12,2),
  "main_item_amount" numeric(12,2),
  "enable_discount" boolean DEFAULT false NOT NULL,
  "discount_description" text,
  "discount_amount" numeric(12,2),
  "total_amount" numeric(12,2),
  "note" text,
  "company_id" uuid,
  "pdf_branding" jsonb,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "invoices_pkey" PRIMARY KEY (id),
  CONSTRAINT "invoices_income_id_key" UNIQUE (income_id)
);
ALTER TABLE "invoices" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "kol_apply" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "name" text,
  "salutation" text,
  "email" text,
  "phone" text,
  "age_group" text,
  "birth_month" text,
  "residence_area" text,
  "work_area" text,
  "blog_themes" text[] DEFAULT '{}'::text[] NOT NULL,
  "specialty" text,
  "instagram_account" text,
  "instagram_followers" integer,
  "facebook_url" text,
  "facebook_likes" integer,
  "xiaohongshu_url" text,
  "xiaohongshu_followers" integer,
  "youtube_url" text,
  "youtube_subscribers" integer,
  "openrice_url" text,
  "openrice_level" text,
  "blog_url" text,
  "blog_subscribers" integer,
  "other_channels" text,
  "other_followers" integer,
  "publish_platforms" text,
  "tasting_frequency" text,
  "tasting_experience" text,
  "model_experience" text,
  "on_camera_experience" text,
  "wine_club" text,
  "cooperation_intent" text,
  "available_times" text,
  "photo_url" text,
  "work_photo_url" text,
  "raw_payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "applied_at" timestamp with time zone DEFAULT now() NOT NULL,
  "audit_status" text DEFAULT 'pending_review'::text NOT NULL,
  "source" text,
  "login_code" text,
  "review_notes" text,
  "reviewed_at" timestamp with time zone,
  "reviewed_by" text,
  "kol_profile_id" uuid,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "video_blog_promo" text,
  "facebook_live_interest" text,
  "kol_new_beauty_id" uuid,
  CONSTRAINT "kol_apply_audit_status_check" CHECK ((audit_status = ANY (ARRAY['pending_review'::text, 'auto_passed'::text, 'approved'::text, 'added_to_db'::text, 'rejected'::text]))),
  CONSTRAINT "kol_apply_pkey" PRIMARY KEY (id)
);
ALTER TABLE "kol_apply" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "kol_cooperation" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "kol_profile_id" uuid,
  "project_name" text,
  "project_type" text,
  "fee" text,
  "evaluation" text,
  "cooperation_content" text,
  "platforms" text[] DEFAULT '{}'::text[] NOT NULL,
  "cooperated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_by" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "kol_new_beauty_id" uuid,
  CONSTRAINT "kol_cooperation_owner_check" CHECK (((kol_profile_id IS NOT NULL) OR (kol_new_beauty_id IS NOT NULL))),
  CONSTRAINT "kol_cooperation_pkey" PRIMARY KEY (id)
);
ALTER TABLE "kol_cooperation" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "kol_new_beauty" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "name" text,
  "salutation" text,
  "email" text,
  "phone" text,
  "age_group" text,
  "birth_month" text,
  "residence_area" text,
  "work_area" text,
  "blog_themes" text[] DEFAULT '{}'::text[] NOT NULL,
  "specialty" text,
  "instagram_account" text,
  "instagram_followers" integer,
  "facebook_url" text,
  "facebook_likes" integer,
  "xiaohongshu_url" text,
  "xiaohongshu_followers" integer,
  "youtube_url" text,
  "youtube_subscribers" integer,
  "openrice_url" text,
  "openrice_level" text,
  "blog_url" text,
  "blog_subscribers" integer,
  "other_channels" text,
  "other_followers" integer,
  "publish_platforms" text,
  "tasting_frequency" text,
  "tasting_experience" text,
  "model_experience" text,
  "on_camera_experience" text,
  "wine_club" text,
  "cooperation_intent" text,
  "available_times" text,
  "photo_url" text,
  "work_photo_url" text,
  "entry_number" text,
  "source_status" text,
  "source_created_at" text,
  "referrer_url" text,
  "raw_payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "video_blog_promo" text,
  "facebook_live_interest" text,
  "primary_category" text DEFAULT 'other'::text NOT NULL,
  "source_system" text DEFAULT 'manual'::text NOT NULL,
  "lifecycle_status" text DEFAULT 'unprocessed'::text NOT NULL,
  "tags" text[] DEFAULT '{}'::text[] NOT NULL,
  "fee_standard" text,
  "recognized_at" timestamp with time zone,
  "recognized_by" text,
  "shortlist_at" timestamp with time zone,
  "meeting_at" timestamp with time zone,
  "meeting_location" text,
  "meeting_notes" text,
  "meeting_status" text,
  "cooperated_at" timestamp with time zone,
  "rating_avg" numeric(4,2),
  "rating_count" integer DEFAULT 0 NOT NULL,
  "last_rated_at" timestamp with time zone,
  "meeting_owner" text,
  "kol_apply_id" uuid,
  CONSTRAINT "kol_new_beauty_pkey" PRIMARY KEY (id)
);
ALTER TABLE "kol_new_beauty" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "kol_profile" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "name" text,
  "salutation" text,
  "email" text,
  "phone" text,
  "age_group" text,
  "birth_month" text,
  "residence_area" text,
  "work_area" text,
  "blog_themes" text[] DEFAULT '{}'::text[] NOT NULL,
  "specialty" text,
  "instagram_account" text,
  "instagram_followers" integer,
  "facebook_url" text,
  "facebook_likes" integer,
  "xiaohongshu_url" text,
  "xiaohongshu_followers" integer,
  "youtube_url" text,
  "youtube_subscribers" integer,
  "openrice_url" text,
  "openrice_level" text,
  "blog_url" text,
  "blog_subscribers" integer,
  "other_channels" text,
  "other_followers" integer,
  "publish_platforms" text,
  "tasting_frequency" text,
  "tasting_experience" text,
  "model_experience" text,
  "on_camera_experience" text,
  "wine_club" text,
  "cooperation_intent" text,
  "available_times" text,
  "photo_url" text,
  "work_photo_url" text,
  "entry_number" text,
  "source_status" text,
  "source_created_at" text,
  "referrer_url" text,
  "raw_payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "video_blog_promo" text,
  "facebook_live_interest" text,
  "primary_category" text DEFAULT 'other'::text NOT NULL,
  "source_system" text DEFAULT 'manual'::text NOT NULL,
  "lifecycle_status" text DEFAULT 'unprocessed'::text NOT NULL,
  "tags" text[] DEFAULT '{}'::text[] NOT NULL,
  "fee_standard" text,
  "recognized_at" timestamp with time zone,
  "recognized_by" text,
  "shortlist_at" timestamp with time zone,
  "meeting_at" timestamp with time zone,
  "meeting_location" text,
  "meeting_notes" text,
  "meeting_status" text,
  "cooperated_at" timestamp with time zone,
  "rating_avg" numeric(4,2),
  "rating_count" integer DEFAULT 0 NOT NULL,
  "last_rated_at" timestamp with time zone,
  "meeting_owner" text,
  CONSTRAINT "kol_profile_lifecycle_status_check" CHECK ((lifecycle_status = ANY (ARRAY['unprocessed'::text, 'shortlist'::text, 'meeting'::text, 'cooperated'::text, 'star'::text]))),
  CONSTRAINT "kol_profile_meeting_status_check" CHECK (((meeting_status IS NULL) OR (meeting_status = ANY (ARRAY['pending'::text, 'scheduled'::text, 'completed'::text, 'cancelled'::text])))),
  CONSTRAINT "kol_profile_primary_category_check" CHECK ((primary_category = ANY (ARRAY['food'::text, 'beauty'::text, 'both'::text, 'other'::text]))),
  CONSTRAINT "kol_profile_source_system_check" CHECK ((source_system = ANY (ARRAY['foodies'::text, 'beauty18'::text, 'emailmeform'::text, 'manual'::text, 'excel'::text]))),
  CONSTRAINT "kol_profile_pkey" PRIMARY KEY (id)
);
ALTER TABLE "kol_profile" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "kol_rating" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "kol_profile_id" uuid,
  "rated_by" text,
  "score_professionalism" smallint NOT NULL,
  "score_cooperation" smallint NOT NULL,
  "score_content" smallint NOT NULL,
  "score_engagement" smallint NOT NULL,
  "overall_score" numeric(4,2) NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "kol_new_beauty_id" uuid,
  CONSTRAINT "kol_rating_owner_check" CHECK (((kol_profile_id IS NOT NULL) OR (kol_new_beauty_id IS NOT NULL))),
  CONSTRAINT "kol_rating_score_content_check" CHECK (((score_content >= 1) AND (score_content <= 5))),
  CONSTRAINT "kol_rating_score_cooperation_check" CHECK (((score_cooperation >= 1) AND (score_cooperation <= 5))),
  CONSTRAINT "kol_rating_score_engagement_check" CHECK (((score_engagement >= 1) AND (score_engagement <= 5))),
  CONSTRAINT "kol_rating_score_professionalism_check" CHECK (((score_professionalism >= 1) AND (score_professionalism <= 5))),
  CONSTRAINT "kol_rating_pkey" PRIMARY KEY (id)
);
ALTER TABLE "kol_rating" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "login_logs" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "user_id" uuid,
  "email" text NOT NULL,
  "login_method" text DEFAULT 'google'::text NOT NULL,
  "ip_address" text,
  "user_agent" text,
  "success" boolean DEFAULT true,
  "created_at" timestamp with time zone DEFAULT now(),
  CONSTRAINT "login_logs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "login_logs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "login_methods" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "login_method" text NOT NULL,
  "display_name" text NOT NULL,
  "account_name" text,
  "phone_number" text,
  "email" text,
  "password" text,
  "two_fa_methods" text[] DEFAULT '{}'::text[] NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "note" text,
  "is_active" boolean DEFAULT true NOT NULL,
  CONSTRAINT "login_methods_login_method_check" CHECK ((login_method = ANY (ARRAY['account_password'::text, 'email_password'::text, 'phone'::text, 'google'::text, 'wechat_scan'::text]))),
  CONSTRAINT "login_methods_two_fa_na_exclusive" CHECK ((NOT (('na'::text = ANY (two_fa_methods)) AND (cardinality(two_fa_methods) > 1)))),
  CONSTRAINT "login_methods_two_fa_valid" CHECK ((two_fa_methods <@ ARRAY['email'::text, 'sms'::text, 'authenticator'::text, 'mobile_app'::text, 'na'::text])),
  CONSTRAINT "login_methods_pkey" PRIMARY KEY (id)
);
ALTER TABLE "login_methods" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "pending_report_items" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "report_date" date NOT NULL,
  "source_module" text NOT NULL,
  "source_type" text NOT NULL,
  "source_id" text NOT NULL,
  "category" text NOT NULL,
  "related_id" text,
  "related_name" text,
  "title" text NOT NULL,
  "suggested_hours" numeric(4,1) DEFAULT 0 NOT NULL,
  "outcome_type" text,
  "outcome_url" text,
  "metadata" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "status" text DEFAULT 'pending'::text NOT NULL,
  "completed_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "staff_id" uuid NOT NULL,
  CONSTRAINT "pending_report_items_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'pulled'::text, 'consumed'::text, 'dismissed'::text]))),
  CONSTRAINT "pending_report_items_pkey" PRIMARY KEY (id),
  CONSTRAINT "pending_report_items_unique_source" UNIQUE (staff_id, source_module, source_type, source_id)
);
ALTER TABLE "pending_report_items" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "projects" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "related_id" text NOT NULL,
  "related_type" text NOT NULL,
  "name" text NOT NULL,
  "status" text DEFAULT ''::text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "company_list_id" uuid,
  "brand_list_id" uuid,
  "client_name" text,
  "meta" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "projects_related_type_check" CHECK ((related_type = ANY (ARRAY['quotation_client'::text, 'webandsystem'::text, 'vchannel'::text, 'manual'::text]))),
  CONSTRAINT "projects_pkey" PRIMARY KEY (id),
  CONSTRAINT "projects_related_type_related_id_key" UNIQUE (related_type, related_id)
);
ALTER TABLE "projects" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "quotation_bv" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "staff_id" uuid NOT NULL,
  "bv_ratio" numeric(6,2) NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "project_id" uuid NOT NULL,
  CONSTRAINT "quotation_bv_bv_ratio_check" CHECK (((bv_ratio > (0)::numeric) AND (bv_ratio <= (70)::numeric))),
  CONSTRAINT "quotation_bv_pkey" PRIMARY KEY (id),
  CONSTRAINT "quotation_bv_project_staff_key" UNIQUE (project_id, staff_id)
);
ALTER TABLE "quotation_bv" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "quotation_client_list" (
  "company_name_zh" text NOT NULL,
  "company_name_en" text,
  "brand_id" text,
  "contact_person" text DEFAULT ''::text NOT NULL,
  "phone" text,
  "email" text,
  "address" text,
  "inquiry_date" date DEFAULT CURRENT_DATE NOT NULL,
  "status" text DEFAULT 'prospect'::text NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "display_name" text DEFAULT ''::text NOT NULL,
  CONSTRAINT "quotation_client_list_status_check" CHECK ((status = ANY (ARRAY['active'::text, 'inactive'::text, 'prospect'::text]))),
  CONSTRAINT "quotation_client_list_pkey" PRIMARY KEY (id)
);
ALTER TABLE "quotation_client_list" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "quotation_client_project" (
  "id" text NOT NULL,
  "asana_task_gid" text,
  "asana_project_gid" text,
  "asana_project_name" text,
  "asana_section_name" text,
  "pitching_code" text,
  "client_name" text,
  "display_name" text NOT NULL,
  "inquiry_date" date NOT NULL,
  "description" text,
  "project_types" text[] DEFAULT '{}'::text[] NOT NULL,
  "assigned_pm" text,
  "assigned_pm_name" text DEFAULT ''::text NOT NULL,
  "status" text DEFAULT 'initial'::text NOT NULL,
  "asana_link" text,
  "notes" text,
  "synced_at" timestamp with time zone,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "estimated_income" numeric(14,2),
  "estimated_expenses" jsonb DEFAULT '[]'::jsonb NOT NULL,
  "client_id" uuid,
  "main_pm_id" uuid,
  "signed_date" date,
  "handover_date" date,
  "webandsystem_list_id" text,
  CONSTRAINT "pitching_records_status_check" CHECK ((status = ANY (ARRAY['initial'::text, 'following_up'::text, 'confirmed'::text, 'closed'::text]))),
  CONSTRAINT "pitching_records_pkey" PRIMARY KEY (id),
  CONSTRAINT "pitching_records_asana_task_gid_key" UNIQUE (asana_task_gid)
);
ALTER TABLE "quotation_client_project" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "quotation_doc_types" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "display" text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "quotation_doc_types_pkey" PRIMARY KEY (id),
  CONSTRAINT "quotation_doc_types_display_key" UNIQUE (display)
);
ALTER TABLE "quotation_doc_types" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "quotation_docs" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "quotation_client_project_id" text NOT NULL,
  "file_name" text NOT NULL,
  "file_url" text NOT NULL,
  "storage_path" text NOT NULL,
  "document_date" date,
  "expiry_date" date,
  "file_size" bigint,
  "mime_type" text,
  "created_by" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "doc_type" uuid NOT NULL,
  CONSTRAINT "quotation_docs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "quotation_docs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "receipt_line_items" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "receipt_id" uuid NOT NULL,
  "item_name" text,
  "quantity" numeric(10,2),
  "price" numeric(12,2),
  "amount" numeric(12,2),
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "receipt_line_items_pkey" PRIMARY KEY (id)
);
ALTER TABLE "receipt_line_items" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "receipts" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "income_id" uuid NOT NULL,
  "invoice_id" uuid,
  "receipt_no" text,
  "receipt_date" date,
  "payment_date" date,
  "received_from_name" text,
  "project_name" text,
  "amount_received" numeric(12,2),
  "payment_method" text,
  "notes" text,
  "enable_price_difference" boolean DEFAULT false NOT NULL,
  "price_difference" numeric(12,2),
  "price_difference_description" text,
  "company_id" uuid,
  "pdf_branding" jsonb,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "receipts_pkey" PRIMARY KEY (id),
  CONSTRAINT "receipts_income_id_key" UNIQUE (income_id)
);
ALTER TABLE "receipts" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "recurring_expenses" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "related_type" text DEFAULT 'project'::text NOT NULL,
  "related_id" uuid NOT NULL,
  "supplier_types_id" uuid NOT NULL,
  "supplier_id" text NOT NULL,
  "credit_card_id" uuid NOT NULL,
  "billed_amount" numeric(14,2) NOT NULL,
  "remarks" text,
  "frequency" text NOT NULL,
  "anchor_date" date NOT NULL,
  "next_occurrence_date" date NOT NULL,
  "automation_run_count" integer DEFAULT 0 NOT NULL,
  "last_generated_at" timestamp with time zone,
  "last_generated_due_date" date,
  "status" text DEFAULT 'active'::text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "recurring_expenses_automation_run_count_check" CHECK ((automation_run_count >= 0)),
  CONSTRAINT "recurring_expenses_billed_amount_check" CHECK ((billed_amount >= (0)::numeric)),
  CONSTRAINT "recurring_expenses_frequency_check" CHECK ((frequency = ANY (ARRAY['weekly'::text, 'monthly'::text, 'quarterly'::text, 'yearly'::text]))),
  CONSTRAINT "recurring_expenses_related_type_check" CHECK ((related_type = 'project'::text)),
  CONSTRAINT "recurring_expenses_status_check" CHECK ((status = ANY (ARRAY['active'::text, 'paused'::text]))),
  CONSTRAINT "recurring_expenses_pkey" PRIMARY KEY (id)
);
ALTER TABLE "recurring_expenses" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "rejected_artist" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "source_form_id" uuid,
  "invite_token" text,
  "name_zh" text,
  "name_en" text,
  "phone" text,
  "payload" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "signature_image" text,
  "reason" text,
  "source" text DEFAULT 'direct'::text NOT NULL,
  "rejected_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "rejected_artist_pkey" PRIMARY KEY (id)
);
ALTER TABLE "rejected_artist" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "seo_keywords" (
  "id" text DEFAULT (gen_random_uuid())::text NOT NULL,
  "website_profile_id" text NOT NULL,
  "keyword" text DEFAULT ''::text NOT NULL,
  "level" text DEFAULT 'level_1'::text NOT NULL,
  "search_volume" integer,
  "current_ranking" numeric,
  "target_ranking" integer,
  "target_page" text,
  "difficulty_score" integer,
  "assigned_article_id" text,
  "status" text DEFAULT 'monitoring'::text NOT NULL,
  "ai_generated" boolean DEFAULT false NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "normalized_keyword" text DEFAULT ''::text NOT NULL,
  "source" text DEFAULT 'manual'::text NOT NULL,
  "gsc_site_url" text,
  "last_gsc_sync_at" timestamp with time zone,
  CONSTRAINT "seo_keywords_level_check" CHECK ((level = ANY (ARRAY['level_1'::text, 'level_2'::text, 'level_3'::text]))),
  CONSTRAINT "seo_keywords_status_check" CHECK ((status = ANY (ARRAY['monitoring'::text, 'optimizing'::text, 'achieved'::text, 'paused'::text]))),
  CONSTRAINT "seo_keywords_pkey" PRIMARY KEY (id),
  CONSTRAINT "seo_keywords_website_normalized_key" UNIQUE (website_profile_id, normalized_keyword)
);
ALTER TABLE "seo_keywords" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "staffs" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "display_name" text DEFAULT ''::text NOT NULL,
  "full_name" text,
  "position" text,
  "user_role" text,
  "status" text DEFAULT 'active'::text NOT NULL,
  "work_email" text,
  "private_email" text,
  "work_phone" text,
  "private_phone" text,
  "base_location" text,
  "entry_date" date,
  "termination_date" text,
  "team_name" text,
  "profile_pic_url" text,
  "synced_at" timestamp with time zone DEFAULT now(),
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now(),
  "otc_staff_sync_id" uuid,
  "chinese_name" text,
  "company_list_id" uuid,
  "brand_list_id" uuid,
  CONSTRAINT "staffs_pkey" PRIMARY KEY (id),
  CONSTRAINT "staffs_otc_staff_sync_id_key" UNIQUE (otc_staff_sync_id)
);
ALTER TABLE "staffs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "supplier_login_methods" (
  "supplier_id" text NOT NULL,
  "login_method_id" uuid NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "supplier_login_methods_pkey" PRIMARY KEY (supplier_id, login_method_id)
);
ALTER TABLE "supplier_login_methods" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "supplier_types" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "categories" text NOT NULL,
  "display_name" text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "supplier_types_categories_check" CHECK ((categories = ANY (ARRAY['網站'::text, '活動'::text, '影片'::text]))),
  CONSTRAINT "supplier_types_pkey" PRIMARY KEY (id),
  CONSTRAINT "supplier_types_categories_display_name_key" UNIQUE (categories, display_name)
);
ALTER TABLE "supplier_types" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "suppliers" (
  "id" text NOT NULL,
  "display_name" text NOT NULL,
  "url" text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "supplier_types_id" uuid,
  "description" text DEFAULT ''::text NOT NULL,
  "company_name" text DEFAULT ''::text NOT NULL,
  "contact_person" text DEFAULT ''::text NOT NULL,
  "phone" text DEFAULT ''::text NOT NULL,
  "email" text DEFAULT ''::text NOT NULL,
  "remarks" text DEFAULT ''::text NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  CONSTRAINT "web_page_suppliers_pkey" PRIMARY KEY (id)
);
ALTER TABLE "suppliers" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "system_options" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "category" text NOT NULL,
  "value" text NOT NULL,
  "sort_order" integer DEFAULT 0,
  "created_at" timestamp with time zone DEFAULT now(),
  "updated_at" timestamp with time zone DEFAULT now(),
  CONSTRAINT "system_options_pkey" PRIMARY KEY (id)
);
ALTER TABLE "system_options" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "upcoming_event" (
  "id" text NOT NULL,
  "title" text NOT NULL,
  "type" text NOT NULL,
  "event_date" date NOT NULL,
  "company" text DEFAULT ''::text NOT NULL,
  "brand" text DEFAULT ''::text NOT NULL,
  "platform" text,
  "hours" numeric,
  "notes" text,
  "status" text DEFAULT 'pending_publish'::text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "upcoming_event_status_check" CHECK ((status = ANY (ARRAY['pending_publish'::text, 'published'::text]))),
  CONSTRAINT "upcoming_event_pkey" PRIMARY KEY (id)
);
ALTER TABLE "upcoming_event" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "users" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "role_tag" text,
  "updated_at" timestamp with time zone DEFAULT now(),
  "created_at" timestamp with time zone DEFAULT now(),
  "email" text,
  "staff_id" uuid NOT NULL,
  "auth_user_id" uuid,
  CONSTRAINT "users_pkey" PRIMARY KEY (id),
  CONSTRAINT "users_auth_user_id_key" UNIQUE (auth_user_id),
  CONSTRAINT "users_staff_id_key" UNIQUE (staff_id)
);
ALTER TABLE "users" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "vchannel_account_login_methods" (
  "vchannel_account_id" uuid NOT NULL,
  "login_method_id" uuid NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "vchannel_account_login_methods_pkey" PRIMARY KEY (vchannel_account_id, login_method_id)
);
ALTER TABLE "vchannel_account_login_methods" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "vchannel_accounts" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "vchannel_codes" text[] NOT NULL,
  "account_label" text DEFAULT ''::text NOT NULL,
  "platform" text NOT NULL,
  "account_id" text,
  "login_method" text,
  "feedhive_managed" boolean DEFAULT false NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "is_active" boolean DEFAULT true NOT NULL,
  CONSTRAINT "vchannel_accounts_platform_check" CHECK ((platform = ANY (ARRAY['youtube'::text, 'instagram'::text, 'facebook'::text, 'xiaohongshu'::text, 'wechat_channels'::text, 'douyin'::text, 'threads'::text, 'linkedin'::text]))),
  CONSTRAINT "vchannel_accounts_pkey" PRIMARY KEY (id)
);
ALTER TABLE "vchannel_accounts" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "vchannels" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "channel_code" character varying(10) NOT NULL,
  "internal_name" text NOT NULL,
  "public_name" text NOT NULL,
  "importance" text DEFAULT 'A3'::text NOT NULL,
  "status" text DEFAULT 'active'::text NOT NULL,
  "platform_status" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "brand_list_id" uuid,
  CONSTRAINT "vchannels_importance_check" CHECK ((importance = ANY (ARRAY['A1'::text, 'A2'::text, 'A3'::text, 'A4'::text, 'A5'::text]))),
  CONSTRAINT "vchannels_status_check" CHECK ((status = ANY (ARRAY['active'::text, 'paused'::text, 'archived'::text]))),
  CONSTRAINT "vchannels_pkey" PRIMARY KEY (id),
  CONSTRAINT "vchannels_channel_code_key" UNIQUE (channel_code)
);
ALTER TABLE "vchannels" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "video_output" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "vchannel_id" uuid NOT NULL,
  "production_year" smallint,
  "video_code" character varying(60) NOT NULL,
  "title" text NOT NULL,
  "asana_task_id" text,
  "asana_url" text,
  "shoot_sz" boolean DEFAULT false NOT NULL,
  "shoot_hk" boolean DEFAULT false NOT NULL,
  "raw_footage_done" boolean DEFAULT false NOT NULL,
  "needs_editing" boolean,
  "demo_done" boolean DEFAULT false NOT NULL,
  "shoot_at" date,
  "planned_publish_date" date,
  "published_date" date,
  "platform_publish" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "storage_path" text,
  "project_category" text DEFAULT 'client'::text NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "copy_sc" boolean DEFAULT false NOT NULL,
  "copy_tc" boolean DEFAULT false NOT NULL,
  "copy_en" boolean DEFAULT false NOT NULL,
  "subtitle_done" boolean DEFAULT false NOT NULL,
  "reviewed" boolean DEFAULT false NOT NULL,
  "workflow_stage" text DEFAULT 'prep'::text NOT NULL,
  "prep_assignments" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "production_progress" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "location_notes" text,
  "review_reject_reason" text,
  "submitted_for_review_at" timestamp with time zone,
  "reviewed_at" timestamp with time zone,
  "reviewed_by" text,
  "admin_review_passed" boolean DEFAULT false NOT NULL,
  "admin_reviewed_at" timestamp with time zone,
  "admin_reviewed_by" text,
  CONSTRAINT "video_output_project_category_check" CHECK ((project_category = ANY (ARRAY['internal'::text, 'client'::text]))),
  CONSTRAINT "video_output_workflow_stage_check" CHECK ((workflow_stage = ANY (ARRAY['prep'::text, 'production'::text, 'review'::text, 'publish'::text, 'published'::text, 'delisted'::text]))),
  CONSTRAINT "video_output_pkey" PRIMARY KEY (id),
  CONSTRAINT "video_output_video_code_key" UNIQUE (video_code)
);
ALTER TABLE "video_output" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "video_output_work_logs" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "video_output_id" uuid NOT NULL,
  "staff_name" text,
  "work_date" date NOT NULL,
  "hours" numeric(4,1) NOT NULL,
  "work_type" text DEFAULT 'editing'::text NOT NULL,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "staff_id" uuid NOT NULL,
  "created_by" uuid,
  CONSTRAINT "video_output_work_logs_hours_check" CHECK ((hours > (0)::numeric)),
  CONSTRAINT "video_output_work_logs_work_type_check" CHECK ((work_type = ANY (ARRAY['editing'::text, 'color'::text, 'subtitle'::text, 'shoot'::text, 'other'::text]))),
  CONSTRAINT "video_output_work_logs_pkey" PRIMARY KEY (id)
);
ALTER TABLE "video_output_work_logs" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "volunteer_apply" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "campaign_id" uuid NOT NULL,
  "status" text DEFAULT 'pending'::text NOT NULL,
  "status_note" text,
  "name" text NOT NULL,
  "phone" text,
  "whatsapp" text,
  "email" text,
  "instagram_account" text NOT NULL,
  "follower_count" integer NOT NULL,
  "treatment_type" text NOT NULL,
  "skin_concerns" text,
  "agree_followup" boolean DEFAULT true NOT NULL,
  "reviewed_at" timestamp with time zone,
  "reviewed_by" text,
  "submitted_at" timestamp with time zone DEFAULT now() NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "volunteer_apply_follower_count_check" CHECK ((follower_count >= 0)),
  CONSTRAINT "volunteer_apply_status_check" CHECK ((status = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text]))),
  CONSTRAINT "volunteer_apply_treatment_type_check" CHECK ((treatment_type = ANY (ARRAY['face'::text, 'body'::text]))),
  CONSTRAINT "volunteer_apply_pkey" PRIMARY KEY (id)
);
ALTER TABLE "volunteer_apply" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "volunteer_campaign" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "slug" text NOT NULL,
  "title" text NOT NULL,
  "product_name" text,
  "description" text,
  "incentive" text,
  "deliverables" text,
  "requirements_note" text,
  "min_followers" integer DEFAULT 5000 NOT NULL,
  "face_quota" integer DEFAULT 20 NOT NULL,
  "body_quota" integer DEFAULT 20 NOT NULL,
  "deadline" timestamp with time zone,
  "status" text DEFAULT 'draft'::text NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "volunteer_campaign_body_quota_check" CHECK ((body_quota >= 0)),
  CONSTRAINT "volunteer_campaign_face_quota_check" CHECK ((face_quota >= 0)),
  CONSTRAINT "volunteer_campaign_min_followers_check" CHECK ((min_followers >= 0)),
  CONSTRAINT "volunteer_campaign_slug_format" CHECK ((slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'::text)),
  CONSTRAINT "volunteer_campaign_status_check" CHECK ((status = ANY (ARRAY['draft'::text, 'open'::text, 'closed'::text]))),
  CONSTRAINT "volunteer_campaign_pkey" PRIMARY KEY (id)
);
ALTER TABLE "volunteer_campaign" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "webandsystem_duplicate_conflicts" (
  "canonical_domain" text NOT NULL,
  "profile_ids" text[] NOT NULL,
  "reason" text NOT NULL,
  "details" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "webandsystem_duplicate_conflicts_pkey" PRIMARY KEY (canonical_domain)
);
ALTER TABLE "webandsystem_duplicate_conflicts" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "webandsystem_list" (
  "id" text NOT NULL,
  "website_name" text NOT NULL,
  "domain_url" text,
  "profile_type" text DEFAULT 'website'::text NOT NULL,
  "project_category" text DEFAULT 'internal'::text NOT NULL,
  "level" integer DEFAULT 3 NOT NULL,
  "platform" text,
  "brand" text,
  "company" text,
  "status" text DEFAULT 'live'::text NOT NULL,
  "articles_count" integer DEFAULT 0 NOT NULL,
  "videos_count" integer DEFAULT 0 NOT NULL,
  "total_hours" integer DEFAULT 0 NOT NULL,
  "project_id" text,
  "company_id" text,
  "brand_id" text,
  "notes" text,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  "updated_at" timestamp with time zone DEFAULT now() NOT NULL,
  "hosting_provider" text,
  "system_type" text,
  "google_ads_customer_id" text,
  "brand_list_id" uuid,
  "company_list_id" uuid,
  "ga4_property_id" text,
  "gsc_site_url" text,
  CONSTRAINT "webandsystem_list_pkey" PRIMARY KEY (id)
);
ALTER TABLE "webandsystem_list" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "webandsystem_merge_log" (
  "id" bigint NOT NULL,
  "keeper_id" text NOT NULL,
  "loser_ids" text[] NOT NULL,
  "canonical_domain" text,
  "coalesced_fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "discarded_fields" jsonb DEFAULT '{}'::jsonb NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "webandsystem_merge_log_pkey" PRIMARY KEY (id)
);
ALTER TABLE "webandsystem_merge_log" ENABLE ROW LEVEL SECURITY;

CREATE TABLE IF NOT EXISTS "website_video_links" (
  "id" uuid DEFAULT gen_random_uuid() NOT NULL,
  "website_profile_id" text NOT NULL,
  "video_output_id" uuid NOT NULL,
  "created_at" timestamp with time zone DEFAULT now() NOT NULL,
  CONSTRAINT "website_video_links_pkey" PRIMARY KEY (id),
  CONSTRAINT "website_video_links_website_profile_id_video_output_id_key" UNIQUE (website_profile_id, video_output_id)
);
ALTER TABLE "website_video_links" ENABLE ROW LEVEL SECURITY;

DO $$ BEGIN ALTER TABLE "ads_campaign_tags" ADD CONSTRAINT "ads_campaign_tags_tag_id_fkey" FOREIGN KEY (tag_id) REFERENCES ads_tags(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "ads_discovered_domains" ADD CONSTRAINT "ads_discovered_domains_website_profile_id_fkey" FOREIGN KEY (website_profile_id) REFERENCES webandsystem_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "artist_apply_photo" ADD CONSTRAINT "artist_apply_photo_artist_apply_id_fkey" FOREIGN KEY (artist_apply_id) REFERENCES artist_apply(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "backlink_purchases" ADD CONSTRAINT "backlink_purchases_web_supplier_id_fkey" FOREIGN KEY (web_supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "brand_list" ADD CONSTRAINT "brand_list_company_id_fkey" FOREIGN KEY (company_id) REFERENCES company_list(uuid) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "confirmed_artist" ADD CONSTRAINT "confirmed_artist_artist_apply_id_fkey" FOREIGN KEY (artist_apply_id) REFERENCES artist_apply(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "credit_cards" ADD CONSTRAINT "credit_cards_brand_list_id_fkey" FOREIGN KEY (brand_list_id) REFERENCES brand_list(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "credit_cards" ADD CONSTRAINT "credit_cards_company_list_id_fkey" FOREIGN KEY (company_list_id) REFERENCES company_list(uuid) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "credit_cards" ADD CONSTRAINT "credit_cards_custodian_id_fkey" FOREIGN KEY (custodian_id) REFERENCES staffs(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "day_report_entries" ADD CONSTRAINT "day_report_entries_day_report_id_fkey" FOREIGN KEY (day_report_id) REFERENCES day_reports(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "day_report_entries" ADD CONSTRAINT "day_report_entries_staff_id_fkey" FOREIGN KEY (staff_id) REFERENCES staffs(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "day_reports" ADD CONSTRAINT "day_reports_reviewer_id_fkey" FOREIGN KEY (reviewer_id) REFERENCES staffs(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "day_reports" ADD CONSTRAINT "day_reports_staff_id_fkey" FOREIGN KEY (staff_id) REFERENCES staffs(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "expenses" ADD CONSTRAINT "expenses_credit_card_id_fkey" FOREIGN KEY (credit_card_id) REFERENCES credit_cards(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "expenses" ADD CONSTRAINT "expenses_recurring_expense_id_fkey" FOREIGN KEY (recurring_expense_id) REFERENCES recurring_expenses(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "expenses" ADD CONSTRAINT "expenses_related_id_fkey" FOREIGN KEY (related_id) REFERENCES projects(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "expenses" ADD CONSTRAINT "expenses_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "expenses" ADD CONSTRAINT "expenses_supplier_types_id_fkey" FOREIGN KEY (supplier_types_id) REFERENCES supplier_types(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "facebook_ads_campaigns" ADD CONSTRAINT "facebook_ads_campaigns_ad_account_id_fkey" FOREIGN KEY (ad_account_id) REFERENCES facebook_ads_accounts(ad_account_id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "facebook_ads_campaigns" ADD CONSTRAINT "facebook_ads_campaigns_brand_list_id_fkey" FOREIGN KEY (brand_list_id) REFERENCES brand_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "ga4_channel_daily_metrics" ADD CONSTRAINT "ga4_channel_daily_metrics_property_id_fkey" FOREIGN KEY (property_id) REFERENCES ga4_properties(property_id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "ga4_properties" ADD CONSTRAINT "ga4_properties_website_profile_id_fkey" FOREIGN KEY (website_profile_id) REFERENCES webandsystem_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "ga4_property_daily_metrics" ADD CONSTRAINT "ga4_property_daily_metrics_property_id_fkey" FOREIGN KEY (property_id) REFERENCES ga4_properties(property_id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "google_ads_campaign_websites" ADD CONSTRAINT "google_ads_campaign_websites_website_profile_id_fkey" FOREIGN KEY (website_profile_id) REFERENCES webandsystem_list(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "google_ads_campaigns" ADD CONSTRAINT "google_ads_campaigns_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES google_ads_accounts(customer_id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "gsc_page_daily_metrics" ADD CONSTRAINT "gsc_page_daily_metrics_site_url_fkey" FOREIGN KEY (site_url) REFERENCES gsc_sites(site_url) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "gsc_query_daily_metrics" ADD CONSTRAINT "gsc_query_daily_metrics_site_url_fkey" FOREIGN KEY (site_url) REFERENCES gsc_sites(site_url) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "gsc_site_daily_metrics" ADD CONSTRAINT "gsc_site_daily_metrics_site_url_fkey" FOREIGN KEY (site_url) REFERENCES gsc_sites(site_url) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "gsc_sites" ADD CONSTRAINT "gsc_sites_website_profile_id_fkey" FOREIGN KEY (website_profile_id) REFERENCES webandsystem_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "incomes" ADD CONSTRAINT "incomes_quotation_client_project_id_fkey" FOREIGN KEY (quotation_client_project_id) REFERENCES quotation_client_project(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "invoice_line_items" ADD CONSTRAINT "invoice_line_items_invoice_id_fkey" FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "invoices" ADD CONSTRAINT "invoices_company_id_fkey" FOREIGN KEY (company_id) REFERENCES company_list(uuid) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "invoices" ADD CONSTRAINT "invoices_income_id_fkey" FOREIGN KEY (income_id) REFERENCES incomes(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_apply" ADD CONSTRAINT "kol_apply_kol_new_beauty_id_fkey" FOREIGN KEY (kol_new_beauty_id) REFERENCES kol_new_beauty(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_apply" ADD CONSTRAINT "kol_apply_kol_profile_id_fkey" FOREIGN KEY (kol_profile_id) REFERENCES kol_profile(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_cooperation" ADD CONSTRAINT "kol_cooperation_kol_new_beauty_id_fkey" FOREIGN KEY (kol_new_beauty_id) REFERENCES kol_new_beauty(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_cooperation" ADD CONSTRAINT "kol_cooperation_kol_profile_id_fkey" FOREIGN KEY (kol_profile_id) REFERENCES kol_profile(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_new_beauty" ADD CONSTRAINT "kol_new_beauty_kol_apply_id_fkey" FOREIGN KEY (kol_apply_id) REFERENCES kol_apply(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_rating" ADD CONSTRAINT "kol_rating_kol_new_beauty_id_fkey" FOREIGN KEY (kol_new_beauty_id) REFERENCES kol_new_beauty(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "kol_rating" ADD CONSTRAINT "kol_rating_kol_profile_id_fkey" FOREIGN KEY (kol_profile_id) REFERENCES kol_profile(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "login_logs" ADD CONSTRAINT "login_logs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "pending_report_items" ADD CONSTRAINT "pending_report_items_staff_id_fkey" FOREIGN KEY (staff_id) REFERENCES staffs(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "projects" ADD CONSTRAINT "projects_brand_list_id_fkey" FOREIGN KEY (brand_list_id) REFERENCES brand_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "projects" ADD CONSTRAINT "projects_company_list_id_fkey" FOREIGN KEY (company_list_id) REFERENCES company_list(uuid) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_bv" ADD CONSTRAINT "quotation_bv_project_id_fkey" FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_bv" ADD CONSTRAINT "quotation_bv_staff_id_fkey" FOREIGN KEY (staff_id) REFERENCES staffs(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_client_project" ADD CONSTRAINT "quotation_client_project_client_id_fkey" FOREIGN KEY (client_id) REFERENCES quotation_client_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_client_project" ADD CONSTRAINT "quotation_client_project_main_pm_id_fkey" FOREIGN KEY (main_pm_id) REFERENCES staffs(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_client_project" ADD CONSTRAINT "quotation_client_project_webandsystem_list_id_fkey" FOREIGN KEY (webandsystem_list_id) REFERENCES webandsystem_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_docs" ADD CONSTRAINT "quotation_docs_doc_type_fkey" FOREIGN KEY (doc_type) REFERENCES quotation_doc_types(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "quotation_docs" ADD CONSTRAINT "quotation_docs_quotation_client_project_id_fkey" FOREIGN KEY (quotation_client_project_id) REFERENCES quotation_client_project(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "receipt_line_items" ADD CONSTRAINT "receipt_line_items_receipt_id_fkey" FOREIGN KEY (receipt_id) REFERENCES receipts(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "receipts" ADD CONSTRAINT "receipts_company_id_fkey" FOREIGN KEY (company_id) REFERENCES company_list(uuid) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "receipts" ADD CONSTRAINT "receipts_income_id_fkey" FOREIGN KEY (income_id) REFERENCES incomes(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "receipts" ADD CONSTRAINT "receipts_invoice_id_fkey" FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "recurring_expenses" ADD CONSTRAINT "recurring_expenses_credit_card_id_fkey" FOREIGN KEY (credit_card_id) REFERENCES credit_cards(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "recurring_expenses" ADD CONSTRAINT "recurring_expenses_related_id_fkey" FOREIGN KEY (related_id) REFERENCES projects(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "recurring_expenses" ADD CONSTRAINT "recurring_expenses_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "recurring_expenses" ADD CONSTRAINT "recurring_expenses_supplier_types_id_fkey" FOREIGN KEY (supplier_types_id) REFERENCES supplier_types(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "seo_keywords" ADD CONSTRAINT "seo_keywords_website_profile_id_fkey" FOREIGN KEY (website_profile_id) REFERENCES webandsystem_list(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "staffs" ADD CONSTRAINT "staffs_brand_list_id_fkey" FOREIGN KEY (brand_list_id) REFERENCES brand_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "staffs" ADD CONSTRAINT "staffs_company_list_id_fkey" FOREIGN KEY (company_list_id) REFERENCES company_list(uuid) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "supplier_login_methods" ADD CONSTRAINT "supplier_login_methods_login_method_id_fkey" FOREIGN KEY (login_method_id) REFERENCES login_methods(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "supplier_login_methods" ADD CONSTRAINT "supplier_login_methods_supplier_id_fkey" FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "suppliers" ADD CONSTRAINT "suppliers_supplier_types_id_fkey" FOREIGN KEY (supplier_types_id) REFERENCES supplier_types(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "users" ADD CONSTRAINT "users_auth_user_id_fkey" FOREIGN KEY (auth_user_id) REFERENCES auth.users(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "users" ADD CONSTRAINT "users_staff_id_fkey" FOREIGN KEY (staff_id) REFERENCES staffs(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "vchannel_account_login_methods" ADD CONSTRAINT "vchannel_account_login_methods_login_method_id_fkey" FOREIGN KEY (login_method_id) REFERENCES login_methods(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "vchannel_account_login_methods" ADD CONSTRAINT "vchannel_account_login_methods_vchannel_account_id_fkey" FOREIGN KEY (vchannel_account_id) REFERENCES vchannel_accounts(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "vchannels" ADD CONSTRAINT "vchannels_brand_list_id_fkey" FOREIGN KEY (brand_list_id) REFERENCES brand_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "video_output" ADD CONSTRAINT "video_output_vchannel_id_fkey" FOREIGN KEY (vchannel_id) REFERENCES vchannels(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "video_output_work_logs" ADD CONSTRAINT "video_output_work_logs_created_by_fkey" FOREIGN KEY (created_by) REFERENCES staffs(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "video_output_work_logs" ADD CONSTRAINT "video_output_work_logs_staff_id_fkey" FOREIGN KEY (staff_id) REFERENCES staffs(id) ON DELETE RESTRICT; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "video_output_work_logs" ADD CONSTRAINT "video_output_work_logs_video_output_id_fkey" FOREIGN KEY (video_output_id) REFERENCES video_output(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "volunteer_apply" ADD CONSTRAINT "volunteer_apply_campaign_id_fkey" FOREIGN KEY (campaign_id) REFERENCES volunteer_campaign(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "webandsystem_list" ADD CONSTRAINT "webandsystem_list_brand_list_id_fkey" FOREIGN KEY (brand_list_id) REFERENCES brand_list(id) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "webandsystem_list" ADD CONSTRAINT "webandsystem_list_company_list_id_fkey" FOREIGN KEY (company_list_id) REFERENCES company_list(uuid) ON DELETE SET NULL; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "website_video_links" ADD CONSTRAINT "website_video_links_video_output_id_fkey" FOREIGN KEY (video_output_id) REFERENCES video_output(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;
DO $$ BEGIN ALTER TABLE "website_video_links" ADD CONSTRAINT "website_video_links_website_profile_id_fkey" FOREIGN KEY (website_profile_id) REFERENCES webandsystem_list(id) ON DELETE CASCADE; EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE INDEX IF NOT EXISTS ads_campaign_tags_campaign_idx ON public.ads_campaign_tags USING btree (platform, campaign_row_id);
CREATE INDEX IF NOT EXISTS ads_campaign_tags_tag_idx ON public.ads_campaign_tags USING btree (tag_id);
CREATE INDEX IF NOT EXISTS ads_discovered_domains_status_idx ON public.ads_discovered_domains USING btree (status);
CREATE INDEX IF NOT EXISTS ads_discovered_domains_website_idx ON public.ads_discovered_domains USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS ads_tags_is_active_idx ON public.ads_tags USING btree (is_active);
CREATE UNIQUE INDEX IF NOT EXISTS ads_tags_name_lower_uidx ON public.ads_tags USING btree (lower(name));
CREATE INDEX IF NOT EXISTS ads_tags_sort_order_idx ON public.ads_tags USING btree (sort_order, name);
CREATE INDEX IF NOT EXISTS artist_apply_categories_gin_idx ON public.artist_apply USING gin (categories);
CREATE INDEX IF NOT EXISTS artist_apply_interview_scheduled_idx ON public.artist_apply USING btree (interview_scheduled_at);
CREATE INDEX IF NOT EXISTS artist_apply_interviewed_idx ON public.artist_apply USING btree (interviewed);
CREATE INDEX IF NOT EXISTS artist_apply_invite_token_idx ON public.artist_apply USING btree (invite_token);
CREATE INDEX IF NOT EXISTS artist_apply_name_zh_idx ON public.artist_apply USING btree (name_zh);
CREATE INDEX IF NOT EXISTS artist_apply_phone_idx ON public.artist_apply USING btree (phone);
CREATE INDEX IF NOT EXISTS artist_apply_photo_apply_id_idx ON public.artist_apply_photo USING btree (artist_apply_id);
CREATE INDEX IF NOT EXISTS artist_apply_photo_role_idx ON public.artist_apply_photo USING btree (file_role);
CREATE UNIQUE INDEX IF NOT EXISTS artist_apply_photo_storage_path_uidx ON public.artist_apply_photo USING btree (bucket, storage_path) WHERE (storage_path IS NOT NULL);
CREATE INDEX IF NOT EXISTS artist_apply_raw_payload_gin_idx ON public.artist_apply USING gin (raw_payload);
CREATE INDEX IF NOT EXISTS artist_apply_status_idx ON public.artist_apply USING btree (status);
CREATE INDEX IF NOT EXISTS artist_apply_submitted_at_idx ON public.artist_apply USING btree (submitted_at DESC);
CREATE INDEX IF NOT EXISTS asana_synced_tasks_inquiry_date_idx ON public.asana_synced_tasks USING btree (inquiry_date DESC);
CREATE INDEX IF NOT EXISTS asana_synced_tasks_project_idx ON public.asana_synced_tasks USING btree (asana_project_gid);
CREATE INDEX IF NOT EXISTS asana_synced_tasks_synced_at_idx ON public.asana_synced_tasks USING btree (synced_at DESC);
CREATE INDEX IF NOT EXISTS backlink_purchases_date_idx ON public.backlink_purchases USING btree (purchase_date);
CREATE INDEX IF NOT EXISTS backlink_purchases_gads_customer_idx ON public.backlink_purchases USING btree (google_ads_customer_id);
CREATE INDEX IF NOT EXISTS backlink_purchases_source_domain_idx ON public.backlink_purchases USING btree (source_domain);
CREATE INDEX IF NOT EXISTS backlink_purchases_supplier_idx ON public.backlink_purchases USING btree (web_supplier_id);
CREATE INDEX IF NOT EXISTS backlink_purchases_website_idx ON public.backlink_purchases USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS brand_list_company_id_idx ON public.brand_list USING btree (company_id);
CREATE UNIQUE INDEX IF NOT EXISTS brand_list_otc_id_key ON public.brand_list USING btree (otc_id) WHERE (otc_id IS NOT NULL);
CREATE UNIQUE INDEX IF NOT EXISTS company_list_uuid_uidx ON public.company_list USING btree (uuid);
CREATE INDEX IF NOT EXISTS confirmed_artist_artist_apply_idx ON public.confirmed_artist USING btree (artist_apply_id);
CREATE INDEX IF NOT EXISTS confirmed_artist_confirmed_idx ON public.confirmed_artist USING btree (confirmed_at DESC);
CREATE INDEX IF NOT EXISTS confirmed_artist_cooperation_stage_idx ON public.confirmed_artist USING btree (cooperation_stage);
CREATE INDEX IF NOT EXISTS confirmed_artist_source_form_idx ON public.confirmed_artist USING btree (source_form_id);
CREATE INDEX IF NOT EXISTS credit_cards_brand_list_id_idx ON public.credit_cards USING btree (brand_list_id);
CREATE INDEX IF NOT EXISTS credit_cards_company_list_id_idx ON public.credit_cards USING btree (company_list_id);
CREATE INDEX IF NOT EXISTS credit_cards_custodian_id_idx ON public.credit_cards USING btree (custodian_id);
CREATE INDEX IF NOT EXISTS expenses_credit_card_id_idx ON public.expenses USING btree (credit_card_id);
CREATE INDEX IF NOT EXISTS expenses_due_date_idx ON public.expenses USING btree (due_date);
CREATE INDEX IF NOT EXISTS expenses_payment_date_idx ON public.expenses USING btree (payment_date);
CREATE INDEX IF NOT EXISTS expenses_payment_status_idx ON public.expenses USING btree (payment_status);
CREATE UNIQUE INDEX IF NOT EXISTS expenses_recurring_due_date_uidx ON public.expenses USING btree (recurring_expense_id, due_date) WHERE (recurring_expense_id IS NOT NULL);
CREATE INDEX IF NOT EXISTS expenses_related_idx ON public.expenses USING btree (related_type, related_id, installment_number, created_at);
CREATE INDEX IF NOT EXISTS expenses_supplier_id_idx ON public.expenses USING btree (supplier_id);
CREATE INDEX IF NOT EXISTS expenses_supplier_types_id_idx ON public.expenses USING btree (supplier_types_id);
CREATE INDEX IF NOT EXISTS facebook_ads_accounts_business_idx ON public.facebook_ads_accounts USING btree (business_key);
CREATE INDEX IF NOT EXISTS facebook_ads_accounts_status_idx ON public.facebook_ads_accounts USING btree (status);
CREATE INDEX IF NOT EXISTS facebook_ads_backfill_jobs_status_idx ON public.facebook_ads_backfill_jobs USING btree (status);
CREATE INDEX IF NOT EXISTS facebook_ads_campaigns_account_idx ON public.facebook_ads_campaigns USING btree (ad_account_id);
CREATE INDEX IF NOT EXISTS facebook_ads_campaigns_brand_list_idx ON public.facebook_ads_campaigns USING btree (brand_list_id);
CREATE INDEX IF NOT EXISTS facebook_ads_campaigns_spend_idx ON public.facebook_ads_campaigns USING btree (spend_micros DESC);
CREATE INDEX IF NOT EXISTS facebook_ads_campaigns_status_idx ON public.facebook_ads_campaigns USING btree (status);
CREATE INDEX IF NOT EXISTS facebook_ads_daily_metrics_account_date_idx ON public.facebook_ads_campaign_daily_metrics USING btree (ad_account_id, metric_date);
CREATE INDEX IF NOT EXISTS facebook_ads_daily_metrics_date_idx ON public.facebook_ads_campaign_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS ga4_backfill_jobs_status_idx ON public.ga4_backfill_jobs USING btree (status);
CREATE INDEX IF NOT EXISTS ga4_channel_daily_date_idx ON public.ga4_channel_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS ga4_properties_account_idx ON public.ga4_properties USING btree (account_id);
CREATE INDEX IF NOT EXISTS ga4_properties_website_idx ON public.ga4_properties USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS ga4_property_daily_date_idx ON public.ga4_property_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS ga4_property_daily_property_date_idx ON public.ga4_property_daily_metrics USING btree (property_id, metric_date);
CREATE INDEX IF NOT EXISTS gads_campaign_websites_campaign_row_idx ON public.google_ads_campaign_websites USING btree (campaign_row_id);
CREATE INDEX IF NOT EXISTS gads_campaign_websites_customer_idx ON public.google_ads_campaign_websites USING btree (customer_id);
CREATE INDEX IF NOT EXISTS gads_campaign_websites_website_idx ON public.google_ads_campaign_websites USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS google_ads_accounts_manager_idx ON public.google_ads_accounts USING btree (manager_customer_id);
CREATE INDEX IF NOT EXISTS google_ads_accounts_status_idx ON public.google_ads_accounts USING btree (status);
CREATE INDEX IF NOT EXISTS google_ads_backfill_jobs_status_idx ON public.google_ads_backfill_jobs USING btree (status);
CREATE INDEX IF NOT EXISTS google_ads_campaigns_cost_idx ON public.google_ads_campaigns USING btree (cost_micros DESC);
CREATE INDEX IF NOT EXISTS google_ads_campaigns_customer_idx ON public.google_ads_campaigns USING btree (customer_id);
CREATE INDEX IF NOT EXISTS google_ads_campaigns_status_idx ON public.google_ads_campaigns USING btree (status);
CREATE INDEX IF NOT EXISTS google_ads_daily_metrics_customer_date_idx ON public.google_ads_campaign_daily_metrics USING btree (customer_id, metric_date);
CREATE INDEX IF NOT EXISTS google_ads_daily_metrics_date_idx ON public.google_ads_campaign_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS google_business_registrations_date_idx ON public.google_business_registrations USING btree (registered_at);
CREATE INDEX IF NOT EXISTS google_business_registrations_website_idx ON public.google_business_registrations USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS gsc_page_daily_date_idx ON public.gsc_page_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS gsc_page_daily_page_idx ON public.gsc_page_daily_metrics USING btree (page);
CREATE INDEX IF NOT EXISTS gsc_query_daily_date_idx ON public.gsc_query_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS gsc_query_daily_query_idx ON public.gsc_query_daily_metrics USING btree (query);
CREATE INDEX IF NOT EXISTS gsc_site_daily_date_idx ON public.gsc_site_daily_metrics USING btree (metric_date);
CREATE INDEX IF NOT EXISTS gsc_sites_website_idx ON public.gsc_sites USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS idx_day_report_entries_category ON public.day_report_entries USING btree (category);
CREATE INDEX IF NOT EXISTS idx_day_report_entries_report_id ON public.day_report_entries USING btree (day_report_id);
CREATE INDEX IF NOT EXISTS idx_day_report_entries_staff_id ON public.day_report_entries USING btree (staff_id);
CREATE INDEX IF NOT EXISTS idx_day_reports_report_date ON public.day_reports USING btree (report_date);
CREATE INDEX IF NOT EXISTS idx_day_reports_reviewer_id ON public.day_reports USING btree (reviewer_id);
CREATE INDEX IF NOT EXISTS idx_day_reports_staff_id ON public.day_reports USING btree (staff_id);
CREATE INDEX IF NOT EXISTS idx_day_reports_status ON public.day_reports USING btree (status);
CREATE INDEX IF NOT EXISTS idx_login_logs_created_at ON public.login_logs USING btree (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_login_logs_user_id ON public.login_logs USING btree (user_id);
CREATE INDEX IF NOT EXISTS idx_staffs_email ON public.staffs USING btree (work_email);
CREATE INDEX IF NOT EXISTS idx_staffs_status ON public.staffs USING btree (status);
CREATE INDEX IF NOT EXISTS idx_staffs_team_name ON public.staffs USING btree (team_name);
CREATE INDEX IF NOT EXISTS idx_system_options_category ON public.system_options USING btree (category);
CREATE INDEX IF NOT EXISTS idx_users_email ON public.users USING btree (email);
CREATE INDEX IF NOT EXISTS idx_users_staff_id ON public.users USING btree (staff_id);
CREATE INDEX IF NOT EXISTS idx_vchannel_accounts_codes ON public.vchannel_accounts USING gin (vchannel_codes);
CREATE INDEX IF NOT EXISTS idx_vchannels_importance ON public.vchannels USING btree (importance);
CREATE INDEX IF NOT EXISTS idx_vchannels_platform ON public.vchannels USING gin (platform_status);
CREATE INDEX IF NOT EXISTS idx_video_output_category ON public.video_output USING btree (project_category);
CREATE INDEX IF NOT EXISTS idx_video_output_platform ON public.video_output USING gin (platform_publish);
CREATE INDEX IF NOT EXISTS idx_video_output_published ON public.video_output USING btree (published_date);
CREATE INDEX IF NOT EXISTS idx_video_output_vchannel ON public.video_output USING btree (vchannel_id);
CREATE INDEX IF NOT EXISTS idx_video_output_work_logs_created_by ON public.video_output_work_logs USING btree (created_by);
CREATE INDEX IF NOT EXISTS idx_video_output_work_logs_staff_date ON public.video_output_work_logs USING btree (staff_id, work_date);
CREATE INDEX IF NOT EXISTS idx_video_output_work_logs_video ON public.video_output_work_logs USING btree (video_output_id);
CREATE INDEX IF NOT EXISTS idx_video_output_workflow_stage ON public.video_output USING btree (workflow_stage);
CREATE INDEX IF NOT EXISTS idx_video_output_year ON public.video_output USING btree (production_year);
CREATE INDEX IF NOT EXISTS idx_website_video_links_video ON public.website_video_links USING btree (video_output_id);
CREATE INDEX IF NOT EXISTS idx_website_video_links_website ON public.website_video_links USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS incomes_due_date_idx ON public.incomes USING btree (due_date);
CREATE INDEX IF NOT EXISTS incomes_payment_date_idx ON public.incomes USING btree (payment_date);
CREATE INDEX IF NOT EXISTS incomes_payment_status_idx ON public.incomes USING btree (payment_status);
CREATE INDEX IF NOT EXISTS incomes_project_id_idx ON public.incomes USING btree (quotation_client_project_id, installment_number, created_at);
CREATE INDEX IF NOT EXISTS invoice_line_items_invoice_id_idx ON public.invoice_line_items USING btree (invoice_id);
CREATE INDEX IF NOT EXISTS invoices_company_id_idx ON public.invoices USING btree (company_id);
CREATE INDEX IF NOT EXISTS kol_apply_applied_idx ON public.kol_apply USING btree (applied_at DESC);
CREATE INDEX IF NOT EXISTS kol_apply_audit_status_idx ON public.kol_apply USING btree (audit_status);
CREATE INDEX IF NOT EXISTS kol_apply_instagram_idx ON public.kol_apply USING btree (instagram_account);
CREATE INDEX IF NOT EXISTS kol_apply_name_idx ON public.kol_apply USING btree (name);
CREATE INDEX IF NOT EXISTS kol_apply_new_beauty_idx ON public.kol_apply USING btree (kol_new_beauty_id);
CREATE INDEX IF NOT EXISTS kol_apply_source_idx ON public.kol_apply USING btree (source);
CREATE INDEX IF NOT EXISTS kol_cooperation_new_beauty_idx ON public.kol_cooperation USING btree (kol_new_beauty_id, cooperated_at DESC);
CREATE INDEX IF NOT EXISTS kol_cooperation_platforms_gin_idx ON public.kol_cooperation USING gin (platforms);
CREATE INDEX IF NOT EXISTS kol_cooperation_profile_idx ON public.kol_cooperation USING btree (kol_profile_id, cooperated_at DESC);
CREATE INDEX IF NOT EXISTS kol_new_beauty_created_idx ON public.kol_new_beauty USING btree (created_at DESC);
CREATE INDEX IF NOT EXISTS kol_new_beauty_lifecycle_idx ON public.kol_new_beauty USING btree (lifecycle_status);
CREATE INDEX IF NOT EXISTS kol_profile_age_group_idx ON public.kol_profile USING btree (age_group);
CREATE INDEX IF NOT EXISTS kol_profile_category_lifecycle_idx ON public.kol_profile USING btree (primary_category, lifecycle_status);
CREATE INDEX IF NOT EXISTS kol_profile_created_idx ON public.kol_profile USING btree (created_at DESC);
CREATE UNIQUE INDEX IF NOT EXISTS kol_profile_email_unique_ci ON public.kol_profile USING btree (lower(email)) WHERE ((email IS NOT NULL) AND (btrim(email) <> ''::text));
CREATE INDEX IF NOT EXISTS kol_profile_instagram_followers_idx ON public.kol_profile USING btree (instagram_followers);
CREATE INDEX IF NOT EXISTS kol_profile_instagram_idx ON public.kol_profile USING btree (instagram_account);
CREATE INDEX IF NOT EXISTS kol_profile_lifecycle_status_idx ON public.kol_profile USING btree (lifecycle_status);
CREATE INDEX IF NOT EXISTS kol_profile_name_idx ON public.kol_profile USING btree (name);
CREATE UNIQUE INDEX IF NOT EXISTS kol_profile_phone_unique_ci ON public.kol_profile USING btree (lower(phone)) WHERE ((phone IS NOT NULL) AND (btrim(phone) <> ''::text));
CREATE INDEX IF NOT EXISTS kol_profile_primary_category_idx ON public.kol_profile USING btree (primary_category);
CREATE INDEX IF NOT EXISTS kol_profile_tags_gin_idx ON public.kol_profile USING gin (tags);
CREATE INDEX IF NOT EXISTS kol_rating_new_beauty_idx ON public.kol_rating USING btree (kol_new_beauty_id, created_at DESC);
CREATE INDEX IF NOT EXISTS kol_rating_profile_idx ON public.kol_rating USING btree (kol_profile_id, created_at DESC);
CREATE INDEX IF NOT EXISTS login_methods_display_name_idx ON public.login_methods USING btree (display_name);
CREATE INDEX IF NOT EXISTS login_methods_is_active_idx ON public.login_methods USING btree (is_active);
CREATE INDEX IF NOT EXISTS login_methods_login_method_idx ON public.login_methods USING btree (login_method);
CREATE INDEX IF NOT EXISTS login_methods_updated_at_idx ON public.login_methods USING btree (updated_at DESC);
CREATE INDEX IF NOT EXISTS pending_report_items_staff_date_status_idx ON public.pending_report_items USING btree (staff_id, report_date, status);
CREATE INDEX IF NOT EXISTS pending_report_items_status_idx ON public.pending_report_items USING btree (status);
CREATE INDEX IF NOT EXISTS projects_brand_list_id_idx ON public.projects USING btree (brand_list_id);
CREATE INDEX IF NOT EXISTS projects_company_list_id_idx ON public.projects USING btree (company_list_id);
CREATE INDEX IF NOT EXISTS projects_is_active_idx ON public.projects USING btree (is_active);
CREATE INDEX IF NOT EXISTS projects_name_idx ON public.projects USING btree (name);
CREATE INDEX IF NOT EXISTS projects_related_type_idx ON public.projects USING btree (related_type);
CREATE INDEX IF NOT EXISTS projects_updated_idx ON public.projects USING btree (updated_at DESC);
CREATE INDEX IF NOT EXISTS quotation_bv_project_id_idx ON public.quotation_bv USING btree (project_id);
CREATE INDEX IF NOT EXISTS quotation_bv_staff_id_idx ON public.quotation_bv USING btree (staff_id);
CREATE INDEX IF NOT EXISTS quotation_client_list_company_zh_idx ON public.quotation_client_list USING btree (company_name_zh);
CREATE INDEX IF NOT EXISTS quotation_client_list_display_name_idx ON public.quotation_client_list USING btree (display_name);
CREATE INDEX IF NOT EXISTS quotation_client_list_status_idx ON public.quotation_client_list USING btree (status);
CREATE INDEX IF NOT EXISTS quotation_client_project_asana_project_idx ON public.quotation_client_project USING btree (asana_project_gid);
CREATE INDEX IF NOT EXISTS quotation_client_project_client_id_idx ON public.quotation_client_project USING btree (client_id);
CREATE INDEX IF NOT EXISTS quotation_client_project_inquiry_date_idx ON public.quotation_client_project USING btree (inquiry_date DESC);
CREATE INDEX IF NOT EXISTS quotation_client_project_main_pm_id_idx ON public.quotation_client_project USING btree (main_pm_id);
CREATE UNIQUE INDEX IF NOT EXISTS quotation_client_project_pitching_code_uidx ON public.quotation_client_project USING btree (pitching_code) WHERE ((pitching_code IS NOT NULL) AND (btrim(pitching_code) <> ''::text));
CREATE INDEX IF NOT EXISTS quotation_client_project_status_idx ON public.quotation_client_project USING btree (status);
CREATE INDEX IF NOT EXISTS quotation_client_project_webandsystem_list_id_idx ON public.quotation_client_project USING btree (webandsystem_list_id);
CREATE INDEX IF NOT EXISTS quotation_doc_types_is_active_idx ON public.quotation_doc_types USING btree (is_active);
CREATE INDEX IF NOT EXISTS quotation_docs_doc_type_idx ON public.quotation_docs USING btree (doc_type);
CREATE INDEX IF NOT EXISTS quotation_docs_expiry_date_idx ON public.quotation_docs USING btree (expiry_date);
CREATE INDEX IF NOT EXISTS quotation_docs_project_id_idx ON public.quotation_docs USING btree (quotation_client_project_id, created_at DESC);
CREATE INDEX IF NOT EXISTS receipt_line_items_receipt_id_idx ON public.receipt_line_items USING btree (receipt_id);
CREATE INDEX IF NOT EXISTS receipts_company_id_idx ON public.receipts USING btree (company_id);
CREATE INDEX IF NOT EXISTS receipts_invoice_id_idx ON public.receipts USING btree (invoice_id);
CREATE INDEX IF NOT EXISTS recurring_expenses_credit_card_id_idx ON public.recurring_expenses USING btree (credit_card_id);
CREATE INDEX IF NOT EXISTS recurring_expenses_due_idx ON public.recurring_expenses USING btree (status, next_occurrence_date);
CREATE INDEX IF NOT EXISTS recurring_expenses_related_idx ON public.recurring_expenses USING btree (related_type, related_id, status, next_occurrence_date);
CREATE INDEX IF NOT EXISTS rejected_artist_rejected_idx ON public.rejected_artist USING btree (rejected_at DESC);
CREATE INDEX IF NOT EXISTS rejected_artist_source_form_idx ON public.rejected_artist USING btree (source_form_id);
CREATE INDEX IF NOT EXISTS seo_keywords_normalized_idx ON public.seo_keywords USING btree (normalized_keyword);
CREATE INDEX IF NOT EXISTS seo_keywords_status_idx ON public.seo_keywords USING btree (status);
CREATE INDEX IF NOT EXISTS seo_keywords_website_idx ON public.seo_keywords USING btree (website_profile_id);
CREATE INDEX IF NOT EXISTS staffs_brand_list_id_idx ON public.staffs USING btree (brand_list_id);
CREATE INDEX IF NOT EXISTS staffs_company_list_id_idx ON public.staffs USING btree (company_list_id);
CREATE INDEX IF NOT EXISTS supplier_login_methods_login_method_idx ON public.supplier_login_methods USING btree (login_method_id);
CREATE INDEX IF NOT EXISTS supplier_types_categories_idx ON public.supplier_types USING btree (categories);
CREATE INDEX IF NOT EXISTS suppliers_display_name_idx ON public.suppliers USING btree (display_name);
CREATE INDEX IF NOT EXISTS suppliers_supplier_types_id_idx ON public.suppliers USING btree (supplier_types_id);
CREATE INDEX IF NOT EXISTS upcoming_event_date_idx ON public.upcoming_event USING btree (event_date);
CREATE INDEX IF NOT EXISTS vchannel_account_login_methods_account_idx ON public.vchannel_account_login_methods USING btree (vchannel_account_id);
CREATE INDEX IF NOT EXISTS vchannel_account_login_methods_login_method_idx ON public.vchannel_account_login_methods USING btree (login_method_id);
CREATE INDEX IF NOT EXISTS vchannel_accounts_is_active_idx ON public.vchannel_accounts USING btree (is_active);
CREATE INDEX IF NOT EXISTS vchannel_accounts_platform_idx ON public.vchannel_accounts USING btree (platform);
CREATE INDEX IF NOT EXISTS vchannels_brand_list_id_idx ON public.vchannels USING btree (brand_list_id);
CREATE INDEX IF NOT EXISTS volunteer_apply_campaign_id_idx ON public.volunteer_apply USING btree (campaign_id);
CREATE INDEX IF NOT EXISTS volunteer_apply_status_idx ON public.volunteer_apply USING btree (status);
CREATE INDEX IF NOT EXISTS volunteer_apply_submitted_at_idx ON public.volunteer_apply USING btree (submitted_at DESC);
CREATE INDEX IF NOT EXISTS volunteer_apply_treatment_type_idx ON public.volunteer_apply USING btree (treatment_type);
CREATE UNIQUE INDEX IF NOT EXISTS volunteer_campaign_slug_uidx ON public.volunteer_campaign USING btree (slug);
CREATE INDEX IF NOT EXISTS volunteer_campaign_status_idx ON public.volunteer_campaign USING btree (status);
CREATE INDEX IF NOT EXISTS webandsystem_list_brand_list_id_idx ON public.webandsystem_list USING btree (brand_list_id);
CREATE INDEX IF NOT EXISTS webandsystem_list_company_list_id_idx ON public.webandsystem_list USING btree (company_list_id);
CREATE INDEX IF NOT EXISTS webandsystem_list_ga4_property_idx ON public.webandsystem_list USING btree (ga4_property_id);
CREATE INDEX IF NOT EXISTS webandsystem_list_gads_customer_idx ON public.webandsystem_list USING btree (google_ads_customer_id);
CREATE INDEX IF NOT EXISTS webandsystem_list_gsc_site_url_idx ON public.webandsystem_list USING btree (gsc_site_url);

CREATE OR REPLACE FUNCTION public.allocate_pitching_code(p_types text[], p_inquiry_date date)
 RETURNS text
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_prefix text;
  v_fy integer;
  v_seq integer;
  v_pattern text;
BEGIN
  IF p_inquiry_date IS NULL THEN
    RAISE EXCEPTION 'inquiry_date is required to allocate pitching_code';
  END IF;

  v_prefix := public.pitching_code_prefix(p_types);
  v_fy := public.pitching_code_fy(p_inquiry_date);
  v_pattern := '^' || v_prefix || lpad(v_fy::text, 2, '0') || '-[0-9]{3}$';

  PERFORM pg_advisory_xact_lock(hashtext(v_prefix), v_fy);

  SELECT COALESCE(MAX(substring(q.pitching_code FROM '[0-9]{3}$')::int), 0) + 1
  INTO v_seq
  FROM public.quotation_client_project q
  WHERE q.pitching_code ~ v_pattern;

  RETURN v_prefix || lpad(v_fy::text, 2, '0') || '-' || lpad(v_seq::text, 3, '0');
END;
$function$
;

CREATE OR REPLACE FUNCTION public.canonical_domain_url(raw text)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE PARALLEL SAFE
AS $function$
  SELECT NULLIF(
    regexp_replace(
      split_part(
        split_part(
          split_part(
            regexp_replace(
              regexp_replace(
                regexp_replace(
                  lower(btrim(COALESCE(raw, ''))),
                  '^https?://',
                  ''
                ),
                '^//',
                ''
              ),
              '^www\.',
              ''
            ),
            '/',
            1
          ),
          '?',
          1
        ),
        '#',
        1
      ),
      ':\d+$',
      ''
    ),
    ''
  );
$function$
;

CREATE OR REPLACE FUNCTION public.create_recurring_expense(p_related_id uuid, p_supplier_types_id uuid, p_supplier_id text, p_credit_card_id uuid, p_billed_amount numeric, p_remarks text, p_frequency text, p_anchor_date date, p_next_occurrence_date date)
 RETURNS uuid
 LANGUAGE plpgsql
 SET search_path TO 'pg_catalog', 'public', 'private'
AS $function$
BEGIN
  IF auth.uid() IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;
  RETURN private.insert_recurring_expense(
    p_related_id,
    p_supplier_types_id,
    p_supplier_id,
    p_credit_card_id,
    p_billed_amount,
    p_remarks,
    p_frequency,
    p_anchor_date,
    p_next_occurrence_date
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.delete_project_row(p_related_type text, p_related_id text)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  DELETE FROM public.projects
  WHERE related_type = p_related_type
    AND related_id = p_related_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.facebook_ads_campaign_metrics_range(p_from date, p_to date)
 RETURNS TABLE(ad_account_id text, campaign_id text, impressions bigint, clicks bigint, spend_micros bigint, conversions numeric, action_breakdown jsonb)
 LANGUAGE sql
 STABLE
AS $function$
  WITH summed AS (
    SELECT
      m.ad_account_id,
      m.campaign_id,
      SUM(m.impressions)::bigint AS impressions,
      SUM(m.clicks)::bigint AS clicks,
      SUM(m.spend_micros)::bigint AS spend_micros,
      SUM(m.conversions) AS conversions
    FROM public.facebook_ads_campaign_daily_metrics m
    WHERE m.metric_date >= p_from
      AND m.metric_date <= p_to
    GROUP BY m.ad_account_id, m.campaign_id
  ),
  breakdowns AS (
    SELECT
      d.ad_account_id,
      d.campaign_id,
      jsonb_object_agg(d.key, d.total) AS action_breakdown
    FROM (
      SELECT
        m.ad_account_id,
        m.campaign_id,
        kv.key,
        SUM((kv.value)::numeric) AS total
      FROM public.facebook_ads_campaign_daily_metrics m
      CROSS JOIN LATERAL jsonb_each_text(COALESCE(m.action_breakdown, '{}'::jsonb)) AS kv(key, value)
      WHERE m.metric_date >= p_from
        AND m.metric_date <= p_to
      GROUP BY m.ad_account_id, m.campaign_id, kv.key
    ) d
    GROUP BY d.ad_account_id, d.campaign_id
  )
  SELECT
    s.ad_account_id,
    s.campaign_id,
    s.impressions,
    s.clicks,
    s.spend_micros,
    s.conversions,
    COALESCE(b.action_breakdown, '{}'::jsonb) AS action_breakdown
  FROM summed s
  LEFT JOIN breakdowns b
    ON b.ad_account_id = s.ad_account_id
   AND b.campaign_id = s.campaign_id;
$function$
;

CREATE OR REPLACE FUNCTION public.ga4_property_metrics_range(p_from date, p_to date)
 RETURNS TABLE(property_id text, users numeric, new_users numeric, sessions numeric, pageviews numeric, engaged_sessions numeric, conversions numeric, duration_seconds numeric)
 LANGUAGE sql
 STABLE
AS $function$
  SELECT
    m.property_id,
    SUM(m.users) AS users,
    SUM(m.new_users) AS new_users,
    SUM(m.sessions) AS sessions,
    SUM(m.pageviews) AS pageviews,
    SUM(m.engaged_sessions) AS engaged_sessions,
    SUM(m.conversions) AS conversions,
    SUM(m.avg_session_duration * m.sessions) AS duration_seconds
  FROM public.ga4_property_daily_metrics m
  WHERE m.metric_date >= p_from
    AND m.metric_date <= p_to
  GROUP BY m.property_id
$function$
;

CREATE OR REPLACE FUNCTION public.get_volunteer_campaign_public(p_slug text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  c public.volunteer_campaign%ROWTYPE;
  face_approved integer;
  body_approved integer;
  is_accepting boolean;
BEGIN
  SELECT * INTO c
  FROM public.volunteer_campaign
  WHERE slug = lower(trim(p_slug));

  IF NOT FOUND THEN
    RETURN NULL;
  END IF;

  SELECT
    COUNT(*) FILTER (WHERE treatment_type = 'face' AND status = 'approved'),
    COUNT(*) FILTER (WHERE treatment_type = 'body' AND status = 'approved')
  INTO face_approved, body_approved
  FROM public.volunteer_apply
  WHERE campaign_id = c.id;

  is_accepting :=
    c.status = 'open'
    AND (c.deadline IS NULL OR c.deadline > now())
    AND (
      face_approved < c.face_quota
      OR body_approved < c.body_quota
    );

  RETURN jsonb_build_object(
    'id', c.id,
    'slug', c.slug,
    'title', c.title,
    'product_name', c.product_name,
    'description', c.description,
    'incentive', c.incentive,
    'deliverables', c.deliverables,
    'requirements_note', c.requirements_note,
    'min_followers', c.min_followers,
    'face_quota', c.face_quota,
    'body_quota', c.body_quota,
    'face_approved', face_approved,
    'body_approved', body_approved,
    'face_remaining', GREATEST(c.face_quota - face_approved, 0),
    'body_remaining', GREATEST(c.body_quota - body_approved, 0),
    'deadline', c.deadline,
    'status', c.status,
    'is_accepting', is_accepting
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.google_ads_campaign_metrics_range(p_from date, p_to date)
 RETURNS TABLE(customer_id text, campaign_id text, impressions bigint, clicks bigint, cost_micros bigint, conversions numeric)
 LANGUAGE sql
 STABLE
AS $function$
  SELECT
    m.customer_id,
    m.campaign_id,
    SUM(m.impressions)::bigint AS impressions,
    SUM(m.clicks)::bigint AS clicks,
    SUM(m.cost_micros)::bigint AS cost_micros,
    SUM(m.conversions) AS conversions
  FROM public.google_ads_campaign_daily_metrics m
  WHERE m.metric_date >= p_from
    AND m.metric_date <= p_to
  GROUP BY m.customer_id, m.campaign_id;
$function$
;

CREATE OR REPLACE FUNCTION public.gsc_site_daily_range(p_site_url text, p_from date, p_to date)
 RETURNS TABLE(metric_date date, clicks numeric, impressions numeric, position_weighted numeric)
 LANGUAGE sql
 STABLE
AS $function$
  WITH site_daily AS (
    SELECT
      m.metric_date,
      SUM(m.clicks) AS clicks,
      SUM(m.impressions) AS impressions,
      SUM(COALESCE(m.position, 0) * m.impressions) AS position_weighted
    FROM public.gsc_site_daily_metrics m
    WHERE m.site_url = p_site_url
      AND m.metric_date >= p_from
      AND m.metric_date <= p_to
    GROUP BY m.metric_date
  ),
  query_daily AS (
    SELECT
      m.metric_date,
      SUM(m.clicks) AS clicks,
      SUM(m.impressions) AS impressions,
      SUM(COALESCE(m.position, 0) * m.impressions) AS position_weighted
    FROM public.gsc_query_daily_metrics m
    WHERE m.site_url = p_site_url
      AND m.metric_date >= p_from
      AND m.metric_date <= p_to
    GROUP BY m.metric_date
  )
  SELECT
    COALESCE(s.metric_date, q.metric_date) AS metric_date,
    COALESCE(s.clicks, q.clicks) AS clicks,
    COALESCE(s.impressions, q.impressions) AS impressions,
    COALESCE(s.position_weighted, q.position_weighted) AS position_weighted
  FROM site_daily s
  FULL OUTER JOIN query_daily q ON q.metric_date = s.metric_date
  ORDER BY 1
$function$
;

CREATE OR REPLACE FUNCTION public.gsc_site_metrics_range(p_from date, p_to date)
 RETURNS TABLE(site_url text, clicks numeric, impressions numeric, position_weighted numeric)
 LANGUAGE sql
 STABLE
AS $function$
  WITH site_daily AS (
    SELECT
      m.site_url,
      SUM(m.clicks) AS clicks,
      SUM(m.impressions) AS impressions,
      SUM(COALESCE(m.position, 0) * m.impressions) AS position_weighted
    FROM public.gsc_site_daily_metrics m
    WHERE m.metric_date >= p_from
      AND m.metric_date <= p_to
    GROUP BY m.site_url
  ),
  query_daily AS (
    SELECT
      m.site_url,
      SUM(m.clicks) AS clicks,
      SUM(m.impressions) AS impressions,
      SUM(COALESCE(m.position, 0) * m.impressions) AS position_weighted
    FROM public.gsc_query_daily_metrics m
    WHERE m.metric_date >= p_from
      AND m.metric_date <= p_to
    GROUP BY m.site_url
  )
  SELECT
    COALESCE(s.site_url, q.site_url) AS site_url,
    COALESCE(s.clicks, q.clicks) AS clicks,
    COALESCE(s.impressions, q.impressions) AS impressions,
    COALESCE(s.position_weighted, q.position_weighted) AS position_weighted
  FROM site_daily s
  FULL OUTER JOIN query_daily q ON q.site_url = s.site_url
$function$
;

CREATE OR REPLACE FUNCTION public.gsc_top_pages_range(p_site_url text, p_from date, p_to date, p_limit integer DEFAULT 100)
 RETURNS TABLE(page text, clicks numeric, impressions numeric, position_weighted numeric)
 LANGUAGE sql
 STABLE
AS $function$
  SELECT
    m.page,
    SUM(m.clicks) AS clicks,
    SUM(m.impressions) AS impressions,
    SUM(COALESCE(m.position, 0) * m.impressions) AS position_weighted
  FROM public.gsc_page_daily_metrics m
  WHERE m.site_url = p_site_url
    AND m.metric_date >= p_from
    AND m.metric_date <= p_to
    AND m.page <> ''
  GROUP BY m.page
  ORDER BY SUM(m.clicks) DESC, SUM(m.impressions) DESC
  LIMIT GREATEST(1, LEAST(COALESCE(p_limit, 100), 500))
$function$
;

CREATE OR REPLACE FUNCTION public.gsc_top_queries_range(p_site_url text, p_from date, p_to date, p_limit integer DEFAULT 100)
 RETURNS TABLE(query text, clicks numeric, impressions numeric, position_weighted numeric)
 LANGUAGE sql
 STABLE
AS $function$
  SELECT
    m.query,
    SUM(m.clicks) AS clicks,
    SUM(m.impressions) AS impressions,
    SUM(COALESCE(m.position, 0) * m.impressions) AS position_weighted
  FROM public.gsc_query_daily_metrics m
  WHERE m.site_url = p_site_url
    AND m.metric_date >= p_from
    AND m.metric_date <= p_to
    AND m.query <> ''
  GROUP BY m.query
  ORDER BY SUM(m.clicks) DESC, SUM(m.impressions) DESC
  LIMIT GREATEST(1, LEAST(COALESCE(p_limit, 100), 500))
$function$
;

CREATE OR REPLACE FUNCTION public.login_logs_fill_user_id()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NEW.user_id IS NULL THEN
    NEW.user_id := public.login_logs_match_user_id(NEW.email);
  END IF;
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.login_logs_match_user_id(p_email text)
 RETURNS uuid
 LANGUAGE sql
 STABLE SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  SELECT u.id
  FROM public.users u
  WHERE p_email IS NOT NULL
    AND btrim(p_email) <> ''
    AND lower(trim(coalesce(u.email, ''))) = lower(trim(p_email))
  ORDER BY u.created_at NULLS LAST
  LIMIT 1;
$function$
;

CREATE OR REPLACE FUNCTION public.merge_webandsystem_profile(p_keeper_id text, p_loser_ids text[])
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  keeper public.webandsystem_list%ROWTYPE;
  loser public.webandsystem_list%ROWTYPE;
  loser_id text;
  keeper_project_id uuid;
  loser_project_ids uuid[];
  canonical text;
  coalesced jsonb := '{}'::jsonb;
  discarded jsonb := '{}'::jsonb;
BEGIN
  IF p_keeper_id IS NULL OR p_loser_ids IS NULL OR cardinality(p_loser_ids) = 0 THEN
    RAISE EXCEPTION 'merge_webandsystem_profile requires keeper and loser ids';
  END IF;
  IF p_keeper_id = ANY (p_loser_ids) THEN
    RAISE EXCEPTION 'keeper_id cannot also be a loser';
  END IF;

  SELECT * INTO keeper FROM public.webandsystem_list WHERE id = p_keeper_id;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'keeper website % is missing', p_keeper_id;
  END IF;

  FOREACH loser_id IN ARRAY p_loser_ids LOOP
    IF NOT EXISTS (SELECT 1 FROM public.webandsystem_list WHERE id = loser_id) THEN
      RAISE EXCEPTION 'loser website % is missing', loser_id;
    END IF;
  END LOOP;

  canonical := COALESCE(
    public.canonical_domain_url(keeper.domain_url),
    (
      SELECT public.canonical_domain_url(w.domain_url)
      FROM public.webandsystem_list w
      WHERE w.id = ANY (p_loser_ids)
        AND public.canonical_domain_url(w.domain_url) IS NOT NULL
      LIMIT 1
    )
  );

  FOREACH loser_id IN ARRAY p_loser_ids LOOP
    SELECT * INTO loser FROM public.webandsystem_list WHERE id = loser_id;

    IF keeper.ga4_property_id IS NULL AND loser.ga4_property_id IS NOT NULL THEN
      keeper.ga4_property_id := loser.ga4_property_id;
      coalesced := coalesced || jsonb_build_object('ga4_property_id', loser.ga4_property_id);
    ELSIF keeper.ga4_property_id IS NOT NULL AND loser.ga4_property_id IS NOT NULL
      AND keeper.ga4_property_id IS DISTINCT FROM loser.ga4_property_id THEN
      discarded := discarded || jsonb_build_object(loser_id || '.ga4_property_id', loser.ga4_property_id);
    END IF;

    IF keeper.gsc_site_url IS NULL AND loser.gsc_site_url IS NOT NULL THEN
      keeper.gsc_site_url := loser.gsc_site_url;
      coalesced := coalesced || jsonb_build_object('gsc_site_url', loser.gsc_site_url);
    ELSIF keeper.gsc_site_url IS NOT NULL AND loser.gsc_site_url IS NOT NULL
      AND keeper.gsc_site_url IS DISTINCT FROM loser.gsc_site_url THEN
      discarded := discarded || jsonb_build_object(loser_id || '.gsc_site_url', loser.gsc_site_url);
    END IF;

    IF keeper.google_ads_customer_id IS NULL AND loser.google_ads_customer_id IS NOT NULL THEN
      keeper.google_ads_customer_id := loser.google_ads_customer_id;
      coalesced := coalesced || jsonb_build_object('google_ads_customer_id', loser.google_ads_customer_id);
    ELSIF keeper.google_ads_customer_id IS NOT NULL AND loser.google_ads_customer_id IS NOT NULL
      AND keeper.google_ads_customer_id IS DISTINCT FROM loser.google_ads_customer_id THEN
      discarded := discarded || jsonb_build_object(loser_id || '.google_ads_customer_id', loser.google_ads_customer_id);
    END IF;

    IF keeper.brand_list_id IS NULL AND loser.brand_list_id IS NOT NULL THEN
      keeper.brand_list_id := loser.brand_list_id;
      coalesced := coalesced || jsonb_build_object('brand_list_id', loser.brand_list_id);
    END IF;
    IF keeper.company_list_id IS NULL AND loser.company_list_id IS NOT NULL THEN
      keeper.company_list_id := loser.company_list_id;
      coalesced := coalesced || jsonb_build_object('company_list_id', loser.company_list_id);
    END IF;
    IF keeper.brand IS NULL AND loser.brand IS NOT NULL THEN
      keeper.brand := loser.brand;
    END IF;
    IF keeper.company IS NULL AND loser.company IS NOT NULL THEN
      keeper.company := loser.company;
    END IF;
    IF keeper.platform IS NULL AND loser.platform IS NOT NULL THEN
      keeper.platform := loser.platform;
    END IF;
    IF keeper.notes IS NULL AND loser.notes IS NOT NULL THEN
      keeper.notes := loser.notes;
    END IF;
    IF keeper.project_id IS NULL AND loser.project_id IS NOT NULL THEN
      keeper.project_id := loser.project_id;
    END IF;
    keeper.articles_count := COALESCE(keeper.articles_count, 0) + COALESCE(loser.articles_count, 0);
    keeper.videos_count := COALESCE(keeper.videos_count, 0) + COALESCE(loser.videos_count, 0);
  END LOOP;

  UPDATE public.webandsystem_list SET
    domain_url = COALESCE(canonical, domain_url),
    ga4_property_id = keeper.ga4_property_id,
    gsc_site_url = keeper.gsc_site_url,
    google_ads_customer_id = keeper.google_ads_customer_id,
    brand_list_id = keeper.brand_list_id,
    company_list_id = keeper.company_list_id,
    brand = keeper.brand,
    company = keeper.company,
    platform = keeper.platform,
    notes = keeper.notes,
    project_id = keeper.project_id,
    articles_count = keeper.articles_count,
    videos_count = keeper.videos_count,
    updated_at = now()
  WHERE id = p_keeper_id;

  INSERT INTO public.webandsystem_merge_log (
    keeper_id, loser_ids, canonical_domain, coalesced_fields, discarded_fields
  ) VALUES (
    p_keeper_id, p_loser_ids, canonical, coalesced, discarded
  );

  IF to_regclass('public.gsc_sites') IS NOT NULL THEN
    UPDATE public.gsc_sites
    SET website_profile_id = p_keeper_id
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.seo_keywords') IS NOT NULL THEN
    UPDATE public.seo_keywords k
    SET website_profile_id = p_keeper_id
    WHERE k.website_profile_id = ANY (p_loser_ids)
      AND NOT EXISTS (
        SELECT 1
        FROM public.seo_keywords k2
        WHERE k2.website_profile_id = p_keeper_id
          AND k2.normalized_keyword = k.normalized_keyword
      );
    DELETE FROM public.seo_keywords
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.google_ads_campaign_websites') IS NOT NULL THEN
    UPDATE public.google_ads_campaign_websites g
    SET website_profile_id = p_keeper_id
    WHERE g.website_profile_id = ANY (p_loser_ids)
      AND NOT EXISTS (
        SELECT 1
        FROM public.google_ads_campaign_websites g2
        WHERE g2.customer_id = g.customer_id
          AND g2.campaign_id = g.campaign_id
          AND g2.website_profile_id = p_keeper_id
      );
    DELETE FROM public.google_ads_campaign_websites
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.ads_discovered_domains') IS NOT NULL THEN
    UPDATE public.ads_discovered_domains
    SET website_profile_id = p_keeper_id
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.ga4_properties') IS NOT NULL THEN
    UPDATE public.ga4_properties
    SET website_profile_id = p_keeper_id
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.website_video_links') IS NOT NULL THEN
    UPDATE public.website_video_links v
    SET website_profile_id = p_keeper_id
    WHERE v.website_profile_id = ANY (p_loser_ids)
      AND NOT EXISTS (
        SELECT 1
        FROM public.website_video_links v2
        WHERE v2.website_profile_id = p_keeper_id
          AND v2.video_output_id = v.video_output_id
      );
    DELETE FROM public.website_video_links
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.quotation_client_project') IS NOT NULL THEN
    UPDATE public.quotation_client_project
    SET webandsystem_list_id = p_keeper_id
    WHERE webandsystem_list_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.social_posts') IS NOT NULL THEN
    UPDATE public.social_posts
    SET website_profile_id = p_keeper_id
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.backlink_purchases') IS NOT NULL THEN
    UPDATE public.backlink_purchases
    SET website_profile_id = p_keeper_id
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.google_business_registrations') IS NOT NULL THEN
    UPDATE public.google_business_registrations
    SET website_profile_id = p_keeper_id
    WHERE website_profile_id = ANY (p_loser_ids);
  END IF;

  IF to_regclass('public.seo_upgrades') IS NOT NULL THEN
    EXECUTE $q$
      UPDATE public.seo_upgrades
      SET website_profile_id = $1
      WHERE website_profile_id = ANY ($2)
    $q$ USING p_keeper_id, p_loser_ids;
  END IF;

  SELECT p.id
  INTO keeper_project_id
  FROM public.projects p
  WHERE p.related_type = 'webandsystem'
    AND p.related_id = p_keeper_id;

  IF keeper_project_id IS NULL THEN
    PERFORM public.upsert_project_row(
      'webandsystem',
      p_keeper_id,
      COALESCE(NULLIF(btrim(keeper.website_name), ''), p_keeper_id),
      COALESCE(keeper.status, ''),
      (COALESCE(keeper.status, '') IS DISTINCT FROM 'archived'),
      keeper.company_list_id,
      keeper.brand_list_id,
      NULL,
      jsonb_build_object(
        'profile_type', keeper.profile_type,
        'project_category', keeper.project_category,
        'domain_url', COALESCE(canonical, keeper.domain_url),
        'level', keeper.level
      )
    );
    SELECT p.id
    INTO keeper_project_id
    FROM public.projects p
    WHERE p.related_type = 'webandsystem'
      AND p.related_id = p_keeper_id;
  END IF;

  SELECT coalesce(array_agg(p.id), ARRAY[]::uuid[])
  INTO loser_project_ids
  FROM public.projects p
  WHERE p.related_type = 'webandsystem'
    AND p.related_id = ANY (p_loser_ids);

  IF keeper_project_id IS NOT NULL THEN
    UPDATE public.day_report_entries
    SET related_id = keeper_project_id::text
    WHERE related_id = ANY (p_loser_ids);

    IF cardinality(loser_project_ids) > 0 THEN
      UPDATE public.day_report_entries
      SET related_id = keeper_project_id::text
      WHERE related_id IN (SELECT unnest(loser_project_ids)::text);

      IF to_regclass('public.expenses') IS NOT NULL THEN
        UPDATE public.expenses
        SET related_id = keeper_project_id
        WHERE related_type = 'project'
          AND related_id = ANY (loser_project_ids);
      END IF;

      IF to_regclass('public.recurring_expenses') IS NOT NULL THEN
        UPDATE public.recurring_expenses
        SET related_id = keeper_project_id
        WHERE related_type = 'project'
          AND related_id = ANY (loser_project_ids);
      END IF;

      IF to_regclass('public.quotation_bv') IS NOT NULL THEN
        UPDATE public.quotation_bv b
        SET project_id = keeper_project_id
        WHERE b.project_id = ANY (loser_project_ids)
          AND NOT EXISTS (
            SELECT 1
            FROM public.quotation_bv b2
            WHERE b2.project_id = keeper_project_id
              AND b2.staff_id = b.staff_id
          );
        DELETE FROM public.quotation_bv
        WHERE project_id = ANY (loser_project_ids);
      END IF;
    END IF;
  END IF;

  DELETE FROM public.webandsystem_list
  WHERE id = ANY (p_loser_ids);

  IF keeper_project_id IS NOT NULL THEN
    UPDATE public.webandsystem_list ws
    SET total_hours = (
      SELECT COALESCE(SUM(e.hours), 0)
      FROM public.day_report_entries e
      JOIN public.projects p ON p.id::text = e.related_id
      WHERE p.related_type = 'webandsystem'
        AND p.related_id = ws.id
    )
    WHERE ws.id = p_keeper_id;
  END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.pitching_code_fy(p_inquiry_date date)
 RETURNS integer
 LANGUAGE sql
 IMMUTABLE
AS $function$
  SELECT CASE
    WHEN p_inquiry_date IS NULL THEN NULL
    WHEN EXTRACT(MONTH FROM p_inquiry_date) >= 4 THEN MOD(EXTRACT(YEAR FROM p_inquiry_date)::int, 100)
    ELSE MOD(EXTRACT(YEAR FROM p_inquiry_date)::int - 1, 100)
  END;
$function$
;

CREATE OR REPLACE FUNCTION public.pitching_code_prefix(p_types text[])
 RETURNS text
 LANGUAGE sql
 IMMUTABLE
AS $function$
  SELECT CASE
    WHEN p_types IS NOT NULL AND 'bwt_system' = ANY(p_types) THEN 'DEMO-S'
    WHEN p_types IS NOT NULL AND 'bwl_event' = ANY(p_types) THEN 'DEMO-E'
    WHEN p_types IS NOT NULL AND 'bwg_gift' = ANY(p_types) THEN 'DEMO-G'
    ELSE 'DEMO-W'
  END;
$function$
;

CREATE OR REPLACE FUNCTION public.quotation_bv_company_label()
 RETURNS text
 LANGUAGE sql
 IMMUTABLE
AS $function$
  SELECT 'Acme Corp'::text;
$function$
;

CREATE OR REPLACE FUNCTION public.quotation_bv_company_ratio()
 RETURNS numeric
 LANGUAGE sql
 IMMUTABLE
AS $function$
  SELECT 30::numeric(6, 2);
$function$
;

CREATE OR REPLACE FUNCTION public.quotation_bv_staff_pool()
 RETURNS numeric
 LANGUAGE sql
 IMMUTABLE
AS $function$
  SELECT 70::numeric(6, 2);
$function$
;

CREATE OR REPLACE FUNCTION public.reattribute_staff_owned_rows(src uuid, dst uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF src IS NULL OR dst IS NULL OR src = dst THEN
    RETURN;
  END IF;

  UPDATE public.day_reports d
  SET staff_id = dst
  WHERE d.staff_id = src
    AND NOT EXISTS (
      SELECT 1
      FROM public.day_reports x
      WHERE x.staff_id = dst
        AND x.report_date = d.report_date
    );

  UPDATE public.day_report_entries e
  SET staff_id = dst
  WHERE e.staff_id = src
    AND EXISTS (
      SELECT 1
      FROM public.day_reports d
      WHERE d.id = e.day_report_id
        AND d.staff_id = dst
    );

  UPDATE public.pending_report_items p
  SET staff_id = dst
  WHERE p.staff_id = src
    AND NOT EXISTS (
      SELECT 1
      FROM public.pending_report_items x
      WHERE x.staff_id = dst
        AND x.source_module = p.source_module
        AND x.source_type = p.source_type
        AND x.source_id = p.source_id
    );

  UPDATE public.video_output_work_logs
  SET staff_id = dst
  WHERE staff_id = src;

  UPDATE public.video_output_work_logs
  SET created_by = dst
  WHERE created_by = src;

  UPDATE public.day_reports
  SET reviewer_id = dst
  WHERE reviewer_id = src;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.replace_day_report_entries(p_report_id uuid, p_staff_id uuid, p_entries jsonb)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF p_report_id IS NULL OR p_staff_id IS NULL THEN
    RAISE EXCEPTION 'replace_day_report_entries: report_id and staff_id are required';
  END IF;

  DELETE FROM public.day_report_entries
  WHERE day_report_id = p_report_id;

  IF p_entries IS NULL
     OR jsonb_typeof(p_entries) <> 'array'
     OR jsonb_array_length(p_entries) = 0 THEN
    RETURN;
  END IF;

  INSERT INTO public.day_report_entries (
    day_report_id, staff_id, category, related_id, related_name, title, hours,
    outcome_type, outcome_url, outcome_images, growth_experience,
    is_ai_assisted, ai_tools, ai_tools_v2, sort_order
  )
  SELECT
    p_report_id,
    p_staff_id,
    rec.category,
    rec.related_id,
    rec.related_name,
    COALESCE(rec.title, ''),
    COALESCE(rec.hours, 0),
    rec.outcome_type,
    rec.outcome_url,
    rec.outcome_images,
    rec.growth_experience,
    COALESCE(rec.is_ai_assisted, false),
    rec.ai_tools,
    rec.ai_tools_v2,
    COALESCE(rec.sort_order, 0)
  FROM jsonb_to_recordset(p_entries) AS rec(
    category text,
    related_id text,
    related_name text,
    title text,
    hours numeric,
    outcome_type text,
    outcome_url text,
    outcome_images jsonb,
    growth_experience text,
    is_ai_assisted boolean,
    ai_tools jsonb,
    ai_tools_v2 jsonb,
    sort_order integer
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.resolve_users_for_auth()
 RETURNS users
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  uid uuid := auth.uid();
  auth_email text;
  rec public.users%ROWTYPE;
BEGIN
  IF uid IS NULL THEN
    RETURN NULL;
  END IF;

  SELECT * INTO rec
  FROM public.users
  WHERE auth_user_id = uid
  LIMIT 1;

  IF rec.id IS NOT NULL THEN
    RETURN rec;
  END IF;

  SELECT lower(trim(u.email)) INTO auth_email
  FROM auth.users u
  WHERE u.id = uid;

  IF auth_email IS NULL OR auth_email = '' THEN
    SELECT lower(trim(i.email)) INTO auth_email
    FROM auth.identities i
    WHERE i.user_id = uid
      AND i.email IS NOT NULL
      AND trim(i.email) <> ''
    LIMIT 1;
  END IF;

  IF auth_email IS NULL OR auth_email = '' THEN
    RETURN NULL;
  END IF;

  SELECT u.* INTO rec
  FROM public.users u
  LEFT JOIN public.staffs s ON s.id = u.staff_id
  WHERE lower(trim(coalesce(u.email, ''))) = auth_email
  ORDER BY
    (
      CASE WHEN u.auth_user_id = uid THEN 200 ELSE 0 END
      + CASE WHEN u.auth_user_id IS NULL THEN 50 ELSE 0 END
      + CASE WHEN lower(coalesce(s.status, '')) = 'active' THEN 100 ELSE 0 END
      + CASE WHEN lower(trim(coalesce(u.email, ''))) = auth_email THEN 30 ELSE 0 END
    ) DESC,
    u.id
  LIMIT 1;

  IF rec.id IS NULL THEN
    RETURN rec;
  END IF;

  IF rec.auth_user_id IS NULL THEN
    UPDATE public.users
    SET auth_user_id = uid,
        updated_at = now()
    WHERE id = rec.id
      AND auth_user_id IS NULL;

    SELECT * INTO rec
    FROM public.users
    WHERE id = rec.id
    LIMIT 1;
  END IF;

  RETURN rec;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.review_volunteer_apply(p_apply_id uuid, p_status text, p_status_note text DEFAULT NULL::text, p_reviewed_by text DEFAULT NULL::text)
 RETURNS volunteer_apply
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  a public.volunteer_apply%ROWTYPE;
  c public.volunteer_campaign%ROWTYPE;
  approved_count integer;
  quota_limit integer;
BEGIN
  IF p_status NOT IN ('approved', 'rejected', 'pending') THEN
    RAISE EXCEPTION 'invalid status';
  END IF;

  SELECT * INTO a
  FROM public.volunteer_apply
  WHERE id = p_apply_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION '報名紀錄不存在';
  END IF;

  SELECT * INTO c
  FROM public.volunteer_campaign
  WHERE id = a.campaign_id
  FOR UPDATE;

  IF p_status = 'approved' AND a.status <> 'approved' THEN
    SELECT COUNT(*) INTO approved_count
    FROM public.volunteer_apply
    WHERE campaign_id = a.campaign_id
      AND treatment_type = a.treatment_type
      AND status = 'approved'
      AND id <> a.id;

    quota_limit := CASE WHEN a.treatment_type = 'face' THEN c.face_quota ELSE c.body_quota END;

    IF approved_count >= quota_limit THEN
      RAISE EXCEPTION '% 名額已滿，無法通過', CASE WHEN a.treatment_type = 'face' THEN 'Face' ELSE 'Body' END;
    END IF;
  END IF;

  UPDATE public.volunteer_apply
  SET
    status = p_status,
    status_note = NULLIF(trim(p_status_note), ''),
    reviewed_at = CASE WHEN p_status = 'pending' THEN NULL ELSE now() END,
    reviewed_by = CASE WHEN p_status = 'pending' THEN NULL ELSE NULLIF(trim(p_reviewed_by), '') END
  WHERE id = p_apply_id
  RETURNING * INTO a;

  RETURN a;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.rls_auto_enable()
 RETURNS event_trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'pg_catalog'
AS $function$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.set_artist_apply_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at = now();
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.set_volunteer_apply_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.set_volunteer_campaign_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.submit_artist_apply(form_payload jsonb, photo_payload jsonb DEFAULT '[]'::jsonb)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public', 'pg_temp'
AS $function$
DECLARE
  apply_id uuid;
BEGIN
  IF form_payload IS NULL OR jsonb_typeof(form_payload) <> 'object' THEN
    RAISE EXCEPTION 'form_payload must be a JSON object';
  END IF;

  IF photo_payload IS NULL THEN
    photo_payload := '[]'::jsonb;
  END IF;

  IF jsonb_typeof(photo_payload) <> 'array' THEN
    RAISE EXCEPTION 'photo_payload must be a JSON array';
  END IF;

  INSERT INTO public.artist_apply (
    invite_token, application_no, application_date, name_zh, name_en, display_name, gender, birth_date, age,
    id_last_four, nationality, residence, residence_other, phone, whatsapp, email, emergency_name,
    emergency_relation, emergency_phone, categories, category_other, height, weight, shoe_size, clothing_size,
    hair_color, languages, language_other, language_fluency, read_script_ability, adlib_ability,
    outdoor_shooting, studio_shooting, live_streaming, travel_availability, early_night_shift,
    weekend_holiday_work, license_or_qualification, special_talents, instagram_account, instagram_followers,
    xiaohongshu_account, xiaohongshu_followers, youtube_account, youtube_followers, facebook_account,
    facebook_followers, tiktok_account, tiktok_followers, other_platform, write_content_ability,
    shoot_edit_ability, live_commerce_experience, live_commerce_details, portfolio_links, signed_company_before,
    contract_status, agency_company_name, contract_period, need_agency_consent, previous_brands, shooting_types,
    representative_works, pricing_modes, price_range_from, price_range_to, reimbursable_expenses,
    image_positioning, development_focus, unacceptable_jobs, dream_brands, company_support_directions,
    company_support_other, submitted_files, other_file_note, uploaded_file_names, applicant_sign_date,
    guardian_name, guardian_signature_text, guardian_sign_date, raw_payload
  )
  VALUES (
    NULLIF(form_payload ->> 'inviteToken', ''),
    NULLIF(form_payload ->> 'applicationNo', ''),
    NULLIF(form_payload ->> 'applicationDate', '')::date,
    NULLIF(form_payload ->> 'nameZh', ''),
    NULLIF(form_payload ->> 'nameEn', ''),
    NULLIF(form_payload ->> 'displayName', ''),
    NULLIF(form_payload ->> 'gender', ''),
    NULLIF(form_payload ->> 'birthDate', '')::date,
    NULLIF(form_payload ->> 'age', ''),
    NULLIF(form_payload ->> 'idLastFour', ''),
    NULLIF(form_payload ->> 'nationality', ''),
    NULLIF(form_payload ->> 'residence', ''),
    NULLIF(form_payload ->> 'residenceOther', ''),
    NULLIF(form_payload ->> 'phone', ''),
    NULLIF(form_payload ->> 'whatsapp', ''),
    NULLIF(form_payload ->> 'email', ''),
    NULLIF(form_payload ->> 'emergencyName', ''),
    NULLIF(form_payload ->> 'emergencyRelation', ''),
    NULLIF(form_payload ->> 'emergencyPhone', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'categories', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'categoryOther', ''),
    NULLIF(form_payload ->> 'height', ''),
    NULLIF(form_payload ->> 'weight', ''),
    NULLIF(form_payload ->> 'shoeSize', ''),
    NULLIF(form_payload ->> 'clothingSize', ''),
    NULLIF(form_payload ->> 'hairColor', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'languages', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'languageOther', ''),
    NULLIF(form_payload ->> 'languageFluency', ''),
    NULLIF(form_payload ->> 'readScriptAbility', ''),
    NULLIF(form_payload ->> 'adlibAbility', ''),
    NULLIF(form_payload ->> 'outdoorShooting', ''),
    NULLIF(form_payload ->> 'studioShooting', ''),
    NULLIF(form_payload ->> 'liveStreaming', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'travelAvailability', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'earlyNightShift', ''),
    NULLIF(form_payload ->> 'weekendHolidayWork', ''),
    NULLIF(form_payload ->> 'licenseOrQualification', ''),
    NULLIF(form_payload ->> 'specialTalents', ''),
    NULLIF(form_payload ->> 'instagramAccount', ''),
    NULLIF(form_payload ->> 'instagramFollowers', ''),
    NULLIF(form_payload ->> 'xiaohongshuAccount', ''),
    NULLIF(form_payload ->> 'xiaohongshuFollowers', ''),
    NULLIF(form_payload ->> 'youtubeAccount', ''),
    NULLIF(form_payload ->> 'youtubeFollowers', ''),
    NULLIF(form_payload ->> 'facebookAccount', ''),
    NULLIF(form_payload ->> 'facebookFollowers', ''),
    NULLIF(form_payload ->> 'tiktokAccount', ''),
    NULLIF(form_payload ->> 'tiktokFollowers', ''),
    NULLIF(form_payload ->> 'otherPlatform', ''),
    NULLIF(form_payload ->> 'writeContentAbility', ''),
    NULLIF(form_payload ->> 'shootEditAbility', ''),
    NULLIF(form_payload ->> 'liveCommerceExperience', ''),
    NULLIF(form_payload ->> 'liveCommerceDetails', ''),
    NULLIF(form_payload ->> 'portfolioLinks', ''),
    NULLIF(form_payload ->> 'signedCompanyBefore', ''),
    NULLIF(form_payload ->> 'contractStatus', ''),
    NULLIF(form_payload ->> 'agencyCompanyName', ''),
    NULLIF(form_payload ->> 'contractPeriod', ''),
    NULLIF(form_payload ->> 'needAgencyConsent', ''),
    NULLIF(form_payload ->> 'previousBrands', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'shootingTypes', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'representativeWorks', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'pricingModes', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'priceRangeFrom', ''),
    NULLIF(form_payload ->> 'priceRangeTo', ''),
    NULLIF(form_payload ->> 'reimbursableExpenses', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'imagePositioning', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'developmentFocus', ''),
    NULLIF(form_payload ->> 'unacceptableJobs', ''),
    NULLIF(form_payload ->> 'dreamBrands', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'companySupportDirections', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'companySupportOther', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'submittedFiles', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'otherFileNote', ''),
    COALESCE((SELECT array_agg(value) FROM jsonb_array_elements_text(COALESCE(form_payload -> 'uploadedFileNames', '[]'::jsonb)) AS t(value)), '{}'::text[]),
    NULLIF(form_payload ->> 'applicantSignDate', '')::date,
    NULLIF(form_payload ->> 'guardianName', ''),
    NULLIF(form_payload ->> 'guardianSignature', ''),
    NULLIF(form_payload ->> 'guardianSignDate', '')::date,
    form_payload
  )
  RETURNING id INTO apply_id;

  INSERT INTO public.artist_apply_photo (
    artist_apply_id, file_role, file_kind, bucket, storage_path, public_url, data_url, external_url,
    original_file_name, mime_type, file_size, width, height, sort_order, description, metadata
  )
  SELECT
    apply_id,
    COALESCE(NULLIF(photo ->> 'fileRole', ''), NULLIF(photo ->> 'file_role', ''), 'submitted_file'),
    COALESCE(NULLIF(photo ->> 'fileKind', ''), NULLIF(photo ->> 'file_kind', ''), 'image'),
    COALESCE(NULLIF(photo ->> 'bucket', ''), 'artist-apply'),
    COALESCE(NULLIF(photo ->> 'storagePath', ''), NULLIF(photo ->> 'storage_path', '')),
    COALESCE(NULLIF(photo ->> 'publicUrl', ''), NULLIF(photo ->> 'public_url', '')),
    COALESCE(NULLIF(photo ->> 'dataUrl', ''), NULLIF(photo ->> 'data_url', '')),
    COALESCE(NULLIF(photo ->> 'externalUrl', ''), NULLIF(photo ->> 'external_url', '')),
    COALESCE(NULLIF(photo ->> 'originalFileName', ''), NULLIF(photo ->> 'original_file_name', '')),
    COALESCE(NULLIF(photo ->> 'mimeType', ''), NULLIF(photo ->> 'mime_type', '')),
    NULLIF(COALESCE(photo ->> 'fileSize', photo ->> 'file_size'), '')::bigint,
    NULLIF(photo ->> 'width', '')::integer,
    NULLIF(photo ->> 'height', '')::integer,
    COALESCE(NULLIF(COALESCE(photo ->> 'sortOrder', photo ->> 'sort_order'), '')::integer, 0),
    NULLIF(photo ->> 'description', ''),
    COALESCE(photo -> 'metadata', '{}'::jsonb)
  FROM jsonb_array_elements(photo_payload) AS p(photo);

  RETURN apply_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.submit_volunteer_apply(form_payload jsonb)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  c public.volunteer_campaign%ROWTYPE;
  v_campaign_id uuid;
  v_name text;
  v_phone text;
  v_whatsapp text;
  v_email text;
  v_ig text;
  v_followers integer;
  v_treatment text;
  v_skin text;
  v_followup boolean;
  approved_count integer;
  quota_limit integer;
  new_id uuid;
BEGIN
  IF form_payload IS NULL OR jsonb_typeof(form_payload) <> 'object' THEN
    RAISE EXCEPTION 'form_payload must be a JSON object';
  END IF;

  v_campaign_id := NULLIF(form_payload->>'campaign_id', '')::uuid;
  v_name := NULLIF(trim(form_payload->>'name'), '');
  v_phone := NULLIF(trim(form_payload->>'phone'), '');
  v_whatsapp := NULLIF(trim(form_payload->>'whatsapp'), '');
  v_email := NULLIF(trim(form_payload->>'email'), '');
  v_ig := NULLIF(trim(form_payload->>'instagram_account'), '');
  v_followers := COALESCE((form_payload->>'follower_count')::integer, -1);
  v_treatment := lower(NULLIF(trim(form_payload->>'treatment_type'), ''));
  v_skin := NULLIF(trim(form_payload->>'skin_concerns'), '');
  v_followup := COALESCE((form_payload->>'agree_followup')::boolean, true);

  IF v_campaign_id IS NULL THEN
    RAISE EXCEPTION 'campaign_id is required';
  END IF;
  IF v_name IS NULL THEN
    RAISE EXCEPTION '姓名為必填';
  END IF;
  IF v_ig IS NULL THEN
    RAISE EXCEPTION 'Instagram 帳號為必填';
  END IF;
  IF v_phone IS NULL AND v_whatsapp IS NULL AND v_email IS NULL THEN
    RAISE EXCEPTION '請至少提供電話、WhatsApp 或 Email 其中一項';
  END IF;
  IF v_treatment IS NULL OR v_treatment NOT IN ('face', 'body') THEN
    RAISE EXCEPTION '請選擇 Face 或 Body';
  END IF;
  IF v_followers < 0 THEN
    RAISE EXCEPTION '粉絲數無效';
  END IF;

  SELECT * INTO c
  FROM public.volunteer_campaign
  WHERE id = v_campaign_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION '活動不存在';
  END IF;

  IF c.status <> 'open' THEN
    RAISE EXCEPTION '活動目前未開放報名';
  END IF;

  IF c.deadline IS NOT NULL AND c.deadline <= now() THEN
    RAISE EXCEPTION '報名已截止';
  END IF;

  IF v_followers < c.min_followers THEN
    RAISE EXCEPTION '粉絲數需達 % 或以上', c.min_followers;
  END IF;

  SELECT COUNT(*) INTO approved_count
  FROM public.volunteer_apply
  WHERE campaign_id = c.id
    AND treatment_type = v_treatment
    AND status = 'approved';

  quota_limit := CASE WHEN v_treatment = 'face' THEN c.face_quota ELSE c.body_quota END;

  IF approved_count >= quota_limit THEN
    RAISE EXCEPTION '% 名額已滿', CASE WHEN v_treatment = 'face' THEN 'Face' ELSE 'Body' END;
  END IF;

  INSERT INTO public.volunteer_apply (
    campaign_id,
    name,
    phone,
    whatsapp,
    email,
    instagram_account,
    follower_count,
    treatment_type,
    skin_concerns,
    agree_followup,
    status
  ) VALUES (
    c.id,
    v_name,
    v_phone,
    v_whatsapp,
    v_email,
    v_ig,
    v_followers,
    v_treatment,
    v_skin,
    v_followup,
    'pending'
  )
  RETURNING id INTO new_id;

  RETURN new_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.sync_website_total_hours()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  target_project_id text;
  website_id text;
BEGIN
  IF TG_OP = 'DELETE' THEN
    target_project_id := OLD.related_id;
  ELSIF TG_OP = 'UPDATE' THEN
    IF OLD.related_id IS DISTINCT FROM NEW.related_id AND OLD.related_id IS NOT NULL THEN
      SELECT p.related_id INTO website_id
      FROM public.projects p
      WHERE p.id::text = OLD.related_id
        AND p.related_type = 'webandsystem';

      IF website_id IS NOT NULL THEN
        UPDATE public.webandsystem_list
        SET total_hours = (
          SELECT COALESCE(SUM(e.hours), 0)
          FROM public.day_report_entries e
          JOIN public.projects p2 ON p2.id::text = e.related_id
          WHERE p2.related_type = 'webandsystem'
            AND p2.related_id = website_id
        )
        WHERE id = website_id;
      END IF;
    END IF;
    target_project_id := NEW.related_id;
  ELSE
    target_project_id := NEW.related_id;
  END IF;

  IF target_project_id IS NOT NULL THEN
    SELECT p.related_id INTO website_id
    FROM public.projects p
    WHERE p.id::text = target_project_id
      AND p.related_type = 'webandsystem';

    IF website_id IS NOT NULL THEN
      UPDATE public.webandsystem_list
      SET total_hours = (
        SELECT COALESCE(SUM(e.hours), 0)
        FROM public.day_report_entries e
        JOIN public.projects p2 ON p2.id::text = e.related_id
        WHERE p2.related_type = 'webandsystem'
          AND p2.related_id = website_id
      )
      WHERE id = website_id;
    END IF;
  END IF;

  RETURN NULL;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_assign_pitching_code()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_prefix text;
  v_fy_label text;
BEGIN
  v_prefix := public.pitching_code_prefix(NEW.project_types);
  v_fy_label := lpad(public.pitching_code_fy(NEW.inquiry_date)::text, 2, '0');

  IF NEW.pitching_code IS NOT NULL
     AND btrim(NEW.pitching_code) <> ''
     AND NEW.pitching_code ~ ('^' || v_prefix || v_fy_label || '-[0-9]{3}$')
  THEN
    RETURN NEW;
  END IF;

  NEW.pitching_code := public.allocate_pitching_code(NEW.project_types, NEW.inquiry_date);
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_canonicalize_webandsystem_domain()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NEW.domain_url IS NOT NULL THEN
    NEW.domain_url := public.canonical_domain_url(NEW.domain_url);
  END IF;
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_expenses_supplier_type_match()
 RETURNS trigger
 LANGUAGE plpgsql
 SET search_path TO 'public'
AS $function$
DECLARE
  v_type uuid;
BEGIN
  SELECT supplier_types_id INTO v_type
  FROM public.suppliers
  WHERE id = NEW.supplier_id;

  IF v_type IS NULL THEN
    RAISE EXCEPTION 'expenses.supplier_id must reference an existing supplier';
  END IF;

  IF v_type IS DISTINCT FROM NEW.supplier_types_id THEN
    RAISE EXCEPTION 'expenses.supplier_types_id must match suppliers.supplier_types_id';
  END IF;

  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_quotation_bv_seed_main_pm()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_project_id uuid;
  v_old_ratio numeric(6, 2);
  v_new_exists boolean;
  v_staff_pool numeric(6, 2) := public.quotation_bv_staff_pool();
BEGIN
  IF NEW.main_pm_id IS NULL THEN
    RETURN NEW;
  END IF;

  SELECT p.id
  INTO v_project_id
  FROM public.projects p
  WHERE p.related_type = 'quotation_client'
    AND p.related_id = NEW.id;

  IF v_project_id IS NULL THEN
    RETURN NEW;
  END IF;

  -- New project, or first time a main PM is set: seed staff pool when no BV exists.
  IF TG_OP = 'INSERT' OR OLD.main_pm_id IS NULL THEN
    IF NOT EXISTS (
      SELECT 1
      FROM public.quotation_bv
      WHERE project_id = v_project_id
    ) THEN
      INSERT INTO public.quotation_bv (project_id, staff_id, bv_ratio)
      VALUES (v_project_id, NEW.main_pm_id, v_staff_pool)
      ON CONFLICT (project_id, staff_id) DO NOTHING;
    END IF;
    RETURN NEW;
  END IF;

  IF OLD.main_pm_id IS NOT DISTINCT FROM NEW.main_pm_id THEN
    RETURN NEW;
  END IF;

  SELECT EXISTS (
    SELECT 1
    FROM public.quotation_bv
    WHERE project_id = v_project_id
      AND staff_id = NEW.main_pm_id
  ) INTO v_new_exists;

  IF v_new_exists THEN
    RETURN NEW;
  END IF;

  SELECT bv_ratio
  INTO v_old_ratio
  FROM public.quotation_bv
  WHERE project_id = v_project_id
    AND staff_id = OLD.main_pm_id;

  IF v_old_ratio IS NOT NULL THEN
    DELETE FROM public.quotation_bv
    WHERE project_id = v_project_id
      AND staff_id = OLD.main_pm_id;

    INSERT INTO public.quotation_bv (project_id, staff_id, bv_ratio)
    VALUES (v_project_id, NEW.main_pm_id, v_old_ratio)
    ON CONFLICT (project_id, staff_id) DO NOTHING;
  ELSIF NOT EXISTS (
    SELECT 1
    FROM public.quotation_bv
    WHERE project_id = v_project_id
  ) THEN
    INSERT INTO public.quotation_bv (project_id, staff_id, bv_ratio)
    VALUES (v_project_id, NEW.main_pm_id, v_staff_pool)
    ON CONFLICT (project_id, staff_id) DO NOTHING;
  END IF;

  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_sync_projects_from_quotation_client()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_name text;
BEGIN
  IF TG_OP = 'DELETE' THEN
    PERFORM public.delete_project_row('quotation_client', OLD.id);
    RETURN OLD;
  END IF;

  v_name := COALESCE(
    NULLIF(btrim(NEW.display_name), ''),
    NULLIF(btrim(NEW.client_name), ''),
    NULLIF(btrim(NEW.pitching_code), ''),
    NEW.id
  );

  PERFORM public.upsert_project_row(
    'quotation_client',
    NEW.id,
    v_name,
    COALESCE(NEW.status, ''),
    (COALESCE(NEW.status, '') IS DISTINCT FROM 'closed'),
    NULL,
    NULL,
    NEW.client_name,
    jsonb_build_object(
      'pitching_code', NEW.pitching_code,
      'project_types', COALESCE(to_jsonb(NEW.project_types), '[]'::jsonb),
      'assigned_pm_name', NEW.assigned_pm_name,
      'asana_link', NEW.asana_link
    )
  );
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_sync_projects_from_vchannel()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  v_company_list_id uuid;
BEGIN
  IF TG_OP = 'DELETE' THEN
    PERFORM public.delete_project_row('vchannel', OLD.id::text);
    RETURN OLD;
  END IF;

  SELECT b.company_id
  INTO v_company_list_id
  FROM public.brand_list b
  WHERE b.id = NEW.brand_list_id;

  PERFORM public.upsert_project_row(
    'vchannel',
    NEW.id::text,
    COALESCE(
      NULLIF(btrim(NEW.internal_name), ''),
      NULLIF(btrim(NEW.public_name), ''),
      NULLIF(btrim(NEW.channel_code), ''),
      NEW.id::text
    ),
    COALESCE(NEW.status, ''),
    (COALESCE(NEW.status, '') = 'active'),
    v_company_list_id,
    NEW.brand_list_id,
    NULL,
    jsonb_build_object(
      'channel_code', NEW.channel_code,
      'public_name', NEW.public_name,
      'importance', NEW.importance
    )
  );
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.trg_sync_projects_from_webandsystem()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  IF TG_OP = 'DELETE' THEN
    PERFORM public.delete_project_row('webandsystem', OLD.id);
    RETURN OLD;
  END IF;

  PERFORM public.upsert_project_row(
    'webandsystem',
    NEW.id,
    COALESCE(NULLIF(btrim(NEW.website_name), ''), NEW.id),
    COALESCE(NEW.status, ''),
    (COALESCE(NEW.status, '') IS DISTINCT FROM 'archived'),
    NEW.company_list_id,
    NEW.brand_list_id,
    NULL,
    jsonb_build_object(
      'profile_type', NEW.profile_type,
      'project_category', NEW.project_category,
      'domain_url', NEW.domain_url,
      'level', NEW.level
    )
  );
  RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.upsert_gsc_seo_keywords(payload jsonb)
 RETURNS integer
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  n integer := 0;
BEGIN
  IF payload IS NULL OR jsonb_typeof(payload) <> 'array' THEN
    RETURN 0;
  END IF;

  INSERT INTO public.seo_keywords (
    id,
    website_profile_id,
    keyword,
    normalized_keyword,
    level,
    current_ranking,
    status,
    source,
    gsc_site_url,
    last_gsc_sync_at,
    updated_at
  )
  SELECT
    COALESCE(NULLIF(r->>'id', ''), gen_random_uuid()::text),
    r->>'website_profile_id',
    r->>'keyword',
    r->>'normalized_keyword',
    COALESCE(NULLIF(r->>'level', ''), 'level_3'),
    NULLIF(r->>'current_ranking', '')::numeric,
    COALESCE(NULLIF(r->>'status', ''), 'monitoring'),
    COALESCE(NULLIF(r->>'source', ''), 'gsc'),
    NULLIF(r->>'gsc_site_url', ''),
    NULLIF(r->>'last_gsc_sync_at', '')::timestamptz,
    COALESCE(NULLIF(r->>'updated_at', '')::timestamptz, now())
  FROM jsonb_array_elements(payload) AS r
  WHERE NULLIF(r->>'website_profile_id', '') IS NOT NULL
    AND NULLIF(r->>'normalized_keyword', '') IS NOT NULL
    AND NULLIF(r->>'keyword', '') IS NOT NULL
  ON CONFLICT (website_profile_id, normalized_keyword)
  DO UPDATE SET
    current_ranking = EXCLUDED.current_ranking,
    gsc_site_url = EXCLUDED.gsc_site_url,
    last_gsc_sync_at = EXCLUDED.last_gsc_sync_at,
    updated_at = EXCLUDED.updated_at;

  GET DIAGNOSTICS n = ROW_COUNT;
  RETURN n;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.upsert_gsc_seo_keywords_from_metrics(p_website_profile_id text DEFAULT NULL::text)
 RETURNS integer
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
DECLARE
  n integer := 0;
BEGIN
  WITH agg AS (
    SELECT
      s.website_profile_id,
      lower(trim(regexp_replace(m.query, '\s+', ' ', 'g'))) AS normalized_keyword,
      (array_agg(m.query ORDER BY m.metric_date DESC, m.impressions DESC))[1] AS keyword,
      (array_agg(m.site_url ORDER BY m.metric_date DESC))[1] AS gsc_site_url,
      sum(m.impressions) AS impressions,
      CASE
        WHEN sum(m.impressions) > 0
          THEN round((sum(m.position * m.impressions) / sum(m.impressions))::numeric, 1)
        ELSE round(avg(m.position)::numeric, 1)
      END AS avg_pos,
      max(m.last_synced_at) AS last_gsc_sync_at
    FROM public.gsc_query_daily_metrics m
    JOIN public.gsc_sites s ON s.site_url = m.site_url
    WHERE s.website_profile_id IS NOT NULL
      AND (p_website_profile_id IS NULL OR s.website_profile_id = p_website_profile_id)
      AND nullif(trim(m.query), '') IS NOT NULL
    GROUP BY 1, 2
    HAVING sum(m.impressions) >= 1
  )
  INSERT INTO public.seo_keywords (
    id,
    website_profile_id,
    keyword,
    normalized_keyword,
    level,
    current_ranking,
    status,
    source,
    gsc_site_url,
    last_gsc_sync_at,
    updated_at
  )
  SELECT
    gen_random_uuid()::text,
    a.website_profile_id,
    a.keyword,
    a.normalized_keyword,
    'level_3',
    a.avg_pos,
    'monitoring',
    'gsc',
    a.gsc_site_url,
    a.last_gsc_sync_at,
    now()
  FROM agg a
  ON CONFLICT (website_profile_id, normalized_keyword)
  DO UPDATE SET
    current_ranking = EXCLUDED.current_ranking,
    gsc_site_url = EXCLUDED.gsc_site_url,
    last_gsc_sync_at = EXCLUDED.last_gsc_sync_at,
    updated_at = EXCLUDED.updated_at;

  GET DIAGNOSTICS n = ROW_COUNT;
  RETURN n;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.upsert_project_row(p_related_type text, p_related_id text, p_name text, p_status text, p_is_active boolean, p_company_list_id uuid, p_brand_list_id uuid, p_client_name text, p_meta jsonb)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
BEGIN
  INSERT INTO public.projects (
    related_id, related_type, name, status, is_active,
    company_list_id, brand_list_id, client_name,
    meta, updated_at
  ) VALUES (
    p_related_id, p_related_type, COALESCE(NULLIF(btrim(p_name), ''), p_related_id),
    COALESCE(p_status, ''), COALESCE(p_is_active, true),
    p_company_list_id, p_brand_list_id, p_client_name,
    COALESCE(p_meta, '{}'::jsonb), now()
  )
  ON CONFLICT (related_type, related_id) DO UPDATE SET
    name = EXCLUDED.name,
    status = EXCLUDED.status,
    is_active = EXCLUDED.is_active,
    company_list_id = EXCLUDED.company_list_id,
    brand_list_id = EXCLUDED.brand_list_id,
    client_name = EXCLUDED.client_name,
    meta = EXCLUDED.meta,
    updated_at = now();
END;
$function$
;

CREATE OR REPLACE VIEW "quotation_bv_with_company" AS  SELECT bv.id,
    bv.project_id,
    bv.staff_id,
    s.display_name AS party_name,
    bv.bv_ratio,
    'staff'::text AS slice_kind,
    bv.created_at,
    bv.updated_at
   FROM quotation_bv bv
     LEFT JOIN staffs s ON s.id = bv.staff_id
UNION ALL
 SELECT NULL::uuid AS id,
    p.id AS project_id,
    NULL::uuid AS staff_id,
    quotation_bv_company_label() AS party_name,
    quotation_bv_company_ratio() AS bv_ratio,
    'company'::text AS slice_kind,
    p.created_at,
    p.updated_at
   FROM projects p
  WHERE (EXISTS ( SELECT 1
           FROM quotation_bv bv
          WHERE bv.project_id = p.id));;
CREATE OR REPLACE VIEW "system_users" AS  SELECT u.id,
    u.staff_id,
    u.auth_user_id,
    u.email,
    u.email AS google_email,
    s.display_name,
    u.role_tag AS role,
    s.team_name AS department,
    s."position",
    COALESCE(s.work_phone, s.private_phone) AS phone,
    true AS is_active,
    s.otc_staff_sync_id::text AS bubble_staff_id,
    u.created_at,
    u.updated_at
   FROM users u
     LEFT JOIN staffs s ON s.id = u.staff_id;;
CREATE OR REPLACE VIEW "user_info" AS  SELECT u.id,
    u.staff_id,
    u.auth_user_id,
    u.role_tag,
    u.email,
    u.email AS google_email,
    s.display_name,
    s.base_location AS office,
    s.team_name AS department,
    u.created_at,
    u.updated_at
   FROM users u
     LEFT JOIN staffs s ON s.id = u.staff_id;;

CREATE TRIGGER set_artist_apply_updated_at BEFORE UPDATE ON artist_apply FOR EACH ROW EXECUTE FUNCTION set_artist_apply_updated_at();
CREATE TRIGGER trg_sync_website_hours AFTER INSERT OR DELETE OR UPDATE ON day_report_entries FOR EACH ROW EXECUTE FUNCTION sync_website_total_hours();
CREATE TRIGGER trg_expenses_supplier_type_match BEFORE INSERT OR UPDATE OF supplier_id, supplier_types_id ON expenses FOR EACH ROW EXECUTE FUNCTION trg_expenses_supplier_type_match();
CREATE TRIGGER trg_login_logs_fill_user_id BEFORE INSERT ON login_logs FOR EACH ROW EXECUTE FUNCTION login_logs_fill_user_id();
CREATE TRIGGER trg_assign_pitching_code BEFORE INSERT OR UPDATE ON quotation_client_project FOR EACH ROW EXECUTE FUNCTION trg_assign_pitching_code();
CREATE TRIGGER trg_sync_projects_quotation_client AFTER INSERT OR DELETE OR UPDATE ON quotation_client_project FOR EACH ROW EXECUTE FUNCTION trg_sync_projects_from_quotation_client();
CREATE TRIGGER trg_sync_quotation_bv_seed_main_pm AFTER INSERT OR UPDATE OF main_pm_id ON quotation_client_project FOR EACH ROW EXECUTE FUNCTION trg_quotation_bv_seed_main_pm();
CREATE TRIGGER trg_sync_projects_vchannel AFTER INSERT OR DELETE OR UPDATE ON vchannels FOR EACH ROW EXECUTE FUNCTION trg_sync_projects_from_vchannel();
CREATE TRIGGER set_volunteer_apply_updated_at BEFORE UPDATE ON volunteer_apply FOR EACH ROW EXECUTE FUNCTION set_volunteer_apply_updated_at();
CREATE TRIGGER set_volunteer_campaign_updated_at BEFORE UPDATE ON volunteer_campaign FOR EACH ROW EXECUTE FUNCTION set_volunteer_campaign_updated_at();
CREATE TRIGGER trg_canonicalize_webandsystem_domain BEFORE INSERT OR UPDATE OF domain_url ON webandsystem_list FOR EACH ROW EXECUTE FUNCTION trg_canonicalize_webandsystem_domain();
CREATE TRIGGER trg_sync_projects_webandsystem AFTER INSERT OR DELETE OR UPDATE ON webandsystem_list FOR EACH ROW EXECUTE FUNCTION trg_sync_projects_from_webandsystem();

CREATE POLICY "Allow delete on ads_campaign_tags" ON "ads_campaign_tags" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ads_campaign_tags" ON "ads_campaign_tags" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ads_campaign_tags" ON "ads_campaign_tags" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ads_campaign_tags" ON "ads_campaign_tags" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on ads_discovered_domains" ON "ads_discovered_domains" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ads_discovered_domains" ON "ads_discovered_domains" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ads_discovered_domains" ON "ads_discovered_domains" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ads_discovered_domains" ON "ads_discovered_domains" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on ads_tags" ON "ads_tags" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ads_tags" ON "ads_tags" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ads_tags" ON "ads_tags" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ads_tags" ON "ads_tags" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon insert on artist_apply" ON "artist_apply" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon read on artist_apply" ON "artist_apply" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on artist_apply" ON "artist_apply" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated delete on artist_apply" ON "artist_apply" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated insert on artist_apply" ON "artist_apply" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow authenticated read on artist_apply" ON "artist_apply" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated update on artist_apply" ON "artist_apply" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon insert on artist_apply_photo" ON "artist_apply_photo" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon read on artist_apply_photo" ON "artist_apply_photo" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow authenticated delete on artist_apply_photo" ON "artist_apply_photo" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated insert on artist_apply_photo" ON "artist_apply_photo" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow authenticated read on artist_apply_photo" ON "artist_apply_photo" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated update on artist_apply_photo" ON "artist_apply_photo" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert on asana_pitching_projects" ON "asana_pitching_projects" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on asana_pitching_projects" ON "asana_pitching_projects" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on asana_pitching_projects" ON "asana_pitching_projects" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert on asana_pitching_sync_runs" ON "asana_pitching_sync_runs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on asana_pitching_sync_runs" ON "asana_pitching_sync_runs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on asana_pitching_sync_runs" ON "asana_pitching_sync_runs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on asana_synced_tasks" ON "asana_synced_tasks" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on asana_synced_tasks" ON "asana_synced_tasks" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on asana_synced_tasks" ON "asana_synced_tasks" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on asana_synced_tasks" ON "asana_synced_tasks" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on backlink_purchases" ON "backlink_purchases" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on backlink_purchases" ON "backlink_purchases" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on backlink_purchases" ON "backlink_purchases" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on backlink_purchases" ON "backlink_purchases" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on brand_list" ON "brand_list" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on brand_list" ON "brand_list" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on brand_list" ON "brand_list" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on brand_list" ON "brand_list" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "brand_list" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "brand_list" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "brand_list" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "brand_list" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on company_list" ON "company_list" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on company_list" ON "company_list" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on company_list" ON "company_list" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on company_list" ON "company_list" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "company_list" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "company_list" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "company_list" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "company_list" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on confirmed_artist" ON "confirmed_artist" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on confirmed_artist" ON "confirmed_artist" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on confirmed_artist" ON "confirmed_artist" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on confirmed_artist" ON "confirmed_artist" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "confirmed_artist" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "confirmed_artist" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "confirmed_artist" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "confirmed_artist" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on credit_cards" ON "credit_cards" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on credit_cards" ON "credit_cards" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on credit_cards" ON "credit_cards" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on credit_cards" ON "credit_cards" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on day_report_entries" ON "day_report_entries" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on day_report_entries" ON "day_report_entries" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on day_report_entries" ON "day_report_entries" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on day_report_entries" ON "day_report_entries" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated full access day_report_entries" ON "day_report_entries" AS PERMISSIVE FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on day_report_type" ON "day_report_type" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on day_report_type" ON "day_report_type" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on day_report_type" ON "day_report_type" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on day_report_type" ON "day_report_type" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "day_report_type" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "day_report_type" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "day_report_type" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "day_report_type" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on day_reports" ON "day_reports" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on day_reports" ON "day_reports" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on day_reports" ON "day_reports" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on day_reports" ON "day_reports" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated full access day_reports" ON "day_reports" AS PERMISSIVE FOR ALL TO public USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on expenses" ON "expenses" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on expenses" ON "expenses" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on expenses" ON "expenses" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on expenses" ON "expenses" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on facebook_ads_accounts" ON "facebook_ads_accounts" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on facebook_ads_accounts" ON "facebook_ads_accounts" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on facebook_ads_accounts" ON "facebook_ads_accounts" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on facebook_ads_accounts" ON "facebook_ads_accounts" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on facebook_ads_backfill_jobs" ON "facebook_ads_backfill_jobs" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on facebook_ads_backfill_jobs" ON "facebook_ads_backfill_jobs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on facebook_ads_backfill_jobs" ON "facebook_ads_backfill_jobs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on facebook_ads_backfill_jobs" ON "facebook_ads_backfill_jobs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on facebook_ads_campaign_daily_metrics" ON "facebook_ads_campaign_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on facebook_ads_campaign_daily_metrics" ON "facebook_ads_campaign_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on facebook_ads_campaign_daily_metrics" ON "facebook_ads_campaign_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on facebook_ads_campaign_daily_metrics" ON "facebook_ads_campaign_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on facebook_ads_campaigns" ON "facebook_ads_campaigns" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on facebook_ads_campaigns" ON "facebook_ads_campaigns" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on facebook_ads_campaigns" ON "facebook_ads_campaigns" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on facebook_ads_campaigns" ON "facebook_ads_campaigns" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert on facebook_ads_sync_runs" ON "facebook_ads_sync_runs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on facebook_ads_sync_runs" ON "facebook_ads_sync_runs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on facebook_ads_sync_runs" ON "facebook_ads_sync_runs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on ga4_backfill_jobs" ON "ga4_backfill_jobs" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ga4_backfill_jobs" ON "ga4_backfill_jobs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ga4_backfill_jobs" ON "ga4_backfill_jobs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ga4_backfill_jobs" ON "ga4_backfill_jobs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on ga4_channel_daily_metrics" ON "ga4_channel_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ga4_channel_daily_metrics" ON "ga4_channel_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ga4_channel_daily_metrics" ON "ga4_channel_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ga4_channel_daily_metrics" ON "ga4_channel_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on ga4_properties" ON "ga4_properties" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ga4_properties" ON "ga4_properties" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ga4_properties" ON "ga4_properties" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ga4_properties" ON "ga4_properties" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on ga4_property_daily_metrics" ON "ga4_property_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on ga4_property_daily_metrics" ON "ga4_property_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ga4_property_daily_metrics" ON "ga4_property_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ga4_property_daily_metrics" ON "ga4_property_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert on ga4_sync_runs" ON "ga4_sync_runs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on ga4_sync_runs" ON "ga4_sync_runs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on ga4_sync_runs" ON "ga4_sync_runs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on google_ads_accounts" ON "google_ads_accounts" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on google_ads_accounts" ON "google_ads_accounts" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_ads_accounts" ON "google_ads_accounts" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_ads_accounts" ON "google_ads_accounts" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on google_ads_backfill_jobs" ON "google_ads_backfill_jobs" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on google_ads_backfill_jobs" ON "google_ads_backfill_jobs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_ads_backfill_jobs" ON "google_ads_backfill_jobs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_ads_backfill_jobs" ON "google_ads_backfill_jobs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on google_ads_campaign_daily_metrics" ON "google_ads_campaign_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on google_ads_campaign_daily_metrics" ON "google_ads_campaign_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_ads_campaign_daily_metrics" ON "google_ads_campaign_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_ads_campaign_daily_metrics" ON "google_ads_campaign_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on google_ads_campaign_websites" ON "google_ads_campaign_websites" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on google_ads_campaign_websites" ON "google_ads_campaign_websites" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_ads_campaign_websites" ON "google_ads_campaign_websites" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_ads_campaign_websites" ON "google_ads_campaign_websites" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on google_ads_campaigns" ON "google_ads_campaigns" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on google_ads_campaigns" ON "google_ads_campaigns" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_ads_campaigns" ON "google_ads_campaigns" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_ads_campaigns" ON "google_ads_campaigns" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert on google_ads_sync_runs" ON "google_ads_sync_runs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_ads_sync_runs" ON "google_ads_sync_runs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_ads_sync_runs" ON "google_ads_sync_runs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on google_business_registrations" ON "google_business_registrations" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on google_business_registrations" ON "google_business_registrations" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on google_business_registrations" ON "google_business_registrations" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on google_business_registrations" ON "google_business_registrations" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on gsc_page_daily_metrics" ON "gsc_page_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on gsc_page_daily_metrics" ON "gsc_page_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on gsc_page_daily_metrics" ON "gsc_page_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on gsc_page_daily_metrics" ON "gsc_page_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on gsc_query_daily_metrics" ON "gsc_query_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on gsc_query_daily_metrics" ON "gsc_query_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on gsc_query_daily_metrics" ON "gsc_query_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on gsc_query_daily_metrics" ON "gsc_query_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on gsc_site_daily_metrics" ON "gsc_site_daily_metrics" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on gsc_site_daily_metrics" ON "gsc_site_daily_metrics" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on gsc_site_daily_metrics" ON "gsc_site_daily_metrics" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on gsc_site_daily_metrics" ON "gsc_site_daily_metrics" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on gsc_sites" ON "gsc_sites" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on gsc_sites" ON "gsc_sites" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on gsc_sites" ON "gsc_sites" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on gsc_sites" ON "gsc_sites" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert on gsc_sync_runs" ON "gsc_sync_runs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on gsc_sync_runs" ON "gsc_sync_runs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on gsc_sync_runs" ON "gsc_sync_runs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on incomes" ON "incomes" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on incomes" ON "incomes" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on incomes" ON "incomes" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on incomes" ON "incomes" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on invoice_line_items" ON "invoice_line_items" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on invoice_line_items" ON "invoice_line_items" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on invoice_line_items" ON "invoice_line_items" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on invoice_line_items" ON "invoice_line_items" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on invoices" ON "invoices" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on invoices" ON "invoices" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on invoices" ON "invoices" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on invoices" ON "invoices" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon insert on kol_apply" ON "kol_apply" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "kol_apply" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "kol_apply" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "kol_apply" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "kol_apply" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on kol_cooperation" ON "kol_cooperation" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on kol_cooperation" ON "kol_cooperation" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on kol_cooperation" ON "kol_cooperation" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on kol_cooperation" ON "kol_cooperation" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete kol_cooperation for authenticated" ON "kol_cooperation" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow read kol_cooperation for authenticated" ON "kol_cooperation" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update kol_cooperation for authenticated" ON "kol_cooperation" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow write kol_cooperation for authenticated" ON "kol_cooperation" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow anon delete on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users on kol_new_beauty" ON "kol_new_beauty" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on kol_profile" ON "kol_profile" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on kol_profile" ON "kol_profile" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on kol_profile" ON "kol_profile" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on kol_profile" ON "kol_profile" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "kol_profile" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "kol_profile" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "kol_profile" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "kol_profile" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on kol_rating" ON "kol_rating" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on kol_rating" ON "kol_rating" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on kol_rating" ON "kol_rating" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on kol_rating" ON "kol_rating" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete kol_rating for authenticated" ON "kol_rating" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow read kol_rating for authenticated" ON "kol_rating" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update kol_rating for authenticated" ON "kol_rating" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow write kol_rating for authenticated" ON "kol_rating" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "login_logs_insert_clients" ON "login_logs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "login_logs_select_clients" ON "login_logs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow delete on login_methods" ON "login_methods" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on login_methods" ON "login_methods" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on login_methods" ON "login_methods" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on login_methods" ON "login_methods" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated delete pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated insert pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow authenticated read pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated update pending_report_items" ON "pending_report_items" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on projects" ON "projects" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on projects" ON "projects" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on projects" ON "projects" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on projects" ON "projects" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated on projects" ON "projects" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated on projects" ON "projects" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated on projects" ON "projects" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated on projects" ON "projects" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on quotation_bv" ON "quotation_bv" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on quotation_bv" ON "quotation_bv" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on quotation_bv" ON "quotation_bv" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on quotation_bv" ON "quotation_bv" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated on quotation_client_list" ON "quotation_client_list" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on pitching_records" ON "quotation_client_project" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on pitching_records" ON "quotation_client_project" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on pitching_records" ON "quotation_client_project" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on pitching_records" ON "quotation_client_project" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on quotation_doc_types" ON "quotation_doc_types" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on quotation_doc_types" ON "quotation_doc_types" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on quotation_doc_types" ON "quotation_doc_types" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on quotation_doc_types" ON "quotation_doc_types" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on quotation_docs" ON "quotation_docs" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on quotation_docs" ON "quotation_docs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on quotation_docs" ON "quotation_docs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on quotation_docs" ON "quotation_docs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on receipt_line_items" ON "receipt_line_items" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on receipt_line_items" ON "receipt_line_items" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on receipt_line_items" ON "receipt_line_items" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on receipt_line_items" ON "receipt_line_items" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on receipts" ON "receipts" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on receipts" ON "receipts" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on receipts" ON "receipts" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on receipts" ON "receipts" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on recurring_expenses" ON "recurring_expenses" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert on recurring_expenses" ON "recurring_expenses" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow select on recurring_expenses" ON "recurring_expenses" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update on recurring_expenses" ON "recurring_expenses" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on rejected_artist" ON "rejected_artist" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on rejected_artist" ON "rejected_artist" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on rejected_artist" ON "rejected_artist" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on rejected_artist" ON "rejected_artist" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete for authenticated users" ON "rejected_artist" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert for authenticated users" ON "rejected_artist" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "rejected_artist" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "rejected_artist" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on seo_keywords" ON "seo_keywords" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on seo_keywords" ON "seo_keywords" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on seo_keywords" ON "seo_keywords" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on seo_keywords" ON "seo_keywords" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "staffs_delete_all" ON "staffs" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "staffs_insert_all" ON "staffs" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "staffs_select_all" ON "staffs" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "staffs_update_all" ON "staffs" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on supplier_login_methods" ON "supplier_login_methods" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on supplier_login_methods" ON "supplier_login_methods" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on supplier_login_methods" ON "supplier_login_methods" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on supplier_login_methods" ON "supplier_login_methods" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on supplier_types" ON "supplier_types" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on supplier_types" ON "supplier_types" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on supplier_types" ON "supplier_types" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on supplier_types" ON "supplier_types" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on suppliers" ON "suppliers" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on suppliers" ON "suppliers" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on suppliers" ON "suppliers" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on suppliers" ON "suppliers" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "system_options_anon_delete" ON "system_options" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "system_options_anon_insert" ON "system_options" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "system_options_anon_select" ON "system_options" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "system_options_anon_update" ON "system_options" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "upcoming_event_delete_clients" ON "upcoming_event" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "upcoming_event_insert_clients" ON "upcoming_event" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "upcoming_event_select_clients" ON "upcoming_event" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "upcoming_event_update_clients" ON "upcoming_event" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "users_delete_authenticated" ON "users" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "users_insert_authenticated" ON "users" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "users_select_clients" ON "users" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "users_update_authenticated" ON "users" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete on vchannel_account_login_methods" ON "vchannel_account_login_methods" AS PERMISSIVE FOR DELETE TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow insert on vchannel_account_login_methods" ON "vchannel_account_login_methods" AS PERMISSIVE FOR INSERT TO "authenticated", "anon" WITH CHECK (true);
CREATE POLICY "Allow select on vchannel_account_login_methods" ON "vchannel_account_login_methods" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow update on vchannel_account_login_methods" ON "vchannel_account_login_methods" AS PERMISSIVE FOR UPDATE TO "authenticated", "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on vchannel_accounts" ON "vchannel_accounts" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on vchannel_accounts" ON "vchannel_accounts" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on vchannel_accounts" ON "vchannel_accounts" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on vchannel_accounts" ON "vchannel_accounts" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete vchannel_accounts for authenticated" ON "vchannel_accounts" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert vchannel_accounts for authenticated" ON "vchannel_accounts" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read vchannel_accounts for authenticated" ON "vchannel_accounts" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update vchannel_accounts for authenticated" ON "vchannel_accounts" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on vchannels" ON "vchannels" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on vchannels" ON "vchannels" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on vchannels" ON "vchannels" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on vchannels" ON "vchannels" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete vchannels for authenticated" ON "vchannels" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert vchannels for authenticated" ON "vchannels" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read vchannels for authenticated" ON "vchannels" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update vchannels for authenticated" ON "vchannels" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on video_output" ON "video_output" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on video_output" ON "video_output" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on video_output" ON "video_output" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on video_output" ON "video_output" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete video_output for authenticated" ON "video_output" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert video_output for authenticated" ON "video_output" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read video_output for authenticated" ON "video_output" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update video_output for authenticated" ON "video_output" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on video_output_work_logs" ON "video_output_work_logs" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on video_output_work_logs" ON "video_output_work_logs" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on video_output_work_logs" ON "video_output_work_logs" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on video_output_work_logs" ON "video_output_work_logs" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete video_output_work_logs for authenticated" ON "video_output_work_logs" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert video_output_work_logs for authenticated" ON "video_output_work_logs" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read video_output_work_logs for authenticated" ON "video_output_work_logs" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update video_output_work_logs for authenticated" ON "video_output_work_logs" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated delete on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated insert on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow authenticated read on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated update on volunteer_apply" ON "volunteer_apply" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon delete on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow authenticated delete on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated insert on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow authenticated read on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow authenticated update on volunteer_campaign" ON "volunteer_campaign" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow select on webandsystem_duplicate_conflicts" ON "webandsystem_duplicate_conflicts" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow all for service role" ON "webandsystem_list" AS PERMISSIVE FOR ALL TO "service_role" USING (true);
CREATE POLICY "Allow anon delete" ON "webandsystem_list" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert" ON "webandsystem_list" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on webandsystem_list" ON "webandsystem_list" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update" ON "webandsystem_list" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow anon update on webandsystem_list" ON "webandsystem_list" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow insert for authenticated users" ON "webandsystem_list" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read for authenticated users" ON "webandsystem_list" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update for authenticated users" ON "webandsystem_list" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
CREATE POLICY "Allow select on webandsystem_merge_log" ON "webandsystem_merge_log" AS PERMISSIVE FOR SELECT TO "authenticated", "anon" USING (true);
CREATE POLICY "Allow anon delete on website_video_links" ON "website_video_links" AS PERMISSIVE FOR DELETE TO "anon" USING (true);
CREATE POLICY "Allow anon insert on website_video_links" ON "website_video_links" AS PERMISSIVE FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select on website_video_links" ON "website_video_links" AS PERMISSIVE FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon update on website_video_links" ON "website_video_links" AS PERMISSIVE FOR UPDATE TO "anon" USING (true) WITH CHECK (true);
CREATE POLICY "Allow delete website_video_links for authenticated" ON "website_video_links" AS PERMISSIVE FOR DELETE TO "authenticated" USING (true);
CREATE POLICY "Allow insert website_video_links for authenticated" ON "website_video_links" AS PERMISSIVE FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow read website_video_links for authenticated" ON "website_video_links" AS PERMISSIVE FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow update website_video_links for authenticated" ON "website_video_links" AS PERMISSIVE FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);
