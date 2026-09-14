# Acme Marketing OS (isolated demo)

Standalone demo of the marketing project workspace. It is **not** connected to the live MPS site, production Supabase project, or the original GitHub remote.

## Demo login

- Email: `demo@example.com`
- Phone password: `5551234`

All rows are synthetic (Acme / Northwind / Contoso). There is no Google login and no live ads/Asana/GSC sync.

## Local app

```bash
cp .env.example .env.local
# set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY from the *demo* Supabase project
npm install
npm run dev
```

## New isolated database (never the live project)

1. Create an empty Supabase project in the dashboard (do not clone production).
2. From this folder only:

```bash
npx supabase link --project-ref YOUR_DEMO_PROJECT_REF
npx supabase db push
npx supabase db query --linked -f supabase/seed.sql
```

If `db query` is unavailable, paste `supabase/seed.sql` into the demo project's SQL editor.

3. Auth → URL configuration: Site URL = this demo's Vercel (or `http://localhost:5173`). Leave Google provider off.

## New Vercel project

Create a **new** Vercel project from this repo. Set only:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

Use the demo project's keys. Do not reuse production keys or `bwteam-marketing.com`.

## Showcase modules

- Home
- Day reports
- Quotation / pitching / projects
- Ads charts (pre-seeded fake metrics)

Hidden on purpose: Asana, live ads/GA4/GSC sync, AI advisor, email, video, KOL, public forms.
