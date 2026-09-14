-- Isolated demo seed — synthetic Acme data only. No production people, clients, or IDs.
-- Demo login: demo@example.com / phone password 5551234

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ---------------------------------------------------------------------------
-- Auth user (email + phone-as-password)
-- ---------------------------------------------------------------------------
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
) VALUES (
  '00000000-0000-0000-0000-000000000000',
  '55555555-5555-4555-8555-555555555555',
  'authenticated',
  'authenticated',
  'demo@example.com',
  crypt('5551234', gen_salt('bf')),
  now(),
  '{"provider":"email","providers":["email"]}'::jsonb,
  '{"full_name":"Jordan Lee"}'::jsonb,
  now(),
  now(),
  '',
  '',
  '',
  ''
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO auth.identities (
  user_id,
  identity_data,
  provider,
  provider_id,
  last_sign_in_at,
  created_at,
  updated_at
) VALUES (
  '55555555-5555-4555-8555-555555555555',
  jsonb_build_object(
    'sub', '55555555-5555-4555-8555-555555555555',
    'email', 'demo@example.com',
    'email_verified', true
  ),
  'email',
  '55555555-5555-4555-8555-555555555555',
  now(),
  now(),
  now()
)
ON CONFLICT DO NOTHING;

-- ---------------------------------------------------------------------------
-- Companies / brands
-- ---------------------------------------------------------------------------
INSERT INTO public.company_list (
  id, company_code, company_name_zh, company_name_en, br_no, bank_name, bank_account,
  address, contact_person, contact_phone, contact_email, is_active, uuid
) VALUES (
  'acme',
  'ACME',
  'Acme Corp',
  'Acme Corporation',
  '00000000-000-00-00-0',
  'Demo Bank',
  '000-000-000000-000',
  '100 Demo Street, Example City',
  'Alex Rivera',
  '+1 555 0100',
  'hello@example.com',
  true,
  '11111111-1111-4111-8111-111111111111'
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.brand_list (id, company_id, brand_code, display_name, is_active)
VALUES (
  '22222222-2222-4222-8222-222222222222',
  '11111111-1111-4111-8111-111111111111',
  'ACME',
  'Acme',
  true
)
ON CONFLICT (id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- Staff + whitelist user
-- ---------------------------------------------------------------------------
INSERT INTO public.staffs (
  id, display_name, full_name, position, user_role, status,
  work_email, private_phone, base_location, team_name,
  company_list_id, brand_list_id
) VALUES (
  '33333333-3333-4333-8333-333333333333',
  'Jordan Lee',
  'Jordan Lee',
  'Demo Manager',
  'management',
  'active',
  'demo@example.com',
  '5551234',
  'hk',
  'Marketing',
  '11111111-1111-4111-8111-111111111111',
  '22222222-2222-4222-8222-222222222222'
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.users (id, role_tag, email, staff_id, auth_user_id)
VALUES (
  '44444444-4444-4444-8444-444444444444',
  'Administrator',
  'demo@example.com',
  '33333333-3333-4333-8333-333333333333',
  '55555555-5555-4555-8555-555555555555'
)
ON CONFLICT (id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- Clients + quotation / pitching projects (hub trigger fills public.projects)
-- ---------------------------------------------------------------------------
INSERT INTO public.quotation_client_list (
  id, company_name_zh, company_name_en, brand_id, contact_person, phone, email,
  address, inquiry_date, status, display_name, notes
) VALUES
  (
    '66666666-6666-4666-8666-666666666666',
    'Northwind Traders',
    'Northwind Traders',
    '22222222-2222-4222-8222-222222222222',
    'Casey Morgan',
    '+1 555 0140',
    'casey@example.com',
    '200 Market Ave, Example City',
    '2026-04-08',
    'active',
    'Northwind',
    'Demo client'
  ),
  (
    '66666666-6666-4666-8666-666666666667',
    'Contoso Ltd',
    'Contoso Ltd',
    '22222222-2222-4222-8222-222222222222',
    'Taylor Quinn',
    '+1 555 0150',
    'taylor@example.com',
    '300 Harbor Rd, Example City',
    '2026-05-12',
    'prospect',
    'Contoso',
    'Demo prospect'
  )
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.quotation_client_project (
  id, display_name, client_name, inquiry_date, description, project_types,
  assigned_pm_name, status, notes, estimated_income, client_id, main_pm_id
) VALUES
  (
    'qcp-demo-001',
    'Northwind website refresh',
    'Northwind Traders',
    '2026-04-08',
    'Demo pitching project for a storefront rebuild.',
    ARRAY['website']::text[],
    'Jordan Lee',
    'confirmed',
    'Synthetic demo row',
    48000,
    '66666666-6666-4666-8666-666666666666',
    '33333333-3333-4333-8333-333333333333'
  ),
  (
    'qcp-demo-002',
    'Contoso launch campaign',
    'Contoso Ltd',
    '2026-05-12',
    'Demo pitching project for a paid-ads launch.',
    ARRAY['paid_ads']::text[],
    'Jordan Lee',
    'following_up',
    'Synthetic demo row',
    22000,
    '66666666-6666-4666-8666-666666666667',
    '33333333-3333-4333-8333-333333333333'
  )
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.quotation_doc_types (id, display, is_active)
VALUES
  ('77777777-7777-4777-8777-777777777771', 'Quotation', true),
  ('77777777-7777-4777-8777-777777777772', 'Proposal', true)
ON CONFLICT (id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- Day reports
-- ---------------------------------------------------------------------------
INSERT INTO public.day_report_type (id, label, icon, color, bg, relation_type, description, is_active, sort_order)
VALUES
  ('website_design', 'Website', '🌐', 'text-teal-700', 'bg-teal-100', 'project_website', 'Website work', true, 1),
  ('paid_ads', 'Paid ads', '📢', 'text-amber-700', 'bg-amber-100', 'project_website', 'Ads work', true, 2)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.day_reports (
  id, report_date, total_hours, target_hours, ot_hours, office_location, status, staff_id
) VALUES
  (
    '88888888-8888-4888-8888-888888888881',
    CURRENT_DATE - 1,
    8.0,
    8.0,
    0,
    'hk',
    'submitted',
    '33333333-3333-4333-8333-333333333333'
  ),
  (
    '88888888-8888-4888-8888-888888888882',
    CURRENT_DATE - 2,
    7.5,
    8.0,
    0,
    'hk',
    'submitted',
    '33333333-3333-4333-8333-333333333333'
  )
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.day_report_entries (
  id, day_report_id, category, related_id, related_name, title, hours, staff_id, sort_order
) VALUES
  (
    '99999999-9999-4999-8999-999999999991',
    '88888888-8888-4888-8888-888888888881',
    'website_design',
    'qcp-demo-001',
    'Northwind website refresh',
    'Homepage wireframes',
    4.0,
    '33333333-3333-4333-8333-333333333333',
    0
  ),
  (
    '99999999-9999-4999-8999-999999999992',
    '88888888-8888-4888-8888-888888888881',
    'paid_ads',
    'qcp-demo-002',
    'Contoso launch campaign',
    'Campaign structure draft',
    4.0,
    '33333333-3333-4333-8333-333333333333',
    1
  ),
  (
    '99999999-9999-4999-8999-999999999993',
    '88888888-8888-4888-8888-888888888882',
    'website_design',
    'qcp-demo-001',
    'Northwind website refresh',
    'Content outline',
    7.5,
    '33333333-3333-4333-8333-333333333333',
    0
  )
ON CONFLICT (id) DO NOTHING;

-- ---------------------------------------------------------------------------
-- Fake ads warehouse so charts render
-- ---------------------------------------------------------------------------
INSERT INTO public.google_ads_accounts (
  customer_id, descriptive_name, currency_code, time_zone, status, is_manager, last_synced_at
) VALUES (
  '1111111111',
  'Acme Google Ads',
  'USD',
  'America/New_York',
  'ENABLED',
  false,
  now()
)
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO public.google_ads_campaigns (
  id, customer_id, campaign_id, campaign_name, status, advertising_channel_type,
  impressions, clicks, cost_micros, conversions, ctr, average_cpc_micros, last_synced_at
) VALUES (
  '1111111111:1001',
  '1111111111',
  '1001',
  'Acme Search — Brand',
  'ENABLED',
  'SEARCH',
  42800,
  1860,
  245000000,
  42,
  0.0435,
  131720,
  now()
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.google_ads_campaign_daily_metrics (
  customer_id, campaign_id, metric_date, impressions, clicks, cost_micros, conversions, ctr, average_cpc_micros
)
SELECT
  '1111111111',
  '1001',
  d::date,
  2800 + (gs.n * 40),
  90 + (gs.n * 3),
  14000000 + (gs.n * 250000),
  2 + (gs.n % 3),
  0.04,
  130000
FROM generate_series(0, 13) AS gs(n)
CROSS JOIN LATERAL (SELECT CURRENT_DATE - gs.n AS d) t
ON CONFLICT (customer_id, campaign_id, metric_date) DO NOTHING;

INSERT INTO public.facebook_ads_accounts (
  ad_account_id, account_name, currency_code, time_zone, status, business_name, last_synced_at
) VALUES (
  'act_200200200',
  'Acme Facebook Ads',
  'USD',
  'America/New_York',
  'ACTIVE',
  'Acme Corp',
  now()
)
ON CONFLICT (ad_account_id) DO NOTHING;

INSERT INTO public.facebook_ads_campaigns (
  id, ad_account_id, campaign_id, campaign_name, status, objective,
  impressions, clicks, spend_micros, conversions, ctr, average_cpc_micros,
  brand_list_id, last_synced_at
) VALUES (
  'act_200200200:3001',
  'act_200200200',
  '3001',
  'Acme Awareness — Prospecting',
  'ACTIVE',
  'OUTCOME_TRAFFIC',
  91000,
  2400,
  312000000,
  28,
  0.0264,
  130000,
  '22222222-2222-4222-8222-222222222222',
  now()
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.facebook_ads_campaign_daily_metrics (
  ad_account_id, campaign_id, metric_date, impressions, clicks, spend_micros, conversions, ctr, average_cpc_micros
)
SELECT
  'act_200200200',
  '3001',
  d::date,
  6200 + (gs.n * 80),
  150 + (gs.n * 4),
  20000000 + (gs.n * 300000),
  1 + (gs.n % 2),
  0.026,
  128000
FROM generate_series(0, 13) AS gs(n)
CROSS JOIN LATERAL (SELECT CURRENT_DATE - gs.n AS d) t
ON CONFLICT (ad_account_id, campaign_id, metric_date) DO NOTHING;
