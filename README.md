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

## Isolated database (already created)

Demo Supabase project: [qdvdnghfnlrqhpypfvub](https://supabase.com/dashboard/project/qdvdnghfnlrqhpypfvub)

Schema + seed are already applied. Login user: `demo@example.com` / `5551234`.

If you clone this repo later:

```bash
npx supabase link --project-ref qdvdnghfnlrqhpypfvub
```

Auth → URL configuration: Site URL = the demo Vercel URL (or `http://localhost:5173`). Leave Google provider off. Do not point this project at the live MPS site.

## New Vercel project

Import **this** GitHub repo (not the MPS repo):

https://github.com/chifung-BWSolution/acme-marketing-os-demo

In Vercel → Settings → Environment Variables, set only:

- `VITE_SUPABASE_URL` = `https://qdvdnghfnlrqhpypfvub.supabase.co`
- `VITE_SUPABASE_ANON_KEY` = the **anon** key from the demo project API settings

Do not reuse production keys or `bwteam-marketing.com`.

## Showcase modules

- Home
- Day reports
- Quotation / pitching / projects
- Ads charts (pre-seeded fake metrics)

Hidden on purpose: Asana, live ads/GA4/GSC sync, AI advisor, email, video, KOL, public forms.
